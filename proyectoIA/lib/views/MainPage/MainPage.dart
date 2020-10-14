import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var img;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio')),
      body: _buildBody(),
      bottomNavigationBar: _buildButtonsBar(),
    );
  }

  _buildBody() {
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
                    child: Column(children: [
                    _plantImage(),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Lorem ipsum dolor sit ametssssssssssssssssssssssssssssssssssssssssss, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16),
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          ' Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, asdadssadsaddsadsaddsadsunt in culpa qui officia deserunt mollit anim id est laborum.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16),
                        ))
                  ]))
          ],
        )),
      ])
    ]));
  }

  _buildButtonsBar() {
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
  }

  _getImage(var source) async {
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
  }
}
