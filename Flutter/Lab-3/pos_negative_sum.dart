import 'dart:io';

void main(){
  int num = int.parse(stdin.readLineSync()!);
  int evenSum = 0;
  int oddSum = 0;

  if(num > 0 && num % 2 == 0){
    evenSum += num;
  }
  else if(num < 0 && num % 2 != 0){
    oddSum +=num;
  }
}

// import 'dart:io';
//
// void main() {
//   int sumEven = 0;  // Sum for positive even numbers
//   int sumOdd = 0;   // Sum for negative odd numbers
//
//   while (true) {
//     // Read the input from the user
//     print("Enter a number (enter 0 to quit):");
//     int num = int.parse(stdin.readLineSync()!);
//
//     // If user enters 0, exit the loop
//     if (num == 0) {
//       break;
//     }
//
//     // Check if the number is positive and even
//     if (num > 0 && num % 2 == 0) {
//       sumEven += num;
//     }
//
//     // Check if the number is negative and odd
//     if (num < 0 && num % 2 != 0) {
//       sumOdd += num;
//     }
//   }

//   // Display the results
//   print("Sum of positive even numbers: $sumEven");
//   print("Sum of negative odd numbers: $sumOdd");
// }
