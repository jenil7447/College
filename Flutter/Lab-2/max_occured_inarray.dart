import 'dart:io';
import 'dart:math';

void main(){
  List<int> array = [3, 2, 3];
  array.sort();
  int count = 0;
  int setvalue = array[0];
  int maxcount = 1;
  for(int i = 0; i < array.length ; i++){
    if( array[i] == setvalue){
      count = count + 1;
    }
    maxcount = max(maxcount,count);
    if(array[i]!= setvalue){
      setvalue = array[i];
      count = 1;
    }
  }
  print(maxcount);
}