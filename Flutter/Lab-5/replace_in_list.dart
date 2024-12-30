import 'dart:io';

void main(){
  List<String> list = ["Delhi",'Mumbai','hyderabad','Banglore','Ahemdabad'];
   for(int i = 0 ; i < list.length ; i ++){
     if(list[i] == 'Ahemdabad'){
       list[i] = 'Surat';
     }
  }
   print(list);
}