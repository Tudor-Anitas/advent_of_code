import 'dart:io';
import 'package:path/path.dart' as path;

void day3A() {
  // Get local path to the input text
  var filePath =
      path.join(Directory.current.path, 'lib', 'day3', 'day3_input.txt');
  File file = File(filePath);

  // Open the input file and storing it into a string
  String memory = file.readAsStringSync();
  int sumOfMult = 0;

  // use regex to find all the references from the memory
  var regex = RegExp(r"mul\(\d{1,3},\d{1,3}\)");
  List<RegExpMatch> multMatches = regex.allMatches(memory).toList(); 

  for(int i = 0; i < multMatches.length; i++){
    sumOfMult += convertMatchToMul(multMatches[i]);
  }
  print(sumOfMult);
}

int convertMatchToMul(RegExpMatch match) {
  // now we use regex again to find the numbers from the matches
  var numberRegex = RegExp(r"\d{1,3}");
  List<RegExpMatch> numbers = numberRegex.allMatches(match.group(0)!).toList();

  return int.parse(numbers[0].group(0)!) * int.parse(numbers[1].group(0)!);
}

// plan for the algorithm

// use the allMatches method to find all occurences
// for each match, check the match[0] (where the match starts)
// find the numbers from the match and multiply them
// add the result to a variable