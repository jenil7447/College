import 'dart:io';
import 'constant.dart';

class User{
  List<Map<String,dynamic>> userList = [];
// Create a user
  void addUserInList({required name, required age, required email}){
    Map<String,dynamic> map = {};
    map[NAME] = name;
    map[AGE] = age;
    map[EMAIL] = email;
    userList.add(map);
  }
//Read a Userlist
  List<Map<String,dynamic>> getUserList(){
    return userList;
  }
//Update in a userlist
  void updateUserInList({required name, required age,required email, required id}){
    Map<String,dynamic> map = {};
    map[NAME] = name;
    map[AGE] = age;
    map[EMAIL] = email;
    userList[id] = map;
  }
//Delete a user in userlist
 void deleteUser(id){
    userList.removeAt(id);
 }
// search in a userList
 void searchDetail({required searchData}){
    for( var element in userList){
      if(element[NAME].toString().toLowerCase()
      .contains(searchData.toString().toLowerCase()) ||
      element[AGE].toString().toLowerCase()
      .contains(searchData.toString().toLowerCase()) ||
       element[EMAIL].toString().toLowerCase()
      .contains(searchData.toString().toLowerCase())){
          print('${element[NAME]} . ${element[AGE]} . ${element[EMAIL]}');
      }
    }
 }
}