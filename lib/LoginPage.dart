import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import './main.dart' as main_page;
import 'LoginSubmitPage.dart' as login_page;
import 'HomePage.dart' as home_page;
import 'selectInterest.dart' as select_page;

TextEditingController usrController = TextEditingController();
TextEditingController pwController = TextEditingController();

class MyLoginPageFiled extends StatelessWidget {
  const MyLoginPageFiled({super.key});

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
          title: "My Apops Login Filed",
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Theme.of(context).textTheme.copyWith(
                    subtitle1: const TextStyle(color: Colors.white),
                  )),
          home: MyLoginField(),
        ));
  }
}

class MyLoginField extends StatefulWidget {
  @override
  State<MyLoginField> createState() => _MyLoginFieldState();
}

class _MyLoginFieldState extends State<MyLoginField> {
  final String myText = "la tua voce sulle arti !";

  late DatabaseReference dbRef;

  late bool err_db = false;

  Future login() async {
    setState(() {
      readFromDB(dbRef).then((value) {
        //print(value);
        if (value == false) {
          err_db = true;
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => home_page.MyHome()));
        }
      });
    });
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
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    bottom: main_page.MyResponsive().HeightResponsive(11)),
                child: main_page.MyApopsandText(),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: main_page.MyResponsive().HeightResponsive(2)),
                width: 256,
                height: 42,
                child: MyTextInput("Email", false, usrController, err_db),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: main_page.MyResponsive().HeightResponsive(2)),
                width: 256,
                height: 42,
                child: MyTextInput("Password", true, pwController, err_db),
              ),
              Container(
                  margin: EdgeInsets.only(
                      bottom: main_page.MyResponsive().HeightResponsive(5.9)),
                  width: 161,
                  height: 42,
                  child: login_page.MyLoginSigInButton(
                      bgColor: Color.fromARGB(255, 206, 162, 241),
                      text: 'log in',
                      onPress: login)),
              Container(
                width: main_page.MyResponsive().WidthResponsive(100),
                height: main_page.MyResponsive().HeightResponsive(29.03),
                margin: EdgeInsets.only(top: 0),
                child: Image(image: AssetImage('images/MaskGroup.png')),
              )
            ],
          ),
        ));
  }
}

class MyTextInput extends StatefulWidget {
  MyTextInput(this._text, this._isPW, this._controller, this._error,
      {super.key});
  final String _text;
  final bool _isPW;
  final TextEditingController _controller;
  final bool _error;

  @override
  State<MyTextInput> createState() => _MyTextInputState();
}

class _MyTextInputState extends State<MyTextInput> {
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
      obscureText: widget._isPW,
      //style: TextStyle(background: Color.fromARGB(255, 61, 61, 63),)
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        filled: true,
        hoverColor: Color.fromARGB(100, 255, 255, 255),
        fillColor: widget._error
            ? Color.fromARGB(255, 255, 61, 63)
            : Color.fromARGB(255, 61, 61, 63),
        focusColor: Color.fromARGB(255, 255, 255, 255),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        hintText: widget._text,
        hintStyle: TextStyle(
          fontSize: 17.0,
          fontFamily: "coolvetica",
          color: Color.fromARGB(100, 255, 255, 255),
        ),
      ),

      controller: widget._controller,
      onChanged: (text) {
        //FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}

class Utente {
  late String username;
  late String password;
}

LoginPressed(_usr, _pw) {
  print(_usr);
  print(_pw);
  return true;
}

//manage user DB
final List<User> list = [];
Future<bool> readFromDB(db) async {
  var email = usrController.text;
  var pw = pwController.text;
  final snapshot = await db.get();
  late bool validUser = false;
  if (snapshot.exists) {
    final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      final user = User.fromMap(value);
      list.add(user);
      if (user.email == email && user.pw == pw) {
        var avatar = int.parse(user.avatar);
        var interest = json.decode(user.interest);
        select_page.writeUserFile(user.email, user.nome, user.cognome,
            user.username, avatar, interest);
        select_page.initUserVariable(user.email, user.nome, user.cognome,
            user.username, avatar, interest);
        validUser = true;
      }
    });
  }
  if (validUser == null) {
    validUser = false;
  }

  return validUser;
}

class User {
  final String nome;
  final String cognome;
  final String username;
  final String avatar;
  final String email;
  final String pw;
  final String interest;

  const User(
      {required this.nome,
      required this.cognome,
      required this.username,
      required this.avatar,
      required this.email,
      required this.pw,
      required this.interest});

  factory User.fromMap(Map<dynamic, dynamic> map) {
    return User(
        nome: map['nome'] ?? '',
        cognome: map['cognome'] ?? '',
        username: map['username'] ?? '',
        avatar: map['avatar'] ?? '',
        email: map['email'] ?? '',
        pw: map['password'] ?? '',
        interest: map['interest'] ?? '');
  }
}
