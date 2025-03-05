import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import './main.dart' as main_page;
import 'LoginSubmitPage.dart' as loginSigIn_page;
import 'HomePage.dart' as home_page;
import 'LoginPage.dart' as login_page;
import 'camera_page.dart' as camera_page;
import 'ProfilePage.dart' as profile_page;
import 'AddPAge.dart' as add_page;
import 'singolaCollezione.dart' as singola_page;
import 'singoloUpdate.dart' as singUpd_page;
import 'singoloExtra.dart' as singExt_page;
import 'clubSingolo.dart' as club_page;

int indiceSelezionato = 4;

class MyExtraPage extends StatelessWidget {
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
            title: "My Apops Extra",
            theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: Theme.of(context).textTheme.copyWith(
                      subtitle1: const TextStyle(color: Colors.white),
                    )),
            home: MyExtra()));
  }
}

class MyExtra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: main_page.BgColor.color(),
      body: MyExtraField(),
      bottomNavigationBar: home_page.MyBottomNavigationBar(1),
    );
  }
}

class MyExtraField extends StatefulWidget {
  @override
  State<MyExtraField> createState() => MyExtraFieldState();
}

class MyExtraFieldState extends State<MyExtraField> {
  @override
  void initState() {
    super.initState();
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
              child: add_page.MyAddBg(),
            ),
            Positioned(
                top: main_page.MyResponsive().HeightResponsive(4),
                right: main_page.MyResponsive().HeightResponsive(3),
                child: add_page.MyIconButton(
                  Icon(Icons.search),
                  () => {
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => profile_page.MyProfilePage()))*/
                  },
                )),
            add_page.MyTextDescription("Extra"),
            Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(18.86)),
              child: add_page.MyExtraContent(),
            ),
            Positioned(
              top: main_page.MyResponsive().HeightResponsive(25.3),
              left: main_page.MyResponsive().WidthResponsive(38 / 3.9),
              width: main_page.MyResponsive().WidthResponsive(141 / 3.9),
              child: Column(
                children: [
                  MyCard(
                      image: "images/curiosita_0.png",
                      text: "cosa non sai su Cyrano de Bergerac",
                      indice: 0),
                  SizedBox(
                    height:
                        main_page.MyResponsive().HeightResponsive(23 / 8.44),
                  ),
                  MyCard(
                      image: "images/curiosita_2.png",
                      text: "curiosità sull’ultimo libro di Zerocalcare",
                      indice: 2),
                ],
              ),
            ),
            Positioned(
              top: main_page.MyResponsive().HeightResponsive(25.3),
              right: main_page.MyResponsive().WidthResponsive(38 / 3.9),
              width: main_page.MyResponsive().WidthResponsive(141 / 3.9),
              child: Column(
                children: [
                  Container(
                      width:
                          main_page.MyResponsive().WidthResponsive(141 / 3.9),
                      height:
                          main_page.MyResponsive().HeightResponsive(64 / 8.44),
                      child: singUpd_page.MyButton(
                        "bookclub",
                        17,
                        main_page.colorIndice[2],
                        () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => club_page.MyClubPage(
                                        indice: 2,
                                      )))
                        },
                      )),
                  SizedBox(
                    height:
                        main_page.MyResponsive().HeightResponsive(23 / 8.44),
                  ),
                  MyCard(
                      image: "images/curiosita_1.png",
                      text: "dietro le quinte di Black Panther",
                      indice: 1),
                  SizedBox(
                    height:
                        main_page.MyResponsive().HeightResponsive(23 / 8.44),
                  ),
                  Container(
                      width:
                          main_page.MyResponsive().WidthResponsive(141 / 3.9),
                      height:
                          main_page.MyResponsive().HeightResponsive(64 / 8.44),
                      child: singUpd_page.MyButton(
                        "teatroclub",
                        17,
                        main_page.colorIndice[0],
                        () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => club_page.MyClubPage(
                                        indice: 0,
                                      )))
                        },
                      )),
                  SizedBox(
                    height:
                        main_page.MyResponsive().HeightResponsive(23 / 8.44),
                  ),
                  Container(
                      width:
                          main_page.MyResponsive().WidthResponsive(141 / 3.9),
                      height:
                          main_page.MyResponsive().HeightResponsive(64 / 8.44),
                      child: singUpd_page.MyButton(
                        "cineclub",
                        17,
                        main_page.colorIndice[1],
                        () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => club_page.MyClubPage(
                                        indice: 1,
                                      )))
                        },
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}

class MyCard extends StatelessWidget {
  MyCard({
    Key? key,
    required this.image,
    required this.text,
    required this.indice,
  });

  final String image;
  final String text;
  final int indice;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => singExt_page.MySingoloExtraPage(
                      indice: indice,
                    )))
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        child: Container(
          height: main_page.MyResponsive().HeightResponsive(260 / 8.44),
          width: main_page.MyResponsive().WidthResponsive(141 / 3.9),
          decoration: BoxDecoration(
            color: main_page.colorIndice[indice],
          ),
          child: Stack(fit: StackFit.expand, children: [
            Positioned(
                top: main_page.MyResponsive().HeightResponsive(20 / 8.44),
                left: main_page.MyResponsive().WidthResponsive(16 / 3.9),
                width: main_page.MyResponsive().WidthResponsive(116 / 3.9),
                height: main_page.MyResponsive().HeightResponsive(18.9),
                child: main_page.MyTextResponsive(
                    text: text,
                    color: Colors.white,
                    size: 17,
                    TextAlign: TextAlign.left)),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: main_page.MyResponsive().HeightResponsive(18.9),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    child: Image.asset(
                      image,
                      fit: BoxFit.fill,
                    ))),
          ]),
        ),
      ),
    );
  }
}
