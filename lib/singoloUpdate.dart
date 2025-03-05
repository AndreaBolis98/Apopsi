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
import 'package:second/AddPAge.dart';

import './main.dart' as main_page;
import 'LoginSubmitPage.dart' as loginSigIn_page;
import 'HomePage.dart' as home_page;
import 'LoginPage.dart' as login_page;
import 'camera_page.dart' as camera_page;
import 'AddPage.dart' as add_page;
import 'editProfile.dart' as editProfile_page;
import 'Collezione.dart' as collect_page;
import 'ProfilePage.dart' as profile_page;
import 'confirmAppuntamenti.dart' as confirmApp_page;

class MySingoloUpdatePage extends StatelessWidget {
  const MySingoloUpdatePage({
    Key? key,
    required this.titolo,
  });
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
            title: "My Apops update singolo page",
            theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: Theme.of(context).textTheme.copyWith(
                      subtitle1: const TextStyle(color: Colors.white),
                    )),
            home: MyUpdateSingolo(
              titolo: titolo,
            )));
  }
}

class MyUpdateSingolo extends StatelessWidget {
  const MyUpdateSingolo({
    Key? key,
    required this.titolo,
  });
  final String titolo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: main_page.BgColor.color(),
      body: MyCollezioneSingolaField(
        titolo: titolo,
      ),
      bottomNavigationBar: home_page.MyBottomNavigationBar(0),
    );
  }
}

class MyCollezioneSingolaField extends StatefulWidget {
  const MyCollezioneSingolaField({
    Key? key,
    required this.titolo,
  });
  final String titolo;
  @override
  State<MyCollezioneSingolaField> createState() => _MyCollezioneSingolaState();
}

class _MyCollezioneSingolaState extends State<MyCollezioneSingolaField> {
  late DatabaseReference dbRef;
  late DatabaseReference dbRefUser;
  String _titolo = "";
  String _autore = "";
  String _commenti = "";
  String _durata = "";
  String _genere = "";
  String _image =
      "https://firebasestorage.googleapis.com/v0/b/apopsi-database.appspot.com/o/Updates%2FUncharted_grande.png?alt=media&token=20e9b274-f548-42a7-a7cc-81a08a8fa68d";
  int _indice = 0;
  int _amici = 4;
  Map _recAmici = {};
  Map _recCom = {};
  List _nStelle = [1, 1, 1, 1, 1, 1];
  double _votoMedio = 0;
  int _votomax = 10;

  Future getFromDB(db) async {
    final snapshot = await db.get();
    if (snapshot.exists) {
      final map = snapshot.value as Map<dynamic, dynamic>;
      _titolo = map["titolo"];
      _autore = map["autore"];
      _commenti = map["Dettaglio"]["commento"];
      _durata = map["Dettaglio"]["durata"];
      _genere = map["Dettaglio"]["genere"];
      _image = map["Dettaglio"]["Immagine"];
      _indice = int.parse(map["indice"]);
      _recAmici = map["Dettaglio"]["recensioni_amici"];
      _recCom = map["Dettaglio"]["recensioni_comununity"];
      _nStelle = map["Dettaglio"]["n_stelle"];
      num n = 0;
      num x = 0;
      for (var i = 1; i < _nStelle.length; i++) {
        if (_nStelle[i] > _votomax) {
          _votomax = _nStelle[i];
        }

        n = n + _nStelle[i];
        x = x + (i * _nStelle[i]);
      }
      _votoMedio = double.parse((x / n).toStringAsFixed(1));
      setState(() {});
    } else {
      print('No data available.');
    }
  }

