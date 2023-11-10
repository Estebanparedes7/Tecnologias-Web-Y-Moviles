import 'dart:io';

void main() {
  print('Ingrese un numero para saber si es Par o Impar: ');
  int n = int.parse(stdin.readLineSync()!);
  bool Par= n % 2==0;

  if (Par) {
    print("El numero $n es Par");
  } else {
    print("El numero $n es Impar");
  }
}  