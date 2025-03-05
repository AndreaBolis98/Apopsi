import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import './main.dart' as main_page;
import 'LoginSubmitPage.dart' as loginSub_page;
import 'HomePage.dart' as home_page;
import 'selectAvatar.dart' as avatar_page;
import 'LoginPage.dart' as login_page;

late String Email;
late String Nome;
late String Cognome;
late String Username;
late String Pw;

class MySignPageFiled extends StatelessWidget {
  const MySignPageFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          title: "My Apops signin Filed",
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Theme.of(context).textTheme.copyWith(
                    subtitle1: const TextStyle(color: Colors.white),
                  )),
          home: MySigninField(),
        ));
  }
}

class MySigninField extends StatefulWidget {
  @override
  State<MySigninField> createState() => MySigninFieldState();
}

class MySigninFieldState extends State<MySigninField> {
  final String myText = "la tua voce sulle arti !";
  late DatabaseReference dbRef;
  TextEditingController emailController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController cognomeController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController againPWController = TextEditingController();

  bool emailok = false;
  bool nomeok = false;
  bool cognomeok = false;
  bool usernameok = false;
  bool pwok = false;
  bool againPWok = false;

  Future signIn() async {
    emailok = await readFromDB(emailController.text, dbRef);
    nomeok = await checkValidity(nomeController.text);
    cognomeok = await checkValidity(cognomeController.text);
    usernameok = await checkUsrn(usernameController.text, dbRef);
    pwok = await checkPW(pwController.text, againPWController.text);

    if (emailok == false &&
        nomeok == false &&
        cognomeok == false &&
        usernameok == false &&
        pwok == false) {
      Email = emailController.text;
      Nome = nomeController.text;
      Cognome = cognomeController.text;
      Username = usernameController.text;
      Pw = pwController.text;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => avatar_page.MyAvatarPageFiled()));
      /*WriteUserOnDB(dbRef, emailController.text, nomeController.text,
          cognomeController.text, usernameController.text, pwController.text);*/
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('User');
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
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(13)),
                child: main_page.MyApopsandText(),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(6.63)),
                width: 256,
                height: 42,
                child: login_page.MyTextInput(
                    "Email", false, emailController, emailok),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(2)),
                width: 256,
                height: 42,
                child: login_page.MyTextInput(
                    "Nome", false, nomeController, nomeok),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(2)),
                width: 256,
                height: 42,
                child: login_page.MyTextInput(
                    "Cognome", false, cognomeController, cognomeok),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(2)),
                width: 256,
                height: 42,
                child: login_page.MyTextInput(
                    "Username", false, usernameController, usernameok),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(2)),
                width: 256,
                height: 42,
                child: login_page.MyTextInput(
                    "Password", true, pwController, pwok),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(2)),
                width: 256,
                height: 42,
                child: login_page.MyTextInput(
                    "Ripeti password", true, againPWController, pwok),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: main_page.MyResponsive().HeightResponsive(2)),
                  width: 161,
                  height: 42,
                  child: loginSub_page.MyLoginSigInButton(
                      bgColor: Color.fromARGB(255, 206, 162, 241),
                      text: 'continua',
                      onPress: (() {
                        signIn();
                      })))
            ],
          ),
        ));
  }
}

Future<bool> checkPW(String text, String againText) async {
  if (!await checkValidity(text)) {
    return text != againText;
  }
  return true;
}

Future<bool> checkUsrn(text, db) async {
  if (!await checkValidity(text)) {
    final snapshot = await db.child(text).get();
    return snapshot.exists;
  }
  return true;
}

Future<bool> checkEmail(text, db) async {
  return true;
}

Future<bool> checkValidity(String text) async {
  //print(text.isEmpty);
  return text.isEmpty;
}

final List<User> list = [];
Future<bool> readFromDB(String text, db) async {
  final snapshot = await db.get();
  late bool errorEmail = false;
  if (snapshot.exists) {
    final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      final user = User.fromMap(value);
      if (user.email == text) {
        errorEmail = true;
      }
    });
    //print(errorEmail);
    if (text.isEmpty == true) {
      errorEmail = true;
    }
  }
  return errorEmail;
}

class User {
  final String email;

  const User({
    required this.email,
  });

  factory User.fromMap(Map<dynamic, dynamic> map) {
    //print(map);
    return User(email: map['email'] ?? '');
  }
}
