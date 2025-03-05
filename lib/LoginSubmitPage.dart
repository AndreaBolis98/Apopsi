import 'package:flutter/material.dart';
import './main.dart' as main_page;
import './LoginPage.dart' as login_page;
import './SignPage.dart' as sign_page;

class MyLoginPage extends StatelessWidget {
  const MyLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Apops Login",
      home: MyLogin(),
    );
  }
}

class MyLogin extends StatelessWidget {
  final String myText = "la tua voce sulle arti !";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: main_page.BgColor.color(),
        body: Container(
          //padding: EdgeInsets.only(top: 213),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    bottom: main_page.MyResponsive().HeightResponsive(11)),
                //top: (MediaQuery.of(context).size.height / 2) - 100),
                child: main_page.MyApopsandText(),
              ),
              Container(
                  margin: EdgeInsets.only(
                      bottom: main_page.MyResponsive().HeightResponsive(2)),
                  width: 161,
                  height: 42,
                  child: MyLoginSigInButton(
                      bgColor: Color.fromARGB(255, 206, 162, 241),
                      text: 'log in',
                      //onPress: () => login_page.MyLoginPageFiled())),
                      onPress: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  login_page.MyLoginPageFiled()),
                        );
                      }))),
              Container(
                  margin: EdgeInsets.only(
                      bottom: main_page.MyResponsive().HeightResponsive(12.9)),
                  width: 161,
                  height: 42,
                  child: MyLoginSigInButton(
                      bgColor: Color.fromARGB(255, 61, 61, 63),
                      text: 'sign in',
                      onPress: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  sign_page.MySignPageFiled()),
                        );
                      }))),
              Container(
                width: main_page.MyResponsive().WidthResponsive(100),
                height: main_page.MyResponsive().HeightResponsive(29.03),
                margin: EdgeInsets.only(top: 0),
                child: Image(
                    image: AssetImage('images/MaskGroup.png'),
                    fit: BoxFit.fill),
              )
            ],
          ),
        ));
  }
}

Widget MyLoginSigInButton({
  required Color bgColor,
  required String text,
  required final VoidCallback onPress,
}) {
  return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(bgColor),
          foregroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(255, 255, 255, 255)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)))),
      onPressed: onPress,
      child: Text(
        text.toString(),
        style: const TextStyle(
          fontSize: 17.0,
          fontFamily: "coolvetica",
        ),
      ));
}
