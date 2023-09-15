// Función para verificar si un número es válido en el rango de 1.0 a 7.0
function esNumeroValido(numero) {
    return !isNaN(numero) && numero >= 1.0 && numero <= 7.0;
}

// Solicitar al usuario que ingrese las tres notas y verificar su validez
var nota1 = parseFloat(prompt("Ingresa la nota 1 (del 1.0 al 7.0):"));
if (!esNumeroValido(nota1)) {
    alert("Ingresa una nota válida en el rango de 1.0 a 7.0 para la nota 1.");
} else {
    var nota2 = parseFloat(prompt("Ingresa la nota 2 (del 1.0 al 7.0):"));
    if (!esNumeroValido(nota2)) {
        alert("Ingresa una nota válida en el rango de 1.0 a 7.0 para la nota 2.");
    } else {
        var nota3 = parseFloat(prompt("Ingresa la nota 3 (del 1.0 al 7.0):"));
        if (!esNumeroValido(nota3)) {
            alert("Ingresa una nota válida en el rango de 1.0 a 7.0 para la nota 3.");
        } else {
            // Calcular el promedio ponderado
            var promedio = (nota1 * 0.4 + nota2 * 0.3 + nota3 * 0.3).toFixed(2); //Con 2 decimales

            // Determinar el resultado
            if (promedio < 3.95) {
                alert("Has reprobado la asignatura. Tu promedio es " + promedio);
            } else if (promedio >= 3.95 && promedio <= 4.94) {
                alert("Vas a examen. Tu promedio es " + promedio);
            } else {
                alert("Te has eximido de la asignatura. Tu promedio es " + promedio);
            }
        }
    }
}