// main.dart
import 'dart:io';
import 'crud.dart';
import 'constant.dart';

void main() {
  User user = User();

  int choice;
  do {
    print('Select Your Choice From Below Available Options:'
        '\n1. Insert User'
        '\n2. List User'
        '\n3. Update User'
        '\n4. Delete User'
        '\n5. Search User'
        '\n6. Exit Application');

    choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        stdout.write('Enter Name: ');
        String name = stdin.readLineSync()!;
        stdout.write('Enter Age: ');
        int age = int.parse(stdin.readLineSync()!);
        stdout.write('Enter Email: ');
        String email = stdin.readLineSync()!;

        user.addUserInList(name: name, age: age, email: email);
        break;

      case 2:
        List<Map<String, dynamic>> userList = user.getUserList();
        if (userList.isEmpty) {
          print('No users found!');
        } else {
          for (var element in userList) {
            print('${element[NAME]} . ${element[AGE]} . ${element[EMAIL]}');
          }
        }
        break;

      case 3:
      //region UPDATE USER
        stdout.write('Enter Name : ');
        String name = stdin.readLineSync()!;
        stdout.write('Enter Age : ');
        int age = int.parse(stdin.readLineSync()!);
        stdout.write('Enter Email : ');
        String email = stdin.readLineSync()!;
        stdout.write('Enter Primary key : ');
        int index = int.parse(stdin.readLineSync()!);
        user.updateUserInList(name: name, age: age, email: email, id: index);
        break;

      case 4:
      //region DELETE USER
        stdout.write('Enter Primary key : ');
        int index = int.parse(stdin.readLineSync()!);
        user.deleteUser(index);
        break;

      case 5:
      //region SEARCH USER
        stdout.write('\nType Here To Search');
        String searchString = stdin.readLineSync()!;
        user.searchDetail(searchData: searchString);
        //endregion
        break;

      case 6:
        print('Exiting Application...');
        break;
      default:
        print('Invalid choice, please try again!');
    }
  } while (choice != 6);
}
