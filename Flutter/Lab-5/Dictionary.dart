import 'dart:io';

void main(){
  Map<String,String> phoneBook = {};
  print('How many contacts you want to add :');
  int count = int.parse(stdin.readLineSync()!);
  for(int i = 0 ; i < count ; i++) {
    print("Enter a Name:");
    String name = stdin.readLineSync()!;
    stdout.write("Enter phone number for $name: ");
    String phoneNumber = stdin.readLineSync()!;
    phoneBook[name] = phoneNumber;
    print(phoneBook);
  }

}