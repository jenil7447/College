import 'dart:io';
void main(){
  stdout.write("enter value in fahrenheit:");
  double f =double.parse(stdin.readLineSync()!);
  double c= ((f-32)*5/9);
  stdout.write("fahrenheit into celsius is:$c");
}