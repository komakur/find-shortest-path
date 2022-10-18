import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:flutter/material.dart';
import 'package:webspark_test_project/models/field.dart';

class FieldListViewModel extends ChangeNotifier {
  List<FieldViewModel> fields = [];
  FieldListViewModel({required this.fields});

  factory FieldListViewModel.fromFieldsList(List<Field> actualFields) {
    final List<FieldViewModel> fields = actualFields
        .map((field) => FieldViewModel(
              fieldScheme: field.fieldScheme,
              start: field.start,
              end: field.end,
              path: field.pathToString(),
            ))
        .toList();
    return FieldListViewModel(fields: fields);
  }
}

class FieldViewModel {
  final List<dynamic> fieldScheme;
  final Pair<int, int> start;
  final Pair<int, int> end;
  String path = '';
  FieldViewModel({
    required this.fieldScheme,
    required this.start,
    required this.end,
    required this.path,
  });
}
