import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert' show utf8;

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

List ble = [];
List ble1 = [];
List blename = [];
List blename1 = [];

int readCharacteristic1 = 0;

class BleMultiDevicePage extends StatefulWidget {
  static final GlobalKey<_BleMultiDevicePageState> blekey =
      GlobalKey<_BleMultiDevicePageState>();

  @override
  _BleMultiDevicePageState createState() => _BleMultiDevicePageState();
}

class _BleMultiDevicePageState extends State<BleMultiDevicePage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = [];
  Map<BluetoothDevice, List<BluetoothService>> connectedDevices = {};

  List<BluetoothService> services = [];

  @override
  void initState() {
    super.initState();
    scanForDevices();
  }

  void scanForDevices() {
    // flutterBlue.startScan(timeout: Duration(seconds: 5));
    scanPermission();
    flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!devicesList.contains(result.device)) {
          setState(() {
            devicesList.add(result.device);
          });
        }
      }
    });

    flutterBlue.stopScan();
  }

  Future scanPermission() async {
    if (await Permission.bluetoothScan.request().isGranted) {
      if (await Permission.bluetoothConnect.request().isGranted) {
        flutterBlue.startScan(timeout: Duration(seconds: 15));

        // flutterBlue.stopScan();
      }
    }
  }

  // void listenToNotifications() {
  //   for (var service in services) {
  //     service.characteristics.forEach((characteristic) async {
  //       if (characteristic.properties.notify) {
  //         await characteristic.setNotifyValue(true);
  //         characteristic.value.listen((value) {
  //           print("Notification received: $value");
  //         });
  //       }
  //     });
  //   }
  // }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    // List<BluetoothService> services = await device.discoverServices();
    services = await device.discoverServices();
    setState(() {
      connectedDevices[device] = services;
    });
    // print('services from : ${services}');
    // disconnectFromDevice(device);
    // discoverServices(device);
  }

  // void discoverServices(BluetoothDevice device) async {
  //   List<BluetoothService> services = await device.discoverServices();
  //   setState(() {
  //     this.services = services;
  //   });
  // }

  void disconnectFromDevice(BluetoothDevice device) async {
    await device.disconnect();
    readCharacteristic1--;
    setState(() {
      connectedDevices.remove(device);
    });
    // listenToNotifications();
  }

  Future<void> readCharacteristic(
      BluetoothDevice device, BluetoothCharacteristic characteristic) async {
    readCharacteristic1++;
    print("readcharcount: ${readCharacteristic1}");
    // var value = await characteristic.read();
    if (characteristic.properties.notify) {
      await characteristic.setNotifyValue(true);
      characteristic.value.listen((value) {
        // print("Notification received: ${utf8.decode((value))}");
        blename.add(device.name);
        ble.add(value[0]);

        print("Notification Read from ${device.name} : ${value[0]}");
        if (ble.length == readCharacteristic1) {
          blename1.replaceRange(0, blename1.length, blename);
          ble1.replaceRange(0, ble1.length, ble);
          blename.clear();
          ble.clear();
        }
        print("ble1 : ${ble1}");
        print("blename1 : ${blename1}");
      });
    }

    // print('Read from ${device.name}: ${utf8.decode(value)}');
    // print('services from : ${services}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLE Multiple Connections'),
      ),
      body: ListView.builder(
        itemCount: devicesList.length,
        itemBuilder: (context, index) {
          BluetoothDevice device = devicesList[index];
          bool isConnected = connectedDevices.containsKey(device);

          return ExpansionTile(
            title: Text(device.name == '' ? 'Unknown Device' : device.name),
            subtitle: Text(device.id.toString()),
            trailing: isConnected
                ? IconButton(
                    icon: Icon(Icons.bluetooth_disabled),
                    onPressed: () => disconnectFromDevice(device),
                  )
                : IconButton(
                    icon: Icon(Icons.bluetooth),
                    onPressed: () {
                      connectToDevice(device);
                      // connectedDevices[device]!
                      //     .expand((service) => service.characteristics);
                    },
                  ),
            children: isConnected
                ? connectedDevices[device]!
                    .expand((service) => service.characteristics)
                    .map((characteristic) {
                    // print(
                    //     "asdfffffff : ${(connectedDevices[device]!.expand((service) => service.characteristics))}");
                    // print('dddddddddd : ${characteristic.uuid}');
                    return ListTile(
                      title: Text('Characteristic: ${characteristic.uuid}'),
                      subtitle:
                          Text('Properties: ${characteristic.properties}'),
                      trailing: IconButton(
                          icon: Icon(Icons.read_more),
                          onPressed: () {
                            readCharacteristic(device, characteristic);
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => MySimpleWidget(),
                            //     ));
                          }),
                    );
                  }).toList()
                : [],
          );
        },
      ),
    );
  }
}

