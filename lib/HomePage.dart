import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import './main.dart' as main_page;
import 'LoginSubmitPage.dart' as login_page;
import 'AddPAge.dart' as add_page;
import 'ProfilePage.dart' as profile_page;
import 'camera_page.dart' as camera_page;
import 'AddPAge.dart' as add_page;
import 'Collezione.dart' as collect_page;
import 'singoloUpdate.dart' as update_page;
import 'recensione.dart' as recensione_pge;
import 'extra.dart' as extra_page;

String email = "";
String nome = "";
String cognome = "";
String username = "";
int avatar = 0;
List interest = [];
int indiceSelezionatoFilter = 4;

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Apops Home PAge",
      home: MyHome(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: Theme.of(context).textTheme.copyWith(
                subtitle1: const TextStyle(color: Colors.white),
              )),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: main_page.BgColor.color(),
      body: MyHomeField(),
      bottomNavigationBar: MyBottomNavigationBar(0),
    );
  }
}

class MyHomeField extends StatefulWidget {
  @override
  State<MyHomeField> createState() => _MyHomeFieldState();
}

class _MyHomeFieldState extends State<MyHomeField> {
  late DatabaseReference dbRef;
  late int avatarSelected;
  late String name;
  late int friend;

  @override
  void initState() {
    indiceSelezionatoFilter = 4;
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Updates');
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
            add_page.MyTextDescription("Updates"),
            Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(18.86)),
              child: add_page.MyExtraContent(),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(15)),
              child: collect_page.MyRowCategory(
                onPress: () {
                  changeList();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(21)),
              child: MyRowCategoryFilter(
                onPress: () {
                  changeList();
                },
              ),
            ),
            /*Positioned(
                top: main_page.MyResponsive().HeightResponsive(30),
                left: main_page.MyResponsive().WidthResponsive(9.7),
                width: 332,
                height: 193,
                child: MyCard(
                  autore: 'Harper Lee',
                  color: main_page.colorIndice[1],
                  commenti:
                      'Un libro ancora attuale e mai banale che parla di liberta',
                  data: 'il 27 febbraio',
                  image:
                      'https://firebasestorage.googleapis.com/v0/b/apopsi-database.appspot.com/o/Added%2F1674922149253?alt=media&token=bca09ca2-ebf9-4945-b5ef-713b54d95114',
                  n_recensioni: 5,
                  onPress: () {},
                  tag: '@test',
                  titolo: 'Un giorno questo dolore ti sara\' utile',
                  voto: 3,
                  votoOcommento: true,
                )*/
            Positioned(
                top: main_page.MyResponsive().HeightResponsive(28),
                left: main_page.MyResponsive().WidthResponsive(9.7),
                width: 332,
                height: 500,
                child: FutureBuilder(
                  future: createList(
                    dbRef,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.count(
                        shrinkWrap: true,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 21,
                        childAspectRatio: (313 / 188),
                        crossAxisCount: 1,
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

//create List for event
Future<List<Widget>> createList(
  db,
) async {
  final List<Widget> list = [];
  List<collection> listCollection = await getFromDB(db);
  var _add = false;
  for (int i = 0; i < listCollection.length; i++) {
    var added = listCollection[i];
    //print(added.image);
    var indice = int.parse(added.indice);
    var subindice = (added.subIndez);
    print(indiceSelezionatoFilter);
    if ((indice == collect_page.indiceSelezionato ||
            collect_page.indiceSelezionato == 4) &&
        (subindice[0] == indiceSelezionatoFilter ||
            subindice[1] == indiceSelezionatoFilter ||
            indiceSelezionatoFilter == 4)) {
      var newItem = MyCard(
        commentiLunghi: added.commeniLunghi,
        autore: added.autore,
        color: main_page.colorIndice[indice],
        commenti: added.commenti,
        data: added.date,
        image: added.image,
        n_recensioni: int.parse(added.n_recensioni),
        tag: added.tag,
        titolo: added.titolo,
        voto: double.parse(added.voto),
        votoOdata: int.parse(added.votoOdata),
        isNew: int.parse(added.isNew),
        indice: indice,
      );

      list.add(newItem);
      _add = true;
    }
  }
  if (_add == false) {
    list.add(SizedBox());
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
  final String votoOdata;
  final String n_recensioni;
  final String isNew;
  final List subIndez;
  final String tag;
  final String commeniLunghi;

  const collection({
    required this.autore,
    required this.commenti,
    required this.titolo,
    required this.image,
    required this.indice,
    required this.spolier,
    required this.sticker,
    required this.voto,
    required this.date,
    required this.votoOdata,
    required this.n_recensioni,
    required this.isNew,
    required this.subIndez,
    required this.tag,
    required this.commeniLunghi,
  });

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
      date: map['data'] ?? '',
      votoOdata: map['v_o_d'] ?? '',
      n_recensioni: map['nRecensioni'] ?? '',
      isNew: map['isNew'] ?? '',
      subIndez: map['sottoindice'] ?? '',
      tag: map['tag'] ?? '',
      commeniLunghi: map['Dettaglio']['commento'] ?? '',
    );
  }
}

class MyCard extends StatelessWidget {
  MyCard({
    Key? key,
    required this.image,
    required this.color,
    required this.n_recensioni,
    required this.voto,
    required this.data,
    required this.autore,
    required this.commenti,
    required this.titolo,
    required this.tag,
    required this.votoOdata,
    required this.isNew,
    required this.indice,
    required this.commentiLunghi,
  });

  final String image;
  final int n_recensioni;
  final Color color;
  final double voto;
  final String data;
  final String autore;
  final String commenti;
  final String titolo;
  final String tag;
  final int votoOdata;
  final int isNew;
  final int indice;
  final String commentiLunghi;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              if (votoOdata == 1)
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => update_page.MySingoloUpdatePage(
                                titolo: titolo,
                              )))
                }
              else if (votoOdata == 0)
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => recensione_pge.MyRecensionePage(
                                commenti: commentiLunghi,
                                image: image,
                                voto: voto,
                                autore: autore,
                                titolo: titolo,
                              )))
                }
            },
        child: Stack(children: [
          Container(
              margin: EdgeInsets.only(left: 0, top: 5),
              width: 313,
              height: 188,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(61, 61, 63, 1),
                  ),
                  child: Stack(fit: StackFit.expand, children: [
                    Positioned(
                        top: 0,
                        left: 0,
                        height: 188,
                        width: 140,
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Container(
                                width: 20,
                                decoration: BoxDecoration(
                                  color: color,
                                )))),
                    Positioned(
                        top: 0,
                        left: 0,
                        height: 158,
                        width: 140,
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Image.network(
                              image,
                              fit: BoxFit.fill,
                            ))),
                    if (votoOdata == 0)
                      Positioned(
                        bottom: 7,
                        left: 14,
                        child: main_page.MyTextResponsive(
                            text: '$voto',
                            size: 14,
                            color: Color.fromRGBO(255, 255, 255, 1),
                            TextAlign: TextAlign.left),
                      ),
                    if (votoOdata == 0)
                      Positioned(
                          bottom: 8,
                          left: 34,
                          child: collect_page.MyStarVis(
                              voto: voto, itemSize: 16.0)),
                    if (votoOdata == 1)
                      Positioned(
                        bottom: 7,
                        left: 0,
                        width: 140,
                        child: main_page.MyTextResponsive(
                            text: '$data',
                            size: 14,
                            color: Color.fromRGBO(255, 255, 255, 1),
                            TextAlign: TextAlign.center),
                      ),
                    Positioned(
                        top: 36,
                        left: 163,
                        width: 148,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            main_page.MyTextResponsive(
                                text: tag,
                                size: 14,
                                color: Color.fromRGBO(153, 153, 155, 1),
                                TextAlign: TextAlign.left),
                            SizedBox(
                              height: 5.3,
                            ),
                            main_page.MyTextResponsive(
                                text: titolo,
                                size: 16,
                                color: Color.fromRGBO(255, 255, 255, 1),
                                TextAlign: TextAlign.left),
                            main_page.MyTextResponsive(
                                text: autore,
                                size: 14,
                                color: Color.fromRGBO(153, 153, 155, 1),
                                TextAlign: TextAlign.left),
                            SizedBox(
                              height: 15.3,
                            ),
                            main_page.MyTextResponsive(
                                text: commenti,
                                size: 14,
                                color: Color.fromRGBO(153, 153, 155, 1),
                                TextAlign: TextAlign.left),
                          ],
                        )),

                    /*Positioned(
              top: 37,
              left: 165,
              child: main_page.MyTextResponsive(
                  text: tag,
                  size: 14,
                  color: Color.fromRGBO(153, 153, 155, 1),
                  TextAlign: TextAlign.left),
            ),
            Positioned(
              top: 56,
              left: 165,
              width: 136,
              child: main_page.MyTextResponsive(
                  text: titolo,
                  size: 16,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  TextAlign: TextAlign.left),
            ),
            Positioned(
              top: 77,
              left: 165,
              child: main_page.MyTextResponsive(
                  text: autore,
                  size: 14,
                  color: Color.fromRGBO(153, 153, 155, 1),
                  TextAlign: TextAlign.left),
            ),
            Positioned(
              top: 103,
              left: 165,
              width: 136,
              child: main_page.MyTextResponsive(
                  text: commenti,
                  size: 14,
                  color: Color.fromRGBO(153, 153, 155, 1),
                  TextAlign: TextAlign.left),
            ),
            Positioned(
              top: 103,
              left: 165,
              width: 136,
              child: main_page.MyTextResponsive(
                  text: commenti,
                  size: 14,
                  color: Color.fromRGBO(153, 153, 155, 1),
                  TextAlign: TextAlign.left),
            ),*/
                  ]),
                ),
              )),
          if (n_recensioni > 0 && isNew == 0)
            Positioned(
                top: 0,
                right: 0,
                height: 25,
                width: 85,
                child: Transform.rotate(
                    angle: -0.19,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: color,
                              border: Border.all(
                                  width: 2,
                                  color: Color.fromRGBO(255, 255, 255, 1))),
                          child: main_page.MyTextResponsive(
                              text: "$n_recensioni  RECENSIONI",
                              size: 14,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              TextAlign: TextAlign.center),
                        )))),
          if (isNew == 1)
            Positioned(
                top: 0,
                right: 0,
                height: 69,
                width: 85,
                child: Image.asset("images/new_$indice.png", fit: BoxFit.fill)),
        ]));
  }
}