  @override
  void initState() {
    dbRef =
        FirebaseDatabase.instance.ref().child('Updates').child(widget.titolo);
    dbRefUser = FirebaseDatabase.instance.ref().child('User');
    getFromDB(dbRef);
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
          height: main_page.MyResponsive().HeightResponsive(52.58),
          width: main_page.MyResponsive().WidthResponsive(100),
          child: MyImageBg(tmp_image: _image),
        ),
        Container(
          margin: EdgeInsets.only(
              top: main_page.MyResponsive().HeightResponsive(32.89)),
          child: add_page.MyExtraContent(),
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
                        builder: (context) => home_page.MyHomePage()))
              },
            )),
        Positioned(
            top: main_page.MyResponsive().HeightResponsive(35),
            left: main_page.MyResponsive().WidthResponsive(84),
            child: IconButton(
                color: Color.fromARGB(255, 255, 255, 255),
                iconSize: 20,
                icon: const Icon(Icons.ios_share_rounded),
                onPressed: () {
                  /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const editProfile_page.MyEditProfilePage()));*/
                })),
        Positioned(
          //height: main_page.MyResponsive().HeightResponsive(4),
          width: main_page.MyResponsive().WidthResponsive(70),
          top: main_page.MyResponsive().HeightResponsive(35),
          left: main_page.MyResponsive().WidthResponsive(15),
          child: main_page.MyTextResponsive(
              text: _titolo,
              size: 28,
              color: Color.fromRGBO(255, 255, 255, 1),
              TextAlign: TextAlign.center),
        ),
        Positioned(
            top: main_page.MyResponsive().HeightResponsive(44.25),
            left: main_page.MyResponsive().WidthResponsive(10),
            width: main_page.MyResponsive().WidthResponsive(80),
            height: main_page.MyResponsive().HeightResponsive(45),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Container(
                      width: main_page.MyResponsive().WidthResponsive(80),
                      child: Container(
                          child: Row(children: <Widget>[
                        Container(
                          width:
                              main_page.MyResponsive().WidthResponsive(51.25),
                          height:
                              main_page.MyResponsive().HeightResponsive(5.8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Color.fromRGBO(61, 61, 61, 1)),
                          child: Stack(children: [
                            Positioned(
                              top: main_page.MyResponsive()
                                  .HeightResponsive(0.7),
                              left:
                                  main_page.MyResponsive().WidthResponsive(4.6),
                              //left: main_page.MyResponsive().WidthResponsive(39.7),
                              child: main_page.MyTextResponsive(
                                  text: 'durata',
                                  size: 15,
                                  color: Color.fromRGBO(153, 153, 155, 1),
                                  TextAlign: TextAlign.center),
                            ),
                            Positioned(
                              top: main_page.MyResponsive().HeightResponsive(3),
                              width: main_page.MyResponsive()
                                  .WidthResponsive(19.5),
                              //left: main_page.MyResponsive().WidthResponsive(39.7),
                              child: main_page.MyTextResponsive(
                                  text: _durata,
                                  size: 14,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  TextAlign: TextAlign.center),
                            ),
                            Positioned(
                              top: main_page.MyResponsive()
                                  .HeightResponsive(0.7),
                              right:
                                  main_page.MyResponsive().WidthResponsive(11),
                              //left: main_page.MyResponsive().WidthResponsive(39.7),
                              child: main_page.MyTextResponsive(
                                  text: 'genere',
                                  size: 15,
                                  color: Color.fromRGBO(153, 153, 155, 1),
                                  TextAlign: TextAlign.center),
                            ),
                            Positioned(
                              top: main_page.MyResponsive().HeightResponsive(3),
                              right: 0,
                              width:
                                  main_page.MyResponsive().WidthResponsive(33),
                              //left: main_page.MyResponsive().WidthResponsive(39.7),
                              child: main_page.MyTextResponsive(
                                  text: _genere,
                                  size: 14,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  TextAlign: TextAlign.center),
                            ),
                          ]),
                        ),
                        SizedBox(
                          width: main_page.MyResponsive().WidthResponsive(6),
                        ),
                        Container(
                            width:
                                main_page.MyResponsive().WidthResponsive(22.25),
                            height:
                                main_page.MyResponsive().HeightResponsive(5.8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: main_page.colorIndice[_indice]),
                            child: Stack(children: [
                              Positioned(
                                width: main_page.MyResponsive()
                                    .WidthResponsive(22.25),
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
                                top: main_page.MyResponsive()
                                    .HeightResponsive(3),
                                width: main_page.MyResponsive()
                                    .WidthResponsive(22.25),
                                //left: main_page.MyResponsive().WidthResponsive(39.7),
                                child: main_page.MyTextResponsive(
                                    text: '$_amici amici',
                                    size: 14,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    TextAlign: TextAlign.center),
                              ),
                            ])),
                      ]))),
                  SizedBox(
                    height: main_page.MyResponsive().HeightResponsive(4),
                  ),
                  main_page.MyTextResponsive(
                      text: _commenti,
                      size: 17,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      TextAlign: TextAlign.left),
                  SizedBox(
                    height: main_page.MyResponsive().HeightResponsive(4),
                  ),
                  Container(
                      height: main_page.MyResponsive().HeightResponsive(5),
                      child: MyButton(
                        "aggiungi ai tuoi appuntamenti",
                        17,
                        main_page.colorIndice[_indice],
                        () => {
                          wrtitePreference(widget.titolo, dbRefUser),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      confirmApp_page.MyConfirmAppuntamentiPage(
                                        indice: _indice,
                                      )))
                        },
                      )),
                  SizedBox(
                    height: main_page.MyResponsive().HeightResponsive(5),
                  ),
                  Container(
                      width: main_page.MyResponsive().WidthResponsive(80),
                      child: main_page.MyTextResponsive(
                          text: "Punteggio medio",
                          color: Color.fromRGBO(255, 255, 255, 1),
                          size: 15,
                          TextAlign: TextAlign.left)),
                  SizedBox(
                    height: main_page.MyResponsive().HeightResponsive(1),
                  ),
                  Row(
                    children: [
                      main_page.MyTextResponsive(
                          text: '$_votoMedio',
                          color: Color.fromRGBO(255, 255, 255, 1),
                          size: 15,
                          TextAlign: TextAlign.left),
                      collect_page.MyStarVis(voto: _votoMedio, itemSize: 16.0)
                    ],
                  ),
                  StarQuantity(
                      index: 5, quantity: _nStelle[1], max: _votomax + 2),
                  StarQuantity(
                      index: 4, quantity: _nStelle[4], max: _votomax + 2),
                  StarQuantity(
                      index: 3, quantity: _nStelle[3], max: _votomax + 2),
                  StarQuantity(
                      index: 2, quantity: _nStelle[2], max: _votomax + 2),
                  StarQuantity(
                      index: 1, quantity: _nStelle[1], max: _votomax + 2),
                  SizedBox(
                    height: main_page.MyResponsive().HeightResponsive(5),
                  ),
                  Container(
                      width: main_page.MyResponsive().WidthResponsive(80),
                      child: main_page.MyTextResponsive(
                          text: "Recensioni dei tuoi amici",
                          color: Color.fromRGBO(255, 255, 255, 1),
                          size: 15,
                          TextAlign: TextAlign.left)),
                  if (_recAmici.length > 0)
                    ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: createListRec(true, _recAmici, _indice)),
                  SizedBox(
                    height: main_page.MyResponsive().HeightResponsive(3),
                  ),
                  Container(
                      width: main_page.MyResponsive().WidthResponsive(80),
                      child: main_page.MyTextResponsive(
                          text: "Recensioni dalla comunity",
                          color: Color.fromRGBO(255, 255, 255, 1),
                          size: 15,
                          TextAlign: TextAlign.left)),
                  if (_recCom.length > 0)
                    ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: createListRec(false, _recCom, _indice)),

                  /*Positioned(
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
                    child: collect_page.MyStarVis(
                        voto: widget.voto, itemSize: 15.0),
                  ),
                  */
                ])))
      ]),
    );
  }
}

