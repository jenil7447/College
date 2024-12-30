import 'dart:io';

void main(){
  List <int> list= [];
print('Enter 5 numbers:');
  for(int i = 0 ; i < 5 ; i++){
    stdout.write('Enter num ${i+1}:');
    int num = int.parse(stdin.readLineSync()!);
    list.add(num);
  }
  list.sort();
  print(list);

}