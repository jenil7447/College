import 'dart:io';

void main(){
  stdout.write("Enter a number");
  int num = int.parse(stdin.readLineSync()!);
  for(int i = 2 ; i <= num ; i++){
    if(num % i == 0){
      if(isprime(i)){
        if(i!=2 && i!=3 && i!=5){
          print("false");
          return;
        }
      }
    }
  }
  print("true");
}
bool isprime(int num){
  if(num < 2) return false;
  for(int i = 2; i < num ;i++){
    if(num % i == 0) return false;
  }
  return true;
}