//Realizar un programa que permita al usuario ingresar su estatura y peso, para que se
//muestre en el navegador su IMC correspondiente. Además de mostrar el IMC, indicar si está
//en la categoría de: “Bajo Peso”, “Peso Normal” o “Sobrepeso”.
//IMC Estado
//Menor a 18.5 Bajo Peso
//18.5 - 24.9 Normal
//Mayor 24.9 Sobrepeso



const estatura = parseFloat(prompt('Ingrese su estatura en metros (por ejemplo, 1.75):'));
const peso = parseFloat(prompt('Ingrese su peso en kilogramos:'));

// Verificar si los valores ingresados son números válidos
if (!isNaN(estatura) && !isNaN(peso) && estatura > 0 && peso > 0) {
    // Calcular el IMC
    const imc = peso / (estatura * estatura);

    // Determinar el estado basado en el IMC
    let estado = "";

    if (imc < 18.5) {
        estado = "Bajo Peso";
    } else if (imc >= 18.5 && imc <= 24.9) {
        estado = "Peso Normal";
    } else {
        estado = "Sobrepeso";
    }

    // Mostrar el IMC y el estado
    alert(`Su IMC es ${imc.toFixed(2)} y está en la categoría de: ${estado}`);
} else {
    alert('Por favor, ingrese valores válidos para estatura y peso.');
}
