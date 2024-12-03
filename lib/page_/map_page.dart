import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/component/datawidget_ble.dart';
import 'package:flutter_application_1/grindwid/bledatawid.dart';
import 'package:flutter_application_1/grindwid/httpalldatawid.dart';
import 'package:flutter_application_1/grindwid/mqttdatawid.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/page_/home_page.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPage_pageState();
}

bool addareabool = false;
var color8 = Colors.white;
var color7 = Colors.white;
var areas;
String areaName = '';

class _MapPage_pageState extends State<MapPage> {
  final _textCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 54, 51, 51),
        body: Stack(children: [
          Hero(tag: 'map', child: AnimatedMapControllerPage()),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      color: color8,
                      iconSize: 30,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('close')),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                areaName = _textCon.text;
                                              });
                                              area.add(
                                                MaterialButton(
                                                  onPressed: () => AnimatedMapControllerPage
                                                      .mapanimated.currentState
                                                      ?.changeMapmove(
                                                          (polygon_point[
                                                                  polygon_point
                                                                          .length -
                                                                      1][0])
                                                              .latitude,
                                                          (polygon_point[
                                                                  polygon_point
                                                                          .length -
                                                                      1][0])
                                                              .longitude),
                                                  child: Text(areaName),
                                                ),
                                              );

                                              Navigator.of(context).pop();

                                              debugPrint('area = $area');
                                            },
                                            child: Text('add')),
                                      ],
                                    )
                                  ],
                                  title: Text('ADD AREA'),
                                  content: TextField(
                                    controller: _textCon,
                                    decoration: InputDecoration(
                                      hintText: '$areas',
                                      border: InputBorder.none,
                                    ),
                                    cursorColor: Colors.white,
                                    maxLines: 6,
                                  ),
                                ));

                        color8 =
                            color8 == Colors.white ? Colors.red : Colors.white;
                        addareabool = addareabool == false ? true : false;
                        // setState(() {});
                      },
                      icon: const Icon(Icons.add_alarm)),
                  Visibility(
                    visible: addareabool,
                    child: IconButton(
                        color: Colors.green,
                        iconSize: 35,
                        onPressed: () {
                          color8 = color8 == Colors.white
                              ? Colors.red
                              : Colors.white;
                          addareabool = addareabool == false ? true : false;
                          setState(() {
                            polygonlist.add(
                              Polygon(
                                  points:
                                      polygon_point[polygon_point.length - 1],
                                  color: Colors.white.withOpacity(0.2),
                                  borderStrokeWidth: 2,
                                  borderColor: Colors.white,
                                  isFilled: true),
                            );
                            for (var i = count - count1; i < count; i++) {
                              _markers1.remove('${i}b');
                            }
                            polygonindex++;
                            count1 = 0;
                          });
                        },
                        icon: const Icon(Icons.add_alarm)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: tabinmap())),
              ),
            ],
          ),
        ]),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     FloatingActionButton(onPressed: () {
              //       Navigator.pushReplacement(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => HomePage(),
              //           ));
              //     }),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget tabinmap() {
  return DefaultTabController(
    length: 3,
    child: Scaffold(
      backgroundColor: Colors.grey[300],
      body: const Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 25,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15)),
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
          Expanded(
            child: TabBarView(
              children: <Widget>[Mqttdatawid(), Httpalldatawid(), mapblewid()],
            ),
          ),
        ],
      ),
    ),
  );
}

class mapblewid extends StatefulWidget {
  const mapblewid({super.key});

  @override
  State<mapblewid> createState() => _mapblewidState();
}

class _mapblewidState extends State<mapblewid> {
  var editonoof = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: Container(
            decoration: BoxDecoration(
              color: Colors.grey[850],
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(30), topRight: Radius.circular(30))
            ),
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,

              // physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.2 / 1,
              ),
              itemBuilder: (context, index) {
                return Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(15)),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                AnimatedMapControllerPage
                                    .mapanimated.currentState
                                    ?.changeMapmove(
                                        latlong1[index][0], latlong1[index][1]);
                                debugPrint('a');
                              });
                            },
                            onDoubleTap: () {
                              setState(() {
                                editonoof = editonoof == false ? true : false;
                                debugPrint('edit : $editonoof');
                              });
                            },
                            child: DatawidgetBle(index: index))),
                  ),
                  Positioned(
                    // right: 0,
                    // top: 0,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: editonoof,
                          child: Column(
                            children: [
                              if (modullist1[index] == null) ...[
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      // modullist
                                      //     .add(DatawidgetBle(index: index));
                                      modullist1[index] =
                                          DatawidgetBle(index: index);
                                      // bleindex[index] = modullist.length;
                                      // debugPrint('modulist : $modullist');
                                      debugPrint('bleindex : $bleindex');
                                      debugPrint('modulist : $modullist1');
                                      debugPrint(
                                          'modulisttolist : ${modulist1tolist()}');
                                      debugPrint(
                                          'markerstolist : ${_markers1tolist()}');
                                      debugPrint(
                                          'modulisttolistkey : ${modulist1tolistindex()}');
                                    });
                                  },
                                  child: const Icon(Icons.add_box_sharp),
                                ),
                              ] else ...[
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      // _markers.removeAt(bleindex[index]! - 1);
                                      // modullist.removeAt(bleindex[index]! - 1);
                                      _markers1.remove(index);
                                      modullist1.remove(index);
                                      latlong1.remove(index);
                                      bleindex.remove(index);
                                    });
                                    count--;
                                    debugPrint('modulist : $modullist1');
                                    debugPrint('bleindex : $bleindex');
                                    debugPrint('markers : $_markers1');
                                    debugPrint(
                                        'modulisttolist : ${modulist1tolist()}');
                                    debugPrint(
                                        'markerstolist : ${_markers1tolist()}');
                                    debugPrint('count : $count');
                                    debugPrint('index : $index');
                                  },
                                  child: const Icon(
                                      Icons.disabled_by_default_rounded),
                                ),
                              ],
                            ],
                          ),

                          // Builder(builder: (_) {
                          //   if (bleindex[index] == null) {
                          //     FloatingActionButton(
                          //       onPressed: () {
                          //         setState(() {});
                          //       },
                          //       child: const Icon(
                          //           Icons.disabled_by_default_rounded),
                          //     );
                          //   } else {
                          //     FloatingActionButton(
                          //       onPressed: () {
                          //         setState(() {});
                          //       },
                          //       child: const Icon(
                          //           Icons.add_box_sharp),
                          //     );
                          //   }
                          // }),

                          // IconButton(
                          //     iconSize: 30,
                          // onPressed: () => setState(() {
                          //   uri.removeAt(index);
                          // }),
                          //     icon: Icon(
                          //       Icons.delete,
                          //       color: Colors.red[800],
                          //     )),
                        ),
                      ],
                    ),
                  ),
                ]);
              },
            ),
          )),
    );
  }
}

class AnimatedMapControllerPage extends StatefulWidget {
  static const String route = '/map_controller_animated';
  // static final GlobalKey<_HomeScreenState> homeScreenKey =
  //   GlobalKey<_HomeScreenState>();
  static final GlobalKey<AnimatedMapControllerPageState> mapanimated =
      GlobalKey<AnimatedMapControllerPageState>();

  // const AnimatedMapControllerPage({super.key});
  AnimatedMapControllerPage() : super(key: mapanimated);

  @override
  AnimatedMapControllerPageState createState() =>
      AnimatedMapControllerPageState();
}

// List modullist = [];
Map<int, dynamic> modullist1 = {};
// List<Marker> _markers = [];
Map<dynamic, Marker> _markers1 = {};
_markers1tolist() => _markers1.entries.map((e) => e.value).toList();
modulist1tolist() => modullist1.entries.map((e) => e.value).toList();
modulist1tolistindex() => modullist1.entries.map((e) => e.key).toList();
List latlong = [];
Map<int, dynamic> latlong1 = {};
Map<int, int> bleindex = {};
Map<int, int> httpindex = {};
Map<int, int> mqttindex = {};
var count = 0;
var count1 = 0;
var polygonindex = 0;
List<Widget> area = [];
List<Polygon> polygonlist = [];
List<List<LatLng>> polygon_point = [
  // [
  //   LatLng(36.95, -9.5),
  //   LatLng(42.25, -9.5),
  // ],
  // [
  //   LatLng(36.95, -9.5),
  //   LatLng(42.25, -9.5),
  // ]
];

