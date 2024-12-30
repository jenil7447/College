import 'dart:io';
void main(){
  stdout.write("enter your weight in pound:");
  double weight=double.parse(stdin.readLineSync()!)* 0.45359237;
  stdout.write("enter your height in inch:");
  double height=double.parse(stdin.readLineSync()!)* 0.0254;
  double bmi=weight/(height*height);
  stdout.write("bmi is:$bmi");
}