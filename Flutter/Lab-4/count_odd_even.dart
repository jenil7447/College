//WAP to count number of even or odd number from an array of n numbers.
import 'dart:io';

void main(){
  print('Enter a length of array :');
  int n = int.parse(stdin.readLineSync()!);
  List<int> array = [];
  int evenCount = 0;
  int oddCount = 0;
  for(int i = 0 ; i < n ; i++){
    print('Enter number :');
    array.add(int.parse(stdin.readLineSync()!));
  }
  for( int i = 0 ; i < array.length ; i ++){
    if( array[i] % 2 == 0){
      evenCount ++;
    }
    if( array[i] % 2 != 0){
      oddCount ++;
    }
  }
  print(evenCount);
  print(oddCount);

}