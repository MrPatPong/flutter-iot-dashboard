import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/protocal/http_api.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int showingTooltip;

  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
  }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: showingTooltip == x ? [0] : [],
      barRods: [
        BarChartRodData(toY: y.toDouble()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: AspectRatio(
            aspectRatio: 2,
            child: BarChart(
              BarChartData(
                barGroups: [
                  generateGroupData(1, alldatas[0][0].value),
                  generateGroupData(2, 18),
                  generateGroupData(3, 4),
                  generateGroupData(4, 11),
                  generateGroupData(5, 18),
                  generateGroupData(6, 4),
                  generateGroupData(7, 11),
                ],
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}









// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter_application_1/protocal/http_api.dart';

// // class DataPoint {
// //   // final String category; // e.g., "Male", "Female"
// //   final double value;

// //   DataPoint(this.value);
// // }

// Map<int, List<datastore>> groupedData = {
//   // 0: [
//   //   DataPoint(5),
//   // ],
//   // 1: [
//   //   DataPoint(5),
//   // ],
// // .....
// };

// class MyBarChart extends StatelessWidget {
//   // final Map<int, List<DataPoint>> groupedData;

//   const MyBarChart({super.key});

//   List<BarChartGroupData> barGroups() {
//     return groupedData.entries.map((entry) {
//       return BarChartGroupData(
//         x: entry.key, // Use category as x-axis value
//         // barsSpace: 4,
//         barRods: entry.value.map((datastore) {
//           return BarChartRodData(
//               toY: datastore.value.toDouble(),
//               color: Colors.grey[800],
//               width: 20,
//               borderRadius: BorderRadius.circular(3),
//               backDrawRodData: BackgroundBarChartRodData(
//                   show: true, toY: 10, color: Colors.white));
//         }).toList(),
//         showingTooltipIndicators: [0], // Show tooltip for the first bar
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // groupedData.update(0, (value) =>);
//     inUrl.add("http://192.168.1.135:8080/data1/6688f54128c227d4a062b59a");

//     for (var i = 0; i < datas.length; i++) {
//       groupedData.addAll({
//         i: alldatas[0][i],
//       });
//     }

//     print(groupedData);

//     print(groupedData);
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       body: SafeArea(
//         child: Center(
//           child: BarChart(
//             BarChartData(
//               maxY: 25,
//               minY: 0,
//               gridData: FlGridData(show: false),
//               borderData: FlBorderData(show: false),
//               titlesData: const FlTitlesData(
//                 show: true,
//                 topTitles:
//                     AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 leftTitles:
//                     AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 rightTitles:
//                     AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     getTitlesWidget: getBottomTitles,
//                     reservedSize: 50,
//                   ),
//                 ),
//               ),
//               barGroups: barGroups(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget getBottomTitles(double value, TitleMeta meta) {
//   const style = TextStyle(
//     color: Color.fromRGBO(66, 66, 66, 1),
//     fontSize: 15,
//     fontWeight: FontWeight.bold,
//   );

//   Widget text;
//   switch (value.toInt()) {
//     case 0:
//       text = const Text(
//         'Mon',
//         style: style,
//       );
//       break;
//     case 1:
//       text = const Text(
//         'Tue',
//         style: style,
//       );
//       break;
//     case 2:
//       text = const Text(
//         'Wed',
//         style: style,
//       );
//       break;
//     case 3:
//       text = const Text(
//         'Thu',
//         style: style,
//       );
//       break;
//     case 4:
//       text = const Text(
//         'fri',
//         style: style,
//       );
//       break;
//     case 5:
//       text = const Text(
//         'Sat',
//         style: style,
//       );
//       break;
//     case 6:
//       text = const Text(
//         'Sun',
//         style: style,
//       );
//       break;
//     default:
//       text = const Text(
//         '',
//         style: style,
//       );
//       break;
//   }
//   return SideTitleWidget(
//     axisSide: meta.axisSide,
//     child: text,
//   );
// }
