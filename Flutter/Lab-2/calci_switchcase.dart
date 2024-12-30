import 'dart:io';

void main() {
  int num1 = int.parse(stdin.readLineSync()!);
  int num2 = int.parse(stdin.readLineSync()!);
  String ope = stdin.readLineSync()!;
  switch (ope) {
    case '+':
      print("Result = ${num1 + num2}");
      break;
    case '-':
      print("Result = ${num1 - num2}");
      break;
    case '*':
      print("Result = ${num1 * num2}");
      break;
    case '/':
      if (num2 != 0) {
        print("Result = ${num1 / num2}");
      } else {
        print("Error: Division by zero is not allowed.");
      }
      break;
    default:
      print("Invalid operator.");
  }
}
