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
import 'extra.dart' as extra_page;

class MySingoloExtraPage extends StatelessWidget {
  const MySingoloExtraPage({
    Key? key,
    required this.indice,
  });
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
            title: "My Apops extrasingolo page",
            theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: Theme.of(context).textTheme.copyWith(
                      subtitle1: const TextStyle(color: Colors.white),
                    )),
            home: MyExtraSingolo(
              indice: indice,
            )));
  }
}

class MyExtraSingolo extends StatelessWidget {
  const MyExtraSingolo({
    Key? key,
    required this.indice,
  });
  final int indice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: main_page.BgColor.color(),
      body: MyExtraSingoloField(
        indice: indice,
      ),
      bottomNavigationBar: home_page.MyBottomNavigationBar(1),
    );
  }
}

class MyExtraSingoloField extends StatefulWidget {
  const MyExtraSingoloField({
    Key? key,
    required this.indice,
  });
  final int indice;
  @override
  State<MyExtraSingoloField> createState() => _MyExtraSingoloState();
}

class _MyExtraSingoloState extends State<MyExtraSingoloField> {
  late int _indice;
  List _titolo = [
    "cosa non sai su\r\nCyrano de Bergerac",
    "dietro le quinte di\r\nBlack Panther ",
    "curiosità sull’ultimo\r\nlibro di Zerocalcare",
  ];
  List _commento = [
    "Lo spadaccino nasone protagonista dell'opera teatrale fu solo frutto della fantasia di Edmond Rostand? Assolutamente no.\r\nAvrete di certo letto, o almeno sentito parlare, della storia di Cyrano de Bergerac, il fantastico spadaccino dal grande e lungo naso, diventato uno dei personaggi della letteratura più famosi del mondo. Tanto famoso che quando uno ha il naso molto grande si dice che ha il naso alla Cyrano.\r\nLa storia è stata scritta da un autore francese, di nome Edmond Rostand, nel 1897. Si tratta di un’opera teatrale che da quell’anno, e tutt’oggi, è una delle più note e rappresentate del mondo. Nell’opera, Cyrano è uno scrittore abilissimo come spadaccino, molto ironico e vitale, che non si piega davanti a nessuno e che fa valere il proprio modo di pensare.\r\nLa fantasia dei grandi scrittori è in grado di creare personaggi che non sono mai esistiti nella realtà, come ad esempio Don Chisciotte, Peter Pan, Alice nel Paese delle meraviglie. Altre volte, invece, succede che uno scrittore si ispiri, per la creazione di un suo personaggio, ad una persona realmente esistita. E sapete cosa? Cyrano de Bergerac è esistito davvero!",
    "Uscito il 9 novembre in Italia, il sequel di Black Panther (2018) è diretto da Ryan Coogler e vede il ritorno di buona parte del cast originale. \r\nGrande assente è stato ovviamente Chadwick Boseman, attore prematuramente scomparso nel 2020, ma omaggiato nella pellicola da Rihanna, con la canzone Lift Me Up. \r\nL’intera pellicola è caratterizzata da numerosi brani di artisti rinomati, riportati di seguito.",
    "Nella primavera del 2021 Zerocalcare si reca in Iraq, per far visita alla comunità ezida di Shengal, minacciata dalle tensioni internazionali e protetta dalle milizie curde, e documentarne le condizioni di vita e la lotta. Il viaggio si rivela difficile perché più volte la delegazione italiana viene respinta ai vari check point controllati dalle diverse forze politiche e militari che si spartiscono il controllo del suolo iracheno. \r\nQuesto libro a fumetti, intitolato No Sleep Till Shengal, è la fotografia di un momento geopolitico preciso, in cui un manipolo di persone si oppone allo strapotere di chi chiama “terrorismo” ogni tentativo di resistenza, mentre gli assetti di potere cambiano lentamente, e il sogno del confederalismo democratico in un pezzetto troppo spesso dimenticato di Mesopotamia rischia di svanire per sempre, nell’indifferenza assordante dell’occidente.\r\nUna lunga testimonianza a fumetti, con i toni di grigio di Alberto Madrigal. In seguito alcune pagine del libro.",
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
          height: main_page.MyResponsive().HeightResponsive(52.58),
          width: main_page.MyResponsive().WidthResponsive(100),
          child: MyImageBg(tmp_image: "images/extra_$_indice.png"),
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
                        builder: (context) => extra_page.MyExtraPage()))
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
              text: _titolo[_indice],
              size: 28,
              color: Color.fromRGBO(255, 255, 255, 1),
              TextAlign: TextAlign.center),
        ),
        Positioned(
            top: main_page.MyResponsive().HeightResponsive(45.25),
            left: main_page.MyResponsive().WidthResponsive(10),
            width: main_page.MyResponsive().WidthResponsive(80),
            height: main_page.MyResponsive().HeightResponsive(45),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  main_page.MyTextResponsive(
                      text: _commento[_indice],
                      size: 13,
                      color: Color.fromRGBO(153, 153, 155, 1),
                      TextAlign: TextAlign.left),
                  SizedBox(
                    height: main_page.MyResponsive().HeightResponsive(4),
                  ),
                  if (_indice == 2)
                    ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: createList_2()),
                  if (_indice == 1)
                    ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: createList_1())
                ])))
      ]),
    );
  }
}

