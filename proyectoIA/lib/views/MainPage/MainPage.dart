import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:proyectoIA/helpers/responsiveHelper.dart';
import '../../helpers/colors.dart' as fcolor;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fcolor.black,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: Container(
          padding: EdgeInsets.all(10),
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
            onPressed: () => Navigator.pushNamed(context, 'Scan'),
          )),
    );
  }

  _buildAppBar() {
    final Widget tabs = TabBar(
      indicatorColor: fcolor.black,
      controller: _tabController,
      labelColor: fcolor.green,
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: Colors.blueGrey,
      indicator: new BubbleTabIndicator(
        insets: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        indicatorHeight: 38.0,
        indicatorColor: fcolor.black,
        tabBarIndicatorSize: TabBarIndicatorSize.tab,
      ),
      tabs: <Widget>[
        Tab(
          text: "Animales",
        ),
        Tab(
          text: "Plantas",
        )
      ],
    );

    return AppBar(
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: fcolor.black,
        centerTitle: true,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Bienvenido",
            style: TextStyle(
              fontSize: 28,
              color: fcolor.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottom: tabs);
  }

  _buildBody() {
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: <Widget>[_petView(), _plantView()]);
  }

  _petView() {
    ResponsiveHelper responsive = new ResponsiveHelper(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              height: 220,
              color: fcolor.black,
              child: Stack(
                children: <Widget>[
                  // ============= Img Avatar ==============//
                  Container(
                    height: responsive.percentHeight(0.3),
                    width: responsive.percentWidth(1),
                    child: Image.asset('assets/images/dev/pet.jpg'),
                  ),
                  // ============= Filtro de Img ==============//
                  Container(
                    height: responsive.percentHeight(0.30),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  // ============= Datos ==============//
                  Container(
                    margin: EdgeInsets.only(top: responsive.percentHeight(0.1)),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Animal',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: responsive.restaurantPageTitleSize()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: Colors.white,
                          height: 30,
                          thickness: 1.5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  // ============= App Bar ==============//
                ],
              )),
          SizedBox(
            height: 50,
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Descubre a los seres vivos que te rodean,\nutlizando tu cámara o galería ',
                style: TextStyle(color: fcolor.green, fontSize: 24),
                textAlign: TextAlign.justify,
              )),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  _plantView() {
    ResponsiveHelper responsive = new ResponsiveHelper(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              height: 220,
              child: Stack(
                children: <Widget>[
                  // ============= Img Avatar ==============//
                  Container(
                    height: responsive.percentHeight(0.3),
                    width: responsive.percentWidth(1),
                    child: Image.asset('assets/images/dev/plant.jpg'),
                  ),
                  // ============= Filtro de Img ==============//
                  Container(
                    height: responsive.percentHeight(0.30),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  // ============= Datos ==============//
                  Container(
                    margin: EdgeInsets.only(top: responsive.percentHeight(0.1)),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Planta',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: responsive.restaurantPageTitleSize()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: Colors.white,
                          height: 30,
                          thickness: 1.5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  // ============= App Bar ==============//
                ],
              )),
          SizedBox(
            height: 50,
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Descubre la flora que te rodea, utlizando \nsimplemente tu cámara o galería de fotos',
                style: TextStyle(color: fcolor.green, fontSize: 24),
                textAlign: TextAlign.justify,
              )),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
