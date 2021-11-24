import 'package:flutter/cupertino.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_manager.dart';


class KeyboardMediaQuery extends StatefulWidget{
  final Widget child;

  KeyboardMediaQuery({required this.child});

  @override
  State<StatefulWidget> createState() =>KeyboardMediaQueryState();

}

class KeyboardMediaQueryState extends State<KeyboardMediaQuery >{
  double keyboardHeight = 0;
  ValueNotifier<double> keyboardHeightNotifier = CoolKeyboard.getKeyboardHeightNotifier();

  @override
  void initState(){
    super.initState();
    CoolKeyboard.getKeyboardHeightNotifier().addListener(onUpdateHeight);
  }

  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    var data = MediaQuery.maybeOf(context);
    if(data == null){
      data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    }
    var bottom = CoolKeyboard.getKeyboardHeightNotifier().value != 0 ? CoolKeyboard.getKeyboardHeightNotifier().value : data.viewInsets.bottom;
    // TODO: implement build
    return MediaQuery(
        child: widget.child,
        data:data.copyWith(
          viewInsets: data.viewInsets.copyWith(
            bottom: bottom
          )
        )
    );
  }

  onUpdateHeight(){
    try{
      setState(()=>{});
    }catch(_){
      WidgetsBinding.instance!.addPostFrameCallback((_){
        setState(()=>{});
      });
    }
  }

  @override
  void dispose(){
    super.dispose();
    CoolKeyboard.getKeyboardHeightNotifier().removeListener(onUpdateHeight);
  }
}