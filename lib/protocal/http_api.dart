// import 'package:flutter_application_1/component/datawidget.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_application_1/page_/home_page.dart';
// import 'package:flutter_application_1/protocal/mqtt.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class datastore {
  final int value;
  final int time;
  final String date;

  datastore({
    required this.value,
    required this.time,
    required this.date,
  });
  @override
  String toString() {
    return '{value: $value, time: $time, date:$date}';
  }
}

late List alldatas = [];
late List<datastore> datas = [];
late List jsondatalist = [];
late List inUrl = [];

// final alldatasMap = alldatas.asMap();

// late Iterable<Future<dynamic>> url = [
//   http.get(
//       Uri.parse("http://192.168.1.135:8080/data1/6688f54128c227d4a062b59a")),
//   http.get(
//       Uri.parse("http://192.168.1.135:8080/data1/66842f7fdc68b130b87ab84b")),
// ];

var jsonData;

var response1;
var responses;

// Future<void> fetchParallelData() async {
//   inUrl.add("http://192.168.1.135:8080/data1/6688f54128c227d4a062b59a");
//   // inUrl.clear();
//   jsondatalist.clear();

//   for (var i = 0; i < inUrl.length; i++) {
//     responses = await http.get(Uri.parse(inUrl[i].toString()));

//     for (response1 in responses) {
//       // Decode the JSON data from each response.
//       // http.Response response2 = response1;

//       data = json.decode(response1.body);

//       // Print the title of each post.
//       print('Title: ${data}');
//       jsondatalist.add(data);
//       print('jlist: ${jsondatalist}');
//       print('inurl: ${inUrl.length}');
//     }
//   }
//   // alldatas.clear();
//   // datas.clear();

// //   for (var i = 0; i < inUrl.length; i++) {
// //     alldatas.add(datas);
// //   }

// //   for (var eachdata in jsondatalist[inUrl.length - 1]["datastore"]) {
// //     final data1 = datastore(
// //       value: eachdata["value"],
// //       time: eachdata["time"],
// //       date: eachdata["date"],
// //     );

// //     alldatas[inUrl.length - 1].add(data1);
// //   }

// //   // "http://192.168.1.135:8080/data1/6688f54128c227d4a062b59a",
// //   // "http://192.168.1.135:8080/data1/6688f54128c227d4a062b59a",
// "http://192.168.1.135:8080/data1/6688f54128c227d4a062b59a"

// //   print(inUrl.length);
// //   print('alldatas: ${alldatas.length}');
// //   print('datas: ${datas.length}');

//   return data;
// }

// Future<dynamic> Get_api() async {
//   // Json.replaceRange(0, Json.length, jsonData);
//   Json1.clear();

//   for (var i = 0; i < inUrl.length; i++) {
//     final Url = Uri.parse(inUrl[i]);

//     http.Response response = await http.get(Url);
//     jsonData = jsonDecode(response.body);

//     Json1.add(jsonData);

//     // if (Json.length > 1) {
//     //   Json.removeAt(0);
//     // }
//   }

//   Json.replaceRange(0, Json.length, Json1);

//   // if (Json.length > 1) {
//   //   Json.removeAt(0);
//   // }

//   // if (Json.length >= 1) {
//   //   Json.removeRange(0, inUrl.length - 1);
//   // }else if (inUrl.length ==) {

//   // }

//   // if (Json1.length > 1) {
//   //   Json1.removeAt(0);
//   // }
//   // Json.clear();
//   // Json.replaceRange(0, Json.length, jsonData);

//   print('inurl:${inUrl.length}');
//   print('Json : ${Json.length}');
//   print('Json_datastore: ${Json[0]["datastore"]}');
//   print('Json1 : ${Json1.length}');
//   // print('Json..:${Json}');

//   // Future.delayed(const Duration(seconds: 1), () {
//   //   print('One second has passed.'); // Prints after 1 second.
//   // });

//   alldatas.clear();
//   datas.clear();

//   for (var i = 0; i < inUrl.length; i++) {
//     alldatas.add(datas);
//   }

//   for (var eachdata in Json[inUrl.length - 1]["datastore"]) {
//     final data1 = datastore(
//       value: eachdata["value"],
//       time: eachdata["time"],
//       date: eachdata["date"],
//     );

//     alldatas[inUrl.length - 1].add(data1);
//   }

//   print('alldata:${alldatas.length}');
//   print('inalldata:${alldatas[0][0]}');
//   print('datas: ${datas[0]}');
//   print('datas: ${datas}');

//   return Json;
// }

var data;
List jsonn = [];
List<Future> jsonnn = [];
List<Future> json2 = [];
List uri = [];
List urlcopy = [];
List url1 = [];
List urlindex = [];

// List jsonvarlist = [];

