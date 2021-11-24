part of aliyun_oss;

class OSSClient {
  factory OSSClient() {
    return _instance!;
  }

  OSSClient._({
    required this.endpoint,
    required this.bucket,
    required this.credentials,
  }) {
    _signer = null;
  }

  /// * 初始化设置`endpoint` `bucket` `getCredentials`
  /// * [credentials] 获取 `Credentials`
  /// * 一旦初始化，则`signer`清空，上传前会重新拉取oss信息
  static OSSClient init({
    required String endpoint,
    required String bucket,
    required Future<Credentials> Function() credentials,
  }) {
    _instance = OSSClient._(
      endpoint: endpoint,
      bucket: bucket,
      credentials: credentials,
    );
    return _instance!;
  }

  static OSSClient? _instance;
  static var isInit = _instance != null;

  Signer? _signer;

  final String endpoint;
  final String bucket;
  final Future<Credentials> Function() credentials;

  //下载
  Future<void> getObject(
    String name, {
    String path = "",
    String? bucket,
    String? endpoint,
  }) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    _signer = await verify();
    final Map<String, dynamic> safeHeaders = _signer!
        .sign(
          httpMethod: 'GET',
          resourcePath: '/${bucket ?? this.bucket}/$name',
        )
        .toHeaders();
    try {
      final String url =
          'https://${bucket ?? this.bucket}.${endpoint ?? this.endpoint}/$name';
      await _http.download(
        url,
        appDocDir.path + path + '/' + name,
        options: Options(
          headers: <String, dynamic>{...safeHeaders},
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  //获取
  Future<String> getObjectData(
    String name, {
    String? bucket,
    String? endpoint,
  }) async {
    _signer = await verify();
    final Map<String, dynamic> safeHeaders = _signer!
        .sign(
          httpMethod: 'GET',
          resourcePath: '/${bucket ?? this.bucket}/$name',
        )
        .toHeaders();
    try {
      final String url =
          'https://${bucket ?? this.bucket}.${endpoint ?? this.endpoint}/$name';
      var res = await _http.request(
        url,
        options: Options(
          headers: <String, dynamic>{...safeHeaders},
        ),
      );
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  /// * [bucket] [endpoint] 一次性生效
  /// * [path] 上传路径 如不写则自动以 Object[type] [time] 生成path
  Future<OSSObject> putObject({
    required OSSObject object,
    String? bucket,
    String? endpoint,
    String? path,
  }) async {
    _signer = await verify();

    final String objectPath = object.resourcePath(path);

    final Map<String, dynamic> safeHeaders = _signer!.sign(
      httpMethod: 'PUT',
      resourcePath: '/${bucket ?? this.bucket}/$objectPath',
      headers: {
        'content-type': object.mediaType.mimeType,
      },
    ).toHeaders();
    try {
      final String url =
          'https://${bucket ?? this.bucket}.${endpoint ?? this.endpoint}/$objectPath';
      await _http.put<void>(
        url,
        data: Stream.fromIterable(object.bytes.map((e) => [e])),
        options: Options(
          headers: <String, dynamic>{
            ...safeHeaders,
            ...<String, dynamic>{
              'content-length': object.size,
            }
          },
          contentType: object._mediaType.mimeType,
        ),
        // onSendProgress: (int count, int total) {
        //   print(((count/total)*100).toStringAsFixed(2));
        // }
      );
      return object..uploadSuccessful(url);
    } catch (e) {
      rethrow;
    }
  }

  /// 不存在Signer 或则 已过期的
  Future<Signer> verify() async {
    if (_signer == null ||
        (_signer?.credentials.expiration.isBefore(DateTime.now().toUtc()) ??
            true)) {
      _signer = Signer(await credentials.call());
    }
    return _signer!;
  }
}
