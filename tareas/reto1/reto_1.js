// Solicita al usuario que ingrese un número
var input = prompt("Ingresa un número:");

// Convertir el valor ingresado a un número entero
var numero = parseInt(input);

// Verificar si el valor ingresado es un número
if (!isNaN(numero)) {
    // Función para verificar si un número es primo
    function esPrimo(num) {
        if (num <= 1) {
            return false;
        }
        for (var i = 2; i < num; i++) {
            if (num % i === 0) {
                return false;
            }
        }
        return true;
    }

    // Verificar si el número es primo y mostrar el resultado
    if (esPrimo(numero)) {
        alert(numero + " es un número primo.");
    } else {
        alert(numero + " no es un número primo.");
    }
} else {
    alert("Ingresa un número válido.");
}