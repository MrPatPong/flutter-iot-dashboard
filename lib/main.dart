// import 'dart:io';
// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'dart:async';
// import 'dart:collection';

// import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/component/bar_graph.dart';
import 'package:flutter_application_1/component/datawidget.dart';
import 'package:flutter_application_1/component/datawidget_ble.dart';
import 'package:flutter_application_1/grindwid/bledatawid.dart';
import 'package:flutter_application_1/page_/map_page.dart';
import 'package:flutter_application_1/protocal/mqtt.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
// import 'package:flutter_application_1/component/bar_graph.dart';
// import 'package:flutter_application_1/component/bar_v2.dart';
// import 'package:flutter_application_1/component/datawidget.dart';
// import 'package:flutter_application_1/component/datawidget_mqtt.dart';
// import 'package:flutter_application_1/grindwid/httpalldatawid.dart';
// import 'package:flutter_application_1/page_/second_page.dart';
// import 'package:flutter_application_1/protocal/ble.dart';
// import 'package:flutter_application_1/protocal/http_api.dart';
// import 'package:flutter_application_1/protocal/mqtt.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:flutter_application_1/component/bar_graph.dart';
// import 'package:flutter_application_1/component/datawidget.dart';
import 'page_/home_page.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart' as client;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/protocal/http_api.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_application_1/protocal/ble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert' show utf8;
import 'package:provider/provider.dart';

// void main() {
//   // runApp(DevicePreview(
//   //   backgroundColor: Colors.grey[850],
//   //   enabled: !kReleaseMode,
//   //   builder: (context) => const MyApp(),
//   // ));

//   runApp(
//     MyApp(),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // get_api();
//     // get_mqtt();
//     // mqtt_gat();
//     // print('pubsn${pub_sub_name}');
//     // print('premqlist${premqttlist}');
//     // print('mqlist${mqttlist}');

//     return MaterialApp(
//         debugShowCheckedModeBanner: false, home: Scaffold(body: BleHomePage()));
//   }
// }

void main() {
  runApp(MyApp());
}

List randomlist = [].obs;
List fakename = [].obs;
// List latlong = [].obs;
double zoom = 10;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    latlong.add(LatLng(53.558463, 9.925584));
    latlong.add(LatLng(51.50739215592943, -0.127709825533512));
    Timer.periodic(const Duration(seconds: 1), (timer) {
      var intValue = Random().nextInt(60) + 30;
      if (randomlist.isEmpty) {
        randomlist.add(0);
        fakename.add('esp69');
      }

      randomlist[0] = intValue;
      // fakename[0] = 'esp69';
      // print('intValue : $intValue');
      // print('random : $randomlist');
      // print('fakename : $fakename');

      // if (counter == 0) {
      //   print('Cancel timer');
      //   timer.cancel();
      // }
    });

    return MaterialApp(
      title: 'Flutter BLE Multiple Connections',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapPage(),
    );
  }
}

class AnimatedMapControllerPage extends StatefulWidget {
  static const String route = '/map_controller_animated';

  const AnimatedMapControllerPage({super.key});

  @override
  AnimatedMapControllerPageState createState() =>
      AnimatedMapControllerPageState();
}

