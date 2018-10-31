import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  final driver = SizedBox(height: 20.0);
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    userNameController.text = '账号';
    passwordController.text = '123456';
    const paddingValue = 30.0;
    var padding = Padding(
      padding: EdgeInsets.only(left: paddingValue, right: paddingValue),
      child: createColumn(context),);
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('登录页'),
            centerTitle: true,
          ),
          body: padding
      ),
    );
  }

  ///设置界面中的视图效果
  createColumn(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        driver,
        MyInputView(
            '请输入姓名', ImageIcon(AssetImage('images/userName_icon.png')),
            userNameController
        ),
        driver,
        MyInputView(
          '请输入密码', ImageIcon(AssetImage('images/password_icon.png')),
          passwordController,
          obscureText: true,
        ),
      ],);
  }
}

/// 只能输入数字
class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    var reg = new RegExp("^[0-9]+([.]{1}[0-9]+){0,1}\$");
    if (reg.hasMatch(newValue.text) || newValue.text.isEmpty) {
      return newValue;
    }
    return oldValue;
  }
}


///输入控件
class MyInputView extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final StatelessWidget icon;

  MyInputView(this.hintText, this.icon,
      this.controller, {this.obscureText = false});

  @override
  State<StatefulWidget> createState() {
    return MyInputViewState(
        hintText, icon, obscureText, controller);
  }

}

///输入控件的状态控制器
class MyInputViewState extends State<MyInputView> {
  final controller;
  final obscureText;
  final hintText;
  final icon;
  final focusNode = FocusNode();

  MyInputViewState(this.hintText, this.icon,
      this.obscureText, this.controller);

  ///边框的默认颜色
  var borderColor = Colors.grey;
  var inputBorder;

  @override
  Widget build(BuildContext context) {
    focusNode.addListener(() {
      setState(() {
        borderColor = focusNode.hasFocus ? Theme
            .of(context)
            .primaryColor : Colors.grey;
      });
    });
    inputBorder = BoxDecoration(
      border: Border.all(color: borderColor, width: 1.5),
    );
    return Container(
      child: createInputView(
          hintText, icon, controller, obscureText),
    );
  }

  ///创建输入框
  createInputView(hint, icon, controller, obscureText) {
    return Container(
        padding: EdgeInsets.only(left: 10.0),
        child: TextField(
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
              icon: icon,
              hintText: hint,
              border: InputBorder.none
          ),
          obscureText: obscureText,
        ),
        decoration: inputBorder
    );
  }
}