class BleScreen extends StatefulWidget {
  @override
  _BleScreenState createState() => _BleScreenState();
}

class _BleScreenState extends State<BleScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = [];
  BluetoothDevice? connectedDevice;
  List<BluetoothService> services = [];

  @override
  void initState() {
    super.initState();
    scanForDevices();
  }

  void scanForDevices() {
    flutterBlue.scan().listen((scanResult) {
      if (!devicesList.contains(scanResult.device)) {
        setState(() {
          devicesList.add(scanResult.device);
        });
      }
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    setState(() {
      connectedDevice = device;
      // print('condevice: $connectedDevice');
    });
    discoverServices(device);
  }

  void discoverServices(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    setState(() {
      this.services = services;
    });
  }

  Future<void> readCharacteristic(
      BluetoothCharacteristic characteristic) async {
    // var value = await characteristic.read();
    // print('Characteristic value: ${utf8.decode(value)}');

    if (characteristic.properties.notify) {
      await characteristic.setNotifyValue(true);
      characteristic.value.listen((value) {
        print("Notification received1: ${value[0]}");
      });
    }
  }

  Future<void> writeCharacteristic(
      BluetoothCharacteristic characteristic, List<int> value) async {
    await characteristic.write(value);
  }

  @override
  Widget build(BuildContext context) {
    scanForDevices();

    return Scaffold(
      appBar: AppBar(
        title: Text('BLE Devices'),
      ),
      body: connectedDevice == null
          ? ListView.builder(
              itemCount: devicesList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(devicesList[index].name),
                  subtitle: Text(devicesList[index].id.toString()),
                  onTap: () {
                    connectToDevice(devicesList[index]);
                  },
                );
              },
            )
          : ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(services[index].uuid.toString()),
                  onTap: () {
                    // setState(() {
                    readCharacteristic((services[index].characteristics[0]));
                    print('char : ${services[index].characteristics.length}');
                    // });
                    // Handle service tap, read or write characteristics
                  },
                );
              },
            ),
    );
  }
}

class BleController extends GetxController {
  FlutterBlue ble = FlutterBlue.instance;

// This Function will help users to scan near by BLE devices and get the list of Bluetooth devices.
  Future scanDevices() async {
    if (await Permission.bluetoothScan.request().isGranted) {
      if (await Permission.bluetoothConnect.request().isGranted) {
        ble.startScan(timeout: Duration(seconds: 15));

        ble.stopScan();
      }
    }
  }

// This function will help user to connect to BLE devices.
  Future<void> connectToDevice(BluetoothDevice device) async {
    await device?.connect(timeout: Duration(seconds: 15));

    device?.state.listen((isConnected) async {
      if (isConnected == BluetoothDeviceState.connecting) {
        print("Device connecting to: ${device.name}");
        // Reads all characteristics
        // Note: You must call discoverServices after every re-connection!
        List<BluetoothService> services = await device.discoverServices();
        services.forEach((service) async {
          // do something with service
          var characteristics = service.characteristics;
          for (BluetoothCharacteristic c in characteristics) {
            if (c.properties.read) {
              List<int> value = await c.read();
              print('value: $value');
            }
          }
        });
      } else if (isConnected == BluetoothDeviceState.connected) {
        print("Device connected: ${device.name}");
      } else {
        print("Device Disconnected");
      }
    });
  }

  Stream<List<ScanResult>> get scanResults => ble.scanResults;
}

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({super.key});

  @override
  State<MyHomePage1> createState() => _MyHomePageState1();
}

class _MyHomePageState1 extends State<MyHomePage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BLE SCANNER"),
        ),
        body: GetBuilder<BleController>(
          init: BleController(),
          builder: (BleController controller) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<List<ScanResult>>(
                      stream: controller.scanResults,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final data = snapshot.data![index];
                                  return Card(
                                    elevation: 2,
                                    child: ListTile(
                                      title: Text(data.device.name),
                                      subtitle: Text(data.device.id.id),
                                      trailing: Text(data.rssi.toString()),
                                      onTap: () => controller
                                          .connectToDevice(data.device),
                                    ),
                                  );
                                }),
                          );
                        } else {
                          return Center(
                            child: Text("No Device Found"),
                          );
                        }
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        controller.scanDevices();
                        // await controller.disconnectDevice();
                      },
                      child: Text("SCAN")),
                ],
              ),
            );
          },
        ));
  }
}
