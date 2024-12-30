import 'dart:io';

    void main(){
      print('Enter Marks  of five subjects:');
      int Marks1 = int.parse(stdin.readLineSync()!);
      int Marks2 = int.parse(stdin.readLineSync()!);
      int Marks3 = int.parse(stdin.readLineSync()!);
      int Marks4 = int.parse(stdin.readLineSync()!);
      int Marks5 = int.parse(stdin.readLineSync()!);

      double percentage = (Marks1 + Marks2 + Marks3 + Marks4 + Marks5)/5;

      if(percentage < 35 ) print('Student is failed');
      else if(percentage < 45) print('Student is pass');
      else if(percentage < 60)print('Student in Secound');
      else if(percentage < 70)print('Student in first');
      else (" Student in Distinction");

    }