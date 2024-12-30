import 'dart:io';

void interest(double p , double r, double t){
  double interest = (p * r * t ) / 100;
  stdout.write(interest);
}
 void main(){
  double p = double.parse(stdin.readLineSync()!);
  double r = double.parse(stdin.readLineSync()!);
  double t = double.parse(stdin.readLineSync()!);

  interest(p, r, t);
  // stdout.write(interest);

}