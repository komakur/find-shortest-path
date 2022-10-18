import 'package:collection/collection.dart';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:flutter/foundation.dart';
import 'package:webspark_test_project/utilities/utility.dart';
import 'package:webspark_test_project/models/cell.dart';
import 'package:tuple/tuple.dart';
import 'package:webspark_test_project/models/field.dart';

typedef Tuple = Tuple3<double, int, int>;

class SearchAlgorithm extends ChangeNotifier {
  late double progress = 0;
  static int mainTotalIterations = 0;
  static int mainCurrentIteration = 0;

  void aStarSearch(Field field, int fieldsLength) {
    List<dynamic> scheme = field.fieldScheme;
    Pair<int, int> src = field.start;
    Pair<int, int> dest = field.end;
    if (!Utility.isValid(scheme, src)) {
      throw Exception('Source is invalid');
    }
    if (!Utility.isValid(scheme, dest)) {
      throw Exception('Destination is invalid');
    }
    if (!Utility.isUnblocked(scheme, src) ||
        !Utility.isUnblocked(scheme, dest)) {
      throw Exception('Source destination is blocked');
    }
    if (Utility.isDestination(src, dest)) {
      throw Exception('You are already at the destination');
    }
    List<List<bool>> closedList = List.generate(scheme.length,
        (index) => List.generate(scheme.first.length, (index) => false));
    List<List<Cell>> cellDetails = List.generate(scheme.length,
        (index) => List.generate(scheme.first.length, (index) => Cell()));

    int i, j;
    i = src.first;
    j = src.last;

    cellDetails[i][j].f = 0.0;
    cellDetails[i][j].g = 0.0;
    cellDetails[i][j].h = 0.0;
    cellDetails[i][j].parent = Pair(i, j);
    //lexicographic ordered queue [ (0,1,1), (0,0,0), (1,1,0), (0,0,1) ] => [ (0,0,0), (0,0,1), (0,1,1), (1,1,0) ]
    PriorityQueue<Tuple> openList = PriorityQueue<Tuple>((a, b) {
      return a.item1 > b.item1
          ? 1
          : a.item1 < b.item1
              ? -1
              : a.item2 > b.item2
                  ? 1
                  : a.item2 < b.item2
                      ? -1
                      : a.item3 > b.item3
                          ? 1
                          : a.item3 < b.item3
                              ? -1
                              : 0;
    });
    openList.add(Tuple(0.0, i, j));

    while (openList.isNotEmpty) {
      final Tuple p = openList.first;
      i = p.item2;
      j = p.item3;

      openList.removeFirst();
      closedList[i][j] = true;

      for (int addX = -1; addX <= 1; addX++) {
        for (int addY = -1; addY <= 1; addY++) {
          Pair<int, int> neighbour = Pair(i + addX, j + addY);
          if (Utility.isValid(scheme, neighbour)) {
            if (Utility.isDestination(neighbour, dest)) {
              cellDetails[neighbour.first][neighbour.last].parent = Pair(i, j);

              List<Pair<int, int>> path =
                  Utility.tracePath(cellDetails, field.start, field.end);
              //adding path to scheme for proper rendering
              for (int i = 0; i < path.length; i++) {
                field.fieldScheme[path[i].last] = Utility.replaceCharAt(
                    field.fieldScheme[path[i].last], path[i].first, 'P');
              }

              path.insert(0, field.start);
              path.add(field.end);
              field.path = path;

              mainTotalIterations = fieldsLength;
              mainCurrentIteration++;
              progress = 100 * (mainCurrentIteration / mainTotalIterations);
              notifyListeners();
            } else if (!closedList[neighbour.first][neighbour.last] &&
                Utility.isUnblocked(scheme, neighbour)) {
              double gNew, hNew, fNew;
              gNew = cellDetails[i][j].g + 1.0;
              hNew = Utility.calculateHValue(neighbour, dest);
              fNew = gNew + hNew;
              if (cellDetails[neighbour.first][neighbour.last].f == -1 ||
                  cellDetails[neighbour.first][neighbour.last].f > fNew) {
                openList.add(Tuple(fNew, neighbour.first, neighbour.last));
                cellDetails[neighbour.first][neighbour.last].g = gNew;
                cellDetails[neighbour.first][neighbour.last].h = hNew;
                cellDetails[neighbour.first][neighbour.last].f = fNew;
                cellDetails[neighbour.first][neighbour.last].parent =
                    Pair(i, j);
              }
            }
          }
        }
      }
    }
  }
}
