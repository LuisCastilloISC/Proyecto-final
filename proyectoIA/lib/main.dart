import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyectoIA/views/MainPage/MainPage.dart';
import 'package:proyectoIA/views/SplashScreen/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.green,
          accentColor: Colors.green,
          buttonColor: Colors.green,
          fontFamily: 'AvenirMedium'),
      initialRoute: 'splash',
      onGenerateRoute: RouteGenerator.generateLoginRoutes,
    );
  }
}

class RouteGenerator {
  // ignore: missing_return
  static Route<dynamic> generateLoginRoutes(RouteSettings settings) {
    //final args = settings.arguments
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (BuildContext context) => MainPage());
      case 'splash':
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen());
    }
  }
}