class AnimatedMapControllerPageState extends State<AnimatedMapControllerPage>
    with TickerProviderStateMixin {
  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';

  static const _london = LatLng(51.5, -0.09);
  static const _paris = LatLng(48.8566, 2.3522);
  static const _dublin = LatLng(53.3498, -6.2603);

  static final _markers = [
    Marker(
      width: 80,
      height: 80,
      point: _london,
      child: FlutterLogo(key: ValueKey('blue')),
    ),
    Marker(
      width: 80,
      height: 80,
      point: _dublin,
      child: FlutterLogo(key: ValueKey('green')),
    ),
    Marker(
      width: 80,
      height: 80,
      point: _paris,
      child: FlutterLogo(key: ValueKey('purple')),
    ),
    Marker(
      width: 150,
      height: 150,
      point: LatLng(53.558463, 9.925584),
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade500,
                borderRadius: BorderRadius.circular(15)),
            child: DatawidgetBle(index: 0)),
      )),
    ),
  ];

  List iconn = [
    Icon(
      Icons.favorite,
      color: Colors.pink,
      size: 24.0,
      semanticLabel: 'Text to announce in accessibility modes',
    ),
    Icon(
      Icons.audiotrack,
      color: Colors.green,
      size: 30.0,
    ),
    Icon(
      Icons.beach_access,
      color: Colors.blue,
      size: 36.0,
    ),
  ];
  List latlong = [];
  List listindex = [];

  var count = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animated MapController')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () => _animatedMapMove(_london, 10),
                    child: const Text('London'),
                  ),
                  MaterialButton(
                    onPressed: () => _animatedMapMove(_paris, 5),
                    child: const Text('Paris'),
                  ),
                  MaterialButton(
                    onPressed: () => _animatedMapMove(_dublin, 5),
                    child: const Text('Dublin'),
                  ),
                ],
              ),
            ),
            Flexible(
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: LatLng(51.5, -0.09),
                  initialZoom: 5,
                  maxZoom: 10,
                  minZoom: 3,
                  onTap: (_, LatLng) {
                    setState(() {
                      _markers.add(Marker(
                        width: 80,
                        height: 80,
                        point: LatLng,
                        child: iconn[count],
                      ));
                      latlong.add(LatLng);
                      listindex.insert(1, _markers.length);
                      debugPrint('listin : $listindex');
                      // _markers[count];
                    });
                    if (count < iconn.length - 1) {
                      count++;
                    }
                    debugPrint('count : $count');
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(markers: _markers),
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
                          color: Colors.white.withOpacity(0.2),
                          borderStrokeWidth: 2,
                          borderColor: Colors.white,
                          isFilled: true),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () => setState(() {
              _markers.removeLast();
            }),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              _animatedMapMove(latlong[count - 1], 10);
            },
          ),
        ],
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

// Widget fluttermap() {
//   return FlutterMap(
//     options: MapOptions(
//       initialCenter: latlong[0],
//       initialZoom: zoom
//     ),
//     children: [
//       TileLayer(
//         urlTemplate:
//             'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png',
//         userAgentPackageName: 'com.example.app',
//       ),
//       CircleLayer(
//         circles: [
//           CircleMarker(
//             point: LatLng(51.50739215592943, -0.127709825533512),
//             radius: 10000,
//             useRadiusInMeter: true,
//             color: Colors.orange,
//             borderColor: Colors.blueGrey,
//           ),
//         ],
//       ),
//       PolygonLayer(
//         polygonCulling: false,
//         polygons: [
//           Polygon(
//               points: [
//                 LatLng(36.95, -9.5),
//                 LatLng(42.25, -9.5),
//                 LatLng(42.25, -6.2),
//                 LatLng(36.95, -6.2),
//               ],
//               color: Colors.blue.withOpacity(0.2),
//               borderStrokeWidth: 2,
//               borderColor: Colors.blue,
//               isFilled: true),
//         ],
//       ),
//       MarkerLayer(
//         markers: [
//           Marker(
//             width: 150,
//             height: 150,
//             point: LatLng(53.558463, 9.925584),
//             child: Scaffold(
//                 body: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade500,
//                       borderRadius: BorderRadius.circular(15)),
//                   child: DatawidgetBle(index: 0)),
//             )),
//           ),
//         ],
//       ),
//     ],
//   );
// }

