import 'dart:io';

void main() {
  print('Ingrese un numero para saber si es Primo: ');
  int num = int.parse(stdin.readLineSync()!);

  if (EsPrimo(num)) {
    print("El numero $num es Primo");
  } else {
    print("El numero $num no es Primo");
  }
}

bool EsPrimo(int numero) {
  for (int i = 2; i < numero; i++) {
    if ((numero % i) == 0) {
      // No es primo :(
      return false;
    }
  }

  // Es primo :)
  return true;
}
