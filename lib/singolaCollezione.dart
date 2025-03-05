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

class MySingolaCollezionePage extends StatelessWidget {
  const MySingolaCollezionePage({
    Key? key,
    required this.image,
    required this.sticker,
    required this.color,
    required this.voto,
    required this.autore,
    required this.commenti,
    required this.titolo,
    required this.spoiler,
    required this.date,
  });
  final String image;
  final int sticker;
  final Color color;
  final double voto;
  final String autore;
  final String commenti;
  final String titolo;
  final bool spoiler;
  final String date;
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
            home: MyCollezioneSingola(
                image: image,
                sticker: sticker,
                color: color,
                voto: voto,
                autore: autore,
                commenti: commenti,
                titolo: titolo,
                spoiler: spoiler,
                date: date)));
  }
}

class MyCollezioneSingola extends StatelessWidget {
  const MyCollezioneSingola({
    Key? key,
    required this.image,
    required this.sticker,
    required this.color,
    required this.voto,
    required this.autore,
    required this.commenti,
    required this.titolo,
    required this.spoiler,
    required this.date,
  });
  final String image;
  final int sticker;
  final Color color;
  final double voto;
  final String autore;
  final String commenti;
  final String titolo;
  final bool spoiler;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: main_page.BgColor.color(),
      body: MyCollezioneSingolaField(
          image: image,
          sticker: sticker,
          color: color,
          voto: voto,
          autore: autore,
          commenti: commenti,
          titolo: titolo,
          spoiler: spoiler,
          date: date),
      bottomNavigationBar: home_page.MyBottomNavigationBar(2),
    );
  }
}

class MyCollezioneSingolaField extends StatefulWidget {
  const MyCollezioneSingolaField({
    Key? key,
    required this.image,
    required this.sticker,
    required this.color,
    required this.voto,
    required this.autore,
    required this.commenti,
    required this.titolo,
    required this.spoiler,
    required this.date,
  });
  final String image;
  final int sticker;
  final Color color;
  final double voto;
  final String autore;
  final String commenti;
  final String titolo;
  final bool spoiler;
  final String date;

  @override
  State<MyCollezioneSingolaField> createState() => _MyCollezioneSingolaState();
}

class _MyCollezioneSingolaState extends State<MyCollezioneSingolaField> {
  late DatabaseReference dbRef;
  late int avatarSelected;
  late String name;
  late String email;
  late int id;
  @override
  void initState() {
    super.initState();
    id = widget.sticker;
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
                            builder: (context) => collect_page.MyCollectPage()))
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
                      Padding(padding: EdgeInsets.only(bottom: 3)),
                      main_page.MyTextResponsive(
                          text: widget.date,
                          size: 17,
                          color: Color.fromRGBO(153, 153, 155, 1),
                          TextAlign: TextAlign.left),
                    ],
                  )),
            ),
            Positioned(
              top: main_page.MyResponsive().HeightResponsive(18.95),
              left: main_page.MyResponsive().WidthResponsive(84),
              child: IconButton(
                  color: Color.fromARGB(255, 255, 255, 255),
                  iconSize: 20,
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const editProfile_page.MyEditProfilePage()));*/
                  }),
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
              height: main_page.MyResponsive().HeightResponsive(2.37),
              top: main_page.MyResponsive().HeightResponsive(33.05),
              left: main_page.MyResponsive().WidthResponsive(39.7),
              child: main_page.MyTextResponsive(
                  text: widget.titolo,
                  size: 17,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  TextAlign: TextAlign.left),
            ),
            Positioned(
              height: main_page.MyResponsive().HeightResponsive(2.37),
              top: main_page.MyResponsive().HeightResponsive(35.19),
              left: main_page.MyResponsive().WidthResponsive(39.7),
              child: main_page.MyTextResponsive(
                  text: widget.autore,
                  size: 15,
                  color: Color.fromRGBO(153, 153, 155, 1),
                  TextAlign: TextAlign.left),
            ),
            Positioned(
              height: main_page.MyResponsive().HeightResponsive(2.37),
              top: main_page.MyResponsive().HeightResponsive(38.15),
              left: main_page.MyResponsive().WidthResponsive(39.7),
              child: main_page.MyTextResponsive(
                  text: widget.voto.toString(),
                  size: 15,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  TextAlign: TextAlign.left),
            ),
            Positioned(
              top: main_page.MyResponsive().HeightResponsive(38.15),
              left: main_page.MyResponsive().WidthResponsive(45.9),
              child: collect_page.MyStarVis(voto: widget.voto, itemSize: 15.0),
            ),
            Positioned(
                height: main_page.MyResponsive().HeightResponsive(6.51),
                width: main_page.MyResponsive().WidthResponsive(16.92),
                top: main_page.MyResponsive().HeightResponsive(40.5),
                left: main_page.MyResponsive().WidthResponsive(38.4),
                child: Image.asset('images/sticker_$id.png')),
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