// class MyAppppppppp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Flutter Map in Container')),
//         body: Center(
//           child: Container(
//             height: 300, // Set the height of the container
//             width: 300, // Set the width of the container
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.blueAccent), // Optional border
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(30)),
//               child: FlutterMap(
//                 options: MapOptions(
//                   initialCenter:
//                       LatLng(51.5, -0.09), // Initial center position of the map
//                   initialZoom: 13.0, // Initial zoom level
//                 ),
//                 children: [
//                   TileLayer(
//                     urlTemplate:
//                         'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                     subdomains: ['a', 'b', 'c'],
//                   ),
//                   MarkerLayer(
//                     markers: [
//                       Marker(
//                         width: 80.0,
//                         height: 80.0,
//                         point: LatLng(51.5, -0.09),
//                         child: Container(
//                           child: Icon(
//                             Icons.location_on,
//                             color: Colors.red,
//                             size: 40,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// class TimeStreamWidget extends StatelessWidget {
//   // This stream will emit a new integer every second.
//   // Stream<int> timerStream() {
//   //   return Stream.periodic(Duration(seconds: 1), (_) => randomlist[0]);
//   // }

//   Stream<int> timerStream() async* {
//     while (true) {
//       await Future.delayed(Duration(seconds: 1));
//       yield randomlist[0];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: StreamBuilder<int>(
//           stream: timerStream(),
//           builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Text('Awaiting seconds...');
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               return Text('Seconds elapsed: ${snapshot.data}');
//             }
//           },
//         ),
//       ),
//     );
//   }
// }



// class MyController extends GetxController {
//   int bledata = 0;
//   int get ble1 => bledata;

//   void changeText() {
//     bledata;
//   }
// }

// class MySimpleWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // final MyController controller = Get.put(MyController());
//     return SafeArea(
//       child: Scaffold(
//         body: Center(child: Builder(builder: (context) {
//           if (randomlist.isEmpty) {
//             return Obx(
//               () => Text(
//                 randomlist[0].toString(),
//                 style: TextStyle(fontSize: 24, color: Colors.blue),
//               ),
//             );
//           } else {
//             return Obx(
//               () => Text(
//                 randomlist[0].toString(),
//                 style: TextStyle(fontSize: 24, color: Colors.blue),
//               ),
//             );
//           }
//         })),
//       ),
//     );
//   }
// }

// class MyController extends GetxController {
//   var myValue = randomlist[0].obs;

//   void updateValue(String newValue) {
//     myValue.value;
//   }
// }

// class MyWidget extends StatelessWidget {
//   final MyController controller = Get.put(MyController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Widget'),
//       ),
//       body: GetBuilder<MyController>(
//         builder: (controller) {
//           return Text(controller.myValue.toString());
//         },
//       ),
//     );
//   }
// }





// class MyDataProvider extends ChangeNotifier {
//   int _data = 0;

//   int get data => _data;

//   void updateData(int newData) {
//     _data = newData;
//     notifyListeners();
//   }
// }

// class MySimpleWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Widget'),
//       ),
//       body: Consumer<MyDataProvider>(
//         builder: (context, dataProvider, child) {
//           return Text(dataProvider.data.toString());
//         },
//       ),
//     );
//   }
// }






// class BleHomePage extends StatefulWidget {
//   @override
//   _BleHomePageState createState() => _BleHomePageState();
// }

// class _BleHomePageState extends State<BleHomePage> {
//   FlutterBlue flutterBlue = FlutterBlue.instance;
//   // FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
//   List<BluetoothDevice> devicesList = [];
//   Map<BluetoothDevice, BluetoothDeviceState> connectedDevices = {};

//   @override
//   void initState() {
//     super.initState();
//     scanForDevices();
//   }

//   void scanForDevices() {
//     flutterBlue.startScan(timeout: Duration(seconds: 5));

//     flutterBlue.scanResults.listen((results) {
//       for (ScanResult result in results) {
//         if (!devicesList.contains(result.device)) {
//           setState(() {
//             devicesList.add(result.device);
//           });
//         }
//       }
//     });

//     flutterBlue.stopScan();
//   }

//   void connectToDevice(BluetoothDevice device) async {
//     await device.connect();
//     setState(() {
//       connectedDevices[device] = BluetoothDeviceState.connected;
//     });

//     // Listen to the device state
//     device.state.listen((state) {
//       setState(() {
//         connectedDevices[device] = state;
//       });
//     });
//   }

