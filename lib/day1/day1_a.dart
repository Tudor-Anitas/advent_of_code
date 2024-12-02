import 'dart:io';

import 'package:path/path.dart' as path;
import 'dart:core';

void day1() {
  // Get local path to the input text
  var filePath =
      path.join(Directory.current.path, 'lib', 'day1', 'day1_input.txt');
  File file = File(filePath);

  // Open the input file and storing it into a string
  String lists = file.readAsStringSync();

  // Separate each number into its own element into a list
  var mainList = lists.split('   ');
  List<int> list1 = [];
  List<int> list2 = [];

  // Populate the lists
  for (int i = 0; i < mainList.length; i++) {
    // split the double element, convert them to int and add to their list
    if (mainList[i].contains('\n')) {
      List<String> values = mainList[i].split('\n');
      // because the first element from **mainList** is a valid element
      // the lists are offset
      // and such, the first split element is to be added to **list2**
      // and the last is to be added to **list1**

      // use insertion sort to add the values to the right place inside the lists
      if (values.first != '') {
        insertionSort(int.parse(values.first), list2);
      }
      if (values.last != '') {
        insertionSort(int.parse(values.last), list1);
      }
    } else {
      // if the element is a single normal value, convert it to int
      // and add it to the list with the least of values
      list1.length > list2.length
          ? insertionSort(int.parse(mainList[i]), list2)
          : insertionSort(int.parse(mainList[i]), list1);
    }
  }

  print(calculateStars(list1, list2));
}

// Insert a new element into a list in a sorted manner
List<int> insertionSort(int elementToBeAdded, List<int> localList) {
  var min = 0;
  var max = localList.length;

  while (min < max) {
    // check if the number is bigger or smaller than the mid value of the already sorted array
    var mid = ((min + max) / 2).floor();
    if (elementToBeAdded < localList[mid]) {
      max = mid;
    } else {
      min = mid + 1;
    }
  }
  localList.insert(min, elementToBeAdded);
  return localList;
}

// Parse through the lists and add the differenece between the elements
int calculateStars(List<int> list1, List<int> list2) {
  int sum = 0;

  for (int index = 0; index < list1.length; index++) {
    sum += (list1[index] - list2[index]).abs();
  }
  return sum;
}
