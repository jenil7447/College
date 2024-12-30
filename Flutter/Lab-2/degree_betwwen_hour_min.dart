import 'dart:io';

void main(){
  stdout.write("Enter hour");
  int hour = int.parse(stdin.readLineSync()!);
  stdout.write("Enter minutes");
  int minutes = int.parse(stdin.readLineSync()!);

  double actualhour = (30 * hour) + ( 0.5 * minutes) ;// 360/12 = 30  // 30/60 = 0.5 // 360/ 60 = 6
  int actualminutes = 6 * minutes;

  double degree = (actualhour - actualminutes).abs();
  print(degree);

}
