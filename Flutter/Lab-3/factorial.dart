import 'dart:io';
void main() {
  int num = int.parse(stdin.readLineSync()!);
  int factorial = 1;
  for(int i = 1 ; i <= num ; i++){
    factorial *= i;
  }
  print(factorial);
}
