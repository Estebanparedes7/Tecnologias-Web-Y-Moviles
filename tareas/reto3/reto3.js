function calcularPropina(){
    let total_boleta = document.getElementById("total_boleta").value;
    let porcentaje_propina = document.getElementById("porcentaje_propina").value / 100;
    let condicion_1 = (total_boleta % 1 == 0);
    let condicion_2 = (total_boleta > 0);

    if(condicion_1 && condicion_2){
        let propina = total_boleta * porcentaje_propina;
        document.getElementById("mostrar_propina").innerHTML = `Propina: $${propina.toFixed(2)} CLP`;
        let total_boleta_final = Number(propina) + Number(total_boleta);
        document.getElementById("mostrar_total_boleta").innerHTML = `Total a pagar: $${total_boleta_final.toFixed(2)} CLP`;
    }
    else{
        alert("Se ha ingresado un valor inválido");
    }

}

function limpiarCampos() {
    document.getElementById("total_boleta").value = "";
    document.getElementById("porcentaje_propina").selectedIndex = 0;
    document.getElementById("mostrar_propina").textContent = "Propina: ";
    document.getElementById("mostrar_total_boleta").textContent = "Total a pagar: ";
}