import 'dart:io';

void main(){
  int num1 = int.parse(stdin.readLineSync()!);
  int num2 = int.parse(stdin.readLineSync()!);

  for(int i = num1 ; i < num2 ; i++){
    if(i % 2 == 0 && i%3!=0){
      print(i);
    }
  }
}