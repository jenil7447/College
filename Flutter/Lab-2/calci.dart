import 'dart:io';

void main(){
  print('Enter two number:');
  int num1 = int.parse(stdin.readLineSync()!);
  int num2 = int.parse(stdin.readLineSync()!);
  print("Enter which operation you want to persfor (+,-,*,/):");
  String oper = stdin.readLineSync()!;
  if(oper == '+') print("Result = ${num1 + num2}");
  else if(oper == '-') print("Result = ${num1 - num2}");
  else if(oper == '*')print("Result = ${num1 * num2}");
  else if(oper == '/')print("Result = ${num1 / num2}");
  else print("Entered a valid Operator");
}