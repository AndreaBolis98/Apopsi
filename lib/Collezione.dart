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

int indiceSelezionato = 4;

class MyCollectPage extends StatelessWidget {
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
            title: "My Apops Collezione",
            theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: Theme.of(context).textTheme.copyWith(
                      subtitle1: const TextStyle(color: Colors.white),
                    )),
            home: MyCollect()));
  }
}

class MyCollect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: main_page.BgColor.color(),
      body: MyCollctField(),
      bottomNavigationBar: home_page.MyBottomNavigationBar(2),
    );
  }
}

class MyCollctField extends StatefulWidget {
  @override
  State<MyCollctField> createState() => MyCollectFieldState();
}

class MyCollectFieldState extends State<MyCollctField> {
  final controller = PageController(initialPage: 1);
  late DatabaseReference dbRef;
  late String image;
  late bool sticker;
  late Color color;
  late double voto;
  late String autore;
  late String commenti;
  late String titolo;
  late bool spoiler;

  @override
  void initState() {
    indiceSelezionato = 4;
    super.initState();
    dbRef = FirebaseDatabase.instance
        .ref()
        .child('Aggiungi')
        .child(home_page.email);
  }

  void changeList() {
    setState(() {});
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
                            builder: (context) => profile_page.MyProfilePage()))
                  },
                )),
            Positioned(
                top: main_page.MyResponsive().HeightResponsive(4),
                right: main_page.MyResponsive().HeightResponsive(3),
                child: add_page.MyIconButton(
                  Icon(Icons.search),
                  () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => profile_page.MyProfilePage()))
                  },
                )),
            add_page.MyTextDescription("Collezione"),
            Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(18.86)),
              child: add_page.MyExtraContent(),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(15)),
              child: MyRowCategory(
                onPress: () {
                  changeList();
                },
              ),
            ),
            Positioned(
                top: main_page.MyResponsive().HeightResponsive(21.32),
                left: main_page.MyResponsive().WidthResponsive(9.7),
                width: 315,
                height: 550,
                child: FutureBuilder(
                  future: createList(
                    dbRef,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.count(
                        mainAxisSpacing: 21,
                        crossAxisSpacing: 21,
                        childAspectRatio: (91 / 120),
                        crossAxisCount: 3,
                        children: snapshot.requireData,
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ))
          ],
        ));
  }
}

class MyCard extends StatelessWidget {
  MyCard(
      {Key? key,
      required void Function() onPress,
      required this.image,
      required this.color,
      required this.sticker,
      required this.voto,
      required this.autore,
      required this.commenti,
      required this.titolo,
      required this.spoiler,
      required this.date});

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
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => singola_page.MySingolaCollezionePage(
                      image: image,
                      sticker: sticker,
                      color: color,
                      voto: voto,
                      autore: autore,
                      commenti: commenti,
                      titolo: titolo,
                      spoiler: spoiler,
                      date: date,
                    )))
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        child: Container(
          decoration: BoxDecoration(
            color: color,
          ),
          child: Stack(fit: StackFit.expand, children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 103,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    child: Image.network(
                      image,
                      fit: BoxFit.fill,
                    ))),
            Positioned(
                height: 31,
                width: 38,
                top: 0,
                right: 0,
                child: Visibility(
                    visible: sticker > 0,
                    child: Image.asset('images/sticker_$sticker.png'))),
            Positioned(
                bottom: 5,
                left: 21,
                child: MyStarVis(voto: voto, itemSize: 8.0))
          ]),
        ),
      ),
    );
  }
}

Widget MyStarVis({required double voto, required double itemSize}) {
  return RatingBar(
    initialRating: voto,
    minRating: 1,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    itemSize: itemSize,
    ignoreGestures: true,
    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
    ratingWidget: RatingWidget(
        full: Icon(
          Icons.star,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        half: Icon(
          Icons.star_half,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        empty: Icon(
          Icons.star_border,
          color: Color.fromRGBO(255, 255, 255, 1),
        )),
    onRatingUpdate: (double value) {},
  );
}

Future<List<Widget>> createList(
  db,
) async {
  final List<Widget> list = [];
  List<collection> listCollection = await getFromDB(db);
  for (int i = 0; i < listCollection.length; i++) {
    var added = listCollection[i];
    var indice = int.parse(added.indice);
    print(indiceSelezionato);
    if (indice == indiceSelezionato || indiceSelezionato == 4) {
      var newItem = MyCard(
        onPress: () {
          singola_page.MySingolaCollezionePage(
              image: added.image,
              sticker: int.parse(added.sticker),
              color: main_page.colorIndice[indice],
              voto: double.parse(added.voto),
              autore: added.autore,
              commenti: added.commenti,
              titolo: added.titolo,
              spoiler: added.spolier == 'true',
              date: added.date);
        },
        image: added.image,
        sticker: int.parse(added.sticker),
        color: main_page.colorIndice[indice],
        voto: double.parse(added.voto),
        autore: added.autore,
        commenti: added.commenti,
        titolo: added.titolo,
        spoiler: added.spolier == 'true',
        date: added.date,
      );

      list.add(newItem);
    }
  }
  return list;
}

Future<List<collection>> getFromDB(db) async {
  final List<collection> list = [];
  final snapshot = await db.get();
  if (snapshot.exists) {
    final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      final collect = collection.fromMap(value);
      list.add(collect);
    });
  } else {
    print('No data available.');
  }
  return list;
}

