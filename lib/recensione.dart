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

class MyRecensionePage extends StatelessWidget {
  const MyRecensionePage({
    Key? key,
    required this.image,
    required this.voto,
    required this.autore,
    required this.commenti,
    required this.titolo,
  });
  final String image;
  final double voto;
  final String autore;
  final String commenti;
  final String titolo;

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
            title: "My Apops collezionepage",
            theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: Theme.of(context).textTheme.copyWith(
                      subtitle1: const TextStyle(color: Colors.white),
                    )),
            home: MyRecensioneSingola(
              image: image,
              voto: voto,
              autore: autore,
              commenti: commenti,
              titolo: titolo,
            )));
  }
}

class MyRecensioneSingola extends StatelessWidget {
  const MyRecensioneSingola({
    Key? key,
    required this.image,
    required this.voto,
    required this.autore,
    required this.commenti,
    required this.titolo,
  });
  final String image;

  final double voto;
  final String autore;
  final String commenti;
  final String titolo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: main_page.BgColor.color(),
      body: MyRecensioneField(
        image: image,
        voto: voto,
        autore: autore,
        commenti: commenti,
        titolo: titolo,
      ),
      bottomNavigationBar: home_page.MyBottomNavigationBar(0),
    );
  }
}

class MyRecensioneField extends StatefulWidget {
  const MyRecensioneField({
    Key? key,
    required this.image,
    required this.voto,
    required this.autore,
    required this.commenti,
    required this.titolo,
  });
  final String image;

  final double voto;
  final String autore;
  final String commenti;
  final String titolo;

  @override
  State<MyRecensioneField> createState() => _MyRecensioneState();
}

class _MyRecensioneState extends State<MyRecensioneField> {
  late DatabaseReference dbRef;
  late int avatarSelected;
  late String name;
  late String email;
  @override
  void initState() {
    super.initState();
    email = home_page.email;
    dbRef = FirebaseDatabase.instance.ref().child('User').child(email);
    avatarSelected = home_page.avatar;
    name = home_page.nome;
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
              child: profile_page.MyAddBg(),
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
                    top: main_page.MyResponsive().HeightResponsive(4),
                    left: main_page.MyResponsive().HeightResponsive(3)),
                child: add_page.MyIconButton(
                  Icon(Icons.keyboard_arrow_left_sharp),
                  () => {
                    wrtiteLine(dbRef, widget.titolo),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => home_page.MyHomePage()))
                  },
                )),
            Container(
              margin: EdgeInsets.only(
                top: main_page.MyResponsive().HeightResponsive(18.95),
                left: main_page.MyResponsive().WidthResponsive(38.71),
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
                      Padding(padding: EdgeInsets.only(bottom: 3, left: 3)),
                      main_page.MyTextResponsive(
                          text: "10 amici",
                          size: 17,
                          color: Color.fromRGBO(153, 153, 155, 1),
                          TextAlign: TextAlign.left),
                    ],
                  )),
            ),
            Positioned(
                height: main_page.MyResponsive().HeightResponsive(15.6),
                width: main_page.MyResponsive().WidthResponsive(26.15),
                top: main_page.MyResponsive().HeightResponsive(32.1),
                left: main_page.MyResponsive().WidthResponsive(9.7),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.0),
                    child: Image.network(widget.image, fit: BoxFit.fill))),
            Positioned(
                top: main_page.MyResponsive().HeightResponsive(33.05),
                left: main_page.MyResponsive().WidthResponsive(39.7),
                width: main_page.MyResponsive().WidthResponsive(190 / 3.9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    main_page.MyTextResponsive(
                        text: widget.titolo,
                        size: 17,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        TextAlign: TextAlign.left),
                    main_page.MyTextResponsive(
                        text: widget.autore,
                        size: 15,
                        color: Color.fromRGBO(153, 153, 155, 1),
                        TextAlign: TextAlign.left),
                    SizedBox(
                      height:
                          main_page.MyResponsive().HeightResponsive(7 / 8.44),
                    ),
                    Row(children: <Widget>[
                      main_page.MyTextResponsive(
                          text: widget.voto.toString(),
                          size: 15,
                          color: Color.fromRGBO(255, 255, 255, 1),
                          TextAlign: TextAlign.left),
                      collect_page.MyStarVis(voto: widget.voto, itemSize: 15.0),
                    ])
                  ],
                )),
            Positioned(
              height: main_page.MyResponsive().HeightResponsive(37.2),
              width: main_page.MyResponsive().WidthResponsive(74.87),
              top: main_page.MyResponsive().HeightResponsive(49.5),
              left: main_page.MyResponsive().WidthResponsive(9.7),
              child: main_page.MyTextResponsive(
                  text: widget.commenti,
                  size: 17,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  TextAlign: TextAlign.left),
            ),
            Positioned(
              height: main_page.MyResponsive().HeightResponsive(20),
              width: main_page.MyResponsive().WidthResponsive(100),
              top: main_page.MyResponsive().HeightResponsive(59),
              left: main_page.MyResponsive().WidthResponsive(0),
              child: Container(
                  margin: EdgeInsets.all(0),
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(0, 0, 0, .8))),
            ),
            Positioned(
              height: main_page.MyResponsive().HeightResponsive(20),
              width: main_page.MyResponsive().WidthResponsive(100),
              top: main_page.MyResponsive().HeightResponsive(69),
              left: main_page.MyResponsive().WidthResponsive(0),
              child: Container(
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 1))),
            ),
            Positioned(
              height: main_page.MyResponsive().HeightResponsive(33 / 8.44),
              width: main_page.MyResponsive().WidthResponsive(224 / 3.9),
              top: main_page.MyResponsive().HeightResponsive(66),
              left: main_page.MyResponsive().WidthResponsive(84 / 3.9),
              child: Image.asset("images/spoiler.png"),
            ),
          ],
        ));
  }
}

void wrtiteLine(DatabaseReference dbRef, String _titolo) {
  final email = home_page.email;
  var dt = DateTime.now();
  Map<String, String> aggiungi = {'titolo': _titolo};

  dbRef.set(aggiungi);
}