//   void disconnectFromDevice(BluetoothDevice device) async {
//     await device.disconnect();
//     setState(() {
//       connectedDevices.remove(device);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('BLE Devices'),
//       ),
//       body: ListView.builder(
//         itemCount: devicesList.length,
//         itemBuilder: (context, index) {
//           BluetoothDevice device = devicesList[index];
//           bool isConnected = connectedDevices.containsKey(device);
//           return ListTile(
//             title: Text(device.name == '' ? 'Unknown Device' : device.name),
//             subtitle: Text(device.id.toString()),
//             trailing: isConnected
//                 ? ElevatedButton(
//                     child: Text('Disconnect'),
//                     onPressed: () => disconnectFromDevice(device),
//                   )
//                 : ElevatedButton(
//                     child: Text('Connect'),
//                     onPressed: () => connectToDevice(device),
//                   ),
//           );
//         },
//       ),
//     );
//   }
// }




// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BLEHome(),
//     );
//   }
// }

// class BLEHome extends StatefulWidget {
//   @override
//   _BLEHomeState createState() => _BLEHomeState();
// }

// class _BLEHomeState extends State<BLEHome> {
//   FlutterBlue flutterBlue = FlutterBlue.instance;
//   BluetoothDevice? connectedDevice;
//   List<BluetoothService> services = [];

//   @override
//   void initState() {
//     super.initState();
//     startScan();
//   }

//   void startScan() {
//     flutterBlue.startScan(timeout: Duration(seconds: 4));

//     flutterBlue.scanResults.listen((results) {
//       for (ScanResult r in results) {
//         print('${r.device.name} found! rssi: ${r.rssi}');
//         if (r.device.name == "TargetDeviceName") {
//           flutterBlue.stopScan();
//           connectToDevice(r.device);
//           break;
//         }
//       }
//     });
//   }

//   void connectToDevice(BluetoothDevice device) async {
//     await device.connect();
//     setState(() {
//       connectedDevice = device;
//     });

//     discoverServices();
//   }

//   void discoverServices() async {
//     if (connectedDevice != null) {
//       List<BluetoothService> services = await connectedDevice!.discoverServices();
//       setState(() {
//         this.services = services;
//       });
//       listenToNotifications();
//     }
//   }

//   void listenToNotifications() {
//     services.forEach((service) {
//       service.characteristics.forEach((characteristic) async {
//         if (characteristic.properties.notify) {
//           await characteristic.setNotifyValue(true);
//           characteristic.value.listen((value) {
//             print("Notification received: $value");
//           });
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("BLE Example")),
//       body: Center(
//         child: connectedDevice == null
//             ? Text("Scanning for devices...")
//             : Text("Connected to ${connectedDevice!.name}"),
//       ),
//     );
//   }
// }

// class MapSample extends StatefulWidget {
//   const MapSample({super.key});

//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: const Text('To the lake!'),
//         icon: const Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   static final GlobalKey<_HomeScreenState> homeScreenKey =
//       GlobalKey<_HomeScreenState>();

//   HomeScreen() : super(key: homeScreenKey);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   void changeTab(int index) {
//     _tabController.animateTo(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen'),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(icon: Icon(Icons.home), text: 'Home'),
//             Tab(icon: Icon(Icons.star), text: 'Star'),
//             Tab(icon: Icon(Icons.settings), text: 'Settings'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           Center(child: Text('Home Tab')),
//           Center(child: Text('Star Tab')),
//           Center(child: Text('Settings Tab')),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => ChangeTabPage()),
//           );
//         },
//         child: Icon(Icons.navigate_next),
//       ),
//     );
//   }
// }

// class ChangeTabPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Change Tab Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             HomeScreen.homeScreenKey.currentState?.changeTab(1);
//             Navigator.pop(context);
//           },
//           child: Text('Go to Star Tab'),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => TabIndexModel(),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }

// class TabIndexModel extends ChangeNotifier {
//   int _tabIndex = 0;

//   int get tabIndex => _tabIndex;

//   void setTabIndex(int index) {
//     _tabIndex = index;
//     notifyListeners();
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final TabIndexModel tabIndexModel = Provider.of<TabIndexModel>(context);

