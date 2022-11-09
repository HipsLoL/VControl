// Constante para establecer la ruta y parámetros de comunicación con la API.
const API_CLIENTE = SERVER + 'private/clientes.php?action=';

// Método manejador de eventos que se ejecuta cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', function () {
    // Se llama a la función que obtiene los registros para llenar la tabla. Se encuentra en el archivo components.js
    readRows(API_CLIENTE);
});

// Función para llenar la tabla con los datos de los registros. Se manda a llamar en la función readRows().
function fillTable(dataset) {
    let content = '';
    // Se recorre el conjunto de registros (dataset) fila por fila a través del objeto row.
    dataset.map(function (row) {
        // Se crean y concatenan las filas de la tabla con los datos de cada registro.
        content += `
            <tr>
                <td class="info-section text-center">${row.nombre_cliente}</td>
                <td class="info-section text-center">${row.apellido_cliente}</td>
                <td class="info-section text-center">${row.correo_cliente}</td>
                <td class="info-section text-center">${row.dui_cliente}</td>
                <td class="info-section text-center">${row.direccion_cliente}</td>
                <td class="info-section text-center">${row.telefono_cliente}</td>
                <td class="info-section d-flex justify-content-center">
                    <button onclick="openUpdate(${row.id_cliente})" class="btn btn-edit" data-bs-toggle="modal"
                    data-bs-target="#modal-agregarClient">Editar</button>
                    <button onclick="openDelete(${row.id_cliente})" class="btn btn-delete">Eliminar</button>
                </td>
            </tr>
        `;
    });
    // Se agregan las filas al cuerpo de la tabla mediante su id para mostrar los registros.
    document.getElementById('tbody-rows').innerHTML = content;
}

// Método manejador de eventos que se ejecuta cuando se envía el formulario de buscar.
document.getElementById('search-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se llama a la función que realiza la búsqueda. Se encuentra en el archivo components.js
    searchRows(API_CLIENTE, 'search-form');
});

//Función para refrescar la tabla manualmente al darle click al botón refresh
document.getElementById('limpiar').addEventListener('click', function () {
    readRows(API_CLIENTE);
    document.getElementById('search').value = "";
});

// Función para preparar el formulario al momento de insertar un registro.
function openCreate() {
    // Se asigna el título para la caja de diálogo (modal).
    document.getElementById('modal-client-title').textContent = 'Crear cliente';
    document.getElementById('save-form-client').reset();
}

// Función para preparar el formulario al momento de modificar un registro.
function openUpdate(id) {
    // Se asigna el título para la caja de diálogo (modal).
    document.getElementById('modal-client-title').textContent = 'Actualizar cliente';
    //Limpiamos los campos del modal
    document.getElementById('save-form-client').reset();
    // Se define un objeto con los datos del registro seleccionado.
    const data = new FormData();
    data.append('id', id);
    // Petición para obtener los datos del registro solicitado.
    fetch(API_CLIENTE + 'readOne', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje en la consola indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('id').value = response.dataset.id_cliente;
                    document.getElementById('nombres-c').value = response.dataset.nombre_cliente;
                    document.getElementById('apellidos-c').value = response.dataset.apellido_cliente;
                    document.getElementById('dui-c').value = response.dataset.dui_cliente;
                    document.getElementById('correo-c').value = response.dataset.correo_cliente;
                    document.getElementById('direccion-c').value = response.dataset.direccion_cliente;
                    document.getElementById('telefono-c').value = response.dataset.telefono_cliente;
                } else {
                    sweetAlert(2, response.exception, null);
                }
            });
        } else {
            console.log(request.status + ' ' + request.statusText);
        }
    });
}

// Método manejador de eventos que se ejecuta cuando se envía el formulario de guardar.
document.getElementById('save-form-client').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se define una variable para establecer la acción a realizar en la API.
    let action = '';
    // Se comprueba si el campo oculto del formulario esta seteado para actualizar, de lo contrario será para crear.
    (document.getElementById('id').value) ? action = 'update' : action = 'create';
    // Se llama a la función para guardar el registro. Se encuentra en el archivo components.js
    saveRow(API_CLIENTE, action, 'save-form-client', 'modal-agregarClient');
});

// Función para establecer el registro a eliminar y abrir una caja de diálogo de confirmación.
function openDelete(id) {
    // Se define un objeto con los datos del registro seleccionado.
    const data = new FormData();
    data.append('id', id);
    // Se llama a la función que elimina un registro. Se encuentra en el archivo components.js
    confirmDelete(API_CLIENTE, data);
}