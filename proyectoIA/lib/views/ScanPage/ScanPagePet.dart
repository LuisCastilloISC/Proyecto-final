import 'dart:io';
import 'package:proyectoIA/helpers/responsiveHelper.dart';
import 'package:proyectoIA/widgets/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import '../../helpers/colors.dart' as fcolor;

class ScanPagePet extends StatefulWidget {
  @override
  _ScanPagePet createState() => _ScanPagePet();
}

class _ScanPagePet extends State<ScanPagePet> {
  var img;
  String _imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: fcolor.green),
        backgroundColor: Colors.white,
        title: Text(
          'Escaner de animal',
          style: TextStyle(color: fcolor.green),
        ),
      ),
      body: _imagePath != null
          ? SingleChildScrollView(
              child: Stack(children: <Widget>[
              capturedImageWidget(_imagePath),
              _buildCard()
            ]))
          : Center(
              child: noImageWidget(),
            ),
      bottomNavigationBar: fabWidget(),
    );
  }

  Widget noImageWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
            'No ha tomado una imagen',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget capturedImageWidget(String imagePath) {
    ResponsiveHelper responsive = new ResponsiveHelper(context);
    return Container(
        height: 200,
        child: Image.file(
          File(
            imagePath,
          ),
          fit: BoxFit.cover,
          width: responsive.percentWidth(1),
          errorBuilder:
              (BuildContext context, Object exception, StackTrace stackTrace) {
            return noImageWidget();
          },
        ));
  }

  Widget fabWidget() {
    return Container(
        padding: EdgeInsets.all(10),
        child: RaisedButton(
          splashColor: fcolor.green,
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10),
              side: BorderSide(color: fcolor.green)),
          child: Text('Escanear',
              style: TextStyle(
                fontSize: 16,
                color: fcolor.green,
              )),
          onPressed: openCamera,
        ));
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

  Widget _buildCard() {
    ResponsiveHelper responsive = new ResponsiveHelper(context);
    return Container(
      alignment: Alignment.topCenter,
      margin:
          new EdgeInsets.only(top: MediaQuery.of(context).size.height * .22),
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0))),
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildimagesResult(),
          Divider(
            indent: responsive.percentWidth(0.1),
            endIndent: responsive.percentWidth(0.1),
            color: fcolor.green,
          ),
          _buildDescripcion(),
          Divider(
            indent: responsive.percentWidth(0.1),
            endIndent: responsive.percentWidth(0.1),
            color: fcolor.green,
          ),
          _buildFacts(),
          Divider(
            indent: responsive.percentWidth(0.1),
            endIndent: responsive.percentWidth(0.1),
            color: fcolor.green,
          ),
          _buildCaracteristics(),
          Divider(
            indent: responsive.percentWidth(0.1),
            endIndent: responsive.percentWidth(0.1),
            color: fcolor.green,
          ),
          _buildConditions(),
          Divider(
            indent: responsive.percentWidth(0.1),
            endIndent: responsive.percentWidth(0.1),
            color: fcolor.green,
          ),
          _buildCare()
        ],
      )),
    );
  }

  Widget _buildimagesResult() {
    ResponsiveHelper responsive = new ResponsiveHelper(context);
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.image,
                    color: fcolor.green,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Galeria',
                    style: TextStyle(
                        color:fcolor.green,
                        fontWeight: FontWeight.normal,
                        fontSize: 20),
                  ),
                ],
              ),
              GridView.count(
                shrinkWrap: true,
                childAspectRatio: (MediaQuery.of(context).size.width + 350) /
                    (MediaQuery.of(context).size.height / 1.9),
                padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: Image.asset('assets/images/dev/pet.jpg')),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0))),
                  Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: Image.asset('assets/images/dev/pet.jpg')),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0))),
                  Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: Image.asset('assets/images/dev/pet.jpg')),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0))),
                  Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: Image.asset('assets/images/dev/pet.jpg')),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0)))
                ],
              )
            ]));
  }

  _buildDescripcion() {
    return Container(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(children: <Widget>[
          Row(children: [
            Icon(
              Icons.description,
              color: fcolor.green,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Descripción',
              style: TextStyle(
                  color: fcolor.green,
                  fontWeight: FontWeight.normal,
                  fontSize: 20),
            ),
          ]),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            textAlign: TextAlign.justify,
          )
        ]));
  }

  _buildFacts() {
    return Container(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(children: <Widget>[
          Row(children: [
            Icon(
              Icons.pets,
              color: fcolor.green,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Curiosidades',
              style: TextStyle(
                  color: fcolor.green,
                  fontWeight: FontWeight.normal,
                  fontSize: 20),
            ),
          ]),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            textAlign: TextAlign.justify,
          )
        ]));
  }

  _buildCaracteristics() {
    return Container(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: [
                Icon(
                  Icons.check,
                  color: fcolor.green,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Caracteristicas',
                  style: TextStyle(
                      color: fcolor.green,
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                ),
              ]),
              Text('Alto 4 patas: 12'),
              Text('Alto 2 patas: 12'),
              Text('Peso: 12'),
            ]));
  }

  _buildConditions() {
    return Container(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(children: <Widget>[
          Row(
            children: [
              Icon(
                Icons.list,
                color: fcolor.green,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Condiciones',
                style: TextStyle(
                    color: fcolor.green,
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [Icon(Icons.star, color: Colors.lightGreen)],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Difilcultad de cuidado',
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.normal,
                              fontSize: 16)),
                      Container(
                          child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
                        textAlign: TextAlign.justify,
                      ))
                    ],
                  ))
                ]),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(Icons.room_service, color: Colors.lightGreen)
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cantidad de comida',
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.normal,
                              fontSize: 16)),
                      Container(
                          child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
                        textAlign: TextAlign.justify,
                      ))
                    ],
                  ))
                ]),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(Icons.wb_iridescent, color: Colors.lightGreen)
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Golosinas',
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.normal,
                              fontSize: 16)),
                      Container(
                          child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
                        textAlign: TextAlign.justify,
                      ))
                    ],
                  ))
                ]),
          ),
        ]));
  }

  _buildCare() {
    return Container(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(children: <Widget>[
          Row(
            children: [
              Icon(
                Icons.local_hospital,
                color: fcolor.green,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Cuidados',
                style: TextStyle(
                    color: fcolor.green,
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [Icon(Icons.security, color: Colors.lightGreen)],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Higiene',
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.normal,
                              fontSize: 16)),
                      Container(
                          child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
                        textAlign: TextAlign.justify,
                      ))
                    ],
                  ))
                ]),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(Icons.restaurant, color: Colors.lightGreen)
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alimentación',
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.normal,
                              fontSize: 16)),
                      Container(
                          child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
                        textAlign: TextAlign.justify,
                      ))
                    ],
                  ))
                ]),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [Icon(Icons.timer, color: Colors.lightGreen)],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ejercicio fisico',
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.normal,
                              fontSize: 16)),
                      Container(
                          child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
                        textAlign: TextAlign.justify,
                      ))
                    ],
                  ))
                ]),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(Icons.add_circle_outline, color: Colors.lightGreen)
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reproducción',
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.normal,
                              fontSize: 16)),
                      Container(
                          child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
                        textAlign: TextAlign.justify,
                      ))
                    ],
                  ))
                ]),
          )
        ]));
  }
}
