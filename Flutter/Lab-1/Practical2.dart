import 'dart:io';

void main(){
   stdout.write("enter number 1:");
   int num1= int.parse(stdin.readLineSync()!);
   stdout.write("enter number 2:");
   int num2= int.parse(stdin.readLineSync()!);
   stdout.write("addition of 2 numbers is:${num1+num2}");
}