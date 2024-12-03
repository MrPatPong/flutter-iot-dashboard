import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/datawidget.dart';
import 'package:flutter_application_1/component/datawidget_ble.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/page_/home_page.dart';

class Bledatawid extends StatefulWidget {
  const Bledatawid({super.key});

  @override
  State<Bledatawid> createState() => _BledatawidState();
}

class _BledatawidState extends State<Bledatawid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: GridView.builder(
        itemCount: 1,

        // physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.2,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade500,
                    borderRadius: BorderRadius.circular(15)),
                child: DatawidgetBle(index: index)),
          );
        },
      ),
    );
  }
}
