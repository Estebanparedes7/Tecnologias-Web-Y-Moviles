//Solicitar al usuario que ingrese una serie de números separados por comas. Encontrar y
//mostrar el número más grande entre los números ingresados
const numero = prompt("Ingrese una serie de números separados por comas: ", '');

const numeros = numero.split(',');

let maxnum = parseInt(numeros[0]);;

for (let i = 0; i < numeros.length; i++) {
    const num = parseInt(numeros[i]);
    if (num > maxnum) {
        maxnum = num;
    }
}
alert("El número más grande es: " + maxnum);