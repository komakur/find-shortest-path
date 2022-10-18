import 'package:flutter/material.dart';
import 'package:webspark_test_project/view_models/field_list_view_model.dart';

class FieldTable extends StatelessWidget {
  final FieldViewModel field;

  const FieldTable({
    Key? key,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: field.fieldScheme.first.length,
        children: buildTableCells(field),
      ),
    );
  }
}

//function which returns list of container representing each cell of field
List<Container> buildTableCells(FieldViewModel field) {
  List<Container> containers = [];
  for (int i = 0; i < field.fieldScheme.length; i++) {
    for (int j = 0; j < field.fieldScheme[i].length; j++) {
      containers.add(
        Container(
          decoration: BoxDecoration(
            color: setColor(x: i, y: j, scheme: field.fieldScheme),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              '($j,$i)',
              style: TextStyle(
                  fontSize: 20.0,
                  color: field.fieldScheme[i][j] == 'X'
                      ? Colors.white
                      : Colors.black),
            ),
          ),
        ),
      );
    }
  }
  return containers;
}

//set color according to field scheme
Color setColor(
    {required int x, required int y, required List<dynamic> scheme}) {
  if (scheme[x][y] == 'S') {
    return const Color(0xFF64FFDA);
  }
  if (scheme[x][y] == 'E') {
    return const Color(0xFF009688);
  }
  if (scheme[x][y] == 'X') {
    return const Color(0xFF000000);
  }
  if (scheme[x][y] == 'P') {
    return const Color(0xFF4CAF50);
  }
  return const Color(0xFFFFFFFF);
}
