import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page_/second_page.dart';
import 'package:flutter_application_1/protocal/http_api.dart';
import 'package:flutter_application_1/page_/home_page.dart';
import 'package:flutter_application_1/protocal/mqtt.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Datawidget_mqtt extends StatefulWidget {
  // const Datawidget({super.key});

  // final String url;
  final int index;

  const Datawidget_mqtt({super.key, required this.index});

  @override
  State<Datawidget_mqtt> createState() => _Datawidget_mqttState();
}

Timer? timer1;
Future<dynamic>? dataFuture1;

// List<Widget> secondPageList = [];

class _Datawidget_mqttState extends State<Datawidget_mqtt> {
  // Future<void> Get_api() async {
  //   final Url = Uri.parse(inUrl[widget.index]);

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

  // @override
  // void dispose() {
  //   timer1?.cancel(); // Cancel the timer
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: dataFuture1,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List checklenght = snapshot.data;
              print('checklenght : ${checklenght} index : ${widget.index}');
              if (checklenght.isNotEmpty) {
                if (checklenght.length - 1 < widget.index) {
                  return const Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                          Text('loading....')
                        ]),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => second_page(widget.index),
                          ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'lib/all_asset/cpu.png',
                          height: 100,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("NAME : ${mqttlist[widget.index]["name"]}",
                            style: GoogleFonts.aDLaMDisplay(
                                fontSize: 15, color: Colors.white)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "VALUE : ${mqttlist[widget.index]["value"]}",
                          style: GoogleFonts.aDLaMDisplay(
                              fontSize: 15, color: Colors.white),
                        )
                      ],
                    ),
                  );
                }
              } else {
                return const Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                        Text('loading....')
                      ]),
                );
              }
            } else if (snapshot.hasError) {
              final error = snapshot.error;
              return Text('status:$error');
            } else {
              return const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      Text('loading....')
                    ]),
              );
            }
          }),
    );
  }
}
