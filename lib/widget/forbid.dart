import 'package:flutter/cupertino.dart';

class Forbid extends StatefulWidget {
  final Widget child;
  final Function onTap;
  final HitTestBehavior behavior;

  Forbid({Key? key, required this.child, required this.onTap, this.behavior = HitTestBehavior.opaque}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ForbidState();
  }
}

class ForbidState extends State<Forbid> {

  bool can = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      onTap: () {
        if (can) {
          can = false;
          widget.onTap.call().then((v) => can = true);
        }
      },
      child: widget.child,
    );
  }
}