//     return DefaultTabController(
//       length: 3,
//       initialIndex: tabIndexModel.tabIndex,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Provider TabBar Example'),
//           bottom: TabBar(
//             onTap: (index) {
//               tabIndexModel.setTabIndex(index); // Update tab index when tapped
//             },
//             tabs: [
//               Tab(icon: Icon(Icons.home), text: 'Home'),
//               Tab(icon: Icon(Icons.star), text: 'Star'),
//               Tab(icon: Icon(Icons.settings), text: 'Settings'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             Center(child: Text('Home Tab')),
//             Center(child: Text('Star Tab')),
//             Center(child: Text('Settings Tab')),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             await Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ChangeTabPage()),
//             );
//           },
//           child: Icon(Icons.navigate_next),
//         ),
//       ),
//     );
//   }
// }

// class ChangeTabPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Change Tab Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Provider.of<TabIndexModel>(context, listen: false).setTabIndex(1);
//             Navigator.pop(context); // Go back to HomeScreen after changing tab
//           },
//           child: Text('Go to Star Tab'),
//         ),
//       ),
//     );
//   }
// }

// import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => TabIndexModel(),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }

// class TabIndexModel extends ChangeNotifier {
//   int _tabIndex = 0;

//   int get tabIndex => _tabIndex;

//   void setTabIndex(int index) {
//     _tabIndex = index;
//     notifyListeners();
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen'),
//         bottom: TabBar(
//           controller: DefaultTabController.of(context),
//           tabs: [
//             Tab(icon: Icon(Icons.home), text: 'Home'),
//             Tab(icon: Icon(Icons.star), text: 'Star'),
//             Tab(icon: Icon(Icons.settings), text: 'Settings'),
//           ],
//         ),
//       ),
//       body: Consumer<TabIndexModel>(
//         builder: (context, tabIndexModel, child) {
//           return DefaultTabController(
//             length: 3,
//             initialIndex: tabIndexModel.tabIndex,
//             child: TabBarView(
//               children: [
//                 Center(child: Text('Home Tab')),
//                 Center(child: Text('Star Tab')),
//                 Center(child: Text('Settings Tab')),
//               ],
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => ChangeTabPage()),
//           );
//         },
//         child: Icon(Icons.navigate_next),
//       ),
//     );
//   }
// }

// class ChangeTabPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Change Tab Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Provider.of<TabIndexModel>(context, listen: false).setTabIndex(1);
//             Navigator.pop(context);
//           },
//           child: Text('Go to Star Tab'),
//         ),
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Fab Menu',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class DialogExample extends StatelessWidget {
//   const DialogExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('showDialog Sample')),
//       body: Center(
//         child: OutlinedButton(
//           onPressed: () => _dialogBuilder(context),
//           child: const Text('Open Dialog'),
//         ),
//       ),
//     );
//   }

// Future<void> _dialogBuilder(BuildContext context) {
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Basic dialog title'),
//         content: const Text(
//           'A dialog is a type of modal window that\n'
//           'appears in front of app content to\n'
//           'provide critical information, or prompt\n'
//           'for a decision to be made.',
//         ),
//         actions: <Widget>[
//           TextButton(
//             style: TextButton.styleFrom(
//               textStyle: Theme.of(context).textTheme.labelLarge,
//             ),
//             child: const Text('Disable'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             style: TextButton.styleFrom(
//               textStyle: Theme.of(context).textTheme.labelLarge,
//             ),
//             child: const Text('Enable'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
// }

// class page2test extends StatelessWidget {
//   const page2test({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Hero(
//               tag: 'tag',
//               child: Material(
//                 color: Colors.black54,
//                 // elevation: 2,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(32)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         color: Colors.grey,
//                         height: 300,
//                         width: 400,
//                         child: const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: TextField(
//                             decoration:
//                                 InputDecoration(border: OutlineInputBorder()),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }

// class testwidget extends StatefulWidget {
//   const testwidget({super.key});

//   @override
//   State<testwidget> createState() => _testwidgetState();
// }

