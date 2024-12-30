import 'dart:io';

void main() {
  print('Enter num1 :');
  int num1 = int.parse(stdin.readLineSync()!);
  print('Enter num2 :');
  int num2 = int.parse(stdin.readLineSync()!);
  print('Enter num3 :');
  int num3 = int.parse(stdin.readLineSync()!);

  if (num1 > num2) {
    if (num1 > num3) {
      print('Entered ${num1} is greatest');
    } else {
      print('Entered ${num3} is greatest');
    }
  } else {
    if (num2 > num3) {
      print('Entered ${num2} is greatest');
    } else {
      print('Entered ${num3} is greatest');
    }
  }
}
