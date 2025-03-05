import 'dart:io';

//import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import './main.dart' as main_page;
import 'LoginSubmitPage.dart' as loginSigIn_page;
import 'HomePage.dart' as home_page;
import 'LoginPage.dart' as login_page;
import 'camera_page.dart' as camera_page;
import 'ProfilePage.dart' as profile_page;
import 'Collezione.dart' as collezione_page;
import 'selectSticker.dart' as selectSticker_page;
import 'confirmSelected.dart' as confirm_page;

late int indiceSelezionato = 0;
late double voto = 0;
int stickerSelected = 0;
bool spoilerPresent = false;
TextEditingController titoloController = TextEditingController();
TextEditingController autoreController = TextEditingController();
TextEditingController commentiController = TextEditingController();

class MyAddPage extends StatelessWidget {
  const MyAddPage({Key? key, required this.image}) : super(key: key);
  final File image;
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
            title: "My Apops Login Filed",
            theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: Theme.of(context).textTheme.copyWith(
                      subtitle1: const TextStyle(color: Colors.white),
                    )),
            home: MyAdd(
              image: image,
            )));
  }
}

class MyAdd extends StatelessWidget {
  const MyAdd({Key? key, required this.image}) : super(key: key);
  final File image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: main_page.BgColor.color(),
      body: MyAddField(
        image: image,
      ),
      bottomNavigationBar: home_page.MyBottomNavigationBar(3),
    );
  }
}

class MyAddField extends StatefulWidget {
  const MyAddField({Key? key, required this.image}) : super(key: key);
  final File image;
  @override
  State<MyAddField> createState() => _MyAddFieldState();
}

