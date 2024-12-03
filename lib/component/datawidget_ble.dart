// import 'dart:async';
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/grindwid/httpalldatawid.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/protocal/ble.dart';
// import 'package:flutter_application_1/page_/second_page.dart';
import 'package:flutter_application_1/protocal/http_api.dart';
// import 'package:flutter_application_1/page_/home_page.dart';
// import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DatawidgetBle extends StatefulWidget {
  // const Datawidget({super.key});

  // final String url;
  final int index;

  const DatawidgetBle({super.key, required this.index});

  @override
  State<DatawidgetBle> createState() => _DatawidgetStateBle();
}

// List<Widget> secondPageList = [];

class _DatawidgetStateBle extends State<DatawidgetBle> {
  bool status = true;
  // @override
  // void initState() {
  //   super.initState();
  //   get_api();
  //   timer = Timer.periodic(
  //       const Duration(seconds: 1),
  //       (_) => setState(() {
  //             dataFuture = get_api();

  //             // dataFuture = Get_api();
  //           }));
  // }

  // @override
  // void dispose() {
  //   timer?.cancel(); // Cancel the timer
  //   super.dispose();
  // }

  // void startget() {
  //   timer = Timer(
  //       Duration(seconds: 1),
  //       () => setState(() {
  //             dataFuture = fetchParallelData();
  //           }));
  // }

  @override
  Widget build(BuildContext context) {
    Stream<List> timerStream() async* {
      while (true) {
        await Future.delayed(Duration(seconds: 1));
        yield randomlist;
      }
    }

    return SafeArea(
      child: StreamBuilder(
          // HomeScreen.homeScreenKey.currentState?._changeTab(1);
          stream: timerStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List? checklenght = snapshot.data;
              if (checklenght!.isNotEmpty) {
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SfRadialGauge(
                              enableLoadingAnimation: true,
                              // animationDuration: 4500,
                              axes: <RadialAxis>[
                                RadialAxis(
                                    minimum: 0,
                                    maximum: 150,
                                    ranges: <GaugeRange>[
                                      GaugeRange(
                                          startValue: 0,
                                          endValue: 50,
                                          color: Colors.green,
                                          startWidth: 10,
                                          endWidth: 10),
                                      GaugeRange(
                                          startValue: 50,
                                          endValue: 100,
                                          color: Colors.orange,
                                          startWidth: 10,
                                          endWidth: 10),
                                      GaugeRange(
                                          startValue: 100,
                                          endValue: 150,
                                          color: Colors.red,
                                          startWidth: 10,
                                          endWidth: 10)
                                    ],
                                    pointers: <GaugePointer>[
                                      NeedlePointer(
                                          value: randomlist[widget.index]
                                              .toDouble()
                                          // 10
                                          // double.parse(
                                          //     jsonn[widget.index]["value"])
                                          ,
                                          enableAnimation: true,
                                          needleStartWidth: 0,
                                          needleEndWidth: 5,
                                          // needleColor: Color(0xFFDADADA),
                                          knobStyle: KnobStyle(
                                              // color: Colors.white,
                                              // borderColor: Color(0xFFDADADA),
                                              knobRadius: 0.06,
                                              borderWidth: 0.04),
                                          tailStyle: TailStyle(
                                              // color: Color(0xFFDADADA),
                                              width: 5,
                                              length: 0.15)),
                                      RangePointer(
                                        value:
                                            randomlist[widget.index].toDouble()
                                        // double.parse(
                                        //     jsonn[widget.index]["value"])
                                        ,
                                        // width: 30,
                                        enableAnimation: true,
                                        // color: Colors.black38,
                                        pointerOffset: -10,
                                        gradient: const SweepGradient(
                                            colors: <Color>[
                                              Color(0xFFCC2B5E),
                                              Color(0xFF753A88)
                                            ],
                                            stops: <double>[
                                              0.25,
                                              0.75
                                            ]),
                                      ),
                                      // WidgetPointer(
                                      //     value: 90,
                                      //     offset: -27,
                                      //     child: Container(
                                      //         height: 55,
                                      //         width: 60,
                                      //         decoration: BoxDecoration(
                                      //             color: Colors.white,
                                      //             borderRadius:
                                      //                 BorderRadius.circular(15),
                                      //             border: Border.all(
                                      //               color: Colors.black45,
                                      //               style: BorderStyle.solid,
                                      //               width: 1.0,
                                      //             )),
                                      //         child: Column(
                                      //           children: <Widget>[
                                      //             Container(
                                      //                 width: 40.00,
                                      //                 height: 30.00,
                                      //                 decoration: BoxDecoration(
                                      //                   image: DecorationImage(
                                      //                     image: ExactAssetImage(
                                      //                         'lib/all_asset/cpu.png'),
                                      //                     fit: BoxFit.fitHeight,
                                      //                   ),
                                      //                 )),
                                      //             Padding(
                                      //               padding: EdgeInsets.fromLTRB(
                                      //                   0, 2, 0, 0),
                                      //               child: Container(
                                      //                 child: Text('45°F',
                                      //                     style: TextStyle(
                                      //                         fontWeight:
                                      //                             FontWeight.bold,
                                      //                         fontSize: 15)),
                                      //               ),
                                      //             )
                                      //           ],
                                      //         )))
                                    ],
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                          widget: Container(
                                              child: Text(
                                                  '${randomlist[widget.index]}',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          angle: 90,
                                          positionFactor: 0.5)
                                    ])
                              ]),
                        ),

                        // Image.asset(
                        //   'lib/all_asset/cpu.png',
                        //   height: 100,
                        //   color: Colors.white,
                        // ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        Text("NAME : ${fakename[widget.index]}",
                            style: GoogleFonts.aDLaMDisplay(
                                fontSize: 15, color: Colors.white)),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        // Text(
                        //   "VALUE : ${jsonn[widget.index]["value"]}",
                        //   style: GoogleFonts.aDLaMDisplay(
                        //       fontSize: 15, color: Colors.white),
                        // ),
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
