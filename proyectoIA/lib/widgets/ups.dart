import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoIA/helpers/responsiveHelper.dart';
import '../helpers/colors.dart' as fcolor;

class UpsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildUpsBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: AppBar(
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Error inesperado",
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 1,
      ),
    );
  }

  Widget _buildUpsBody(BuildContext context) {
    ResponsiveHelper res = new ResponsiveHelper(context);
    return Container(
        child: Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 60, bottom: 40),
            padding: EdgeInsets.all(30),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            height: 150,
            width: 150,
            child: Icon(
              Icons.sentiment_dissatisfied,
              color: fcolor.green,
              size: 82,
            ),
          ),
          Text(
            'Upss...',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Text(
              "Lo sentimos",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            width: res.percentWidth(0.8),
          ),
        ],
      ),
    ));
  }
}