//create List for event
List<Widget> createList_2() {
  final List<Widget> list = [];

  for (int i = 0; i < 3; i++) {
    var newItem = Container(
        height: main_page.MyResponsive().HeightResponsive(226 / 8.44),
        width: main_page.MyResponsive().WidthResponsive(80),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Image.asset("images/extra_2_0.png")));
    list.add(newItem);
    var spaceBox =
        SizedBox(height: main_page.MyResponsive().HeightResponsive(29 / 8.44));
    list.add(spaceBox);
  }

  return list;
}

List<Widget> createList_1() {
  final List<Widget> list = [];

  List _titolo = [
    "Lift me up",
    "Alone",
    "No woman no cry",
    "Interlude",
    "They Want It, But No",
    "Wake Up",
    "Pantera"
  ];

  List _autore = [
    "Rihanna",
    "Burna Boy",
    "Tems",
    "Stormzy",
    "Tobe Nwigwe & Fat Nwigwe",
    "Bloody Civilian (feat. Rema)",
    "Aleman"
  ];

  list.add(
    main_page.MyTextResponsive(
        text: "Canzoni presenti nel film",
        size: 17,
        color: Color.fromRGBO(255, 255, 255, 1),
        TextAlign: TextAlign.left),
  );
  list.add(SizedBox(
    height: main_page.MyResponsive().HeightResponsive(20 / 8.44),
  ));

  for (int i = 0; i < 7; i++) {
    var newItem = MyCard(
      autore: _autore[i],
      image: "images/extra_1_$i.png",
      titolo: _titolo[i],
    );
    list.add(newItem);
    var spaceBox =
        SizedBox(height: main_page.MyResponsive().HeightResponsive(29 / 8.44));
    list.add(spaceBox);
  }
  return list;
}

class MyImageBg extends StatelessWidget {
  MyImageBg({super.key, required this.tmp_image});
  String tmp_image;

  @override
  Widget build(BuildContext context) {
    //print(tmp_image);
    return Image.asset(
      tmp_image,
      fit: BoxFit.fill,
    );
  }
}

class MyCard extends StatelessWidget {
  MyCard({
    Key? key,
    required this.image,
    required this.autore,
    required this.titolo,
  });

  final String image;

  final String autore;

  final String titolo;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          width: main_page.MyResponsive().WidthResponsive(314 / 3.9),
          height: main_page.MyResponsive().HeightResponsive(97 / 8.44),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Container(
                decoration: BoxDecoration(
                  color: main_page.colorIndice[1],
                ),
              ))),
      Positioned(
          height: main_page.MyResponsive().HeightResponsive(97 / 8.44),
          width: main_page.MyResponsive().WidthResponsive(94 / 3.9),
          child: Image.asset(
            image,
            fit: BoxFit.fill,
          )),
      Positioned(
          top: main_page.MyResponsive().HeightResponsive(26 / 8.44),
          left: main_page.MyResponsive().WidthResponsive(116 / 3.9),
          width: 148,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              main_page.MyTextResponsive(
                  text: titolo,
                  size: 15,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  TextAlign: TextAlign.left),
              SizedBox(
                height: main_page.MyResponsive().HeightResponsive(14 / 8.44),
              ),
              main_page.MyTextResponsive(
                  text: autore,
                  size: 13,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  TextAlign: TextAlign.left),
            ],
          ))
    ]);
  }
}
