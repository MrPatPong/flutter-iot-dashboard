// import 'dart:async';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/component/datawidget_ble.dart';
// import 'package:flutter_application_1/component/bar_graph.dart';
// import 'package:flutter_application_1/component/datawidget.dart';
// import 'package:flutter_application_1/component/datawidget_mqtt.dart';
import 'package:flutter_application_1/grindwid/bledatawid.dart';
import 'package:flutter_application_1/grindwid/httpalldatawid.dart';
import 'package:flutter_application_1/grindwid/mqttdatawid.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/page_/map_page.dart';
// import 'package:flutter_application_1/page_/second_page.dart';
import 'package:flutter_application_1/protocal/http_api.dart';
import 'package:flutter_application_1/protocal/mqtt.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_application_1/http_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

var asdf = Colors.grey;
var textin;
var textmq;
var textmq1;
var textmq2;
List onOff = [];
List onOff_mq = [];
final double horizontalPadding = 40;
final double verticalPadding = 25;

class _HomePageState extends State<HomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   // get_api();
  //   timer = Timer.periodic(
  //       const Duration(seconds: 2),
  //       (_) => setState(() {
  //             // dataFuture = get_api();
  //             print('asdfasdfasdfas');
  //             // dataFuture = Get_api();
  //           }));
  // }

  // @override
  // void dispose() {
  //   timer!.cancel();
  //   // Cancel the timer
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // TabController tabController = TabController(length: 3, vsync: this);
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // app bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // menu icon
                  Image.asset(
                    'lib/all_asset/menu.png',
                    height: 25,
                    color: Colors.grey[800],
                  ),

                  // account icon
                  Icon(
                    Icons.person,
                    size: 25,
                    color: Colors.grey[800],
                  )
                ],
              ),
            ),

            const SizedBox(height: 5),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(children: [
                    Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(15)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: SizedBox(
                                child: Hero(
                                    tag: 'map',
                                    child: FlutterMap(
                                      options: MapOptions(
                                        initialCenter: latlong[0],
                                        initialZoom: zoom,
                                        // onTap: (tapPosition, point) => setState(() {

                                        // }),
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png',
                                          userAgentPackageName:
                                              'com.example.app',
                                        ),
                                        CircleLayer(
                                          circles: [
                                            CircleMarker(
                                              point: LatLng(51.50739215592943,
                                                  -0.127709825533512),
                                              radius: 10000,
                                              useRadiusInMeter: true,
                                              color: Colors.orange,
                                              borderColor: Colors.blueGrey,
                                            ),
                                          ],
                                        ),
                                        PolygonLayer(
                                          polygonCulling: false,
                                          polygons: [
                                            Polygon(
                                                points: [
                                                  LatLng(36.95, -9.5),
                                                  LatLng(42.25, -9.5),
                                                  LatLng(42.25, -6.2),
                                                  LatLng(36.95, -6.2),
                                                ],
                                                color: Colors.blue
                                                    .withOpacity(0.2),
                                                borderStrokeWidth: 2,
                                                borderColor: Colors.blue,
                                                isFilled: true),
                                          ],
                                        ),
                                        // MarkerLayer(
                                        //   markers: [
                                        //     Marker(
                                        //       width: 150,
                                        //       height: 150,
                                        //       point:
                                        //           LatLng(53.558463, 9.925584),
                                        //       child: Scaffold(
                                        //           body: Padding(
                                        //         padding:
                                        //             const EdgeInsets.all(10),
                                        //         child: Container(
                                        //             decoration: BoxDecoration(
                                        //                 color: Colors
                                        //                     .grey.shade500,
                                        //                 borderRadius:
                                        //                     BorderRadius
                                        //                         .circular(15)),
                                        //             child: DatawidgetBle(
                                        //                 index: 0)),
                                        //       )),
                                        //     ),
                                        //   ],
                                        // )
                                        // ,
                                      ],
                                    ))))),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (_, __, ___) => MapPage(),
                          ),
                        );
                      },
                      child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(15)),
                          child: const SizedBox()),
                    ),
                  ]),
                ],
              ),
            ),

            // welcome home
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Text(
            //         "Welcome Home",
            //         style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
            //       ),
            //       Text(
            //         'NON DASHBOARD',
            //         style: GoogleFonts.bebasNeue(fontSize: 20),
            //       ),
            //     ],
            //   ),
            // ),

            const SizedBox(height: 5),

            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 40.0),
            //   child: Divider(
            //     thickness: 5,
            //     color: Color.fromARGB(255, 204, 204, 204),
            //   ),
            // ),

            // const SizedBox(height: 5),

            // smart devices grid
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            //   child: Text(
            //     "Smart Devices",
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 20,
            //       color: Colors.grey.shade800,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 15),

            // SizedBox(
            //   height: 30,
            //   child: TabBar(
            //       controller: tabController,
            // indicatorSize: TabBarIndicatorSize.tab,
            // dividerColor: Colors.transparent,
            // indicator: BoxDecoration(
            //   color: Colors.grey,
            //   borderRadius: BorderRadius.all(Radius.circular(50)),
            // ),
            // unselectedLabelColor: Colors.black54,
            //       tabs: const [
            //         Tab(
            //           icon: Icon(
            //             Icons.home_filled,
            //             color: Colors.deepPurple,
            //           ),
            //         ),
            //         Tab(
            //           icon: Icon(
            //             Icons.home_filled,
            //             color: Colors.deepPurple,
            //           ),
            //         ),
            //         Tab(
            //           icon: Icon(
            //             Icons.home_filled,
            //             color: Colors.deepPurple,
            //           ),
            //         ),
            //       ]),
            // ),

            // SizedBox(
            //   height: 10,
            // ),

            // Expanded(
            //   child: TabBarView(
            //       controller: tabController,
            //       children: [Mqttdatawid(), Httpalldatawid(), Bledatawid()]),
            // )

            Expanded(child: HomeScreen()),

            // const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[850],
                // borderRadius: const BorderRadius.only(
                //     topLeft: Radius.circular(30), topRight: Radius.circular(30))
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // IconButton(
                    //     color: Colors.white,
                    //     onPressed: () => setState(() {
                    //           // uri.add(
                    //           //     "http://192.168.1.135:8080/data1/6688f54128c227d4a062b59a");
                    //           uri.add(
                    //               "http://192.168.1.135:8080/data1/66842f7fdc68b130b87ab84b");
                    //           urlcopy.add(
                    //               "http://192.168.1.135:8080/data1/6688f54128c227d4a062b59a");
                    //           // // urlcopy.add("");
                    //           // urlcopy.add(
                    //           //     "http://192.168.1.135:8080/data1/66842f7fdc68b130b87ab84b");
                    //           // // urlcopy.add("");

                    //           // pub_sub_name.add('esp32/datacall');
                    //           // pub_sub_name.add("esp32/datanonOut");
                    //           // pub_sub_name.add("esp33_mqtt");
                    //           // pub_sub_name.add('');
                    //           // pub_sub_name.add("");
                    //           // pub_sub_name.add("");
                    //           // pub_sub_name.add('esp32/datacall1');
                    //           // pub_sub_name.add("esp32/datanonOut1");
                    //           // pub_sub_name.add("esp34_mqtt");

                    //           // pubSNcopy.add('esp32/datacall');
                    //           // pubSNcopy.add("esp32/datanonOut");
                    //           // pubSNcopy.add("esp33_mqtt");
                    //           // pubSNcopy.add('');
                    //           // pubSNcopy.add("");
                    //           // pubSNcopy.add("");
                    //           // pubSNcopy.add('esp32/datacall1');
                    //           // pubSNcopy.add("esp32/datanonOut1");
                    //           // pubSNcopy.add("esp34_mqtt");
                    //           // pub_sub_name.add('esp32/datacall1');
                    //           // pub_sub_name.add("esp32/datanonOut1");
                    //           // pub_sub_name.add("esp34_mqtt");

                    //           // pubSNcopy.add('esp32/datacall');
                    //           // pubSNcopy.add("esp32/datanonOut");
                    //           // pubSNcopy.add("esp33_mqtt");
                    //           // for (var i = 0; i < 1; i++) {
                    //           //   onOff_mq.add(true);
                    //           // }
                    //           // print('onoff: ${onOff}');

                    //           for (var i = 0; i < 1; i++) {
                    //             onOff.add(true);
                    //           }
                    //           print('onoff: ${onOff}');

                    //           // mqttdatain.add(get_mqtt('esp32/datacall',
                    //           //     "esp32/datanonOut", "esp33_mqtt"));
                    //           //     mqttdatain.add(get_mqtt('esp32/datacall',
                    //           //     "esp32/datanonOut1", "esp34_mqtt"));

                    //           // datawidlist.add(Datawidget(
                    //           //     "http://192.168.1.135:8080/data1/6688f54128c227d4a062b59a"));
                    //           // datawidlist.add(Datawidget(
                    //           //     "http://192.168.1.135:8080/data1/66842f7fdc68b130b87ab84b"));
                    //         }),
                    //     icon: const Icon(Icons.add_a_photo)),
                    IconButton(
                        color:
                            editButt == false ? Colors.white : Colors.redAccent,
                        //  Colors.white,
                        onPressed: () => setState(() {
                              // if (editButt == false) {
                              //   editButt = true;
                              // } else {
                              //   editButt = false;
                              // }

                              editButt = editButt == false ? true : false;
                            }),
                        icon: const Icon(Icons.mode_edit_outlined)),
                    MyHomePage(),
                    // HomeScreen(),
                    IconButton(
                        color: Colors.white,
                        onPressed: () => setState(() {
                              uri.clear();
                              urlcopy.clear();
                              pub_sub_name.clear();
                              mqttlist.clear();
                              premqttlist.clear();
                            }),
                        icon: const Icon(Icons.delete)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  static final GlobalKey<_HomeScreenState> homeScreenKey =
      GlobalKey<_HomeScreenState>();

  HomeScreen() : super(key: homeScreenKey);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  void _changeTab(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.index = index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // callbackTab(tabindex) {
  //   setState(() {
  //     _changeTab(tabindex);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   // appBar: AppBar(
        //   //   title: Text('Tab Bar Example'),
        //   //   bottom: MyTabBar(tabController: _tabController),
        //   // ),
        //   body:
        Column(
      children: [
        Expanded(child: TabBarExample(tabController: _tabController)),
      ],
    );
    // );
  }
}

