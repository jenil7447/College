import 'dart:io';

void main() {
  List<int> array = [1, 2, 4, 5];
  int element = 3;
  int position = 2;
  array.add(0);
  for (int i = array.length - 2; i >= position; i--) {
    array[i + 1] = array[i];
  }
  array[position] = element;

  print("Modified Array: $array");
}

// 0 1 2 3 4

