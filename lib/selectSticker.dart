import 'dart:ffi';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import './main.dart' as main_page;
import 'AddPAge.dart' as add_page;
import 'LoginSubmitPage.dart' as login_page;
import 'selectAvatar.dart' as avatar_page;
import 'SignPage.dart' as signin_page;
import 'HomePage.dart' as home_page;
import 'confirmSignIn.dart' as confirmSignIn_page;

int stickerSelect = 0;

class MyStickerPageFiled extends StatelessWidget {
  const MyStickerPageFiled({super.key, required this.image});
  final File image;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My Apops Sticker Selecte",
        home: MyStickerField(
          image: image,
        ));
  }
}

class MyStickerField extends StatefulWidget {
  MyStickerField({Key? key, required this.image}) : super(key: key);
  final File image;
  @override
  State<MyStickerField> createState() => MyStickerFieldState();
}

class MyStickerFieldState extends State<MyStickerField> {
  int selSticker = 0;
  bool visibility = false;

  selectSticker(int id) {
    visibility = true;
    selSticker = id;
    stickerSelect = id;
    print(id);
    setState(() {});
  }

  List<Widget> createListSticker() {
    final List<Widget> list = [];
    for (int i = 1; i <= 8; i++) {
      var newItem = MySticker(
        id: i,
        onPress: (() {
          selectSticker(i);
        }),
      );
      list.add(newItem);
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: main_page.BgColor.color(),
      body: Stack(
        //padding: EdgeInsets.only(top: 50),
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(4),
                  left: main_page.MyResponsive().HeightResponsive(3)),
              child: add_page.MyIconButton(
                Icon(Icons.keyboard_arrow_left_sharp),
                () => {
                  stickerSelect = 0,
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => add_page.MyAddPage(
                              image: widget.image,
                            )),
                  )
                },
              )),
          Container(
            margin: EdgeInsets.only(
              top: main_page.MyResponsive().HeightResponsive(5),
            ),
            child: avatar_page.MyTextDescription(text: "Scegli tuo sticker"),
          ),
          Container(
              /*left: 30,
              height: 500,*/
              width: main_page.MyResponsive().WidthResponsive(76.9),
              margin: EdgeInsets.only(
                top: main_page.MyResponsive().HeightResponsive(20),
                left: main_page.MyResponsive().WidthResponsive(45 / 3.9),
              ),
              child: GridView.count(
                mainAxisSpacing: 0,
                crossAxisSpacing: 20,
                childAspectRatio: (122 / 85),
                crossAxisCount: 2,
                children: createListSticker(),
              )),
          Visibility(
              visible: visibility,
              child: Container(
                  margin: EdgeInsets.only(
                      top: main_page.MyResponsive().HeightResponsive(82.48),
                      left: main_page.MyResponsive().WidthResponsive(29.48)),
                  width: main_page.MyResponsive().WidthResponsive(41.28),
                  height: main_page.MyResponsive().HeightResponsive(4.9),
                  child: login_page.MyLoginSigInButton(
                      bgColor: Color.fromARGB(255, 206, 162, 241),
                      text: 'continua',
                      onPress: (() {
                        add_page.stickerSelected = selSticker;
                        stickerSelect = selSticker;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => add_page.MyAddPage(
                                      image: widget.image,
                                    )));
                      }))))
        ],
      ),
    );
  }
}

class MySticker extends StatefulWidget {
  MySticker({Key? key, required this.id, required this.onPress});
  final int id;
  final void Function() onPress;
  @override
  State<MySticker> createState() => _MyStickerState();
}

class _MyStickerState extends State<MySticker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onPress,
        child: Container(
          height: 50,
          width: 50,
          child: Image.asset(
            stickerSelect != widget.id
                ? 'images/sticker_${widget.id}.png'
                : 'images/sticker_${widget.id} round.png',
          ),
        ));
  }
}
