//Crear un algoritmo que solicite al usuario un número entero positivo. Luego, utilizar un ciclo
//para calcular la suma de todos los números pares desde 1 hasta el número ingresado por el
//usuario. Mostrar el resultado de la operación en el navegador

let num = parseInt(prompt('Ingresa un Número: '));

while (isNaN(num) || num <= 0) {
    alert("Por favor, ingresa un número entero positivo válido.");
    num = parseInt(prompt('Ingresa un Número: '));
}

var suma = 0;

for (var i = 1; i <= num; i++) {
    if (i % 2 === 0) {
        suma += i;
    }
}

alert(`La suma de todos los números pares desde el 1 hasta ${num} es: ${suma}`);
