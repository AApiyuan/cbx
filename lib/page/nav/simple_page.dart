import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/widget/CheetahButton.dart';

class NavSimplePage extends StatelessWidget {
  final String? title = Get.parameters['title'];
  final String? name = Get.parameters['name'];

  final String argName = Get.arguments;
  @override
  Widget build(BuildContext context) {
    print(Get.parameters);
    return Scaffold(
      appBar: AppBar(title: Text(title ?? 'SimplePage')),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Text(
                name ?? argName,
                style: TextStyle(fontSize: 32),
              ),
              SizedBox(height: 16),
              SizedBox(height: 16),
              CheetahButton(
                '携带返回值返回',
                () => Get.back(result: '新垣结衣'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
