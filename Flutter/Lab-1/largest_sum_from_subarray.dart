import 'dart:math';

void main() {
  List<int> array = [-2, 1, -3, 4, -1, 2, 1, -5, 4];
  int currentSum = 0;
  int maxSum = array[0];

  for (int i = 0; i < array.length; i++) {
    currentSum += array[i];
    maxSum = max(maxSum, currentSum);
    if (currentSum < 0) {
      currentSum = 0;
    }
  }
  print(maxSum);
}
