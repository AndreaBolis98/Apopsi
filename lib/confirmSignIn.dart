import 'dart:ffi';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import './main.dart' as main_page;
import 'LoginSubmitPage.dart' as loginSub_page;
import './LoginPage.dart' as login_page;
import 'SignPage.dart' as signin_page;
import 'HomePage.dart' as home_page;
import 'selectAvatar.dart' as avatar_page;
import 'selectInterest.dart' as sel_int;

class MyConfirmSignFiledPage extends StatelessWidget {
  const MyConfirmSignFiledPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My Apops Login Filed", home: MyConfirmSignField());
  }
}

class MyConfirmSignField extends StatefulWidget {
  @override
  State<MyConfirmSignField> createState() => MyConfirmSignState();
}

class MyConfirmSignState extends State<MyConfirmSignField> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  int avatarSelected = 0;
  late String userName;
  late String nome_cognome;
  late String email;
  late String pw;
  late String nome;
  late String cognome;

  @override
  void initState() {
    super.initState();
    avatarSelected = avatar_page.avatarSelected;
    email = signin_page.Email;
    userName = signin_page.Username;
    nome = signin_page.Nome;
    cognome = signin_page.Cognome;
    nome_cognome = signin_page.Nome + " " + signin_page.Cognome;
    pw = signin_page.Pw;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: main_page.BgColor.color(),
        body: Container(
          width: main_page.MyResponsive().WidthResponsive(100),
          height: main_page.MyResponsive().HeightResponsive(100),
          //padding: EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(9.31)),
                width: main_page.MyResponsive().WidthResponsive(23.9),
                height: main_page.MyResponsive().HeightResponsive(12.26),
                child: Image(
                    image: AssetImage('images/avatar_${avatarSelected}.png')),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: main_page.MyResponsive().HeightResponsive(0)),
                  child: avatar_page.MyTextDescription(text: userName)),
              Container(
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(11.5)),
                width: main_page.MyResponsive().WidthResponsive(65.6),
                height: main_page.MyResponsive().HeightResponsive(4.9),
                child: login_page.MyTextInput(
                    nome_cognome, false, nomeController, false),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(2)),
                width: main_page.MyResponsive().WidthResponsive(65.6),
                height: main_page.MyResponsive().HeightResponsive(4.9),
                child: login_page.MyTextInput(
                    email, false, emailController, false),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(2)),
                width: main_page.MyResponsive().WidthResponsive(65.6),
                height: main_page.MyResponsive().HeightResponsive(4.9),
                child: login_page.MyTextInput(pw, true, pwController, false),
              ),
              Container(
                  margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(12),
                  ),
                  width: main_page.MyResponsive().WidthResponsive(41.28),
                  height: main_page.MyResponsive().HeightResponsive(4.9),
                  child: loginSub_page.MyLoginSigInButton(
                      bgColor: Color.fromARGB(255, 206, 162, 241),
                      text: 'continua',
                      onPress: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    sel_int.MyInterestPage()));
                      })))
            ],
          ),
        ));
  }
}
