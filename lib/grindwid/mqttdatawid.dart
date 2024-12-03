import 'dart:async';
import 'dart:convert';
// import 'dart:convert';
// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/datawidget_mqtt.dart';
import 'package:flutter_application_1/grindwid/httpalldatawid.dart';
import 'package:flutter_application_1/page_/home_page.dart';
import 'package:flutter_application_1/page_/second_page.dart';
import 'package:flutter_application_1/protocal/http_api.dart';
import 'package:flutter_application_1/protocal/mqtt.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Mqttdatawid extends StatefulWidget {
  const Mqttdatawid({super.key});

  @override
  State<Mqttdatawid> createState() => _MqttdatawidState();
}

class _MqttdatawidState extends State<Mqttdatawid> {
  @override
  void initState() {
    super.initState();
    timer1 = Timer.periodic(
        const Duration(seconds: 2),
        (_) => setState(() {
              if (pub_sub_name.isNotEmpty) {
                dataFuture1 = get_mqtt();
                mqtt_gat();
                //   if (premqttlist.length == pub_sub_name.length / 3) {
                //     mqttlist.replaceRange(0, mqttlist.length, premqttlist);
                //   }
              }
              if (uri.isNotEmpty) {
                dataFuture = get_api();
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    print('pubsn${pub_sub_name}');
    print('premqlist${premqttlist}');
    print('mqlist${mqttlist}');
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: GridView.builder(
        itemCount:
            // mqttlist.length,
            pub_sub_name.length ~/ 3,
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
              columnCount:
                  // mqttlist.length,
                  pub_sub_name.length ~/ 3,
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
                            child: Datawidget_mqtt(index: index))),
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
                                  // pub_sub_name.removeAt((index * 3));
                                  // pub_sub_name.removeAt((index * 3) + 1);
                                  // pub_sub_name.removeAt((index * 3) + 2);
                                  pub_sub_name.removeRange(
                                      (index * 3), (index * 3) + 3);
                                  mqttlist.removeAt(index);
                                  onOff_mq.removeAt(index);
                                  // premqttlist.removeAt(index);
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
                          value: onOff_mq[index],
                          borderRadius: 30.0,
                          padding: 7.0,
                          activeColor: Colors.greenAccent,
                          inactiveColor: Colors.redAccent,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              onOff_mq[index] = val;

                              // onOff_mq[index] == false
                              //     ? pub_sub_name[index] = ""
                              //     : pub_sub_name[index] = pubSNcopy[index];

                              if (onOff_mq[index] == false) {
                                pub_sub_name[index * 3] = "";
                                pub_sub_name[index * 3 + 1] = "";
                                pub_sub_name[index * 3 + 2] = "";
                              } else {
                                pub_sub_name[index * 3] = pubSNcopy[index * 3];
                                pub_sub_name[index * 3 + 1] =
                                    pubSNcopy[index * 3 + 1];
                                pub_sub_name[index * 3 + 2] =
                                    pubSNcopy[index * 3 + 2];
                              }

                              print(onOff_mq[index]);
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

// Padding(
//             padding: const EdgeInsets.all(10),
//             child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.grey.shade500,
//                     borderRadius: BorderRadius.circular(15)),
//                 child: Datawidget_mqtt(index: index)),
//           );
//         },