import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SkuListView extends StatelessWidget {
  Widget skuBar;
  SkuItem skuItem;
  List<dynamic> skuList;

  SkuListView(this.skuBar, this.skuItem, this.skuList);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        skuBar,
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return skuItem.call(skuList[index], index);
            },
            itemCount: skuList.length,
          ),
        ),
      ],
    );
  }
}

typedef SkuItem = Widget Function(dynamic, int);
