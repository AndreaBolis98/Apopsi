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
import 'changeAvater.dart' as changeAvatar_page;
import 'ProfilePage.dart' as profile_page;
import 'AddPAge.dart' as add_page;

late bool change = false;
int avatarSelected = 0;
late String userName;
late String email;
late String nome;
late String cognome;
TextEditingController nomeController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController usernameController = TextEditingController();
TextEditingController cognomeController = TextEditingController();

class MyEditProfilePage extends StatelessWidget {
  const MyEditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Apops Edit Page",
      home: MyEditProfileield(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: Theme.of(context).textTheme.copyWith(
                subtitle1: const TextStyle(color: Colors.white),
              )),
    );
  }
}

class MyEditProfileield extends StatefulWidget {
  @override
  State<MyEditProfileield> createState() => MyEdidtProfileState();
}

class MyEdidtProfileState extends State<MyEditProfileield> {
  @override
  void initState() {
    super.initState();
    avatarSelected = home_page.avatar;
    email = home_page.email;
    userName = home_page.username;
    nome = home_page.nome;
    cognome = home_page.cognome;
    nomeController.text = "";
    emailController.text = "";
    usernameController.text = "";
    cognomeController.text = "";
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
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                    top: main_page.MyResponsive().HeightResponsive(4),
                    left: main_page.MyResponsive().HeightResponsive(3),
                    child: add_page.MyIconButton(
                      Icon(Icons.keyboard_arrow_left_sharp),
                      () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    profile_page.MyProfilePage()))
                      },
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: 92,
                      ),
                      width: main_page.MyResponsive().WidthResponsive(23.9),
                      height: main_page.MyResponsive().HeightResponsive(12.26),
                      child: Image(
                          image: AssetImage(
                              'images/avatar_${avatarSelected}.png')),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 77),
                        child: MyProfileEditFiled(
                            leftText: "Nome",
                            hintText: nome,
                            controller: nomeController,
                            error: false)),
                    Container(
                        margin: EdgeInsets.only(top: 24),
                        child: MyProfileEditFiled(
                            leftText: "Cognome",
                            hintText: cognome,
                            controller: cognomeController,
                            error: false)),
                    Container(
                        margin: EdgeInsets.only(top: 24),
                        child: MyProfileEditFiled(
                            leftText: "Username",
                            hintText: userName,
                            controller: usernameController,
                            error: false)),
                    Container(
                        margin: EdgeInsets.only(top: 24),
                        child: MyProfileEditFiled(
                            leftText: "Mail",
                            hintText: email,
                            controller: emailController,
                            error: false)),
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
                              if (nomeController.text != "") {
                                nome = nomeController.text;
                              }
                              if (emailController.text != "") {
                                email = emailController.text;
                              }
                              if (usernameController.text != "") {
                                userName = usernameController.text;
                              }
                              if (cognomeController.text != "") {
                                cognome = cognomeController.text;
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => changeAvatar_page
                                          .MyChangeAvatarPagePage()));
                            })))
                  ],
                ),
              ],
            )));
  }
}

class MyTextEditInput extends StatefulWidget {
  MyTextEditInput(this._text, this._controller, this._error, {super.key});
  final String _text;
  final TextEditingController _controller;
  final bool _error;

  @override
  State<MyTextEditInput> createState() => _MyTextEdittate();
}

class _MyTextEdittate extends State<MyTextEditInput> {
  late TextEditingController myController = widget._controller;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    //print('Second text field: ${myController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,

      //style: TextStyle(background: Color.fromARGB(255, 61, 61, 63),)
      decoration: InputDecoration(
        filled: true,
        hoverColor: Color.fromARGB(100, 255, 255, 255),
        fillColor: widget._error
            ? Color.fromARGB(255, 255, 61, 63)
            : Color.fromARGB(0, 61, 61, 63),
        focusColor: Color.fromARGB(255, 255, 255, 255),
        hintText: widget._text,
        hintStyle: TextStyle(
          fontSize: 15.0,
          fontFamily: "coolvetica",
          color: Color.fromARGB(100, 255, 255, 255),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),

      controller: widget._controller,
      onChanged: (text) {
        change = true;
      },
    );
  }
}

Widget MyProfileEditFiled({
  required String leftText,
  required String hintText,
  required TextEditingController controller,
  required bool error,
}) {
  return SizedBox(
      width: 322,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          decoration: const BoxDecoration(
              color: true
                  ? Color.fromRGBO(61, 61, 63, 1)
                  : Color.fromRGBO(255, 0, 0, 1)),
          child: Stack(
            children: <Widget>[
              Container(
                height: 50,
                width: 80,
                padding: EdgeInsets.only(top: 16, left: 16),
                child: main_page.MyTextResponsive(
                    text: leftText,
                    size: 15,
                    color: Colors.white,
                    TextAlign: TextAlign.left),
              ),
              Positioned(
                  top: 0,
                  height: 50,
                  width: 200,
                  left: 122,
                  child: MyTextEditInput(hintText, controller, false))
            ],
          ),
        ),
      ));
}
