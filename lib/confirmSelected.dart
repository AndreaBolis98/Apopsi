import 'dart:async';
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
import 'ProfilePage.dart' as profile_page;
import 'selectAvatar.dart' as avatar_page;

class MyConfirmAddPage extends StatelessWidget {
  const MyConfirmAddPage({
    Key? key,
    required this.indice,
  });
  final int indice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => profile_page.MyProfilePage()),
              );
        },
        child: MaterialApp(
            title: "My Apops confrim add",
            theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: Theme.of(context).textTheme.copyWith(
                      subtitle1: const TextStyle(color: Colors.white),
                    )),
            home: MyCollezioneSingola(indice: indice)));
  }
}

class MyCollezioneSingola extends StatefulWidget {
  const MyCollezioneSingola({
    Key? key,
    required this.indice,
  });
  final int indice;

  @override
  State<MyCollezioneSingola> createState() => _MyCollezioneSingolaState();
}

class _MyCollezioneSingolaState extends State<MyCollezioneSingola> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        (() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => profile_page.MyProfilePage()),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: main_page.colorIndice[widget.indice],
        body: Container(
            margin: EdgeInsets.only(
              top: main_page.MyResponsive().HeightResponsive(43.95),
              left: main_page.MyResponsive().WidthResponsive(9.7),
            ),
            child: main_page.MyTextResponsive(
                text:
                    "ottimo!\r\nhai aggiunto un contenuto\r\nalla tua collezione",
                color: Colors.white,
                size: 28,
                TextAlign: TextAlign.center)));
  }
}
