import 'dart:io';
 void main(){
   stdout.write("enter number in meter:");
   double meter=double.parse(stdin.readLineSync()!);
   double feet= meter *3.28;
   stdout.write(feet);
 }