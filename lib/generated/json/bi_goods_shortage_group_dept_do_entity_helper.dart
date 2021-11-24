import 'package:haidai_flutter_module/page/bi/model/res/bi_goods_shortage_group_dept_do_entity.dart';

biGoodsShortageGroupDeptDoEntityFromJson(BiGoodsShortageGroupDeptDoEntity data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
	}
	if (json['shortageNum'] != null) {
		data.shortageNum = json['shortageNum'] is String
				? int.tryParse(json['shortageNum'])
				: json['shortageNum'].toInt();
	}
	return data;
}

Map<String, dynamic> biGoodsShortageGroupDeptDoEntityToJson(BiGoodsShortageGroupDeptDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['deptName'] = entity.deptName;
	data['shortageNum'] = entity.shortageNum;
	return data;
}