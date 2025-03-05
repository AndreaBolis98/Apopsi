import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:second/AddPAge.dart';
import './main.dart' as main_page;
import 'LoginSubmitPage.dart' as login_page;
import 'SignPage.dart' as signin_page;
import 'HomePage.dart' as home_page;
import 'selectAvatar.dart' as avatar_page;
import 'AddPAge.dart' as add_page;

var interest = {
  1: {
    'name': 'thriller',
    'top': 229.0,
    'left': 95.0,
    'color': Color.fromARGB(255, 152, 191, 26)
  },
  2: {
    'name': 'avventra',
    'top': 229.0,
    'left': 205.0,
    'color': Color.fromARGB(255, 152, 191, 26)
  },
  3: {
    'name': 'fantasy',
    'top': 266.0,
    'left': 157.0,
    'color': Color.fromARGB(255, 152, 191, 26)
  },
  4: {
    'name': 'classco',
    'top': 303.0,
    'left': 71.0,
    'color': Color.fromARGB(255, 206, 162, 241)
  },
  5: {
    'name': 'giallo',
    'top': 303.0,
    'left': 181.0,
    'color': Color.fromARGB(255, 206, 162, 241)
  },
  6: {
    'name': 'distopico',
    'top': 340.0,
    'left': 143.0,
    'color': Color.fromARGB(255, 206, 162, 241)
  },
  7: {
    'name': 'biografico',
    'top': 377.0,
    'left': 117.0,
    'color': Color.fromARGB(255, 206, 162, 241)
  },
  8: {
    'name': 'commedia',
    'top': 377.0,
    'left': 227.0,
    'color': Color.fromARGB(255, 215, 19, 75)
  },
  9: {
    'name': 'tragedia',
    'top': 414.0,
    'left': 59.0,
    'color': Color.fromARGB(255, 152, 191, 26)
  },
  10: {
    'name': 'young adult',
    'top': 414.0,
    'left': 169.0,
    'color': Color.fromARGB(255, 152, 191, 26)
  },
  11: {
    'name': 'self help',
    'top': 451.0,
    'left': 153.0,
    'color': Color.fromARGB(255, 152, 191, 26)
  },
  12: {
    'name': 'romantico',
    'top': 488.0,
    'left': 87.0,
    'color': Color.fromARGB(255, 206, 162, 241)
  },
  13: {
    'name': 'cult',
    'top': 488.0,
    'left': 197.0,
    'color': Color.fromARGB(255, 206, 162, 241)
  },
};

class MyInterestPage extends StatelessWidget {
  const MyInterestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "My Apops Login Filed", home: MyInterestField());
  }
}

class MyInterestField extends StatefulWidget {
  @override
  State<MyInterestField> createState() => MyInterestFieldState();
}

class MyInterestFieldState extends State<MyInterestField> {
  late DatabaseReference dbRef;
  int avatarSelected = 0;
  late String userName;
  late String nome_cognome;
  late String email;
  late String pw;
  late String nome;
  late String cognome;
  late int indexSelected;
  late int indiceSelezionato = 0;
  late List<int> selectedlist = List<int>.filled(6, 0);

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('User');
    avatarSelected = avatar_page.avatarSelected;
    email = signin_page.Email;
    userName = signin_page.Username;
    nome = signin_page.Nome;
    cognome = signin_page.Cognome;
    nome_cognome = signin_page.Nome + " " + signin_page.Cognome;
    pw = signin_page.Pw;
    indiceSelezionato == 0;
  }

  List<Container> getInterest() {
    List<Container> item = [];
    bool selected;
    for (int i = 1; i <= interest.length; i++) {
      selected = false;
      var tmp = interest[i];
      var top = tmp!['top'] as double;
      var left = tmp!['left'] as double;
      for (int x = 0; x < 6; x++) {
        if (selectedlist[x] == i) {
          selected = true;
        }
      }
      var newItem = Container(
          //padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(
              //top: main_page.MyResponsive().HeightResponsive(top),
              //left: main_page.MyResponsive().WidthResponsive(left)),
              top: top,
              left: left),
          // width: main_page.MyResponsive().WidthResponsive(26.6),
          //height: main_page.MyResponsive().HeightResponsive(4),
          width: 104,
          height: 32,
          child: MyInteresetButton(
            color: selected
                ? tmp!['color'] as Color
                : Color.fromARGB(255, 22, 22, 15),
            text: tmp!['name'],
            onPress: () {
              selectedInterest(tmp_i: i);
            },
          ));
      item.add(newItem);
    }
    return item;
  }

  selectedInterest({required int tmp_i}) {
    setState(() {
      for (var i = 0; i < 6; i++) {
        if (selectedlist[i] == tmp_i) {
          return;
        }
      }
      selectedlist[indiceSelezionato] = tmp_i;
      indiceSelezionato++;
      if (indiceSelezionato >= 6) {
        indiceSelezionato = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
          width: main_page.MyResponsive().WidthResponsive(100),
          margin: EdgeInsets.only(
              top: main_page.MyResponsive().HeightResponsive(15)),
          child: AutoSizeText("Scegli i tuoi Interessi",
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                decoration: TextDecoration.none,
                height: 1.15,
                fontSize: 30,
                foreground: Paint()..color = Colors.white,
                fontFamily: "coolvetica",
              ))),
      Stack(children: getInterest()),
      Container(
          margin: EdgeInsets.only(
              top: main_page.MyResponsive().HeightResponsive(83.29),
              left: main_page.MyResponsive().WidthResponsive(29.49)),
          width: main_page.MyResponsive().WidthResponsive(41.28),
          height: main_page.MyResponsive().HeightResponsive(4.9),
          child: login_page.MyLoginSigInButton(
              bgColor: Color.fromARGB(255, 206, 162, 241),
              text: 'continua',
              onPress: (() {
                WriteUserOnDB(dbRef, email, nome, cognome, userName, pw,
                    avatarSelected, selectedlist);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => home_page.MyHome()));
              })))
    ]);
  }
}

WriteUserOnDB(db, String email, String nome, String cognome, String Usrn,
    String pw, int avatarSelected, List intereset) {
  Map<String, String> user = {
    'email': email,
    'nome': nome,
    'cognome': cognome,
    'username': Usrn,
    'password': pw,
    'avatar': avatarSelected.toString(),
    'interest': intereset.toString(),
  };
  db.child(email).set(user);
  writeUserFile(email, nome, cognome, Usrn, avatarSelected, intereset);
  initUserVariable(email, nome, cognome, Usrn, avatarSelected, intereset);
}

writeUserFile(String email, String nome, String cognome, String Usrn,
    int avatarSelected, List intereset) async {
  final String path = await add_page.getAppPath();
  final File file = File('$path/User.csv');
  //email nome cognome Usrn avatarSelected intereset
  final content = '$email;$nome;$cognome;$Usrn;$avatarSelected;$intereset';
  file.writeAsStringSync(content);
}

initUserVariable(String email, String nome, String cognome, String Usrn,
    int avatarSelected, List intereset) {
  home_page.email = email;
  home_page.nome = nome;
  home_page.cognome = cognome;
  home_page.username = Usrn;
  home_page.avatar = avatarSelected;
  home_page.interest = intereset;
}

Widget MyInteresetButton({
  required text,
  required color,
  required VoidCallback onPress,
}) {
  return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
        foregroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(255, 255, 255, 255)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0))),
      ),
      onPressed: onPress,
      child: Text(text));
}
