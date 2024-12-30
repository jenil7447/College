import 'dart:io';

void main(){
  int num = int.parse(stdin.readLineSync()!);
  int sum = 0 ;
  while(num != 0){
    int remainder = num % 10;
    sum = sum * 10 + remainder ;
    num = num ~/ 10;
  }
  print(sum);

}


