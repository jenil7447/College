import 'dart:io';

void main() {
  List<int> list1 = [];
  List<int> list2 = [];
  List<int> ans = [];

  print("Enter 5 numbers for the first list:");
  for (int i = 0; i < 5; i++) {
    stdout.write('Enter num ${i + 1}: ');
    int num = int.parse(stdin.readLineSync()!);
    list1.add(num);
  }

  print("\nEnter 5 numbers for the second list:");
  for (int i = 0; i < 5; i++) {
    stdout.write('Enter num ${i + 1}: ');
    int num = int.parse(stdin.readLineSync()!);
    list2.add(num);
  }
  for (int i = 0; i < list1.length; i++) {
    if (list2.contains(list1[i])) {
      ans.add(list1[i]);
    }
  }

  print("\nCommon elements between the two lists: $ans");
}
