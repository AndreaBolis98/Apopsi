import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'LoginSubmitPage.dart' as loginSub_page;
import 'AddPAge.dart' as add_page;
import 'HomePage.dart' as home_page;
//Color bgColor = Color.fromARGB(255, 99, 90, 64);

final List<Color> colorIndice = [
  Color.fromRGBO(152, 191, 30, 1),
  Color.fromRGBO(215, 19, 75, 1),
  Color.fromRGBO(206, 162, 241, 1),
  Color.fromRGBO(152, 191, 30, 1),
  Color.fromARGB(255, 61, 61, 63),
  Color.fromARGB(255, 61, 61, 63),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (() => () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => loginSub_page.MyLoginPage()),
            )),
        child: MaterialApp(
          title: "My Apops Page",
          //home: MyApops(),
          home: FutureBuilder(
              future: _fbApp,
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  //print("you have an error! ${snapshot.error.toString()}");
                  return Text("wrong");
                } else if (snapshot.hasData) {
                  print(snapshot.hasData);
                  return MyApops();
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
        ));
  }
}

class MyApops extends StatefulWidget {
  @override
  State<MyApops> createState() => _MyApopsState();
}

class _MyApopsState extends State<MyApops> {
  final String myText = "la tua voce sulle arti";

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        (() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => loginSub_page.MyLoginPage()),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BgColor.color(),
      body: Stack(
        children: <Widget>[
          Positioned(
              height: MyResponsive().HeightResponsive(13),
              width: MyResponsive().WidthResponsive(36.15),
              top: MyResponsive().HeightResponsive(35.78),
              left: MyResponsive().WidthResponsive(31.79),
              child: Image(
                image: AssetImage('images/Apops_completa.png'),
                fit: BoxFit.fill,
              )),
          /*Positioned(
              top: MyResponsive().HeightResponsive(46.09),
              width: MyResponsive().WidthResponsive(100),
              child: MyTextResponsive(
                  text: myText,
                  size: 15,
                  color: Colors.white,
                  TextAlign: TextAlign.center)),*/
          Positioned(
            width: MyResponsive().WidthResponsive(100),
            height: MyResponsive().HeightResponsive(29.03),
            left: 0,
            bottom: 0,
            child: Image(
              image: AssetImage('images/MaskGroup.png'),
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}

class MyApopsandText extends StatelessWidget {
  final String myText = "la tua voce sulle arti";

  @override
  Widget build(BuildContext context) {
    var file_exist;
    var page;
    return Container(
      /*onTap: () async => {
        file_exist = await getUserFile(),
        if (file_exist == false)
          {page = loginSub_page.MyLoginPage()}
        else
          {page = home_page.MyHomePage()},
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        )
      },*/
      child: Column(
        children: <Widget>[
          Image(image: AssetImage('images/Apops.png')),
          MyTextResponsive(
              text: myText,
              size: 15,
              color: Colors.white,
              TextAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class BgColor {
  static Color color() {
    return Color.fromARGB(255, 31, 30, 32);
  }
}

class MyResponsive {
  Size size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;

  double HeightResponsive(perc) {
    double height = size.height;
    if (perc != null) {
      double heightResp = height * perc / 100;
      return heightResp;
    } else {
      return 0;
    }
  }

  double WidthResponsive(perc) {
    double width = size.width;
    if (perc != null) {
      double widthResp = width * perc / 100;
      return widthResp;
    } else {
      return 0;
    }
  }
}

Widget MyTextResponsive(
    {required String text,
    required Color color,
    required double size,
    required TextAlign}) {
  return //Expanded(
      //child:
      AutoSizeText(text,
          textAlign: TextAlign,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            height: 1.15,
            fontSize: size,
            foreground: Paint()..color = color,
            fontFamily: "coolvetica",
          ))
      //)
      ;
}

Future<bool> getUserFile() async {
  final String path = await add_page.getAppPath();
  final File file = File('$path/User.csv');

  if (await file.exists()) {
    final content = file.readAsStringSync();
    final list = content.split(';');
    //email nome cognome Usrn avatarSelected intereset

    if (list != null) {
      return false;
    }
  }
  return false;
}
