import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        createColumnDriver(20.0),
        Image.asset('images/fish.png', color: Theme
            .of(context)
            .primaryColor,),
        createColumnDriver(20.0),
        MyInputView(
            '请输入姓名', ImageIcon(AssetImage('images/userName_icon.png')),
            userNameController
        ),
        createColumnDriver(20.0),
        MyInputView(
          '请输入密码', ImageIcon(AssetImage('images/password_icon.png')),
          passwordController,
          obscureText: true,
        ),
        createColumnDriver(30.0),
        createLoginBtn(context)
      ],);
  }

  ///垂直间隔
  createColumnDriver(double height) => SizedBox(height: height);

  ///登录按钮
  createLoginBtn(context) {
    var loginBtn = RaisedButton(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text('登录',
          style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      onPressed: onClickLogin,
      textColor: Colors.white,
      highlightColor: Theme
          .of(context)
          .primaryColorDark,
      color: Theme
          .of(context)
          .primaryColor,
      shape: StadiumBorder(),
    );
    return Row(children: <Widget>[
      Expanded(
        child: loginBtn,
      )
    ],);
  }

  ///登录
  onClickLogin() {
    Fluttertoast.showToast(
        msg: '账号：${userNameController.text}\n密码：${passwordController.text}');
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
        border: Border.all(
          color: borderColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(10.0)
        )
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