class MyButton extends StatelessWidget {
  MyButton(this._text, this._fontSize, this._textbgcolor, this._onPress);
  final String _text;
  final double _fontSize;
  final Color _textbgcolor;
  final void Function() _onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(_textbgcolor),
          foregroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(255, 255, 255, 255)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)))),
      onPressed: _onPress,
      child: main_page.MyTextResponsive(
          text: _text,
          size: _fontSize,
          color: Colors.white,
          TextAlign: TextAlign.center),
    );
  }
}

Widget StarQuantity({
  required int index,
  required int quantity,
  required int max,
}) {
  return Column(children: [
    SizedBox(height: main_page.MyResponsive().HeightResponsive(.5)),
    Row(children: [
      Container(
          width: main_page.MyResponsive().WidthResponsive(11),
          child: main_page.MyTextResponsive(
              text: "$index stelle",
              size: 13,
              color: Color.fromRGBO(153, 153, 155, 1),
              TextAlign: TextAlign.center)),
      SizedBox(width: main_page.MyResponsive().WidthResponsive(1)),
      Container(
        width: main_page.MyResponsive().WidthResponsive(67.5),
        height: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: LinearProgressIndicator(
            value: quantity / max,
            valueColor:
                AlwaysStoppedAnimation<Color>(Color.fromRGBO(255, 255, 255, 1)),
            backgroundColor: Color.fromRGBO(153, 153, 155, 1),
          ),
        ),
      )
    ])
  ]);
}

