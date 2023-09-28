//Crear un programa que solicite al usuario una contraseña y verifique si cumple con ciertos
//criterios de seguridad. La contraseña debe cumplir con los siguientes requisitos para
//considerarse válida:
    //a. Debe tener al menos 8 caracteres de longitud.
    //b. Debe contener al menos una letra mayúscula.
    //c. Debe contener al menos un número.
    //d. Debe incluir al menos un carácter especial, como: !@#$%^&*()_+{}[]:;<>,.?~\-
//Se debe mostrar un mensaje en el navegador indicando si la contraseña ingresada es válida
//o no, según los criterios mencionados. Si la contraseña cumple con todos los criterios, se
//mostrará un mensaje de "La contraseña es válida". De lo contrario, se mostrará un mensaje
//que indica que la contraseña no cumple con los requisitos de seguridad.


const contraseña = prompt('Ingrese una contraseña: ');

// Verificar la longitud mínima de 8 caracteres
const longitudValida = contraseña.length >= 8;
let mensaje = "";

if (!longitudValida) {
    mensaje += "- La contraseña debe tener al menos 8 caracteres.\n";
}

// Verificar al menos una letra mayúscula
const contieneMayuscula = /[A-Z]/.test(contraseña);

if (!contieneMayuscula) {
    mensaje += "- La contraseña debe contener al menos una letra mayúscula.\n";
}

// Verificar al menos un número
const contieneNumero = /[0-9]/.test(contraseña);

if (!contieneNumero) {
    mensaje += "- La contraseña debe contener al menos un número.\n";
}

// Verificar al menos un carácter especial
const contieneEspecial = /[!@#$%^&*()_+{}[\]:;<>,.?~\\-]/.test(contraseña);

if (!contieneEspecial) {
    mensaje += "- La contraseña debe incluir al menos un carácter especial: !@#$%^&*()_+{}[]:;<>,.?~\\-\n";
}

// Verificar si cumple con todos los criterios
if (longitudValida && contieneMayuscula && contieneNumero && contieneEspecial) {
    alert("La contraseña es válida.");
} else {
    alert("La contraseña no cumple con los siguientes requisitos de seguridad:\n" + mensaje);
}

