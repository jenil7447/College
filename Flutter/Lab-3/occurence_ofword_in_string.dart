import 'dart:io';

void main() {
  String str = "this is a test this is a";
  List<String> words = str.split(' ');
  Map<String, int> wordCountMap = {};
  for (String word in words) {
    if (wordCountMap.containsKey(word)) {
      wordCountMap[word] = wordCountMap[word]! + 1;
    } else {
      wordCountMap[word] = 1;
    }
  }
  print(wordCountMap);
}