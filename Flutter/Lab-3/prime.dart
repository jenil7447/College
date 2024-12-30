import 'dart:io';

void main() {
  int num = int.parse(stdin.readLineSync()!);

  if (num < 2) {
    stdout.write("${num} is not a prime number");
  } else {
    bool isPrime = true;
    for (int i = 2; i <= num / 2; i++) {
      if (num % i == 0) {
        isPrime = false;
        break;
      }
    }
    if (isPrime) {
      stdout.write("${num} is a prime number");
    } else {
      stdout.write("${num} is not a prime number");
    }
  }
}