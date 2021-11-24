//调拨单类型
enum TransferOrderType {
  transferIn, //调入
  transferOut //调出
}

extension TransferOrderTypeExtension on TransferOrderType{
  // String get name => describeEnum(this);
  // String describeEnum(Object enumEntry) {
  //   final String description = enumEntry.toString();
  //   final int indexOfDot = description.indexOf('.');
  //   assert(indexOfDot != -1 && indexOfDot <     description.length - 1);
  //   return description.substring(indexOfDot + 1);
  // }
  String get enumString {
    switch (this) {
      case TransferOrderType.transferIn:
        return 'TRANSFERIN';
      case TransferOrderType.transferOut:
        return 'TRANSFEROUT';
      default:
        return 'TRANSFERIN';
    }
  }
}

//调拨单选择类型
enum TransferSelectType {
  distribution, //配货调拨
  direct,       //直接调拨
  apply,        //申请调拨
  substandard   //次品调拨
}

extension TransferSelectTypeExtension on TransferSelectType{
  String get enumString {
    switch (this) {
      case TransferSelectType.distribution:
        return 'DISTRIBUTION';
      case TransferSelectType.direct:
        return 'DIRECT';
      case TransferSelectType.apply:
        return 'APPLY';
      case TransferSelectType.substandard:
        return 'SUBSTANDARD';
      default:
        return 'DISTRIBUTION';
    }
  }
}