// Future<dynamic> Get_api() async {
//   final Url =
//       Uri.parse("http://192.168.1.135:8080/data1/6688f54128c227d4a062b59a");

//   response1 = await http.get(Url);
//   jsonData = jsonDecode(response1.body);

//   jsonnn.add(jsonData);

//   // Future.delayed(const Duration(seconds: 1), () {
//   //   print('One second has passed.'); // Prints after 1 second.
//   // });

//   // datas.clear();

//   // for (var eachdata in jsonData["datastore"]) {
//   //   final data = datastore(
//   //     value: eachdata["value"],
//   //     time: eachdata["time"],
//   //     date: eachdata["date"],
//   //   );

//   //   datas.add(data);
//   // }

//   // print('jsondata: ${jsonData}');

//   // return jsonData;
// }

// Future<dynamic> getUri(String uri) async {
//   var response5 = await http.get(Uri.parse(uri));
//   return response5;
// }

Future<dynamic> get_api() async {
  // uri.clear();
  url1.clear();
  urlindex.clear();
  // uri.add("");
  // uri.add("http://192.168.1.135:8080/data1/6688f54128c227d4a062b59a");
  // uri.add("http://192.168.1.135:8080/data1/66842f7fdc68b130b87ab84b");
  // uri.add("http://192.168.1.135:8080/data1/6688f54128c227d4a062b59a");
  // uri.add("");
  // onOff.clear();
  json2.clear();
  // for (var i = 0; i < uri.length; i++) {
  //   onOff.add(false);
  // }
  // print('onoff: ${onOff}');

  for (var i = 0; i < uri.length; i++) {
    if (uri[i].length != 0) {
      // uri.removeAt(uri.indexOf([i]));
      url1.add(uri[i]);
    } else if (uri[i].length == 0) {
      urlindex.add(i);
    }
  }

  print('uri : ${uri.length}');
  print('url1 : ${url1}');
  print('urlin : ${urlindex}');

  for (var i = 0; i < url1.length; i++) {
    // var aass = http.get(Uri.parse(uri[i]));
    json2.add(http.get(Uri.parse(url1[i])));
    // print('listjson2: ${json2}');
  }

  final getjson = await Future.wait(json2);
  // print('getj : ${getjson.statuscode}');
  // final getjson = await Future.wait([
  //   http.get(
  //       Uri.parse("http://192.168.1.135:8080/data1/6688f54128c227d4a062b59a")),
  //   // http.get(
  //   //     Uri.parse("http://192.168.1.135:8080/data1/66842f7fdc68b130b87ab84b")),
  // ]);

  jsonn.clear();
  for (final response in getjson) {
    data = json.decode(response.body);
    jsonn.add(data);
    // print('Title: ${data}');
  }

  const jsonString =
      '{"name": "NO", "value": 0,"datastore": [{"value": 0,"time": 0,"date": "0"}]}';

  for (var i = 0; i < urlindex.length; i++) {
    jsonn.insert(urlindex[i], jsonDecode(jsonString));
  }

  print('jsonn: ${jsonn}');
  print('jsonnleg: ${jsonn.length}');
  print('uri: ${uri.length}');

  // alldatas.clear();
  // datas.clear();

  // for (var i = 0; i < uri.length; i++) {
  //   alldatas.add(datas);
  // }

  // for (var i = 0; i < uri.length; i++) {
  //   for (var eachdata in jsonn[uri.length - 1]["datastore"]) {
  //     final data1 = datastore(
  //       value: eachdata["value"],
  //       time: eachdata["time"],
  //       date: eachdata["date"],
  //     );

  //     alldatas[uri.length -1 ].add(data1);
  //   }
  // }

  // print('alldatalen:${alldatas.length}');
  // // print('inalldata:${alldatas[0][0]}');
  // // print('datas: ${datas[0]}');
  // // print('datas: ${datas}');
  // print('alldata:${alldatas}');
  // print('json8:${jsonn[0]["datastore"][0]["value"]}');

  return jsonn;
}




// Future<void> Get_api(String url) async {
//   final Url = Uri.parse(url);

//   http.Response response = await http.get(Url);
//   jsonData = jsonDecode(response.body);

//   // Future.delayed(const Duration(seconds: 1), () {
//   //   print('One second has passed.'); // Prints after 1 second.
//   // });

//   datas.clear();

//   for (var eachdata in jsonData["datastore"]) {
//     final data = datastore(
//       value: eachdata["value"],
//       time: eachdata["time"],
//       date: eachdata["date"],
//     );

//     datas.add(data);
//   }
//   return jsonData;
// }





  // getdata() async {
  //   var request = await http.get(Uri.parse("http://localhost:8080"), headers: {
  //     "Access-Control-Allow-Origin": "*",
  //     'Content-Type': 'application/json',
  //     'Accept': '*/*'
  //   });
  //   print(request.body.toString());
  // }
