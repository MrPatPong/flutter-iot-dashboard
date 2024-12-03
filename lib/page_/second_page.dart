import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/component/bar_graph.dart';
import 'package:flutter_application_1/component/datawidget.dart';
import 'package:flutter_application_1/component/datawidget_mqtt.dart';
import 'package:flutter_application_1/grindwid/httpalldatawid.dart';
import 'package:flutter_application_1/page_/home_page.dart';
import 'package:flutter_application_1/protocal/http_api.dart';

class second_page extends StatefulWidget {
  // const second_page({super.key});
  // final String url;
  final int index;
  const second_page(this.index, {super.key});

  @override
  State<second_page> createState() => _second_pageState();
}

class _second_pageState extends State<second_page> {
  @override
  void initState() {
    super.initState();
    get_api();
    timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => setState(() {
              dataFuture = get_api();

              // dataFuture = Get_api();
            }));
  }

  // @override
  // Void dispose() {
  //   Datawidget(widget.url).cancel();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // barchart.clear();
    // for (var i = 0; i < inUrl.length; i++) {
    //   barchart.add(mybar_graph(widget.index));
    // }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 54, 51, 51),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => setState(() {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ));
                      }),
                  icon: const Icon(Icons.backspace))
            ],
          ),
          Column(
            children: [
              Container(
                  width: 200,
                  height: 200,
                  // color: Colors.black,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade500,
                      borderRadius: BorderRadius.circular(15)),
                  child: Datawidget(index: widget.index)),
              SizedBox(
                height: 100,
              ),
              SizedBox(height: 250, child: mybar_graph(index: widget.index)),
            ],
          ),
        ],
      )),
    );
  }
}