class _MyAddFieldState extends State<MyAddField> {
  final controller = PageController(initialPage: 1);
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Aggiungi');
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
              child: MyAddBg(),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(4),
                    left: main_page.MyResponsive().HeightResponsive(3)),
                child: MyIconButton(
                  Icon(Icons.keyboard_arrow_left_sharp),
                  () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => home_page.MyHomePage()),
                    )
                  },
                )),
            MyTextDescription("Aggiungi alla collezione"),
            Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(18.86)),
              child: MyExtraContent(),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(15)),
              child: MyRowCategory(),
            ),
            Container(
                width: main_page.MyResponsive().WidthResponsive(25.64),
                height: main_page.MyResponsive().HeightResponsive(16),
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(23.58),
                    left: main_page.MyResponsive().WidthResponsive(9.7)),
                child: GestureDetector(
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => camera_page.CameraPage(
                                    controller: this.controller)),
                          )
                        },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(14.0),
                        child: widget.image.path != "images/foto.png"
                            ? Image.file(
                                widget.image,
                                fit: BoxFit.fill,
                              )
                            : Image.asset("images/foto.png",
                                fit: BoxFit.fill)))),
            Container(
              width: main_page.MyResponsive().WidthResponsive(50.51),
              height: main_page.MyResponsive().HeightResponsive(4.95),
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(23.58),
                  left: main_page.MyResponsive().WidthResponsive(39.74)),
              child: login_page.MyTextInput(
                  "Titolo", false, titoloController, false),
              //child: login_page.MyCustomForm(titoloController),
            ),
            Container(
              width: main_page.MyResponsive().WidthResponsive(50.51),
              height: main_page.MyResponsive().HeightResponsive(4.95),
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(30.54),
                  left: main_page.MyResponsive().WidthResponsive(39.74)),
              child: login_page.MyTextInput(
                  "Autore", false, autoreController, false),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(37.55),
                    left: main_page.MyResponsive().WidthResponsive(40)),
                child: MyStarTry()),
            Container(
              width: main_page.MyResponsive().WidthResponsive(33.33),
              height: main_page.MyResponsive().HeightResponsive(4.5),
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(40.70),
                  left: main_page.MyResponsive().WidthResponsive(9.8)),
              child: MyCustomSticker("scegli uno sticker", true, widget.image),
            ),
            Container(
                width: main_page.MyResponsive().WidthResponsive(33.33),
                height: main_page.MyResponsive().HeightResponsive(4.5),
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(46),
                    left: main_page.MyResponsive().WidthResponsive(9.8)),
                child: MyImagePickerButton(
                    text: "aggiungi un video", onPress: () => {})),
            Container(
                width: main_page.MyResponsive().WidthResponsive(33.33),
                height: main_page.MyResponsive().HeightResponsive(4.5),
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(46),
                    left: main_page.MyResponsive().WidthResponsive(47.28)),
                child: MyImagePickerButton(
                  text: "aggiungi una foto",
                  onPress: () => {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => camera_page.CameraPage(
                              controller: this.controller)),
                    )*/
                  },
                )),
            Container(
                width: main_page.MyResponsive().WidthResponsive(80.25),
                height: main_page.MyResponsive().HeightResponsive(26.77),
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(51.18),
                    left: main_page.MyResponsive().WidthResponsive(9.74)),
                child: MyTextInputLarge(commentiController)),
            Container(
                width: main_page.MyResponsive().WidthResponsive(48),
                height: main_page.MyResponsive().HeightResponsive(3.3),
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(79.41),
                    left: main_page.MyResponsive().WidthResponsive(9.74)),
                child: main_page.MyTextResponsive(
                    text: "sono presenti spoiler?",
                    color: Colors.white,
                    size: 15,
                    TextAlign: TextAlign.left)),
            Container(
                width: main_page.MyResponsive().WidthResponsive(48),
                height: main_page.MyResponsive().HeightResponsive(5),
                margin: EdgeInsets.only(
                    top: main_page.MyResponsive().HeightResponsive(78),
                    left: main_page.MyResponsive().WidthResponsive(27)),
                child: MyIcon()),
            Container(
              width: main_page.MyResponsive().WidthResponsive(41.02),
              height: main_page.MyResponsive().HeightResponsive(5),
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(83.84),
                  left: main_page.MyResponsive().WidthResponsive(29.48)),
              child: MyImagePickerButton(
                  text: "conferma",
                  onPress: () async {
                    String url = await uploadImage();
                    wrtiteLine(url, dbRef);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => confirm_page.MyConfirmAddPage(
                                  indice: indiceSelezionato,
                                )));
                    clearAdd();
                  }),
            ),
            /*Container(
              width: main_page.MyResponsive().WidthResponsive(41.02),
              height: main_page.MyResponsive().HeightResponsive(5),
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(83.84),
                  left: main_page.MyResponsive().WidthResponsive(0)),
              child: MyImagePickerButton(
                  text: "conferma",
                  onPress: () {
                    //readFromDB(dbRef);
                    uploadImage();
                  }),
            ),
            Container(
              width: main_page.MyResponsive().WidthResponsive(41.02),
              height: main_page.MyResponsive().HeightResponsive(5),
              margin: EdgeInsets.only(
                  top: main_page.MyResponsive().HeightResponsive(83.84),
                  left: main_page.MyResponsive().WidthResponsive(55)),
              child: MyImagePickerButton(
                  text: "conferma",
                  onPress: () {
                    //readFromDB(dbRef);
                    downloadImage();
                  }),
            )*/
          ],
        ));
  }
}

class MyAddBg extends StatelessWidget {
  const MyAddBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/sfondo colorato.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MyIconButton extends StatelessWidget {
  MyIconButton(this._icon, this._onPress);
  final Icon _icon;
  final void Function() _onPress;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _icon,
      iconSize: 32,
      color: Color.fromARGB(255, 255, 255, 255),
      onPressed: _onPress,
    );
  }
}

class MyTextDescription extends StatelessWidget {
  MyTextDescription(
    this._text,
  );
  final String _text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: main_page.MyResponsive().WidthResponsive(100),
      margin: EdgeInsets.only(
          top: main_page.MyResponsive().HeightResponsive(10),
          left: main_page.MyResponsive().HeightResponsive(0)),
      child: main_page.MyTextResponsive(
          text: _text,
          size: 30,
          color: Colors.white,
          TextAlign: TextAlign.center),
    );
  }
}

class MyExtraContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: MyRect(),
              ),
            ],
          ),
        ));
  }
}

class MyRect extends StatelessWidget {
  const MyRect({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(0.0, 0.0),
        child: SizedBox(
          width: main_page.MyResponsive().WidthResponsive(100),
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(46), topLeft: Radius.circular(46)),
            child: Container(
              decoration: BoxDecoration(
                color: main_page.BgColor.color(),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0),
                ],
              ),
            ),
          ),
        ));
  }
}

class MyRowCategory extends StatefulWidget {
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
            ButtonData(text: 'teatro'),
            ButtonData(text: 'cinema'),
            ButtonData(text: 'letteratura')
          ],
        )
      ]),
    );
  }
}

Widget MyImage({
  required AssetImage path,
}) {
  return Image(
    image: path,
  );
}

class MyStarTry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: RatingBar(
            initialRating: voto,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 15.0,
            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
            ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 206, 162, 241),
                ),
                half: Icon(
                  Icons.star_half,
                  color: Color.fromARGB(255, 206, 162, 241),
                ),
                empty: Icon(
                  Icons.star_border,
                  color: Color.fromARGB(255, 206, 162, 241),
                )),
            onRatingUpdate: (rating) {
              voto = rating;
            }));
  }
}

class MyCustomSticker extends StatefulWidget {
  MyCustomSticker(this._text, this._isSticker, this.image);
  final File image;
  final String _text;
  final bool _isSticker;

  @override
  State<MyCustomSticker> createState() => _MyCustomStickerState();
}

class _MyCustomStickerState extends State<MyCustomSticker> {
  late bool isstickerSelected = false;
  int id = selectSticker_page.stickerSelect;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          setState(() {
            //print("a");
            if (id == 0) {
              isstickerSelected = false;
            } else {
              isstickerSelected = true;
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => selectSticker_page.MyStickerPageFiled(
                          image: widget.image,
                        )));
          });
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Visibility(
              visible: id == 0,
              child: MyCustomButton(
                  widget._text, () => login_page.MyLoginPageFiled(), true),
            ),
            Visibility(
                visible: id > 0,
                child: Image(
                    image: AssetImage('images/sticker_$id.png'),
                    fit: BoxFit.contain)),
          ],
        ));
  }
}

class MyCustomButton extends StatelessWidget {
  MyCustomButton(this._text, this._function, this.isNull);

  final String _text;
  final bool isNull;
  Widget Function() _function;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(255, 206, 162, 241)),
          foregroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(255, 255, 255, 255)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)))),
      onPressed: isNull ? null : null,
      child: SizedBox.expand(
          child: main_page.MyTextResponsive(
              text: _text,
              size: 15,
              color: Colors.white,
              TextAlign: TextAlign.center)),
    );
  }
}

Widget MyImagePickerButton({
  required String text,
  required final VoidCallback onPress,
}) {
  return TextButton(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(255, 206, 162, 241)),
        foregroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(255, 255, 255, 255)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))),
    onPressed: onPress,
    child: SizedBox.expand(
        child: main_page.MyTextResponsive(
            text: text,
            size: 15,
            color: Colors.white,
            TextAlign: TextAlign.center)),
  );
}

class MyTextInputLarge extends StatefulWidget {
  MyTextInputLarge(this._controller, {super.key});
  final TextEditingController _controller;

  @override
  State<MyTextInputLarge> createState() => _MyTextInputLargeState();
}

