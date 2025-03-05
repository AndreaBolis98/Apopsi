import 'dart:io';

//import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import './main.dart' as main_page;
import 'LoginSubmitPage.dart' as loginSigIn_page;
import 'HomePage.dart' as home_page;
import 'LoginPage.dart' as login_page;
import 'camera_page.dart' as camera_page;
import 'ProfilePage.dart' as profile_page;
import 'Collezione.dart' as collezione_page;
import 'selectSticker.dart' as selectSticker_page;
import 'confirmSelected.dart' as confirm_page;
import 'extra.dart' as extra_page;
import 'AddPAge.dart' as add_page;
import 'singoloUpdate.dart' as singUpd_page;

class MyClubPage extends StatelessWidget {
  const MyClubPage({Key? key, required this.indice}) : super(key: key);
  final int indice;
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
            title: "My Apops Club",
            theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: Theme.of(context).textTheme.copyWith(
                      subtitle1: const TextStyle(color: Colors.white),
                    )),
            home: MyClub(
              indice: indice,
            )));
  }
}

class MyClub extends StatelessWidget {
  const MyClub({Key? key, required this.indice}) : super(key: key);
  final int indice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: main_page.BgColor.color(),
      body: MyClubField(
        indice: indice,
      ),
      bottomNavigationBar: home_page.MyBottomNavigationBar(1),
    );
  }
}

class MyClubField extends StatefulWidget {
  const MyClubField({Key? key, required this.indice}) : super(key: key);
  final int indice;
  @override
  State<MyClubField> createState() => _MyClubFieldState();
}

class _MyClubFieldState extends State<MyClubField> {
  late int _indice;

  List _titolo = ["Teatroclub", "Cineclub", "Bookclub"];
  List _subTitolo = [
    "Sappiamo che hai sempre desiderato una community con la quale discutere riguardo l’ultimo libro che hai letto, parlarne, confrontarti sui passaggi cruciali, fantasticare su cosa sarebbe potuto succedere se…\r\nFinalmente puoi farlo!",
    "Sappiamo che hai sempre desiderato una community con la quale discutere riguardo l’ultimo film che hai visto, parlarne, confrontarti sui passaggi cruciali, fantasticare su cosa sarebbe potuto succedere se…\r\nFinalmente puoi farlo!",
    "Sappiamo che hai sempre desiderato una community con la quale discutere riguardo l’ultimo film che hai visto, parlarne, confrontarti sui passaggi cruciali, fantasticare su cosa sarebbe potuto succedere se…\r\nFinalmente puoi farlo!"
  ];

  List _quando = [
    "Il primo martedì di ogni mese.",
    "Il primo venerdì di ogni mese.",
    "Il primo giovedì di ogni mese.",
  ];

  List _dove = [
    "A ‘La Libreria delle ragazze e dei ragazzi di Milano’, in Via Alessandro Tadino, 53. ",
    "A ‘La Libreria delle ragazze e dei ragazzi di Milano’, in Via Alessandro Tadino, 53. ",
    "A ‘La Libreria delle ragazze e dei ragazzi di Milano’, in Via Alessandro Tadino, 53. ",
  ];

  List _cheSucc = [
    "Parlare degli spettacoli è la nostra attività principale, ma ogni tanto abbiamo il grande onore di incontrare registi e attori degli spettacoli che abbiamo visto.",
    "Parlare di film è la nostra attività principale, ma ogni tanto abbiamo il grande onore di incontrare attori, registi, sceneggiatori, dei film che abbiamo visto.",
    "Parlare di libri è la nostra attività principale, ma ogni tanto abbiamo il grande onore di incontrare gli scrittori dei libri che abbiamo letto.",
  ];

  List _chiLibro = [
    "Tu! Semplicemente accedendo alla sezione sottostante.",
    "Tu! Semplicemente accedendo alla sezione sottostante.",
    "Tu! Semplicemente accedendo alla sezione sottostante."
  ];

  List _next = [
    "Il prossimo incontro sarà martedì 6 dicembre alle ore 17:00, e parleremo di Art",
    "Il prossimo incontro sarà venerdì 2 dicembre alle ore 17:00, e parleremo di Diabolik - Ginko all’attacco!",
    "Il prossimo incontro sarà giovedì 1 dicembre alle ore 17:00, e parleremo di Il buio oltre la siepe di Harper Lee",
  ];

