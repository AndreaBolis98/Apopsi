import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import './main.dart' as main_page;
import 'LoginSubmitPage.dart' as loginSigIn_page;
import 'HomePage.dart' as home_page;
import 'LoginPage.dart' as login_page;
import 'camera_page.dart' as camera_page;
import 'AddPage.dart' as add_page;
import 'editProfile.dart' as editProfile_page;
import 'Collezione.dart' as collect_page;
import 'appuntamenti.dart' as app_page;

class MyProfilePage extends StatelessWidget {
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
            title: "My Apops ProfilePAge",
            theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: Theme.of(context).textTheme.copyWith(
                      subtitle1: const TextStyle(color: Colors.white),
                    )),
            home: MyProfile()));
  }
}

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: main_page.BgColor.color(),
      body: MyProfileField(),
      bottomNavigationBar: home_page.MyBottomNavigationBar(2),
    );
  }
}

class MyProfileField extends StatefulWidget {
  @override
  State<MyProfileField> createState() => _MyProfileFieldState();
}

class _MyProfileFieldState extends State<MyProfileField> {
  late DatabaseReference dbRef;
  late int avatarSelected;
  late String name;
  late int friend;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('User');
    avatarSelected = home_page.avatar;
    name = home_page.nome;
    friend = 10;
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: main_page.BgColor.color(),
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(0),
              height: main_page.MyResponsive().HeightResponsive(23.58),
              width: main_page.MyResponsive().WidthResponsive(100),
              child: MyAddBg(),
            ),
            Container(
                margin: EdgeInsets.all(0),
                height: main_page.MyResponsive().HeightResponsive(23.58),
                width: main_page.MyResponsive().WidthResponsive(100),
                decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5))),
            Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(18.86)),
              child: add_page.MyExtraContent(),
            ),
            Container(
              margin: EdgeInsets.only(
                top: main_page.MyResponsive().HeightResponsive(13.03),
                left: main_page.MyResponsive().WidthResponsive(12.5),
              ),
              width: 86.81,
              height: 135.12,
              child: Image(
                  image: AssetImage('images/avatar_${avatarSelected}.png')),
            ),
            Container(
              margin: EdgeInsets.only(
                top: main_page.MyResponsive().HeightResponsive(18.7),
                left: main_page.MyResponsive().WidthResponsive(38.7),
              ),
              height: 60,
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      main_page.MyTextResponsive(
                          text: name,
                          size: 28,
                          color: Colors.white,
                          TextAlign: TextAlign.left),
                      Padding(padding: EdgeInsets.only(bottom: 3)),
                      main_page.MyTextResponsive(
                          text: "$friend amici",
                          size: 17,
                          color: Color.fromRGBO(187, 225, 67, 1),
                          TextAlign: TextAlign.left),
                    ],
                  )),
            ),
            Positioned(
              top: main_page.MyResponsive().HeightResponsive(19.19),
              left: main_page.MyResponsive().WidthResponsive(84.87),
              child: IconButton(
                  color: Color.fromARGB(255, 255, 255, 255),
                  iconSize: 20,
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const editProfile_page.MyEditProfilePage()));
                  }),
            ),
            Container(
                /*left: 30,
              height: 500,*/
                width: 314,
                margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(30.9),
                  left: main_page.MyResponsive().WidthResponsive(9.7),
                ),
                child: GridView.count(
                    padding: EdgeInsets.zero,
                    mainAxisSpacing: 32,
                    crossAxisSpacing: 32,
                    childAspectRatio: (314 / 220),
                    crossAxisCount: 1,
                    children: <Widget>[
                      Container(
                          //margin: EdgeInsets.only(top: 251, left: 38),
                          child: MyPrifileCustoButton(
                        bgColor: const Color.fromRGBO(206, 162, 241, 1),
                        text: "La mia collezione",
                        imagePath: 'images/collezione.png',
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      collect_page.MyCollectPage()));
                        },
                      )),
                      Container(
                          //margin: EdgeInsets.only(top: 510, left: 38),
                          child: MyPrifileCustoButton(
                        bgColor: Color.fromRGBO(215, 19, 75, 1),
                        text: "Prossimi appuntamenti",
                        imagePath: 'images/appuntamenti.png',
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      app_page.MyAppuntamentiPage()));
                        },
                      ))
                    ])),
          ],
        ));
  }
}

class MyAddBg extends StatelessWidget {
  const MyAddBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/sfondo_profilo.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

Widget MyPrifileCustoButton({
  required String text,
  required Color bgColor,
  required String imagePath,
  required final VoidCallback onPress,
}) {
  return GestureDetector(
      onTap: onPress,
      child: SizedBox(
          width: 314,
          height: 220,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(21)),
            child: Container(
              decoration: BoxDecoration(color: bgColor),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 25, left: 25),
                    child: main_page.MyTextResponsive(
                        text: text,
                        size: 28,
                        color: Colors.white,
                        TextAlign: TextAlign.left),
                  ),
                  Positioned(
                      height: 150,
                      width: 314,
                      bottom: 0,
                      child:
                          Image(fit: BoxFit.fill, image: AssetImage(imagePath)))
                ],
              ),
            ),
          )));
}