// List d2 = ['bbbbbbbb', 'aaaaaaaaaa'];
// List d3 = ['bbbbbbbb', 'aaaaaaaaaa'];

// class _testwidgetState extends State<testwidget> {
//   bool status = true;

//   @override
//   Widget build(BuildContext context) {
//     print('d3: $d3');
//     print('d2: $d2');
//     return Center(
//       child: FlutterSwitch(
//         width: 125.0,
//         height: 55.0,
//         valueFontSize: 25.0,
//         toggleSize: 45.0,
//         value: status,
//         borderRadius: 30.0,
//         padding: 8.0,
//         activeColor: Colors.greenAccent,
//         inactiveColor: Colors.redAccent,
//         showOnOff: true,
//         onToggle: (val) {
//           setState(() {
//             status = val;
//             print('status : $status');
//             status == false ? d2[0] = "" : d2[0] = d3[0];
//           });
//         },
//       ),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: MediaQuery.removePadding(
//           context: context,
//           removeTop: true,
//           removeBottom: true,
//           child: AnimatedGrid(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 1 / 1.2,
//               ),
//               initialItemCount: 4,
//               itemBuilder: (BuildContext context, int index,
//                   Animation<double> animation) {
//                 return Card(
//                   color: Colors.amber,
//                   child: Center(child: Text('$index')),
//                 );
//               }),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// /// Flutter code sample for [AnimatedGrid].

// void main() {
//   runApp(const AnimatedGridSample());
// }

// class AnimatedGridSample extends StatefulWidget {
//   const AnimatedGridSample({super.key});

//   @override
//   State<AnimatedGridSample> createState() => _AnimatedGridSampleState();
// }

// class _AnimatedGridSampleState extends State<AnimatedGridSample> {
//   final GlobalKey<AnimatedGridState> _gridKey = GlobalKey<AnimatedGridState>();
//   late ListModel<int> _list;
//   int? _selectedItem;
//   late int
//       _nextItem; // The next item inserted when the user presses the '+' button.

//   @override
//   void initState() {
//     super.initState();
//     _list = ListModel<int>(
//       listKey: _gridKey,
//       initialItems: <int>[0, 1, 2, 3, 4, 5],
//       removedItemBuilder: _buildRemovedItem,
//     );
//     _nextItem = 6;
//   }

//   // Used to build list items that haven't been removed.
//   Widget _buildItem(
//       BuildContext context, int index, Animation<double> animation) {
//     return CardItem(
//       animation: animation,
//       item: _list[index],
//       selected: _selectedItem == _list[index],
//       onTap: () {
//         setState(() {
//           _selectedItem = _selectedItem == _list[index] ? null : _list[index];
//         });
//       },
//     );
//   }

//   // Used to build an item after it has been removed from the list. This method
//   // is needed because a removed item remains visible until its animation has
//   // completed (even though it's gone as far as this ListModel is concerned).
//   // The widget will be used by the [AnimatedGridState.removeItem] method's
//   // [AnimatedGridRemovedItemBuilder] parameter.
//   Widget _buildRemovedItem(
//       int item, BuildContext context, Animation<double> animation) {
//     return CardItem(
//       animation: animation,
//       item: item,
//       removing: true,
//       // No gesture detector here: we don't want removed items to be interactive.
//     );
//   }

//   // Insert the "next item" into the list model.
//   void _insert() {
//     final int index =
//         _selectedItem == null ? _list.length : _list.indexOf(_selectedItem!);
//     setState(() {
//       _list.insert(index, _nextItem++);
//     });
//   }

