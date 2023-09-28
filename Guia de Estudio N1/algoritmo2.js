//Desarrollar un contador de palabras, solicitando al usuario que ingrese una oración, para
//luego contar cuántas palabras hay en la oración. Mostrar la oración ingresada y el número
//de palabras en el navegador.

const oracion = prompt('Ingrese una oración: ');

// Verificar si la entrada es una oración
if (oracion.trim() === "") {
    alert("Por favor, ingrese una oración válida.");
} else {
    const palabras = oracion.match(/\S+/g);

    const numPalabras = palabras ? palabras.length : 0;

    alert(`La Oración ingresada fue: ${oracion}\nEl Número de palabras es: ${numPalabras}`);
}

