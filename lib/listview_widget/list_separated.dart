import 'package:flutter/material.dart';

class ListSeparatedWidget extends StatelessWidget {
  const ListSeparatedWidget({super.key});

  static const partai = ["Golongan Karya", "PDI Perjuangan", "Demokrat", "PKB"];
  static const partaiColour = [
    Colors.amber,
    Colors.red,
    Colors.blue,
    Colors.green,
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: partai.length,
      itemBuilder: (context, index) {
        return Container(
          height: 400,
          color: partaiColour[index],
          child: Center(child: Text(partai[index].toString())),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.black,
          height: 10,
          radius: BorderRadius.circular(10),
          indent: 90,
          endIndent: 90,
        );
      },
    );
  }
}