//   // Remove the selected item from the list model.
//   void _remove() {
//     if (_selectedItem != null) {
//       setState(() {
//         _list.removeAt(_list.indexOf(_selectedItem!));
//         _selectedItem = null;
//       });
//     } else if (_list.length > 0) {
//       setState(() {
//         _list.removeAt(_list.length - 1);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'AnimatedGrid',
//             style: TextStyle(fontSize: 30),
//           ),
//           centerTitle: true,
//           leading: IconButton(
//             icon: const Icon(Icons.remove_circle),
//             iconSize: 32,
//             onPressed: (_list.length > 0) ? _remove : null,
//             tooltip: 'remove the selected item',
//           ),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.add_circle),
//               iconSize: 32,
//               onPressed: _insert,
//               tooltip: 'insert a new item',
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: AnimatedGrid(
//             key: _gridKey,
//             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//               maxCrossAxisExtent: 100.0,
//               mainAxisSpacing: 10.0,
//               crossAxisSpacing: 10.0,
//             ),
//             initialItemCount: _list.length,
//             itemBuilder: _buildItem,
//           ),
//         ),
//       ),
//     );
//   }
// }

// typedef RemovedItemBuilder<T> = Widget Function(
//     T item, BuildContext context, Animation<double> animation);

// /// Keeps a Dart [List] in sync with an [AnimatedGrid].
// ///
// /// The [insert] and [removeAt] methods apply to both the internal list and
// /// the animated list that belongs to [listKey].
// ///
// /// This class only exposes as much of the Dart List API as is needed by the
// /// sample app. More list methods are easily added, however methods that
// /// mutate the list must make the same changes to the animated list in terms
// /// of [AnimatedGridState.insertItem] and [AnimatedGrid.removeItem].
// class ListModel<E> {
//   ListModel({
//     required this.listKey,
//     required this.removedItemBuilder,
//     Iterable<E>? initialItems,
//   }) : _items = List<E>.from(initialItems ?? <E>[]);

//   final GlobalKey<AnimatedGridState> listKey;
//   final RemovedItemBuilder<E> removedItemBuilder;
//   final List<E> _items;

//   AnimatedGridState? get _animatedGrid => listKey.currentState;

//   void insert(int index, E item) {
//     _items.insert(index, item);
//     _animatedGrid!.insertItem(
//       index,
//       duration: const Duration(milliseconds: 500),
//     );
//   }

//   E removeAt(int index) {
//     final E removedItem = _items.removeAt(index);
//     if (removedItem != null) {
//       _animatedGrid!.removeItem(
//         index,
//         (BuildContext context, Animation<double> animation) {
//           return removedItemBuilder(removedItem, context, animation);
//         },
//       );
//     }
//     return removedItem;
//   }

//   int get length => _items.length;

//   E operator [](int index) => _items[index];

//   int indexOf(E item) => _items.indexOf(item);
// }

// /// Displays its integer item as 'item N' on a Card whose color is based on
// /// the item's value.
// ///
// /// The text is displayed in bright green if [selected] is
// /// true. This widget's height is based on the [animation] parameter, it
// /// varies from 0 to 128 as the animation varies from 0.0 to 1.0.
// class CardItem extends StatelessWidget {
//   const CardItem({
//     super.key,
//     this.onTap,
//     this.selected = false,
//     this.removing = false,
//     required this.animation,
//     required this.item,
//   }) : assert(item >= 0);

//   final Animation<double> animation;
//   final VoidCallback? onTap;
//   final int item;
//   final bool selected;
//   final bool removing;

//   @override
//   Widget build(BuildContext context) {
//     TextStyle textStyle = Theme.of(context).textTheme.headlineMedium!;
//     if (selected) {
//       textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
//     }
//     return Padding(
//       padding: const EdgeInsets.all(2.0),
//       child: ScaleTransition(
//         scale: CurvedAnimation(
//             parent: animation,
//             curve: removing ? Curves.easeInOut : Curves.bounceOut),
//         child: GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: onTap,
//           child: SizedBox(
//             height: 80.0,
//             child: Card(
//               color: Colors.primaries[item % Colors.primaries.length],
//               child: Center(
//                 child: Text('${item + 1}', style: textStyle),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class test extends StatefulWidget {
//   const test({super.key});

//   @override
//   State<test> createState() => _testState();
// }

// class _testState extends State<test> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Timer(const Duration(seconds: 1), () {
//       setState(() {
//         print('object');
//       });
//     });
//     return Text(data);
//   }
// }

