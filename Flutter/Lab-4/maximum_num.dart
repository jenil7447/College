import 'dart:io';

void main(){
  int num1 = int.parse(stdin.readLineSync()!);
  int num2 = int.parse(stdin.readLineSync()!);
  maxNum(num1,num2);
}
void maxNum(int num1, int num2){
    if(num1 > num2) stdout.write('${num1} is large');
    else stdout.write('${num2} is large');
}