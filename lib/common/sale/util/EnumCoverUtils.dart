/**
 * 字符串工具类
 */
class EnumCoverUtils{

  /**
   * 枚举转字符串
   */
  static String? enumsToString(dynamic dataEnum){
    return dataEnum == null ? null : dataEnum.toString().split(".")[1];
  }

  /**
   * 字符串转枚举
   */
  static T? stringToEnums<T>(String? data,List<T> dataEnum){
    if (data == null) return null;
    for(T enums in dataEnum){
      if(enums.toString().split(".")[1].startsWith(data)){
        return enums;
      }
    }
    throw new Exception("枚举" + data + "不存在");
  }
}