class TabBarExample extends StatelessWidget {
  // const TabBarExample({super.key});
  final TabController tabController;

  const TabBarExample({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              // textAlign: TextAlign.center,
              "Smart Devices",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          bottom: TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            unselectedLabelColor: Colors.black54,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.cloud_outlined),
              ),
              Tab(
                icon: Icon(Icons.beach_access_sharp),
              ),
              Tab(
                icon: Icon(Icons.brightness_5_sharp),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[Mqttdatawid(), Httpalldatawid(), Bledatawid()],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // static final GlobalKey<_HomeScreenState> homeScreenKey =
  //     GlobalKey<_HomeScreenState>();

  // HomeScreen() : super(key: homeScreenKey);
  static final GlobalKey<_MyHomePageState> animatCon =
      GlobalKey<_MyHomePageState>();
  MyHomePage() : super(key: animatCon);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  late Animation rotationAnimation;
  late Animation rotationAnimationadd;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    rotationAnimationadd = Tween<double>(begin: 180.0, end: 45.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return
        // Scaffold(
        //     backgroundColor: Colors.amberAccent,
        //     body:
        SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
              // right: 0,
              // bottom: 0,
              child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              IgnorePointer(
                child: Container(
                  color: Colors.transparent,
                  height: 150.0,
                  width: 150.0,
                ),
              ),
              Transform.translate(
                offset: Offset.fromDirection(getRadiansFromDegree(330),
                    degOneTranslationAnimation.value * 70),
                child: Transform(
                  transform: Matrix4.rotationZ(
                      getRadiansFromDegree(rotationAnimation.value))
                    ..scale(degOneTranslationAnimation.value),
                  alignment: Alignment.center,
                  child: Hero(
                    tag: 'tag1',
                    child: CircularButton(
                      color: Colors.blue,
                      width: 50,
                      height: 50,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onClick: () {
                        print('First Button');
                        Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          barrierDismissible: true,
                          barrierColor: Colors.black54,
                          transitionDuration: Duration(milliseconds: 400),
                          pageBuilder: (_, __, ___) => _AddTodoPopupCard_mq(),
                        ));
                      },
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset.fromDirection(getRadiansFromDegree(270),
                    degTwoTranslationAnimation.value * 70),
                child: Transform(
                  transform: Matrix4.rotationZ(
                      getRadiansFromDegree(rotationAnimation.value))
                    ..scale(degTwoTranslationAnimation.value),
                  alignment: Alignment.center,
                  child: Hero(
                    tag: 'tag',
                    child: CircularButton(
                      color: Colors.grey,
                      width: 50,
                      height: 50,
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      onClick: () {
                        print('Second button');
                        Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          barrierDismissible: true,
                          barrierColor: Colors.black54,
                          transitionDuration: Duration(milliseconds: 400),
                          pageBuilder: (_, __, ___) => _AddTodoPopupCard(),
                        ));
                      },
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset.fromDirection(getRadiansFromDegree(210),
                    degThreeTranslationAnimation.value * 70),
                child: Transform(
                  transform: Matrix4.rotationZ(
                      getRadiansFromDegree(rotationAnimation.value))
                    ..scale(degThreeTranslationAnimation.value),
                  alignment: Alignment.center,
                  child: CircularButton(
                    color: Colors.orangeAccent,
                    width: 50,
                    height: 50,
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    onClick: () {
                      print('Third Button');
                    },
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.rotationZ(
                    getRadiansFromDegree(rotationAnimationadd.value)),
                alignment: Alignment.center,
                child: CircularButton(
                  color: asdf,
                  width: 50,
                  height: 50,
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onClick: () {
                    if (animationController.isCompleted) {
                      animationController.reverse();
                      asdf = Colors.grey;
                    } else {
                      animationController.forward();
                      asdf = Colors.red;
                    }
                  },
                ),
              )
            ],
          ))
        ],
      ),
    );
    // );
  }
}

class CircularButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final Icon icon;
  final Function() onClick;

  CircularButton(
      {this.color,
      this.width,
      this.height,
      required this.icon,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick),
    );
  }
}

class _AddTodoPopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  const _AddTodoPopupCard({super.key});

  @override
  State<_AddTodoPopupCard> createState() => _AddTodoPopupCardState();
}

class _AddTodoPopupCardState extends State<_AddTodoPopupCard> {
  @override
  Widget build(BuildContext context) {
    final _textcon = TextEditingController();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: 'tag',
          child: Material(
            color: Colors.grey,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _textcon,
                      decoration: InputDecoration(
                          hintText: 'New todo',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                              onPressed: () {
                                _textcon.clear();
                              },
                              icon: Icon(Icons.clear))),
                      cursorColor: Colors.white,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    MaterialButton(
                      onPressed: () => setState(() {
                        HomeScreen.homeScreenKey.currentState?._changeTab(1);

                        textin = _textcon.text;
                        uri.add("$textin");
                        urlcopy.add("$textin");
                        for (var i = 0; i < 1; i++) {
                          onOff.add(true);
                        }
                        //                         static final GlobalKey<_MyHomePageState> animatCon =
                        //     GlobalKey<_MyHomePageState>();
                        // MyHomePage() : super(key: animatCon);
                        // animationController.reverse();
                        MyHomePage.animatCon.currentState?.animationController
                            .reverse();
                        asdf = Colors.grey;
                        print('onoff: ${onOff}');

                        Navigator.pop(context);
                      }),
                      child: Text('create'),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '$textin',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                      maxLines: 6,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AddTodoPopupCard_mq extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  const _AddTodoPopupCard_mq({super.key});

  @override
  State<_AddTodoPopupCard_mq> createState() => _AddTodoPopupCard_mqState();
}

class _AddTodoPopupCard_mqState extends State<_AddTodoPopupCard_mq> {
  @override
  Widget build(BuildContext context) {
    final _textcon1 = TextEditingController();
    final _textcon2 = TextEditingController();
    final _textcon3 = TextEditingController();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: 'tag1',
          child: Material(
            color: Colors.grey,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _textcon1,
                      decoration: InputDecoration(
                          hintText: 'New todo',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                              onPressed: () {
                                _textcon1.clear();
                              },
                              icon: Icon(Icons.clear))),
                      cursorColor: Colors.white,
                    ),
                    TextField(
                      controller: _textcon2,
                      decoration: InputDecoration(
                          hintText: 'New todo',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                              onPressed: () {
                                _textcon2.clear();
                              },
                              icon: Icon(Icons.clear))),
                      cursorColor: Colors.white,
                    ),
                    TextField(
                      controller: _textcon3,
                      decoration: InputDecoration(
                          hintText: 'New todo',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                              onPressed: () {
                                _textcon3.clear();
                              },
                              icon: Icon(Icons.clear))),
                      cursorColor: Colors.white,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    MaterialButton(
                      onPressed: () => setState(() {
                        textmq = _textcon1.text;
                        textmq1 = _textcon2.text;
                        textmq2 = _textcon3.text;
                        pub_sub_name.add('$textmq');
                        pub_sub_name.add("$textmq1");
                        pub_sub_name.add("$textmq2");
                        pubSNcopy.add('$textmq');
                        pubSNcopy.add("$textmq1");
                        pubSNcopy.add("$textmq2");
                        for (var i = 0; i < 1; i++) {
                          onOff_mq.add(true);
                        }
                        print('onoff: ${onOff_mq}');

                        Navigator.pop(context);
                        // pub_sub_name.add('esp32/datacall1');
                        // pub_sub_name.add("esp32/datanonOut1");
                        // pub_sub_name.add("esp34_mqtt");
                        // pubSNcopy.add('esp32/datacall');
                        // pubSNcopy.add("esp32/datanonOut");
                        // pubSNcopy.add("esp33_mqtt");
                      }),
                      child: Text('create'),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '$textmq,$textmq1,$textmq2',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                      maxLines: 6,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class QuickActionIcon extends StatelessWidget {
//   final Icon icon;
//   final Color backgroundColor;

//   const QuickActionIcon({
//     required this.icon,
//     required this.backgroundColor,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 60,
//       height: 60,
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         shape: BoxShape.circle,
//       ),
//       clipBehavior: Clip.hardEdge,
//       child: Center(
//         child: icon,
//       ),
//     );
//   }
// }

// class QuickActionMenuFloatingActionButton extends StatefulWidget {
//   final Function() open;
//   final Function() close;
//   final Function() onTap;
//   final bool isOpen;
//   final IconData icon;
//   final Color backgroundColor;

//   const QuickActionMenuFloatingActionButton({
//     required this.open,
//     required this.close,
//     required this.onTap,
//     required this.isOpen,
//     required this.icon,
//     required this.backgroundColor,
//     super.key,
//   });

//   @override
//   State<QuickActionMenuFloatingActionButton> createState() =>
//       _QuickActionMenuFloatingActionButtonState();
// }

// class _QuickActionMenuFloatingActionButtonState
//     extends State<QuickActionMenuFloatingActionButton> {
//   final _duration = const Duration(milliseconds: 200);
//   var _isPressed = false;

//   _pressDown() {
//     setState(() {
//       _isPressed = true;
//     });
//   }

//   _pressUp() {
//     setState(() {
//       _isPressed = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => _pressDown(),
//       onTapUp: (_) => _pressUp(),
//       onTapCancel: () => _pressUp(),
//       onTap: () => widget.isOpen ? widget.close() : widget.onTap(),
//       onLongPress: () {
//         if (!widget.isOpen) {
//           widget.open();
//           _pressUp();
//         }
//       },
//       child: AnimatedScale(
//         scale: _isPressed || widget.isOpen ? 0.8 : 1,
//         duration: _duration,
//         child: Container(
//           decoration: const BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 2,
//                 offset: Offset(0, 2),
//                 color: Colors.black26,
//               ),
//             ],
//           ),
//           child: Stack(
//             children: [
//               QuickActionIcon(
//                 icon: Icon(
//                   Icons.close_rounded,
//                   color: widget.backgroundColor,
//                   size: 28,
//                 ),
//                 backgroundColor: Colors.white,
//               ),
//               AnimatedOpacity(
//                 opacity: widget.isOpen ? 0 : 1,
//                 duration: _duration,
//                 child: QuickActionIcon(
//                   icon: Icon(
//                     widget.icon,
//                     color: Colors.white,
//                     size: 28,
//                   ),
//                   backgroundColor: widget.backgroundColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// -------------------------------------------------------Future
//   @override
//   Widget build(BuildContext context) {
//     // print(dataFuture);
//     return const Scaffold(
//       body: SafeArea(
//           child: Center(
//               child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Datawidget(),
//           SizedBox(
//             height: 100,
//           ),
//           SizedBox(height: 250, child: mybar_graph()),
//         ],
//       ))),
//     );
//   }
// }

//------------------------------------------------------listview
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: SafeArea(
//       child: FutureBuilder(
//         future: Get_api(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return ListView.builder(
//               itemCount: datas.length,
//               padding: EdgeInsets.all(8),
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 24, 20, 20),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: ListTile(
//                       title: Text(datas[index].date),
//                       subtitle: Text(datas[index].value.toString()),
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     ),
//   );
// }
