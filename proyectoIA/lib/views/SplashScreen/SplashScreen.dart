import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import '../../helpers/colors.dart' as fcolor;

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
      color: fcolor.black,
      width: double.infinity,
      child: (Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: logo()),
          SizedBox(
            height: 100,
          ),
          Text(
            "Orbis\n",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          Text(
            "Conoce tu mundo",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(
            height: 100,
          ),
          CircularProgressIndicator()
        ],
      )),
    ));
  }

  Widget logo() {
    return Container(
        margin: EdgeInsets.all(10),
        height: 300,
        width: 400,
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/dev/LogoIA.png'),
        ));
  }

  _goToHome() {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    });
  }
}
