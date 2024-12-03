// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/datawidget_mqtt.dart';
// import 'package:flutter_application_1/component/datawidget.dart';
import 'package:flutter_application_1/grindwid/httpalldatawid.dart';
// import 'package:flutter_application_1/page_/second_page.dart';
import 'package:flutter_application_1/protocal/http_api.dart';
import 'package:fl_chart/fl_chart.dart';
// import 'package:google_fonts/google_fonts.dart';

class mybar_graph extends StatefulWidget {
  // const mybar_graph({super.key});
  // final String url;
  final int index;
  const mybar_graph({super.key, required this.index});

  @override
  State<mybar_graph> createState() => _mybar_graphState();
}

// class Count {
//   final int x;
//   Count({
//     required this.x,
//   });
// }

// List<Count> countdate = [];
// var contt;

//   for (var eachdata in contt) {
//     final data = datastore(
//       value: eachdata["value"],
//       time: eachdata["time"],
//       date: eachdata["date"],
//     );

//     datas.add(data);

// Map<int, List<datastore>> groupdata = {
//   // 0: [
//   //   DataPoint(5),
//   // ],
//   // 1: [
//   //   DataPoint(5),
//   // ],
//   // ....
// };

Map<int, List<datastore>> groupedData = {
  // 0: [
  //   DataPoint(5),
  // ],
  // 1: [
  //   DataPoint(5),
  // ],
// .....
};

late List<BarChartGroupData> mapList = [];

// late List<Widget> barchart = [];

// final maplistMap = mapList.asMap();

class _mybar_graphState extends State<mybar_graph> {
  late int showingTooltip;

  @override
  void initState() {
    super.initState();
    showingTooltip = -1;
    // timer = Timer.periodic(
    //     const Duration(seconds: 1),
    //     (_) => setState(() {
    //           dataFuture = Get_api();
    //           // dataFuture = Json[widget.index];
    //           // dataFuture = Get_api();
    //         }));
  }

  // @override
  // void initState() {
  //   super.initState();
  //   timer = Timer.periodic(Duration(seconds: 1), (_) => setState(() {}));
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
  //             // dataFuture = Get_api(widget.url);
  //           }));
  // }

  // List<BarChartGroupData> allbarGroups() {
  //   return groupdata.entries.map((entry) {
  //     return BarChartGroupData(
  //       x: entry.key, // Use category as x-axis value
  //       // barsSpace: 4,
  //       barRods: entry.value.map((datastore) {
  //         return BarChartRodData(
  //             toY: datastore.value.toDouble(),
  //             color: Colors.grey[800],
  //             width: 20,
  //             borderRadius: BorderRadius.circular(3),
  //             backDrawRodData: BackgroundBarChartRodData(
  //                 show: true, toY: 10, color: Colors.white));
  //       }).toList(),
  //       showingTooltipIndicators: [0], // Show tooltip for the first bar
  //     );
  //   }).toList();
  // }

  // List<BarChartGroupData> barGroups() {
  //   return groupedData.entries.map((entry) {
  //     return BarChartGroupData(
  //       x: entry.key, // Use category as x-axis value
  //       // barsSpace: 4,
  //       barRods: entry.value.map((datastore1) {
  //         return BarChartRodData(
  //             toY: datastore1.value.toDouble(),
  //             color: Colors.grey[800],
  //             width: 20,
  //             borderRadius: BorderRadius.circular(3),
  //             backDrawRodData: BackgroundBarChartRodData(
  //                 show: true, toY: 10, color: Colors.white));
  //       }).toList(),
  //       showingTooltipIndicators: [1], // Show tooltip for the first bar
  //     );
  //   }).toList();
  // }

