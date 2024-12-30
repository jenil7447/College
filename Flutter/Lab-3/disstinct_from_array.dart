import 'dart:io';

void main(){
  List<int> array =[4, 1, 2, 1, 2];
  int result = array[0];
  for(int i = 1; i < array.length ; i++){
    result  = result ^ array[i]; // XOR gate
  }
  print(result);
}