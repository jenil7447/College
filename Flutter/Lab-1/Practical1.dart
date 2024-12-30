import 'dart:io';

void main(){
  stdout.write("enter your name:");
  String str=stdin.readLineSync()!;
  stdout.write(str);
}