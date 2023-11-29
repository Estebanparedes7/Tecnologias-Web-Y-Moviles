function calcularIMC() {
    const nombre = document.getElementById("nombre").value;
    const peso = parseFloat(document.getElementById("peso").value);
    const altura = parseFloat(document.getElementById("altura").value);
    const edad = parseInt(document.getElementById("edad").value);
    const genero = document.getElementById("genero").value;
    const actividad = document.getElementById("actividad").value;

    if (!nombre || isNaN(peso) || isNaN(altura) || isNaN(edad)) {
        alert("Por favor, complete todos los campos correctamente.");
        return;
    }

    const imc = peso / (altura * altura);

    let clasificacion = "";
    if (imc < 18.5) {
        clasificacion = "Bajo peso";
    } else if (imc >= 18.5 && imc < 24.9) {
        clasificacion = "Peso normal";
    } else if (imc >= 25 && imc < 29.9) {
        clasificacion = "Sobrepeso";
    } else {
        clasificacion = "Obesidad";
    }

    let factorActividad = 1.2; // Sedentario
    if (actividad === "moderado") {
        factorActividad = 1.55;
    } else if (actividad === "activo") {
        factorActividad = 1.9;
    }

    const gastoEnergeticoDiario = factorActividad * peso;

    let estadoNutricional = "Normal";
    if (imc < 18.5 || imc >= 25) {
        estadoNutricional = "Necesita atención especializada";
    }

    const resultado = `
        Nombre: ${nombre}<br>
        IMC: ${imc.toFixed(2)}<br>
        Clasificación: ${clasificacion}<br>
        Gasto Energético Diario: ${gastoEnergeticoDiario.toFixed(2)} kcal<br>
        Estado Nutricional: ${estadoNutricional}
    `;

    document.getElementById("resultado").innerHTML = resultado;
}
