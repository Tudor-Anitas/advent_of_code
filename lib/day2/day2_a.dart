import 'dart:io';

import 'package:path/path.dart' as path;

void day2A() {
  // Get local path to the input text
  var filePath =
      path.join(Directory.current.path, 'lib', 'day2', 'day2_input.txt');
  File file = File(filePath);

  // Open the input file and storing it into a string
  String reports = file.readAsStringSync();

  List<List<int>> correctedReports = separateRowsAndConvert(reports);

  int nrValidReports = 0;
  for (int index = 0; index < correctedReports.length; index++) {
    nrValidReports += checkReportValidity(correctedReports.elementAt(index));
    
  }
  print(nrValidReports);
}

/// Takes the txt input, separates each report to a line and convert
/// the strings from the report to int
List<List<int>> separateRowsAndConvert(String txtInput) {
  // first we split each report into a element in a list
  List<String> separatedReports = txtInput.split('\n');
  // after, we can convert each element from every report to int
  List<List<int>> correctedReports = [];
  for (int index = 0; index < separatedReports.length; index++) {
    // separate each element and convert them to int
    correctedReports.add(separatedReports
        .elementAt(index)
        .split(' ')
        .map((element) => int.parse(element))
        .toList());
  }

  return correctedReports;
}

/// Takes a report as input and checks for all numbers to respect this scenarios:
/// 1. to either be **all increasing** or **all decreasing**
/// 2. any 2 adjacent numbers differ by **at least 1** and **at most 3**
int checkReportValidity(List<int> report) {
  bool isDesc = false;
  bool isInc = false;
  for (int index = 0; index < report.length - 1; index++) {
    // element from the left is smaller than the element from the right
    if (report[index] < report[index + 1]) {
      // if the difference between elements is bigger than 3
      // or if the report is already decreasing exit the loop
      // the report is unsafe
      if ((report[index] - report[index + 1]).abs() > 3 || isDesc) {
        return 0;
      } else {
        // the adjacent numbers respect the rules, let the loop continue
        isInc = true;
      }
    } else if (report[index] > report[index + 1]) {
      if ((report[index] - report[index + 1]).abs() > 3 || isInc) {
        return 0;
      } else {
        isDesc = true;
      }
    } else {
      return 0;
    }
  }
  return 1;
}
