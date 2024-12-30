import 'dart:io';

void main(){
  stdout.write("Enter a string");
  String str = stdin.readLineSync()!;
  String result = "";
  String ans ="";
  for(int i = str.length -1  ; i > 0 ; i--){
    if(str[i] == " "){
      break;
    }
    result += str[i];
  }
  for(int i = result.length-1; i >= 0; i--){
    ans+= result[i];
  }
  print(ans);
}