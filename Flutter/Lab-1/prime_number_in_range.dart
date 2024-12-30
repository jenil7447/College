import 'dart:io';

void main(){
  stdout.write("Give starting point of range");
  int start = int.parse(stdin.readLineSync()!);
  stdout.write("Give Ending point of range");
  int end = int.parse(stdin.readLineSync()!);
  for(int i = start + 1 ; i < end ; i++){
    if(isprime(i)){
      print(i);
    }
  }
}
bool isprime(int num){
  if(num < 2) return false;
  for(int i = 2; i < num ;i++){
    if(num % i == 0) return false;
  }
  return true;
}