class collection {
  final String autore;

  const collection({
    required this.autore,
  });

  factory collection.fromMap(Map<dynamic, dynamic> map) {
    return collection(
      autore: map['autore'] ?? '',
    );
  }
}

class MyImageBg extends StatelessWidget {
  MyImageBg({super.key, required this.tmp_image});
  String tmp_image;

  @override
  Widget build(BuildContext context) {
    //print(tmp_image);
    return Image.network(
      tmp_image,
      fit: BoxFit.fill,
    );
  }
}

//create List for recension
List<Widget> createListRec(_a, _map, _indice) {
  final List<Widget> list = [];

  for (int i = 1; i <= _map.length || i <= 3; i++) {
    list.add(SizedBox(height: main_page.MyResponsive().HeightResponsive(1)));
    var tmp;
    if (_a == true) {
      tmp = "rec_amici$i";
    } else {
      tmp = "rec_com$i";
    }

    var sticker = _map[tmp]["sticker"];
    if (sticker == null) {
      sticker = 4;
    }

    var tag = _map[tmp]["user"];
    var voto = _map[tmp]["voto"];
    if (voto == null) {
      voto = 0;
    }
    var commento = _map[tmp]["commento"];

    list.add(Container(
        height: main_page.MyResponsive().HeightResponsive(12),
        width: main_page.MyResponsive().WidthResponsive(80),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: BoxDecoration(
                color: main_page.colorIndice[_indice],
              ),
              child: Stack(
                children: [
                  Positioned(
                      top: main_page.MyResponsive().HeightResponsive(2.2),
                      left: main_page.MyResponsive().WidthResponsive(4.8),
                      height: main_page.MyResponsive().HeightResponsive(7.2),
                      child: Image.asset('images/avatar_$sticker.png')),
                  Positioned(
                      top: main_page.MyResponsive().HeightResponsive(1.7),
                      left: main_page.MyResponsive().WidthResponsive(25),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            main_page.MyTextResponsive(
                                text: tag,
                                size: 13,
                                color: Color.fromRGBO(255, 255, 255, 1),
                                TextAlign: TextAlign.left),
                            Row(
                              children: [
                                main_page.MyTextResponsive(
                                    text: '$voto',
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    size: 11,
                                    TextAlign: TextAlign.left),
                                collect_page.MyStarVis(
                                    voto: voto.toDouble(), itemSize: 16.0)
                              ],
                            ),
                            Container(
                              width:
                                  main_page.MyResponsive().WidthResponsive(47),
                              child: main_page.MyTextResponsive(
                                  text: commento,
                                  size: 13,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  TextAlign: TextAlign.left),
                            )
                          ])),
                ],
              ),
            ))));
  }
  return list;
}

void wrtitePreference(String _titolo, DatabaseReference dbRef) {
  final email = home_page.email;
  Map<String, String> aggiungi = {
    _titolo: _titolo,
  };

  dbRef.child(email).child('preferenze').update(aggiungi);
}
