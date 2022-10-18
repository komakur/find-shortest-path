import 'package:webspark_test_project/models/cell.dart';
import 'package:analyzer_plugin/utilities/pair.dart';

abstract class Utility {
  static bool isValid(List<dynamic> scheme, Pair<int, int> point) {
    if (scheme.isNotEmpty && scheme.first.isNotEmpty) {
      return (point.first >= 0) &&
          (point.first < scheme.length) &&
          (point.last >= 0) &&
          (point.last < scheme.first.length);
    }
    return false;
  }

  static bool isUnblocked(List<dynamic> scheme, Pair<int, int> point) =>
      (isValid(scheme, point) && scheme[point.first][point.last] == '.') ||
      (isValid(scheme, point) && scheme[point.first][point.last] == 'S') ||
      (isValid(scheme, point) && scheme[point.first][point.last] == 'E');

  static bool isDestination(Pair<int, int> position, Pair<int, int> dest) =>
      position == dest;

  static double calculateHValue(Pair<int, int> src, Pair<int, int> dest) => 1;

  static List<Pair<int, int>> tracePath(
    List<List<Cell>> cellsScheme,
    Pair<int, int> start,
    Pair<int, int> dest,
  ) {
    List<Pair<int, int>> path = [];

    int row = dest.first;
    int col = dest.last;
    Pair<int, int> nextNode = cellsScheme[row][col].parent;

    do {
      path.insert(0, Pair(nextNode.first, nextNode.last));
      nextNode = cellsScheme[row][col].parent;
      row = nextNode.first;
      col = nextNode.last;
    } while (cellsScheme[row][col].parent != nextNode);
    path.removeLast();

    return path.toList();
  }

  static String replaceCharAt(String oldString, int index, String newChar) =>
      oldString.substring(0, index) + newChar + oldString.substring(index + 1);
}
