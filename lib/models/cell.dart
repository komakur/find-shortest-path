import 'package:analyzer_plugin/utilities/pair.dart';

class Cell {
  Pair<int, int> parent;
  double f;
  double g;
  double h;
  //initial values of cell
  Cell()
      : parent = Pair(-1, -1),
        f = -1,
        g = -1,
        h = -1;
}