  // void addchart() {
  //   groupedData.clear();
  //   for (var i = 0; i < datas.length; i++) {
  //     groupedData.addAll({
  //       i: [alldatas[widget.index][i]],
  //     });
  //   }
  //   mapList.add(groupedData);
  // }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: showingTooltip == x ? [0] : [],
      barRods: [
        BarChartRodData(
            toY: y.toDouble(),
            color: Colors.grey[800],
            width: 20,
            borderRadius: BorderRadius.circular(3),
            backDrawRodData: BackgroundBarChartRodData(
                show: true, toY: 20, color: Colors.white)),
      ],
    );
  }

  // void addchart() {
  //   mapList.clear();
  //   for (var i = 0; i < jsonn[widget.index]["datastore"].length; i++) {
  //     mapList.add(
  //         generateGroupData(i, jsonn[widget.index]["datastore"][i]["value"]));
  //   }
  // }

  void addchart() {
    mapList.clear();

    if (jsonn[widget.index]["datastore"].length < 7) {
      for (var i = 0; i < jsonn[widget.index]["datastore"].length; i++) {
        mapList.add(
            generateGroupData(i, jsonn[widget.index]["datastore"][i]["value"]));
      }
      for (var i = jsonn[widget.index]["datastore"].length; i < 7; i++) {
        mapList.add(generateGroupData(i, 0));
      }
    } else {
      for (var i = 0; i < jsonn[widget.index]["datastore"].length; i++) {
        mapList.add(
            generateGroupData(i, jsonn[widget.index]["datastore"][i]["value"]));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    addchart();

    return FutureBuilder(
        future: dataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BarChart(BarChartData(
              maxY: 20,
              minY: 0,
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: const FlTitlesData(
                show: true,
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: getBottomTitles,
                    reservedSize: 35,
                  ),
                ),
              ),
              barGroups: mapList
              // [mapList[widget.index]]
              // [
              // BarChartGroupData(x: 0, barRods: [
              //   BarChartRodData(toY: jsonn[widget.index]["value"].toDouble())
              // ]),
              // BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 10)]),
              // BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 10)]),
              // generateGroupData(0, jsonn[1]["value"]),
              // generateGroupData(1, alldatas[widget.index][1].value),
              // generateGroupData(2, alldatas[widget.index][2].value ?? 0),
              // generateGroupData(3, alldatas[widget.index][3].value ?? 0),
              // generateGroupData(4, alldatas[widget.index][4].value ?? 0),
              // generateGroupData(5, alldatas[widget.index][5].value ?? 0),
              // generateGroupData(6, alldatas[widget.index][6].value ?? 0),
              // ]
              ,
              barTouchData: BarTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchCallback: (event, response) {
                    if (response != null &&
                        response.spot != null &&
                        event is FlTapUpEvent) {
                      setState(() {
                        final x = response.spot!.touchedBarGroup.x;
                        final isShowing = showingTooltip == x;
                        if (isShowing) {
                          showingTooltip = -1;
                        } else {
                          showingTooltip = x;
                        }
                      });
                    }
                  },
                  mouseCursorResolver: (event, response) {
                    return response == null || response.spot == null
                        ? MouseCursor.defer
                        : SystemMouseCursors.click;
                  }),

              //   datas
              // .map(
              //   (data) => BarChartGroupData(
              //     x: data.date.length,
              //     barRods: [
              //       BarChartRodData(
              //           toY: data.value.toDouble(),
              //           color: Colors.grey[800],
              //           width: 15,
              //           borderRadius: BorderRadius.circular(3),
              //           backDrawRodData: BackgroundBarChartRodData(
              //               show: true, toY: 20, color: Colors.white))
              //     ],
              //   ),
              // )
              // .toList(),
            ));
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
        });
  }
}

// SideTitles _bottomTitles() {
//   return SideTitles(
//     showTitles: true,
//     interval: 1,
//     getTitlesWidget: (value, meta) {
//       var date = value.toInt() < datas.length ? datas[value.toInt()].date : "";
//       return SideTitleWidget(
//           axisSide: meta.axisSide,
//           child: Text(
//             date,
//             style: const TextStyle(color: Colors.white),
//           ));
//     },
//   );
// }

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'Mon',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'Tue',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'Wed',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'Thu',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'fri',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'Sat',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'Sun',
        style: style,
      );
      break;
    default:
      text = const Text(
        '',
        style: style,
      );
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}
