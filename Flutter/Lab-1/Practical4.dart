import 'dart:io';
void main(){
  stdout.write("enter 5 sub marks");
  double sum=0;
  for(int i=0;i<5;i++){
      stdout.write("enter sub $i mark: ");
      int mark= int.parse(stdin.readLineSync()!);
      sum+=mark;
  }
  double percentage=(sum*100)/500;
  stdout.write("percentage is:$percentage");
}