class _MyTextInputLargeState extends State<MyTextInputLarge> {
  late TextEditingController myController = widget._controller;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Second text field: ${myController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 9,
      obscureText: false,
      //style: TextStyle(background: Color.fromARGB(255, 61, 61, 63),)
      decoration: const InputDecoration(
        filled: true,
        hoverColor: Color.fromARGB(100, 255, 255, 255),
        fillColor: Color.fromARGB(255, 61, 61, 63),
        focusColor: Color.fromARGB(255, 255, 255, 255),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        hintText: "Scrivi cosa ne pensi",
        hintStyle: TextStyle(
          fontSize: 15.0,
          fontFamily: "coolvetica",
          color: Color.fromARGB(100, 255, 255, 255),
        ),
      ),
      controller: widget._controller,
      onChanged: (text) {
        //FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}

class MyText extends StatelessWidget {
  MyText(this._string);
  final String _string;
  @override
  Widget build(BuildContext context) {
    return Text(
      _string.toString(),
      style: TextStyle(
        fontSize: 15.0,
        fontFamily: "coolvetica",
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}

class MyIcon extends StatefulWidget {
  @override
  State<MyIcon> createState() => _MyIconState();
}

class _MyIconState extends State<MyIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          setState(() {
            //print("a");
            if (spoilerPresent == false) {
              spoilerPresent = true;
            } else {
              spoilerPresent = false;
            }
          });
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Visibility(
              child: Icon(
                Icons.rectangle_sharp,
                color: Color.fromARGB(255, 61, 61, 63),
              ),
            ),
            Visibility(
                visible: spoilerPresent,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                )),
          ],
        ));
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
    print(indiceSelezionato);
    if (indiceSelezionato <= 2 && indiceSelezionato >= 0) {
      favoriateState[indiceSelezionato] = true;
    }

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
                indiceSelezionato = i;
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

void wrtiteLine(String downloadURL, DatabaseReference dbRef) {
  final email = home_page.email;
  var dt = DateTime.now();
  var newFormat = DateFormat("dd/MM/yy");
  Map<String, String> aggiungi = {
    'indice': indiceSelezionato.toString(),
    'titolo': titoloController.text,
    'autore': autoreController.text,
    'commenti': commentiController.text,
    'sticker': stickerSelected.toString(),
    'spoiler': spoilerPresent.toString(),
    'voto': voto.toString(),
    'image': downloadURL,
    'date': newFormat.format(dt)
  };

  dbRef.child(email).push().set(aggiungi);
}

final List<collection> list = [];
readFromDB(db) async {
  final snapshot = await db.get();
  if (snapshot.exists) {
    final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      final user = collection.fromMap(value);

      list.add(user);
      //print(list);
    });
  } else {
    print('No data available.');
  }
}

class collection {
  final String autore;
  final String commenti;
  final String titolo;

  const collection({
    required this.autore,
    required this.commenti,
    required this.titolo,
  });

  factory collection.fromMap(Map<dynamic, dynamic> map) {
    print(map);
    return collection(
      autore: map['autore'] ?? '',
      commenti: map['commenti'] ?? '',
      titolo: map['titolo'] ?? '',
    );
  }
}

uploadImage() async {
  final _firebaseStorage = FirebaseStorage.instance;
  final _imagePicker = ImagePicker();

  //var permissionStatus = await Permission.photos.status;

  //Select Image
  //final image = await ImagePicker().pickImage(source: ImageSource.camera);
  final dirPath = await getAppPath();
  final String filePath = '$dirPath/ImagePick.png';
  print(filePath);
  if (filePath == null) return;
  final file = File(filePath);
  if (filePath != null) {
    //Upload to Firebase
    var actDate = DateTime.now().millisecondsSinceEpoch;
    var snapshot =
        await _firebaseStorage.ref().child('Added/$actDate').putFile(file);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  } else {
    print('No Image Path Received');
  }
}

// get app dir
getAppPath() async {
// getting a directory path for saving
  final Directory extDir = await getApplicationDocumentsDirectory();
  return extDir.path;
}

/*uploadInfo() async {
  Map<String, String> aggiungi = {
    'titlolo': titoloController.text,
    'autore': autoreController.text,
    'commenti': commentiController.text
  };
  dbRef.push().set(aggiungi);
}*/

void clearAdd() {
  //indiceSelezionato = 0;
  titoloController.text = '';
  autoreController.text = '';
  commentiController.text = '';
  stickerSelected = 0;
  spoilerPresent = false;
  voto = 0;
  selectSticker_page.stickerSelect = 0;
}
