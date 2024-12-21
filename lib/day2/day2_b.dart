import 'dart:io';

import 'package:path/path.dart' as path;

void day2B() {
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
    print('${correctedReports[index]} $nrValidReports');
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

int checkReportValidity(List<int> report) {
  int result = 0;

  result += checkIncompleteReport(report);

  for (int i = 0; i < report.length; i++) {
    List<int> tempList = List.from(report);
    tempList.removeAt(i);
    result += checkIncompleteReport(tempList);
  }

  return result > 0 ? 1 : 0;
}

int checkIncompleteReport(List<int> report) {
  bool isIncreasing = false;
  bool isDecresing = false;

  for (int index = 0; index < report.length - 1; index++) {
    if (diffIsWrong(report[index], report[index + 1]) ||
        (report[index] > report[index + 1] && isIncreasing)) {
      return 0;
    } else if (diffIsWrong(report[index], report[index + 1]) ||
        (report[index] < report[index + 1] && isDecresing)) {
      return 0;
    } else if (report[index] == report[index + 1]) {
      return 0;
    }
  }
  return 1;
}

bool diffIsWrong(int a, int b) {
  return (a - b).abs() > 3;
}
