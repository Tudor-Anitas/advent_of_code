import 'dart:io';
import 'package:path/path.dart' as path;

void day1B() {
  // Get local path to the input text
  var filePath =
      path.join(Directory.current.path, 'lib', 'day1', 'day1_input.txt');
  File file = File(filePath);

  // Open the input file and storing it into a string
  String lists = file.readAsStringSync();

  // Separate each number into its own element into a list
  var mainList = lists.split('   ');
  // the left column of the input
  List<int> listLeft = [];
  // The right column of the input stored as a map for faster access
  Map<int, int> mapRight = {};

  for (int index = 0; index < mainList.length; index++) {
    // split the double element, convert them to int and add to their list
    if (mainList[index].contains('\n')) {
      List<String> values = mainList[index].split('\n');

      // because the first element from **mainList** is a valid element
      // the lists are offset
      // and such, the first split element is to be added to **mapRight**
      // and the last is to be added to **listLeft**
      if (values.first != '') {
        int value = int.parse(values.first);
        mapRight[value] = mapRight[value] != null ? mapRight[value]! + 1 : 1;
      }
      if (values.last != '') {
        int value = int.parse(values.last);
        listLeft.add(value);
      }
    } else {
      // if the element is a single normal value, convert it to int
      // and add it to the list with the least of values
      int value = int.parse(mainList[index]);
      listLeft.length > mapRight.length
          ? mapRight[value] = mapRight[value] != null ? mapRight[value]! + 1 : 1
          : listLeft.add(value);
    }
  }

  print(calculateReferences(listLeft, mapRight));
}

int calculateReferences(List<int> list, Map<int, int> map) {
  int sum = 0;

  for (int index = 0; index < list.length; index++) {
    // multiply the value (list[index]) by the number of refrences in the map
    // and add it to the sum
    int currentValue = list[index];
    sum += (map[currentValue] != null ? map[currentValue]! : 0) * currentValue;
  }

  return sum;
}
