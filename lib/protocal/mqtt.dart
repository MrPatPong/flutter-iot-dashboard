import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/bar_graph.dart';
import 'package:flutter_application_1/component/datawidget_mqtt.dart';
import 'package:flutter_application_1/protocal/http_api.dart';
import 'package:http/http.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final MqttServerClient client =
    MqttServerClient.withPort('broker.hivemq.com', 'flutter_client', 1883);

List mqttlist = [];
List premqttlist = [];
List pub_sub_name = [];
List pub_sub_name1 = [];
List pub_sub_nameindex = [];
List pubSNcopy = [];

Future<dynamic> get_mqtt() async {
  pub_sub_name1.clear();
  pub_sub_nameindex.clear();
  // pub_sub_name.clear();
  // pub_sub_name.add('esp32/datacall');
  // pub_sub_name.add("esp32/datanonOut");
  // pub_sub_name.add("esp33_mqtt");
  // pub_sub_name1.add('');
  // pub_sub_name1.add("");
  // pub_sub_name1.add("");
  // pub_sub_name.add('esp32/datacall2');
  // pub_sub_name.add("esp32/datanonOut2");
  // pub_sub_name.add("esp35_mqtt");
  // pub_sub_name.add('');
  // pub_sub_name.add("");
  // pub_sub_name.add("");
  // pub_sub_name.add('esp32/datacall');
  // pub_sub_name.add("esp32/datanonOut");
  // pub_sub_name.add("esp33_mqtt");
  // pub_sub_name.add('esp32/datacall1');
  // pub_sub_name.add("esp32/datanonOut1");
  // pub_sub_name.add("esp34_mqtt");
  // pub_sub_name.add('esp32/datacall2');
  // pub_sub_name.add("esp32/datanonOut2");
  // pub_sub_name.add("esp35_mqtt");

  for (var i = 0; i < pub_sub_name.length; i++) {
    if (pub_sub_name[i].length != 0) {
      // uri.removeAt(uri.indexOf([i]));
      pub_sub_name1.add(pub_sub_name[i]);
    } else if (pub_sub_name[i].length == 0) {
      pub_sub_nameindex.add(i);
    }
  }

  print('pubsub : ${pub_sub_name}');
  print('pubsub1 : ${pub_sub_name1}');
  print('pubsubin : ${pub_sub_nameindex}');

  client.keepAlivePeriod = 60;

  final connMessage = MqttConnectMessage()
      .authenticateAs('username', 'password')
      .withWillTopic('willtopic')
      .withWillMessage('Will message')
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);
  client.connectionMessage = connMessage;

  // if (client.connectionStatus!.state != MqttConnectionState.connected) {
  try {
    print('Connecting');
    await client.connect();
  } catch (e) {
    print('Exception: $e');
    client.disconnect();
  }
  // print("connected");

  for (var i = 0; i < pub_sub_name1.length / 3; i++) {
    final builder = MqttClientPayloadBuilder();

    builder.addString('{"name":"${pub_sub_name1[(i * 3) + 2]}","value":30}');
    client.publishMessage(
        pub_sub_name1[i * 3], MqttQos.atLeastOnce, builder.payload!);

    client.subscribe(pub_sub_name1[(i * 3) + 1], MqttQos.atLeastOnce);
  }

  // client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c2) async {
  //   final recMess2 = c2![0].payload as MqttPublishMessage;
  //   var pt2 =
  //       MqttPublishPayload.bytesToStringAsString(recMess2.payload.message);

  //   ptjson = await jsonDecode(pt2);

  //   mqttlist.add(ptjson);
  //   // print('ptjson: ${ptjson}');
  //   // print('mqttlist: ${mqttlist}');
  // });

  //   Future<dynamic> mqtt_gat(pub, sub, name) async {
  //   for (var i = 0; i < pub.lenght; i++) {
  //     var pubTopic = pub[i];
  //     final builder = MqttClientPayloadBuilder();
  //   builder.addString('{"name":"${name[i]}"}');
  //     client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);

  //     client.subscribe(sub[i], MqttQos.atLeastOnce);

  //   }
  // }

  // var pubTopic = pub;
  // final builder = MqttClientPayloadBuilder();
  // builder.addString('{"name":"$name"}');
  // client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);

  // client.subscribe(sub, MqttQos.atLeastOnce);

  // var pubTopic1 = 'esp32/datacall1';
  // final builder1 = MqttClientPayloadBuilder();
  // builder1.addString('{"name":"esp34_mqtt"}');
  // client.publishMessage(pubTopic1, MqttQos.atLeastOnce, builder1.payload!);

  // client.subscribe("esp32/datanonOut1", MqttQos.atLeastOnce);

  // var pubTopic2 = 'esp32/datacall2';
  // final builder2 = MqttClientPayloadBuilder();
  // builder2.addString('{"name":"esp35_mqtt"}');
  // client.publishMessage(pubTopic2, MqttQos.atLeastOnce, builder2.payload!);

  // client.subscribe("esp32/datanonOut2", MqttQos.atLeastOnce);
  // mqttlist.clear();
  premqttlist.clear();
  client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c2) async {
    final recMess2 = c2![0].payload as MqttPublishMessage;
    var pt2 =
        MqttPublishPayload.bytesToStringAsString(recMess2.payload.message);

    var ptjson = jsonDecode(pt2);
    premqttlist.add(ptjson);
  });

  // print('premqttlist: ${premqttlist}');
  // for (var i = 0; i < pub_sub_name.length / 3; i++) {
  //   final builder = MqttClientPayloadBuilder();

  //   builder.addString('{"name":"${pub_sub_name[(i * 3) + 2]}","value":11}');
  //   client.publishMessage(
  //       pub_sub_name[i * 3], MqttQos.atLeastOnce, builder.payload!);

  //   client.subscribe(pub_sub_name[(i * 3) + 1], MqttQos.atLeastOnce);
  // }

  // // client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c2) async {
  // //   final recMess2 = c2![0].payload as MqttPublishMessage;
  // //   var pt2 =
  // //       MqttPublishPayload.bytesToStringAsString(recMess2.payload.message);

  // //   ptjson = await jsonDecode(pt2);

  // //   mqttlist.add(ptjson);
  // //   // print('ptjson: ${ptjson}');
  // //   // print('mqttlist: ${mqttlist}');
  // // });

  // //   Future<dynamic> mqtt_gat(pub, sub, name) async {
  // //   for (var i = 0; i < pub.lenght; i++) {
  // //     var pubTopic = pub[i];
  // //     final builder = MqttClientPayloadBuilder();
  // //   builder.addString('{"name":"${name[i]}"}');
  // //     client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);

  // //     client.subscribe(sub[i], MqttQos.atLeastOnce);

  // //   }
  // // }

  // // var pubTopic = pub;
  // // final builder = MqttClientPayloadBuilder();
  // // builder.addString('{"name":"$name"}');
  // // client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);

  // // client.subscribe(sub, MqttQos.atLeastOnce);

  // // var pubTopic1 = 'esp32/datacall1';
  // // final builder1 = MqttClientPayloadBuilder();
  // // builder1.addString('{"name":"esp34_mqtt"}');
  // // client.publishMessage(pubTopic1, MqttQos.atLeastOnce, builder1.payload!);

  // // client.subscribe("esp32/datanonOut1", MqttQos.atLeastOnce);

  // // var pubTopic2 = 'esp32/datacall2';
  // // final builder2 = MqttClientPayloadBuilder();
  // // builder2.addString('{"name":"esp35_mqtt"}');
  // // client.publishMessage(pubTopic2, MqttQos.atLeastOnce, builder2.payload!);

  // // client.subscribe("esp32/datanonOut2", MqttQos.atLeastOnce);
  // // mqttlist.clear();
  // premqttlist.clear();
  // client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c2) async {
  //   final recMess2 = c2![0].payload as MqttPublishMessage;
  //   var pt2 =
  //       MqttPublishPayload.bytesToStringAsString(recMess2.payload.message);

  //   var ptjson = jsonDecode(pt2);
  //   premqttlist.add(ptjson);
  // });

  // mqttlist.insertAll(0, premqttlist);
  // mqttlist.removeRange(2, mqttlist.length);
  // Future.delayed(const Duration(seconds: 2), () {});

  return mqttlist;
}

Future<dynamic> mqtt_gat() async {
  // if (pub_sub_name.isNotEmpty) {

  const jsonString1 = '{"name": "NO", "value": "0"}';

  if (premqttlist.isNotEmpty) {
    for (var i = 0; i < pub_sub_nameindex.length / 3; i++) {
      premqttlist.insert(
          (pub_sub_nameindex[(i * 3)]) ~/ 3, jsonDecode(jsonString1));
    }
  }

  if (premqttlist.length == pub_sub_name.length / 3) {
    mqttlist.replaceRange(0, mqttlist.length, premqttlist);
  }
  // }
}
