import 'dart:ffi';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import './main.dart' as main_page;
import 'LoginSubmitPage.dart' as login_page;
import 'SignPage.dart' as signin_page;
import 'HomePage.dart' as home_page;
import 'confirmSignIn.dart' as confirmSignIn_page;

int avatarSelected = 0;

class MyAvatarPageFiled extends StatelessWidget {
  const MyAvatarPageFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "My Apops Login Filed", home: MyAvatarField());
  }
}

class MyAvatarField extends StatefulWidget {
  @override
  State<MyAvatarField> createState() => _MyAvatarFieldState();
}

class _MyAvatarFieldState extends State<MyAvatarField> {
  int selWidget = 0;
  bool visibility = false;

  selectWidget(int id) {
    visibility = true;
    selWidget = id;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: main_page.BgColor.color(),
      body: Stack(
        //padding: EdgeInsets.only(top: 50),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: main_page.MyResponsive().HeightResponsive(5)),
            child: MyTextDescription(text: "Scegli il tuo avatar"),
          ),
          Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(26.06),
                  left: main_page.MyResponsive().WidthResponsive(16)),
              width: main_page.MyResponsive().WidthResponsive(23.9),
              height: main_page.MyResponsive().HeightResponsive(12.26),
              child: MyIconButton(
                  id: 1,
                  img: selWidget != 1
                      ? const AssetImage('images/avatar_1.png')
                      : const AssetImage('images/avatar_1_round.png'),
                  onPress: () => selectWidget(1))),
          Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(26.06),
                  left: main_page.MyResponsive().WidthResponsive(56.9)),
              width: main_page.MyResponsive().WidthResponsive(23.9),
              height: main_page.MyResponsive().HeightResponsive(12.26),
              child: MyIconButton(
                  id: 2,
                  img: selWidget != 2
                      ? const AssetImage('images/avatar_2.png')
                      : const AssetImage('images/avatar_2_round.png'),
                  onPress: () => selectWidget(2))),
          Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(45),
                  left: main_page.MyResponsive().WidthResponsive(16)),
              width: main_page.MyResponsive().WidthResponsive(23.9),
              height: main_page.MyResponsive().HeightResponsive(12.26),
              child: MyIconButton(
                  id: 3,
                  img: selWidget != 3
                      ? const AssetImage('images/avatar_3.png')
                      : const AssetImage('images/avatar_3_round.png'),
                  onPress: () => selectWidget(3))),
          Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(45),
                  left: main_page.MyResponsive().WidthResponsive(56.9)),
              width: main_page.MyResponsive().WidthResponsive(23.9),
              height: main_page.MyResponsive().HeightResponsive(12.26),
              child: MyIconButton(
                  id: 4,
                  img: selWidget != 4
                      ? const AssetImage('images/avatar_4.png')
                      : const AssetImage('images/avatar_4_round.png'),
                  onPress: () => selectWidget(4))),
          Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(64.9),
                  left: main_page.MyResponsive().WidthResponsive(16)),
              width: main_page.MyResponsive().WidthResponsive(23.9),
              height: main_page.MyResponsive().HeightResponsive(12.26),
              child: MyIconButton(
                  id: 5,
                  img: selWidget != 5
                      ? const AssetImage('images/avatar_5.png')
                      : const AssetImage('images/avatar_5_round.png'),
                  onPress: () => selectWidget(5))),
          Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(64.9),
                  left: main_page.MyResponsive().WidthResponsive(56.9)),
              width: main_page.MyResponsive().WidthResponsive(23.9),
              height: main_page.MyResponsive().HeightResponsive(12.26),
              child: MyIconButton(
                  id: 6,
                  img: selWidget != 6
                      ? const AssetImage('images/avatar_6.png')
                      : const AssetImage('images/avatar_6_round.png'),
                  onPress: () => selectWidget(6))),
          Visibility(
              visible: visibility,
              child: Container(
                  margin: EdgeInsets.only(
                      top: main_page.MyResponsive().HeightResponsive(82.48),
                      left: main_page.MyResponsive().WidthResponsive(29.48)),
                  width: main_page.MyResponsive().WidthResponsive(41.28),
                  height: main_page.MyResponsive().HeightResponsive(4.9),
                  child: login_page.MyLoginSigInButton(
                      bgColor: Color.fromARGB(255, 206, 162, 241),
                      text: 'continua',
                      onPress: (() {
                        avatarSelected = selWidget;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => confirmSignIn_page
                                    .MyConfirmSignFiledPage()));
                      }))))
        ],
      ),
    );
  }
}

Widget MyTextDescription({
  required String text,
}) {
  return Container(
      width: main_page.MyResponsive().WidthResponsive(100),
      margin: EdgeInsets.only(
          top: main_page.MyResponsive().HeightResponsive(12),
          left: main_page.MyResponsive().HeightResponsive(0)),
      child: main_page.MyTextResponsive(
          text: text,
          color: Colors.white,
          size: 30,
          TextAlign: TextAlign.center));
}

Widget MyIconButton({
  required int id,
  required AssetImage img,
  required VoidCallback onPress,
}) {
  return GestureDetector(
      onTap: onPress,
      child: Image(
        image: img,
      ));
}