//Bottom navigation
class MyBottomNavigationBar extends StatelessWidget {
  final controller = PageController(initialPage: 1);
  MyBottomNavigationBar(this._page);
  final int _page;
  @override
  Widget build(BuildContext context) {
    return GNav(
        backgroundColor: main_page.BgColor.color(),
        rippleColor: Color.fromARGB(
            255, 215, 19, 75), // tab button ripple color when pressed
        hoverColor: Color.fromARGB(255, 215, 19, 75), // tab button hover color
        haptic: true, // haptic feedback
        tabBorderRadius: 12,
        curve: Curves.easeOutExpo, // tab animation curves
        duration: Duration(milliseconds: 500), // tab animation duration
        gap: 8, // the tab button gap between icon and text
        color: Colors.white, // unselected icon color
        activeColor: Colors.white, // selected icon and text color
        iconSize: 28, // tab button icon size
        tabMargin: EdgeInsets.only(
            bottom: main_page.MyResponsive().HeightResponsive(2)),
        tabBackgroundColor:
            Color.fromARGB(255, 215, 19, 75), // selected tab background color
        padding: EdgeInsets.all(16), // navigation bar padding
        selectedIndex: _page,
        onTabChange: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHome()),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => extra_page.MyExtraPage()),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => profile_page.MyProfilePage()),
            );
          }
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      camera_page.CameraPage(controller: this.controller)),
            );
          }
        },
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'home',
          ),
          GButton(
            icon: Icons.web_asset,
            text: 'extra',
          ),
          GButton(
            icon: Icons.account_circle,
            text: 'profilo',
          ),
          GButton(
            icon: Icons.add_circle_outline,
            text: 'aggiungi',
          )
        ]);
  }
}

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < widget.buttons.length; i++)
          MyWidget(
            text: widget.buttons[i].text,
            onPressed: () {
              for (var j = 0; j < favoriateState.length; j++) {
                favoriateState[j] = false;
              }
              setState(() {
                favoriateState[i] = true;
                if (widget.buttons[i].onPressed != null) {
                  widget.buttons[i].onPressed!();
                }
              });
            },
            isFavourte: favoriateState[i],
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
      required this.text,
      required this.onPressed,
      this.isFavourte = false})
      : super(key: key);

  final String text;
  final Function()? onPressed;
  final bool isFavourte;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: isFavourte ? Colors.red : Colors.green,
        ),
        onPressed: onPressed,
        child: Text(text));
  }
}

