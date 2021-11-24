part of '../sql_db.dart';

///读取内容
Future<String> readContents(String contents,{String? keyString}) async {
  if(keyString ==  null){
    return contents;
  }
  final key = Key.fromUtf8(keyString);
  final encrypt = Encrypter(AES(key, mode: AESMode.ecb));
  return encrypt.decrypt16(contents,iv: IV.fromUtf8(keyString));
}