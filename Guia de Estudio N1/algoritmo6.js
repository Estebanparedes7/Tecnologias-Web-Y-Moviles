//Desarrollar un algoritmo que permita ingresar un objeto representando un inventario de
//productos. Cada producto en el inventario debe tener como propiedades un nombre, un
//precio, y una cantidad de stock en formato de número entero. Se debe recorrer el inventario
//y verificar si el stock de alguno de los productos es inferior a 1000 unidades. Si existe algún
//producto con stock crítico (menos de 1000 unidades), mostrará un mensaje indicando cuál
//es ese producto y que el stock es crítico. Si todos los productos tienen un stock igual o
//superior a 1000 unidades, el programa mostrará un mensaje que indique que el inventario
//está en buen estado.



// Crear un arreglo vacío para almacenar los productos
const inventario = [];

// Solicitar al usuario que ingrese los productos y sus cantidades de stock
while (true) {
    const nombre = prompt('Ingrese el nombre del producto (o escriba "fin" para terminar):');
    
    // Si el usuario escribe "fin", salimos del bucle
    if (nombre.toLowerCase() === 'fin') {
        break;
    }
    
    const precio = parseFloat(prompt('Ingrese el precio del producto:'));
    const stock = parseInt(prompt('Ingrese la cantidad de stock del producto:'));

    // Verificar si el stock es crítico y agregar el producto al inventario
    if (stock < 1000) {
        inventario.push({ nombre, precio, stock });
        alert(`El producto "${nombre}" ha sido agregado al inventario con stock crítico.`);
    } else {
        inventario.push({ nombre, precio, stock });
    }
}

let stockCritico = false;

// Recorrer el inventario y verificar el stock de cada producto
for (let i = 0; i < inventario.length; i++) {
    const producto = inventario[i];
    
    if (producto.stock < 1000) {
        stockCritico = true;
        alert(`El producto "${producto.nombre}" tiene un stock crítico (${producto.stock} unidades).`);
    }
}

// Mostrar un mensaje indicando el estado del inventario
if (stockCritico) {
    alert("El inventario contiene productos con stock crítico.");
} else {
    alert("El inventario está en buen estado, todos los productos tienen suficiente stock.");
}
