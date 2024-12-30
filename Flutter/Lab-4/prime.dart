import 'dart:io';
void main(){
  int num = int.parse(stdin.readLineSync()!);

  if(isPrime(num)) stdout.write("It is prime number");
  else stdout.write('It is not a prime number');
}
bool isPrime(int num){
  if(num < 2) return false;

  for(int i = 2 ; i < num /2 ; i ++){
    if(num % 2 == 0) return false;
  }
  return true;
}