class collection {
  final String autore;
  final String commenti;
  final String titolo;
  final String image;
  final String indice;
  final String spolier;
  final String sticker;
  final String voto;
  final String date;

  const collection(
      {required this.autore,
      required this.commenti,
      required this.titolo,
      required this.image,
      required this.indice,
      required this.spolier,
      required this.sticker,
      required this.voto,
      required this.date});

  factory collection.fromMap(Map<dynamic, dynamic> map) {
    return collection(
      autore: map['autore'] ?? '',
      commenti: map['commenti'] ?? '',
      titolo: map['titolo'] ?? '',
      image: map['image'] ?? '',
      indice: map['indice'] ?? '',
      spolier: map['spoiler'] ?? '',
      sticker: map['sticker'] ?? '',
      voto: map['voto'] ?? '',
      date: map['date'] ?? '',
    );
  }
}

class MyRowCategory extends StatefulWidget {
  MyRowCategory({Key? key, required this.onPress});

  final void Function() onPress;
  @override
  State<MyRowCategory> createState() => _MyRowCategoryState();
}

class _MyRowCategoryState extends State<MyRowCategory> {
  @override
  Widget build(BuildContext context) {
    var teatro;
    return Container(
      padding: EdgeInsets.all(10),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        MyButtonList(
          buttons: [
            ButtonData(text: 'teatro', onPressed: widget.onPress),
            ButtonData(text: 'cinema', onPressed: widget.onPress),
            ButtonData(text: 'letteratura', onPressed: widget.onPress)
          ],
        )
      ]),
    );
  }
}

//3 pulsanti di scelta in alto
class MyButtonList extends StatefulWidget {
  const MyButtonList({Key? key, required this.buttons}) : super(key: key);

  final List<ButtonData> buttons;

  @override
  State<MyButtonList> createState() => _MyButtonListState();
}

class _MyButtonListState extends State<MyButtonList> {
  late List<bool> favoriateState;

  @override
  void initState() {
    favoriateState = List.generate(
        widget.buttons.length, (index) => widget.buttons[index].isFavorite);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var i = 0; i < widget.buttons.length; i++)
          MyWidget(
            i: i,
            text: widget.buttons[i].text,
            onPressed: () {
              for (var j = 0; j < favoriateState.length; j++) {
                favoriateState[j] = false;
              }
              setState(() {
                favoriateState[i] = true;
                if (indiceSelezionato != i) {
                  indiceSelezionato = i;
                } else {
                  indiceSelezionato = 4;
                }

                if (widget.buttons[i].onPressed != null) {
                  widget.buttons[i].onPressed!();
                }
              });
            },
            isFavourte: indiceSelezionato == i,
          ),
      ],
    );
  }
}

class ButtonData {
  final String text;
  final Function()? onPressed;
  final bool isFavorite;

  ButtonData({required this.text, this.onPressed, this.isFavorite = false});
}

class MyWidget extends StatelessWidget {
  const MyWidget(
      {Key? key,
      required this.i,
      required this.text,
      required this.onPressed,
      this.isFavourte = false})
      : super(key: key);
  final int i;
  final String text;
  final Function()? onPressed;
  final bool isFavourte;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: main_page.MyResponsive().WidthResponsive(25),
        height: main_page.MyResponsive().HeightResponsive(5),
        padding: EdgeInsets.only(right: 5),
        child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                isFavourte
                    ? main_page.colorIndice[i]
                    : Color.fromARGB(255, 61, 61, 63),
              ),
              foregroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 255, 255, 255)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11.0))),
            ),
            onPressed: onPressed,
            child: Text(text)));
  }
}
