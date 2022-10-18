import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:flutter/foundation.dart';
import 'package:webspark_test_project/utilities/utility.dart';

class Field extends ChangeNotifier {
  final String _id;
  final Pair<int, int> start;
  final Pair<int, int> end;
  final List<dynamic> fieldScheme;
  List<Pair> path = [];

  Field(
    this._id, {
    required this.fieldScheme,
    required this.start,
    required this.end,
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    final String id = json['id'];
    Map<String, dynamic> start = json['start'];
    Pair<int, int> startCoordinates = Pair(start['x'], start['y']);

    Map<String, dynamic> end = json['end'];
    Pair<int, int> endCoordinates = Pair(end['x'], end['y']);

    json['field'][start['y']] =
        Utility.replaceCharAt(json['field'][start['y']], start['x'], 'S');

    json['field'][end['y']] =
        Utility.replaceCharAt(json['field'][end['y']], end['x'], 'E');

    return Field(
      id,
      fieldScheme: json['field'],
      start: startCoordinates,
      end: endCoordinates,
    );
  }

  Map<String, dynamic> toMyJson() =>
      {'id': _id, 'fieldScheme': fieldScheme, 'start': start, 'end': end};

  String pathToString() {
    return path.join('->');
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'result': {
          'steps': pathToMap(),
          'path': pathToString(),
        },
      };
  List<Map<String, String>> pathToMap() => path
      .map<Map<String, String>>((e) => {
            'x': e.first.toString(),
            'y': e.last.toString(),
          })
      .toList();
}
