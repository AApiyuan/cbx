part of '../sql_db.dart';

///获取文件路径
Future<File> _getLocalFile(String path) async {
  // 获取文档目录的路径
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String dir = appDocDir.path;
  final file = new File('$dir/$path');
  return file;
}

///读取文件内容
Future<String> readContent(String path,{String? keyString}) async {
  File file = await _getLocalFile(path);
  // 从文件中读取变量作为字符串，一次全部读完存在内存里面
  String  contents = await file.readAsString();
  if(keyString ==  null){
    return contents;
  }
  final key = Key.fromUtf8(keyString);
  final encrypt = Encrypter(AES(key, mode: AESMode.ecb));
  return encrypt.decrypt16(contents,iv: IV.fromUtf8(keyString));
}

///删除文件
Future<bool> deleteFile(String path) async{
  File file = await _getLocalFile(path);
  file.deleteSync();
  return true;
}