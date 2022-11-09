// Constante para establecer la ruta y parámetros de comunicación con la API.
const API_USUARIOS = SERVER + 'private/usuarios.php?action=';
const ENDPOINT_ROL = SERVER + 'private/rol_usuario.php?action=readAll';
const ENDPOINT_ESTADO = SERVER + 'private/estado_usuario.php?action=readAll';
const ENDPOINT_ACCESO = SERVER + 'private/perfil_acceso.php?action=readAll';

// Método manejador de eventos que se ejecuta cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', function () {
    // Se llama a la función que obtiene los registros para llenar la tabla. Se encuentra en el archivo components.js
    readRows(API_USUARIOS);
});

// Función para llenar la tabla con los datos de los registros. Se manda a llamar en la función readRows().
function fillTable(dataset) {
    let content = '';
    // Se recorre el conjunto de registros (dataset) fila por fila a través del objeto row.
    dataset.map(function (row) {
        // Se crean y concatenan las filas de la tabla con los datos de cada registro.
        content += `
            <tr>
                <td class="info-section text-center">${row.nombre_usuario}</td>
                <td class="info-section text-center">${row.apellido_usuario}</td>
                <td class="info-section text-center">${row.correo_usuario}</td>
                <td class="info-section text-center">${row.rol_usuario}</td>
                <td class="info-section text-center">${row.perfil_acceso}</td>
                <td class="info-section text-center">${row.estado_usuario}</td>
                <td class="info-section d-flex justify-content-center">
                    <button onclick="openUpdate(${row.id_usuario})" class="btn btn-edit" data-bs-toggle="modal"
                    data-bs-target="#modal-agregarUser">Editar</button>
                    <button onclick="openDelete(${row.id_usuario})" class="btn btn-delete">Eliminar</button>
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
    searchRows(API_USUARIOS, 'search-form');
});

//Función para refrescar la tabla manualmente al darle click al botón refresh
document.getElementById('limpiar').addEventListener('click', function () {
    readRows(API_USUARIOS);
    document.getElementById('search').value = "";
});

// Función para preparar el formulario al momento de insertar un registro.
function openCreate() {
    // Se asigna el título para la caja de diálogo (modal).
    document.getElementById('modal-user-title').textContent = 'Crear usuario';
    document.getElementById('save-form-user').reset();
    document.getElementById("col-correo-user").classList.remove('col-lg-6');
    document.getElementById("col-correo-user").classList.add('col-lg-12');
    document.getElementById("col-estado-user").classList.add('input-hide');
    document.getElementById("div-pass").classList.remove('input-hide');
    document.getElementById("div-conf").classList.remove('input-hide');
    // Se habilitan los campos de alias y contraseña.
    fillSelect(ENDPOINT_ROL, 'rol', null);
    fillSelect(ENDPOINT_ESTADO, 'estado', null);
    fillSelect(ENDPOINT_ACCESO, 'acceso', null);
}

// Función para preparar el formulario al momento de modificar un registro.
function openUpdate(id) {
    // Se asigna el título para la caja de diálogo (modal).
    document.getElementById('modal-user-title').textContent = 'Actualizar usuario';

    // Se esconden los campos de contraseña porque ya no son necesarios.
    document.getElementById('clave-label').style.display = 'none';
    document.getElementById('clave2-label').style.display = 'none';
    document.getElementById('clave').style.display = 'none';
    document.getElementById('clave2').style.display = 'none';
    // Se inhabilitan los campos de contraseña y alias para no poder ser editados
    document.getElementById('clave').disabled = true;
    document.getElementById('clave2').disabled = true;

    document.getElementById("col-correo-user").classList.remove('col-lg-12');
    document.getElementById("col-correo-user").classList.add('col-lg-6');
    document.getElementById("col-estado-user").classList.remove('input-hide');
    //Limpiamos los campos del modal
    document.getElementById('save-form-user').reset();
    // Se define un objeto con los datos del registro seleccionado.
    const data = new FormData();
    data.append('id', id);
    // Petición para obtener los datos del registro solicitado.
    fetch(API_USUARIOS + 'readOne', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje en la consola indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('id').value = response.dataset.id_usuario;
                    document.getElementById('nombres').value = response.dataset.nombre_usuario;
                    document.getElementById('apellidos').value = response.dataset.apellido_usuario;
                    document.getElementById('correo').value = response.dataset.correo_usuario;
                    fillSelect(ENDPOINT_ROL, 'rol', response.dataset.id_rol_usuario);
                    fillSelect(ENDPOINT_ESTADO, 'estado', response.dataset.id_estado_usuario);
                    fillSelect(ENDPOINT_ACCESO, 'acceso', response.dataset.id_perfil_acceso);
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
document.getElementById('save-form-user').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se define una variable para establecer la acción a realizar en la API.
    let action = '';
    // Se comprueba si el campo oculto del formulario esta seteado para actualizar, de lo contrario será para crear.
    (document.getElementById('id').value) ? action = 'update' : action = 'create';
    // Se llama a la función para guardar el registro. Se encuentra en el archivo components.js
    saveRow(API_USUARIOS, action, 'save-form-user', 'modal-agregarUser');
});

// Función para establecer el registro a eliminar y abrir una caja de diálogo de confirmación.
function openDelete(id) {
    // Se define un objeto con los datos del registro seleccionado.
    const data = new FormData();
    data.append('id', id);
    // Se llama a la función que elimina un registro. Se encuentra en el archivo components.js
    confirmDelete(API_USUARIOS, data);
}