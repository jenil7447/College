import 'dart:io';
void main(){
  print('Enter Number:');
  int num = int.parse(stdin.readLineSync()!);
  if(num > 0){
    print('Entered num is positive');
  }
  else if(num < 0){
    print('Entered num is negative');
  }
  else {
    print('Entered num is zero');
  }
}