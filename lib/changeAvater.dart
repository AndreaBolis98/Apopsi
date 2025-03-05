import 'dart:ffi';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import './main.dart' as main_page;
import 'LoginSubmitPage.dart' as login_page;
import 'SignPage.dart' as signin_page;
import 'HomePage.dart' as home_page;
import 'confirmSignIn.dart' as confirmSignIn_page;
import 'AddPAge.dart' as add_page;
import 'editProfile.dart' as edit_profile;
import 'ProfilePage.dart' as profile_page;

int avatarSelected = 0;

class MyChangeAvatarPagePage extends StatelessWidget {
  const MyChangeAvatarPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My Apops Login Filed", home: MyChangeAvatarField());
  }
}

class MyChangeAvatarField extends StatefulWidget {
  @override
  State<MyChangeAvatarField> createState() => _MyChangeAvatarFieldState();
}

class _MyChangeAvatarFieldState extends State<MyChangeAvatarField> {
  int selWidget = 0;
  bool visibility = false;

  void initState() {
    super.initState();
    avatarSelected = home_page.avatar;
  }

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
                  top: main_page.MyResponsive().HeightResponsive(4),
                  left: main_page.MyResponsive().HeightResponsive(3)),
              child: add_page.MyIconButton(
                Icon(Icons.keyboard_arrow_left_sharp),
                () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              edit_profile.MyEditProfilePage()))
                },
              )),
          Positioned(
              top: main_page.MyResponsive().HeightResponsive(92 / 8.44),
              width: main_page.MyResponsive().WidthResponsive(100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Positioned(
                    height: main_page.MyResponsive().HeightResponsive(12.26),
                    child: Image(
                        image:
                            AssetImage('images/avatar_${avatarSelected}.png')),
                  ),
                  SizedBox(
                    height: main_page.MyResponsive().HeightResponsive(6 / 8.44),
                  ),
                  Positioned(
                      top:
                          main_page.MyResponsive().HeightResponsive(150 / 8.44),
                      width: main_page.MyResponsive().WidthResponsive(100),
                      child: main_page.MyTextResponsive(
                          text: "Il tuo avatar",
                          color: Color.fromRGBO(255, 255, 255, 1),
                          size: 17,
                          TextAlign: TextAlign.center)),
                ],
              )),
          Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(303 / 8.44),
                  left: main_page.MyResponsive().WidthResponsive(66 / 3.9)),
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
                  top: main_page.MyResponsive().HeightResponsive(303 / 8.44),
                  left: main_page.MyResponsive().WidthResponsive(230 / 3.9)),
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
                  top: main_page.MyResponsive().HeightResponsive(482 / 8.44),
                  left: main_page.MyResponsive().WidthResponsive(66 / 3.9)),
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
                  top: main_page.MyResponsive().HeightResponsive(482 / 8.44),
                  left: main_page.MyResponsive().WidthResponsive(230 / 3.9)),
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
                  top: main_page.MyResponsive().HeightResponsive(624 / 8.44),
                  left: main_page.MyResponsive().WidthResponsive(66 / 3.9)),
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
                  top: main_page.MyResponsive().HeightResponsive(624 / 8.44),
                  left: main_page.MyResponsive().WidthResponsive(230 / 3.9)),
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
                      top: main_page.MyResponsive().HeightResponsive(90),
                      left: main_page.MyResponsive().WidthResponsive(29.48)),
                  width: main_page.MyResponsive().WidthResponsive(41.28),
                  height: main_page.MyResponsive().HeightResponsive(4.9),
                  child: login_page.MyLoginSigInButton(
                      bgColor: Color.fromARGB(255, 206, 162, 241),
                      text: 'continua',
                      onPress: (() {
                        String originalMAil = home_page.email;
                        avatarSelected = selWidget;
                        home_page.email = edit_profile.email;
                        home_page.nome = edit_profile.nome;
                        home_page.cognome = edit_profile.cognome;
                        home_page.avatar = edit_profile.avatarSelected;
                        updateDB(originalMAil);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    profile_page.MyProfilePage()));
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

Future updateDB(String _originalMail) async {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('User');

  dbRef.child(_originalMail).update({
    'avatar': avatarSelected.toString(),
    'email': edit_profile.email,
    'nome': edit_profile.nome,
    'cognome': edit_profile.cognome,
    'username': edit_profile.userName,
  });
  final snapshot = await dbRef.child(_originalMail).get();

  if (snapshot.exists) {
    final map = snapshot.value;
    dbRef.child(edit_profile.email).set(map);
  }

  await dbRef.child(_originalMail).remove();
}
