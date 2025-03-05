import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import './main.dart' as main_page;
import 'AddPAge.dart' as add_page;

class CameraPage extends StatefulWidget {
  CameraPage({Key? key, required this.controller}) : super(key: key);

  final PageController controller;
  final double iconHeight = 30;
  final PageController bottomPageController =
      PageController(viewportFraction: .2);

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _controllerInizializer;
  double cameraHorizontalPosition = 0;

  Future<CameraDescription> getCamera() async {
    final c = await availableCameras();
    //print(c.length);
    return c[0];
  }

  @override
  void initState() {
    super.initState();

    getCamera().then((camera) {
      if (camera == null) return;
      setState(() {
        _controller = CameraController(
          camera,
          ResolutionPreset.high,
        );
        _controllerInizializer = _controller.initialize();
        _controllerInizializer.whenComplete(() {
          setState(() {
            /*cameraHorizontalPosition = -(MediaQuery.of(context).size.width *
                    _controller.value.aspectRatio) /
                1;*/
          });
        });
      });
    });
  }

  void takePicture() {
    _controller.takePicture();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned.fill(
          /* trying to preserve aspect ratio */
          left: cameraHorizontalPosition,
          right: cameraHorizontalPosition,
          child: FutureBuilder(
            future: _controllerInizializer,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            /*appBar: AppBar(
              toolbarHeight: main_page.MyResponsive().HeightResponsive(20),
              backgroundColor: Color.fromARGB(88, 0, 0, 0),
              title: Positioned(
                  top: main_page.MyResponsive().HeightResponsive(15),
                  child: Text(
                    "inquadra una copertina",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "coolvetica",
                    ),
                  )),
              leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => add_page.MyAddPage()),
                  );
                },
                child: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              actions: null,
            ),*/
            body: Container(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: main_page.MyResponsive().HeightResponsive(0),
                    left: 0,
                    width: main_page.MyResponsive().WidthResponsive(100),
                    height: main_page.MyResponsive().HeightResponsive(20),
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(88, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: main_page.MyResponsive().HeightResponsive(20),
                    left: 0,
                    width: main_page.MyResponsive().WidthResponsive(8),
                    height: main_page.MyResponsive().HeightResponsive(60),
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(88, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: main_page.MyResponsive().HeightResponsive(0),
                    width: main_page.MyResponsive().WidthResponsive(100),
                    height: main_page.MyResponsive().HeightResponsive(20),
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(88, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: main_page.MyResponsive().HeightResponsive(20),
                    left: main_page.MyResponsive().WidthResponsive(8),
                    width: 50,
                    height: 7,
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: main_page.MyResponsive().HeightResponsive(20),
                    left: main_page.MyResponsive().WidthResponsive(8),
                    width: 7,
                    height: 50,
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: main_page.MyResponsive().HeightResponsive(20),
                    right: main_page.MyResponsive().WidthResponsive(8),
                    width: 50,
                    height: 7,
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: main_page.MyResponsive().HeightResponsive(20),
                    right: main_page.MyResponsive().WidthResponsive(8),
                    width: 7,
                    height: 50,
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: main_page.MyResponsive().HeightResponsive(20),
                    right: main_page.MyResponsive().WidthResponsive(8),
                    width: 50,
                    height: 7,
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: main_page.MyResponsive().HeightResponsive(20),
                    right: main_page.MyResponsive().WidthResponsive(8),
                    width: 7,
                    height: 50,
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: main_page.MyResponsive().HeightResponsive(20),
                    left: main_page.MyResponsive().WidthResponsive(8),
                    width: 50,
                    height: 7,
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: main_page.MyResponsive().HeightResponsive(20),
                    left: main_page.MyResponsive().WidthResponsive(8),
                    width: 7,
                    height: 50,
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: main_page.MyResponsive().HeightResponsive(20),
                    right: 0,
                    width: main_page.MyResponsive().WidthResponsive(8),
                    height: main_page.MyResponsive().HeightResponsive(60),
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(88, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: main_page.MyResponsive().HeightResponsive(10),
                    left: 30,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => add_page.MyAddPage(
                                    image: File("images/foto.png"),
                                  )),
                        );
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  Positioned(
                    top: main_page.MyResponsive().HeightResponsive(13),
                    child: Text(
                      "inquadra una copertina",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 25.0,
                        fontFamily: "coolvetica",
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            // Take the Picture in a try / catch block. If anything goes wrong,
                            // catch the error.
                            try {
                              // Ensure that the camera is initialized.

                              // Attempt to take a picture and then get the location
                              // where the image file is saved.
                              final image = await _controller.takePicture();

                              if (!mounted) return;

                              // If the picture was taken, display it on a new screen.
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DisplayPictureScreen(
                                    // Pass the automatically generated path to
                                    // the DisplayPictureScreen widget.
                                    imagePath: image.path,
                                  ),
                                ),
                              );
                            } catch (e) {
                              // If an error occurs, log the error to the console.
                              print(e);
                            }
                          },
                          child: Container(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                            ),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(35),
                              ),
                              border: Border.all(
                                width: 10,
                                color: Colors.white.withOpacity(.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final displayController = PageController(initialPage: 1);
  DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: main_page.BgColor.color(),
        //appBar: AppBar(title: const Text('Display the Picture')),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Stack(alignment: Alignment.center, children: <Widget>[
          Container(
            height: main_page.MyResponsive().HeightResponsive(100),
            child: Image.file(File(imagePath)),
          ),
          Positioned(
            bottom: main_page.MyResponsive().HeightResponsive(10),
            right: 50,
            child: IconButton(
                color: Color.fromARGB(255, 255, 255, 255),
                iconSize: 50,
                icon: Icon(Icons.check),
                onPressed: () {
                  saveImage(File(imagePath));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => add_page.MyAddPage(
                              image: File(imagePath),
                            )),
                  );
                }),
          ),
          Positioned(
            bottom: main_page.MyResponsive().HeightResponsive(10),
            left: 50,
            child: IconButton(
                color: Color.fromARGB(255, 255, 255, 255),
                iconSize: 50,
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CameraPage(
                                // Pass the automatically generated path to
                                // the DisplayPictureScreen widget.
                                controller: displayController,
                              )));
                }),
          ),
        ]));
  }
}

saveImage(File _image) async {
  final Directory extDir = await getApplicationDocumentsDirectory();
  String dirPath = extDir.path;
  final String filePath = '$dirPath/ImagePick.png';
  print(filePath);
// copy the file to a new path
  _image.copy(filePath);
}