class MyBg extends StatelessWidget {
  const MyBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(58, 215, 19, 1)),
    );
  }
}

//3 pulsanti di scelta in alto
class MyRowCategoryFilter extends StatefulWidget {
  MyRowCategoryFilter({Key? key, required this.onPress});

  final void Function() onPress;
  @override
  State<MyRowCategoryFilter> createState() => _MyRowCategoryStateFilter();
}

class _MyRowCategoryStateFilter extends State<MyRowCategoryFilter> {
  @override
  Widget build(BuildContext context) {
    var teatro;
    return Container(
      padding: EdgeInsets.all(10),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        MyButtonList_filter(
          buttons: [
            ButtonDataFilter(text: 'per te', onPressed: widget.onPress),
            ButtonDataFilter(text: 'novita\'', onPressed: widget.onPress),
            ButtonDataFilter(text: 'amici', onPressed: widget.onPress)
          ],
        )
      ]),
    );
  }
}

class MyButtonList_filter extends StatefulWidget {
  const MyButtonList_filter({Key? key, required this.buttons})
      : super(key: key);

  final List<ButtonDataFilter> buttons;

  @override
  State<MyButtonList_filter> createState() => _MyButtonFilterListState();
}

class _MyButtonFilterListState extends State<MyButtonList_filter> {
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
          MyWidgetFilter(
            i: collect_page.indiceSelezionato,
            text: widget.buttons[i].text,
            onPressed: () {
              for (var j = 0; j < favoriateState.length; j++) {
                favoriateState[j] = false;
              }
              setState(() {
                favoriateState[i] = true;
                if (indiceSelezionatoFilter != i) {
                  indiceSelezionatoFilter = i;
                } else {
                  indiceSelezionatoFilter = 4;
                }

                if (widget.buttons[i].onPressed != null) {
                  widget.buttons[i].onPressed!();
                }
              });
            },
            isFavourte: indiceSelezionatoFilter == i,
          ),
      ],
    );
  }
}

class ButtonDataFilter {
  final String text;
  final Function()? onPressed;
  final bool isFavorite;

  ButtonDataFilter(
      {required this.text, this.onPressed, this.isFavorite = false});
}

class MyWidgetFilter extends StatelessWidget {
  const MyWidgetFilter(
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
                isFavourte && i < 3
                    ? main_page.colorIndice[i]
                    : (isFavourte
                        ? Color.fromARGB(200, 200, 61, 63)
                        : Color.fromARGB(255, 61, 61, 63)),
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
