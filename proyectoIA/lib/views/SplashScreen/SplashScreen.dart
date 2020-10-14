import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    _goToHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setNavigationBarColor(Colors.black);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    return Scaffold(
        body: Container(
      color: Colors.white,
      width: double.infinity,
      child: (Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: logo()),
          SizedBox(
            height: 100,
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.green,
          )
        ],
      )),
    ));
  }

  Widget logo() {
    return Container(
        height: 300,
        width: 400,
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/dev/LogoIA.png'),
        ));
  }

  _goToHome() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    });
  }
}