class AnimatedMapControllerPageState extends State<AnimatedMapControllerPage>
    with TickerProviderStateMixin {
  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';

  static const _london = LatLng(51.5, -0.09);
  static const _paris = LatLng(48.8566, 2.3522);
  static const _dublin = LatLng(53.3498, -6.2603);

  final mapController = MapController();

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final camera = mapController.camera;
    final latTween = Tween<double>(
        begin: camera.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: camera.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    // Note this method of encoding the target destination is a workaround.
    // When proper animated movement is supported (see #1263) we should be able
    // to detect an appropriate animated movement event which contains the
    // target zoom/center.
    final startIdWithTarget =
        '$_startedId#${destLocation.latitude},${destLocation.longitude},$destZoom';
    bool hasTriggeredMove = false;

    controller.addListener(() {
      final String id;
      if (animation.value == 1.0) {
        id = _finishedId;
      } else if (!hasTriggeredMove) {
        id = startIdWithTarget;
      } else {
        id = _inProgressId;
      }

      hasTriggeredMove |= mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
        id: id,
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  void add_area() {
    setState(() {});
  }

  void changeMapmove(latin, longin) {
    setState(() {
      // _animatedMapMove(LatLng(50, -0.09), 15);
      _animatedMapMove(LatLng(latin, longin), 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print((polygon_point[0][0]).latitude);
    // changeMapmove();
    // _animatedMapMove(LatLng(50, -0.09), 10);
    return Scaffold(
      // appBar: AppBar(title: const Text('Animated MapController')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: area

                // [
                //   MaterialButton(
                //     onPressed: () => _animatedMapMove(_london, 10),
                //     child: const Text('London'),
                //   ),
                //   MaterialButton(
                //     onPressed: () => _animatedMapMove(_paris, 5),
                //     child: const Text('Paris'),
                //   ),
                //   MaterialButton(
                //     onPressed: () => _animatedMapMove(_dublin, 5),
                //     child: const Text('Dublin'),
                //   ),
                //   MaterialButton(
                //     onPressed: () => _animatedMapMove(_dublin, 5),
                //     child: const Text('Dublin'),
                //   ),
                // ]
                ,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8),
            //   child: Row(
            //     children: <Widget>[
            //       MaterialButton(
            //         onPressed: () {
            //           final bounds = LatLngBounds.fromPoints([
            //             _dublin,
            //             _paris,
            //             _london,
            //           ]);

            //           mapController.fitCamera(
            //             CameraFit.bounds(
            //               bounds: bounds,
            //               padding: const EdgeInsets.symmetric(horizontal: 15),
            //             ),
            //           );
            //         },
            //         child: const Text('Fit Bounds'),
            //       ),
            //       MaterialButton(
            //         onPressed: () {
            //           final bounds = LatLngBounds.fromPoints([
            //             _dublin,
            //             _paris,
            //             _london,
            //           ]);

            //           final constrained = CameraFit.bounds(
            //             bounds: bounds,
            //           ).fit(mapController.camera);
            //           _animatedMapMove(constrained.center, constrained.zoom);
            //         },
            //         child: const Text('Fit Bounds animated'),
            //       ),
            //     ],
            //   ),
            // ),
            Flexible(
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: LatLng(51.5, -0.09),
                  initialZoom: 5,
                  maxZoom: 10,
                  minZoom: 3,
                  onTap: (_, LatLng) {
                    // setState(() {
                    //   _markers1[modulist1tolistindex()[count]] = Marker(
                    //     width: 80,
                    //     height: 80,
                    //     point: LatLng,
                    //     child: modulist1tolist()[count],
                    //   );
                    // latlong.add(LatLng.latitude);
                    //   latlong1[modulist1tolistindex()[count]] = [
                    //     LatLng.latitude,
                    //     LatLng.longitude
                    //   ];

                    //   debugPrint('latl1 : $latlong1');

                    // });
                    // count++;
                    // // if (count < modullist.length - 1) {
                    // //   count++;
                    // // }
                    // debugPrint('count : $count');

                    if (addareabool == false) {
                      setState(() {
                        _markers1[modulist1tolistindex()[count]] = Marker(
                          width: 80,
                          height: 80,
                          point: LatLng,
                          child: modulist1tolist()[count],
                        );
                        // latlong.add(LatLng.latitude);
                        latlong1[modulist1tolistindex()[count]] = [
                          LatLng.latitude,
                          LatLng.longitude
                        ];

                        debugPrint('latl1 : $latlong1');
                      });
                      count++;
                      // if (count < modullist.length - 1) {
                      //   count++;
                      // }
                      debugPrint('count : $count');
                    } else {
                      setState(() {
                        _markers1['${count}b'] = Marker(
                          width: 80,
                          height: 80,
                          point: LatLng,
                          child: const Icon(
                            Icons.accessible,
                            color: Colors.white,
                          ),
                        );
                      });
                      if (polygon_point.length < polygonindex + 1) {
                        polygon_point.add([]);
                      }
                      polygon_point[polygonindex].add(LatLng);
                      count++;
                      count1++;

                      debugPrint('count : $count');
                      debugPrint('count1 : $count1');
                      debugPrint('polygon_point : $polygon_point');
                      debugPrint('mark : $_markers1');
                    }
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(markers: _markers1tolist()),
                  PolygonLayer(
                    polygonCulling: false,
                    polygons: polygonlist
                    // [
                    // Polygon(
                    //     points: [
                    // LatLng(36.95, -9.5),
                    // LatLng(42.25, -9.5),
                    //       LatLng(42.25, -6.2),
                    //       LatLng(36.95, -6.2),
                    //     ],
                    //     color: Colors.white.withOpacity(0.2),
                    //     borderStrokeWidth: 2,
                    //     borderColor: Colors.white,
                    //     isFilled: true),
                    //   Polygon(
                    //       points: [
                    //         LatLng(47.795505089230836, -0.6442921769769551),
                    //         LatLng(49.87770381412587, 4.673090635523046),
                    //         LatLng(47.26139889927198, 8.056879698023046),
                    //         LatLng(45.31822766062265, 2.9152781355230455),
                    //       ],
                    //       color: Colors.white.withOpacity(0.2),
                    //       borderStrokeWidth: 1,
                    //       borderColor: Colors.white,
                    //       isFilled: true),
                    // ]
                    ,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Causes tiles to be prefetched at the target location and disables pruning
/// whilst animating movement. When proper animated movement is added (see
/// #1263) we should just detect the appropriate AnimatedMove events and
/// use their target zoom/center.
final _animatedMoveTileUpdateTransformer =
    TileUpdateTransformer.fromHandlers(handleData: (updateEvent, sink) {
  final mapEvent = updateEvent.mapEvent;

  final id = mapEvent is MapEventMove ? mapEvent.id : null;
  if (id?.startsWith(AnimatedMapControllerPageState._startedId) ?? false) {
    final parts = id!.split('#')[2].split(',');
    final lat = double.parse(parts[0]);
    final lon = double.parse(parts[1]);
    final zoom = double.parse(parts[2]);

    // When animated movement starts load tiles at the target location and do
    // not prune. Disabling pruning means existing tiles will remain visible
    // whilst animating.
    sink.add(
      updateEvent.loadOnly(
        loadCenterOverride: LatLng(lat, lon),
        loadZoomOverride: zoom,
      ),
    );
  } else if (id == AnimatedMapControllerPageState._inProgressId) {
    // Do not prune or load whilst animating so that any existing tiles remain
    // visible. A smarter implementation may start pruning once we are close to
    // the target zoom/location.
  } else if (id == AnimatedMapControllerPageState._finishedId) {
    // We already prefetched the tiles when animation started so just prune.
    sink.add(updateEvent.pruneOnly());
  } else {
    sink.add(updateEvent);
  }
});