  @override
  void initState() {
    _indice = widget.indice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: main_page.BgColor.color(),
        body: Stack(children: <Widget>[
          Container(
            margin: EdgeInsets.all(0),
            height: main_page.MyResponsive().HeightResponsive(23.58),
            width: main_page.MyResponsive().WidthResponsive(100),
            child: MyAddBg(_indice),
          ),
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
                        builder: (context) => extra_page.MyExtraPage()),
                  )
                },
              )),
          add_page.MyTextDescription(_titolo[_indice]),
          Container(
            margin: EdgeInsets.only(
                top: main_page.MyResponsive().HeightResponsive(18.86)),
            child: add_page.MyExtraContent(),
          ),
          Positioned(
              top: main_page.MyResponsive().HeightResponsive(207 / 8.44),
              left: main_page.MyResponsive().WidthResponsive(10),
              width: main_page.MyResponsive().WidthResponsive(80),
              height: main_page.MyResponsive().HeightResponsive(564 / 8.44),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    main_page.MyTextResponsive(
                        text: "Discuti con la community",
                        size: 28,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        TextAlign: TextAlign.left),
                    SizedBox(
                      height:
                          main_page.MyResponsive().HeightResponsive(6 / 8.44),
                    ),
                    main_page.MyTextResponsive(
                        text: _subTitolo[_indice],
                        size: 13,
                        color: Color.fromRGBO(153, 153, 155, 1),
                        TextAlign: TextAlign.left),
                    SizedBox(
                      height:
                          main_page.MyResponsive().HeightResponsive(8 / 8.44),
                    ),
                    Container(
                      width: main_page.MyResponsive().WidthResponsive(80),
                      child: main_page.MyTextResponsive(
                          text: "quando?",
                          size: 17,
                          color: Color.fromRGBO(255, 255, 255, 1),
                          TextAlign: TextAlign.left),
                    ),
                    SizedBox(
                      height:
                          main_page.MyResponsive().HeightResponsive(8 / 8.44),
                    ),
                    Container(
                      width: main_page.MyResponsive().WidthResponsive(80),
                      child: main_page.MyTextResponsive(
                          text: _quando[_indice],
                          size: 13,
                          color: Color.fromRGBO(153, 153, 155, 1),
                          TextAlign: TextAlign.left),
                    ),
                    SizedBox(
                      height:
                          main_page.MyResponsive().HeightResponsive(19 / 8.44),
                    ),
                    Container(
                      width: main_page.MyResponsive().WidthResponsive(80),
                      child: main_page.MyTextResponsive(
                          text: "dove?",
                          size: 17,
                          color: Color.fromRGBO(255, 255, 255, 1),
                          TextAlign: TextAlign.left),
                    ),
                    SizedBox(
                      height:
                          main_page.MyResponsive().HeightResponsive(8 / 8.44),
                    ),
                    Container(
                      width: main_page.MyResponsive().WidthResponsive(80),
                      child: main_page.MyTextResponsive(
                          text: _dove[_indice],
                          size: 13,
                          color: Color.fromRGBO(153, 153, 155, 1),
                          TextAlign: TextAlign.left),
                    ),
                    SizedBox(
                      height:
                          main_page.MyResponsive().HeightResponsive(19 / 8.44),
                    ),
                    Container(
                      width: main_page.MyResponsive().WidthResponsive(80),
                      child: main_page.MyTextResponsive(
                          text: "ma a parte parlare cosa succede?",
                          size: 17,
                          color: Color.fromRGBO(255, 255, 255, 1),
                          TextAlign: TextAlign.left),
                    ),
                    SizedBox(
                      height:
                          main_page.MyResponsive().HeightResponsive(8 / 8.44),
                    ),
                    Container(
                      width: main_page.MyResponsive().WidthResponsive(80),
                      child: main_page.MyTextResponsive(
                          text: _cheSucc[_indice],
                          size: 13,
                          color: Color.fromRGBO(153, 153, 155, 1),
                          TextAlign: TextAlign.left),
                    ),
                    SizedBox(
                      height:
                          main_page.MyResponsive().HeightResponsive(19 / 8.44),
                    ),
                    Container(
                      width: main_page.MyResponsive().WidthResponsive(80),
                      child: main_page.MyTextResponsive(
                          text: "chi sceglie il libro?",
                          size: 17,
                          color: Color.fromRGBO(255, 255, 255, 1),
                          TextAlign: TextAlign.left),
                    ),
                    SizedBox(
                      height:
                          main_page.MyResponsive().HeightResponsive(8 / 8.44),
                    ),
                    Container(
                      width: main_page.MyResponsive().WidthResponsive(80),
                      child: main_page.MyTextResponsive(
                          text: _chiLibro[_indice],
                          size: 13,
                          color: Color.fromRGBO(153, 153, 155, 1),
                          TextAlign: TextAlign.left),
                    ),
                    SizedBox(
                      height:
                          main_page.MyResponsive().HeightResponsive(30 / 8.44),
                    ),
                    Row(children: <Widget>[
                      Container(
                          width: main_page.MyResponsive()
                              .WidthResponsive(101 / 3.9),
                          height: main_page.MyResponsive()
                              .HeightResponsive(42 / 8.44),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: main_page.colorIndice[_indice]),
                          child: Stack(children: [
                            Positioned(
                              width: main_page.MyResponsive()
                                  .WidthResponsive(101 / 3.9),
                              top: main_page.MyResponsive()
                                  .HeightResponsive(0.7),
                              //left: main_page.MyResponsive().WidthResponsive(39.7),
                              child: main_page.MyTextResponsive(
                                  text: 'aggiunto da',
                                  size: 15,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  TextAlign: TextAlign.center),
                            ),
                            Positioned(
                              top: main_page.MyResponsive().HeightResponsive(3),
                              width: main_page.MyResponsive()
                                  .WidthResponsive(101 / 3.9),
                              //left: main_page.MyResponsive().WidthResponsive(39.7),
                              child: main_page.MyTextResponsive(
                                  text: '5 amici',
                                  size: 14,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  TextAlign: TextAlign.center),
                            ),
                          ])),
                      SizedBox(
                        width:
                            main_page.MyResponsive().WidthResponsive(13 / 3.9),
                      ),
                      Container(
                          width: main_page.MyResponsive()
                              .WidthResponsive(198 / 3.9),
                          height: main_page.MyResponsive()
                              .HeightResponsive(42 / 8.44),
                          child: singUpd_page.MyButton(
                            "partecipa",
                            17,
                            main_page.colorIndice[_indice],
                            () => {
                              /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          club_page.MyClubPage(
                                            indice: 1,
                                          )))*/
                            },
                          )),
                    ])
                  ]))),
        ]));
  }
}

class MyAddBg extends StatelessWidget {
  const MyAddBg(this._indice);
  final int _indice;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: main_page.colorIndice[_indice]));
  }
}
