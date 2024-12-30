import 'dart:io';

void main(){
  String str = stdin.readLineSync()!;
  String reversed = str.split('').reversed.join('');
  stdout.write(reversed);
}






















// import 'dart:io';
//
// void main() {
//   // Read input number as a string
//   String numString = stdin.readLineSync()!;
//
//   // Reverse the string
//   String reversedString = numString.split('').reversed.join('');
//
//   // Print the reversed string
//   print(reversedString);
// }
