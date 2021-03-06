import 'dart:io';
import 'package:proyectoIA/helpers/ApiHelper.dart';
import 'package:proyectoIA/helpers/StatePanel.dart';
import 'package:proyectoIA/helpers/blocProvider.dart';
import 'package:proyectoIA/helpers/responsiveHelper.dart';
import 'package:proyectoIA/views/ScanPage/ScanBloc.dart';
import 'package:proyectoIA/widgets/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:proyectoIA/widgets/loading.dart';
import '../../helpers/colors.dart' as fcolor;
import '../../widgets/ups.dart';
import 'package:transparent_image/transparent_image.dart';

class ScanPage extends StatefulWidget {
  final int type;

  const ScanPage({Key key, this.type}) : super(key: key);
  @override
  _ScanPage createState() => _ScanPage();
}

class _ScanPage extends State<ScanPage> {
  var img;
  File _image;
  var barText = "Escaner";
  ApiHelper apiHelper;
  final picker = ImagePicker();
  String _imagePath;
  ScanBloc bloc;
  bool _visible = false;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ScanBloc>(context);
    bloc.init(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: fcolor.black,
        appBar: AppBar(
          iconTheme: IconThemeData(color: fcolor.green),
          backgroundColor: fcolor.black,
          title: Text(
            barText,
            style: TextStyle(color: fcolor.green),
          ),
        ),
        body: StreamBuilder(
            stream: bloc.statePanel,
            builder: (context, snapshot) {
              StatePanel state = snapshot.data;
              if (state is StateError && state.code != 0) {
                return UpsPage();
              } else if (state is StateSuccess && state.code != 0) {
                return _imagePath != null
                    ? SingleChildScrollView(
                        child: Stack(children: <Widget>[
                        capturedImageWidget(_imagePath),
                        _buildCard()
                      ]))
                    : Center(
                        child: noImageWidget(),
                      );
              } else if (state is StateLoading) {
                return Center(child: Loading());
              } else {
                return _imagePath != null
                    ? SingleChildScrollView(
                        child: Stack(children: <Widget>[
                        capturedImageWidget(_imagePath),
                        _buildCard()
                      ]))
                    : Center(
                        child: noImageWidget(),
                      );
              }
            }),
        bottomNavigationBar: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [fabWidget(), galeria()]));
  }

  Widget noImageWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Icon(
            Icons.image,
            color: fcolor.green,
          ),
          width: 60.0,
          height: 60.0,
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: Text(
            'No ha tomado una imagen',
            style: TextStyle(
              color: fcolor.green,
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
    ResponsiveHelper responsive = new ResponsiveHelper(context);
    return Container(
        width: responsive.percentWidth(0.5),
        padding: EdgeInsets.all(5),
        child: RaisedButton(
          splashColor: fcolor.green,
          elevation: 0,
          color: fcolor.black,
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

  Widget galeria() {
    ResponsiveHelper responsive = new ResponsiveHelper(context);
    return Container(
        padding: EdgeInsets.all(10),
        width: responsive.percentWidth(0.5),
        child: RaisedButton(
            splashColor: fcolor.green,
            elevation: 0,
            color: fcolor.black,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10),
                side: BorderSide(color: fcolor.green)),
            child: Text('Abrir galeria',
                style: TextStyle(
                  fontSize: 16,
                  color: fcolor.green,
                )),
            onPressed: () async {
              final pickedFile =
                  await picker.getImage(source: ImageSource.gallery);
              File x = File(pickedFile.path);
              await bloc.sendFile(x);
              setState(() {
                _imagePath = x.path;
                barText = "Resultado:" + bloc.entidad.nombre;
              });
            }));
  }

  Future openCamera() async {
    availableCameras().then((cameras) async {
      final imagePath = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraPage(cameras),
        ),
      );
      await bloc.sendFile(File(imagePath));
      setState(() {
        _imagePath = imagePath;
        barText = "Resultado:" + bloc.entidad.nombre;
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
          Container(
              decoration: BoxDecoration(
                  color: fcolor.black, border: Border.all(color: fcolor.black)),
              child: Divider(
                  indent: responsive.percentWidth(0.1),
                  endIndent: responsive.percentWidth(0.1),
                  color: fcolor.green,
                  thickness: 1)),
          _buildDescripcion(),
          Container(
              decoration: BoxDecoration(
                  color: fcolor.black, border: Border.all(color: fcolor.black)),
              child: Divider(
                  indent: responsive.percentWidth(0.1),
                  endIndent: responsive.percentWidth(0.1),
                  color: fcolor.green,
                  thickness: 1)),
          _buildFacts(),
          Container(
              decoration: BoxDecoration(
                  color: fcolor.black, border: Border.all(color: fcolor.black)),
              child: Divider(
                  indent: responsive.percentWidth(0.1),
                  endIndent: responsive.percentWidth(0.1),
                  color: fcolor.green,
                  thickness: 1)),
          _buildCaracteristics(),
          Container(
              decoration: BoxDecoration(
                  color: fcolor.black, border: Border.all(color: fcolor.black)),
              child: Divider(
                  indent: responsive.percentWidth(0.1),
                  endIndent: responsive.percentWidth(0.1),
                  color: fcolor.green,
                  thickness: 1)),
          bloc.entidad.tipo == "Planta"
              ? _buildConditions()
              : _buildConditionsPet(),
          Container(
              decoration: BoxDecoration(
                  color: fcolor.black, border: Border.all(color: fcolor.black)),
              child: Divider(
                  indent: responsive.percentWidth(0.1),
                  endIndent: responsive.percentWidth(0.1),
                  color: fcolor.green,
                  thickness: 1)),
          bloc.entidad.tipo == "Planta" ? _buildCare() : _buildCarePet()
        ],
      )),
    );
  }

  Widget _buildimagesResult() {
    ResponsiveHelper responsive = new ResponsiveHelper(context);
    return Container(
        color: fcolor.black,
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
                        color: fcolor.green,
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
                          child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              imageErrorBuilder: (BuildContext context,
                                  Object exception, StackTrace stackTrace) {
                                return Image.asset(
                                    'assets/images/dev/plant.jpg');
                              },
                              placeholder: 'assets/images/dev/loading.gif',
                              image: bloc.entidad.listImgurl[0])),
                      decoration: new BoxDecoration(
                          color: fcolor.black,
                          borderRadius: BorderRadius.circular(8.0))),
                  Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              imageErrorBuilder: (BuildContext context,
                                  Object exception, StackTrace stackTrace) {
                                return Image.asset(
                                    'assets/images/dev/plant.jpg');
                              },
                              placeholder: 'assets/images/dev/loading.gif',
                              image: bloc.entidad.listImgurl[1])),
                      decoration: new BoxDecoration(
                          color: fcolor.black,
                          borderRadius: BorderRadius.circular(8.0))),
                  Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              imageErrorBuilder: (BuildContext context,
                                  Object exception, StackTrace stackTrace) {
                                return Image.asset(
                                    'assets/images/dev/plant.jpg');
                              },
                              placeholder: 'assets/images/dev/loading.gif',
                              image: bloc.entidad.listImgurl[2])),
                      decoration: new BoxDecoration(
                          color: fcolor.black,
                          borderRadius: BorderRadius.circular(40.0))),
                  Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              imageErrorBuilder: (BuildContext context,
                                  Object exception, StackTrace stackTrace) {
                                return Image.asset(
                                    'assets/images/dev/plant.jpg');
                              },
                              placeholder: 'assets/images/dev/loading.gif',
                              image: bloc.entidad.listImgurl[3])),
                      decoration: new BoxDecoration(
                          color: fcolor.black,
                          borderRadius: BorderRadius.circular(40.0)))
                ],
              )
            ]));
  }

  _buildDescripcion() {
    return Container(
        color: fcolor.black,
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
            bloc.entidad.descripcion,
            textAlign: TextAlign.justify,
            style: TextStyle(color: fcolor.green),
          )
        ]));
  }

  _buildFacts() {
    return Container(
        color: fcolor.black,
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(children: <Widget>[
          Row(children: [
            Icon(
              Icons.face,
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
            bloc.entidad.curiosidades,
            textAlign: TextAlign.justify,
            style: TextStyle(color: fcolor.green),
          )
        ]));
  }

  _buildCaracteristics() {
    return Container(
        color: fcolor.black,
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
              Text(
                bloc.entidad.caracteristicas,
                style: TextStyle(color: fcolor.green),
              ),
            ]));
  }

  _buildConditions() {
    return Container(
        color: fcolor.black,
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(children: <Widget>[
          Row(
            children: [
              Icon(
                Icons.nature,
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
                      Text('Difilcultad',
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.normal,
                              fontSize: 16)),
                      Container(
                          child: Text(
                        bloc.entidad.dificultad,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: fcolor.green),
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
                    children: [Icon(Icons.wb_sunny, color: Colors.lightGreen)],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nivel de luz',
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.normal,
                              fontSize: 16)),
                      Container(
                          child: Text(
                        bloc.entidad.luz == null
                            ? 'Información en investigación'
                            : bloc.entidad.luz,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: fcolor.green),
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
                      Text('Fertlizante',
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.normal,
                              fontSize: 16)),
                      Container(
                          child: Text(
                        bloc.entidad.fertilizante == null
                            ? 'Información en investigación'
                            : bloc.entidad.fertilizante,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: fcolor.green),
                      ))
                    ],
                  ))
                ]),
          ),
        ]));
  }

  _buildCare() {
    return Container(
        color: fcolor.black,
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
                    children: [Icon(Icons.wb_cloudy, color: Colors.lightGreen)],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Agua',
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.normal,
                              fontSize: 16)),
                      Container(
                          child: Text(
                        bloc.entidad.agua == null
                            ? 'Información en investigación'
                            : bloc.entidad.agua,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: fcolor.green),
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
                    children: [Icon(Icons.nature, color: Colors.lightGreen)],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fertilización',
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.normal,
                              fontSize: 16)),
                      Container(
                          child: Text(
                        bloc.entidad.fertilizacion == null
                            ? 'Información en investigación'
                            : bloc.entidad.fertilizacion,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: fcolor.green),
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
                      Text('Temporada',
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.normal,
                              fontSize: 16)),
                      Container(
                          child: Text(
                        bloc.entidad.temporada == null
                            ? 'Información en investigación'
                            : bloc.entidad.temporada,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: fcolor.green),
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
                      Text('Propagación',
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.normal,
                              fontSize: 16)),
                      Container(
                          child: Text(
                        bloc.entidad.propagacion == null
                            ? 'Información en investigación'
                            : bloc.entidad.propagacion,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: fcolor.green),
                      ))
                    ],
                  ))
                ]),
          )
        ]));
  }

  _buildConditionsPet() {
    return Container(
        color: fcolor.black,
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
                        bloc.entidad.dificultad == null
                            ? 'Información en investigación'
                            : bloc.entidad.dificultad,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: fcolor.green),
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
                        bloc.entidad.comida == null
                            ? 'Información en investigación'
                            : bloc.entidad.comida,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: fcolor.green),
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
                        bloc.entidad.golosinas == null
                            ? 'Información en investigación'
                            : bloc.entidad.golosinas,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: fcolor.green),
                      ))
                    ],
                  ))
                ]),
          ),
        ]));
  }

  _buildCarePet() {
    return Container(
        color: fcolor.black,
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
                        bloc.entidad.higiene == null
                            ? 'Información en investigación'
                            : bloc.entidad.higiene,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: fcolor.green),
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
                        bloc.entidad.alimentacion == null
                            ? 'Información en investigación'
                            : bloc.entidad.alimentacion,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: fcolor.green),
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
                        bloc.entidad.fisico == null
                            ? 'Información en investigación'
                            : bloc.entidad.fisico,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: fcolor.green),
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
                        bloc.entidad.reproduccion == null
                            ? 'Información en investigación'
                            : bloc.entidad.reproduccion,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: fcolor.green),
                      ))
                    ],
                  ))
                ]),
          )
        ]));
  }
}
