import 'dart:io';
import 'package:proyectoIA/widgets/camera.dart';

import '../../widgets/customTile.dart' as custom;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:camera/camera.dart';


class ScanPagePet extends StatefulWidget {
  @override
  _ScanPagePet createState() => _ScanPagePet();
}

class _ScanPagePet extends State<ScanPagePet> {
  var img;
  final ImagePicker _picker = ImagePicker();
  String _imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escaner animal'),
      ),
      body: Stack(
        children: <Widget>[
          _imagePath != null
              ? capturedImageWidget(_imagePath)
              : noImageWidget(),
          fabWidget(),
        ],
      ),
    );
  }

  Widget noImageWidget() {
    return SizedBox.expand(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Icon(
            Icons.image,
            color: Colors.grey,
          ),
          width: 60.0,
          height: 60.0,
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: Text(
            'No Image Captured',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    ));
  }

  Widget capturedImageWidget(String imagePath) {
    return SizedBox.expand(
      child: Image.file(File(
        imagePath,
      )),
    );
  }

  Widget fabWidget() {
    return Positioned(
      bottom: 30.0,
      right: 16.0,
      child: FloatingActionButton(
        onPressed: openCamera,
        child: Icon(
          Icons.photo_camera,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future openCamera() async {
    availableCameras().then((cameras) async {
      final imagePath = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraPage(cameras),
        ),
      );
      setState(() {
        _imagePath = imagePath;
      });
    });
  }

  /*_buildBody() {
    return SafeArea(
        child: ListView(children: [
      Column(children: [
        Center(
            child: Column(
          children: [
            img == null
                ? Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 300,
                          color: Colors.green,
                        ),
                        Text("Seleccione o tome una foto de una planta.")
                      ],
                    ),
                  )
                : Container(
                    child: Column(children: [_plantImage(), _buildTiles()]))
          ],
        )),
      ])
    ]));
  }*/

  Widget _buildTiles() {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return _buildCondiciones();
        },
        separatorBuilder: (context, index) => Container(width: 2),
        itemCount: 1);
  }

  _buildCondiciones() {
    return custom.ExpansionTile(
        leading: Icon(Icons.cake),
        initiallyExpanded: false,
        onExpansionChanged: (bool isExpanded) {},
        headerBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: RichText(
            text: TextSpan(
                style: TextStyle(fontSize: 18, color: Colors.black),
                text: "Condiciones de cuidado")),
        children: <Widget>[
          Column(children: <Widget>[
            Row(
              children: [
                Column(
                  children: [Icon(Icons.rate_review)],
                ),
                Column(
                  children: [
                    Text("Dificultad de cuidado"),
                    Text(
                        "Texto de prueba para ver la dificultad de cuidado de esta planta")
                  ],
                )
              ],
            )
          ])
        ]);
  }

  Widget _buildQuestion(int index) {
    return custom.ExpansionTile(
        initiallyExpanded: false,
        onExpansionChanged: (bool isExpanded) {},
        headerBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: RichText(
            text: TextSpan(
          style: TextStyle(fontSize: 18, color: Colors.black),
          text: "Question" + index.toString(),
        )),
        children: <Widget>[
          Column(children: <Widget>[
            Container(
              height: 20,
            )
          ])
        ]);
  }

  /*_buildButtonsBar() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        Container(
            width: 500,
            child: FlatButton(
                color: Colors.green,
                onPressed: () {
                  _getImage(1);
                },
                child: Text("Tomar una foto"))),
        Container(
            width: 500,
            child: FlatButton(
                color: Colors.green,
                onPressed: () {
                  _getImage(2);
                },
                child: Text("Tomar desde la galeria")))
      ],
    );
  }*/

  /*_getImage(var source) async {
    var file = await _picker.getImage(
        source: source == 1 ? ImageSource.camera : ImageSource.gallery);
    if (file != null) {
      setState(() {
        img = file;
      });
      source = 0;
    }
  }

  _plantImage() {
    return Center(
        child: Container(
            padding: EdgeInsets.all(10),
            width: 500,
            height: 500,
            child: Image.file(
              File(img.path),
              fit: BoxFit.cover,
            )));
  }*/
}
