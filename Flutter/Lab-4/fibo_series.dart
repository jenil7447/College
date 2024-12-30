import 'dart:io';

void main(){
  print('Enter how long you want a series :');
  int n = int.parse(stdin.readLineSync()!);

  print(fibo(n));
}

int fibo(int n){
  if(n < 0) return -1;
  if ( n < 2) return n;
  return fibo(n-1) + fibo(n-2);
}