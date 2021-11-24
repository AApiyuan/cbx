import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoadListView extends StatefulWidget {
  BuildItem buildItem;
  LoadMoreCallback? loadMoreCallback;

  LoadListView({Key? key, required this.buildItem, this.loadMoreCallback}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoadListViewState(buildItem, loadMoreCallback: loadMoreCallback);
}

class LoadListViewState extends State<LoadListView> {
  static const bottomTag = "##bottom##";
  static const loadingTag = 1;
  static const endTag = 2;
  static const completeTag = 3;
  static const failTag = 4;
  static const emptyTag = 5;
  var data = <dynamic>[];
  var _loadState = emptyTag;

  BuildItem _buildItem;
  LoadMoreCallback? loadMoreCallback;

  LoadListViewState(this._buildItem, {this.loadMoreCallback}){
    if (loadMoreCallback != null) {
      data.add(bottomTag);
      loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (data[index] == bottomTag) {
            return _bottomView(context);
          }
          return _buildItem(getItem(index));
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: data.length);
  }

  getItem(int index) => data[index];

  Widget _bottomView(BuildContext context) {
    switch (_loadState) {
      case completeTag:
        {
          loading();
          /*if (loadMoreCallback != null) {
            loadMoreCallback();
          }*/
          loadMoreCallback?.call();
          return Center(
            child: Row(
              children: [
                CircularProgressIndicator(),
                Text("正在加载中..."),
              ],
            ),
          );
        }
      case loadingTag:
        return Row(
          children: [
            CircularProgressIndicator(),
            Text("正在加载中..."),
          ],
        );
      case failTag:
        return Center(
          child: Text("加载失败请重试"),
        );
    }
    return Center(
      child: Text("没有更多数据了哦~"),
    );
  }

  void addData(List<dynamic> list, [int index = -1]) {
    if (index < 0) {
      index = data.length - 1;
    }
    data.insertAll(index, list);
    setState(() {});
  }

  void loadComplete() => _loadState = completeTag;

  void loadFail() => _loadState = failTag;

  void loadEnd() => _loadState = endTag;

  void loading() => _loadState = loadingTag;

  int getLoadState() => _loadState;
}

typedef BuildItem = Widget Function(dynamic data);

typedef LoadMoreCallback = Function();