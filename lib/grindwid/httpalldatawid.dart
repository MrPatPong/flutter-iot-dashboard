import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/datawidget.dart';
import 'package:flutter_application_1/component/datawidget_mqtt.dart';
import 'package:flutter_application_1/page_/home_page.dart';
import 'package:flutter_application_1/page_/second_page.dart';
import 'package:flutter_application_1/protocal/http_api.dart';
import 'package:flutter_application_1/protocal/mqtt.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Httpalldatawid extends StatefulWidget {
  const Httpalldatawid({super.key});

  @override
  State<Httpalldatawid> createState() => _HttpalldatawidState();
}

Timer? timer;
Future<dynamic>? dataFuture;
bool editButt = false;
// double padAnimat = 0.0;
bool status = true;

class _HttpalldatawidState extends State<Httpalldatawid> {
  // final GlobalKey<AnimatedGridState> _gridKey = GlobalKey<AnimatedGridState>();
  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
        const Duration(seconds: 2),
        (_) => setState(() {
              if (uri.isNotEmpty) {
                dataFuture = get_api();
              }
              if (pub_sub_name.isNotEmpty) {
                dataFuture1 = get_mqtt();
                mqtt_gat();

                //   if (premqttlist.length == pub_sub_name.length / 3) {
                //     mqttlist.replaceRange(0, mqttlist.length, premqttlist);
                //   }
              }
              // dataFuture = Get_api();
            }));
  }

  // @override
  // void initState() {
  //   super.initState();

  //   timer = Timer.periodic(
  //       const Duration(seconds: 1),
  //       (_) => setState(() {
  //             if (uri.isNotEmpty) {
  //               dataFuture = get_api();
  //             }
  //             // dataFuture = Get_api();
  //           }));
  // }

  @override
  Widget build(BuildContext context) {
    print('url');
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: GridView.builder(
        // key: _gridKey,
        itemCount: uri.length,
        // uri.length,
        // physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.2,
        ),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 300),
              columnCount: uri.length,
              // uri.length,

              child: ScaleAnimation(
                  child: SlideAnimation(
                child: Padding(
                  // duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(20),
                  // curve: Curves.bounceInOut,
                  child: Stack(children: [
                    Container(
                        width: 200,
                        height: 200,
                        // color: Colors.black,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(15)),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => second_page(index),
                                  ));
                            },
                            child: Datawidget(index: index))),
                    Positioned(
                      right: 0,
                      // top: 0,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: editButt,
                            child: FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  uri.removeAt(index);
                                  onOff.removeAt(index);
                                });
                              },
                              child:
                                  const Icon(Icons.disabled_by_default_rounded),
                            ),

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
                    Visibility(
                      visible: editButt,
                      child: Center(
                        child: FlutterSwitch(
                          width: 100.0,
                          height: 50.0,
                          valueFontSize: 25.0,
                          toggleSize: 40.0,
                          value: onOff[index],
                          borderRadius: 30.0,
                          padding: 7.0,
                          activeColor: Colors.greenAccent,
                          inactiveColor: Colors.redAccent,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              onOff[index] = val;
                              onOff[index] == false
                                  ? uri[index] = ""
                                  : uri[index] = urlcopy[index];

                              print(onOff[index]);
                            });
                          },
                        ),
                      ),
                    )
                  ]),
                ),
              )));
        },
      ),
    );
  }
}
