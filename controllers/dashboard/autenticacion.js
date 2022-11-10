// Constante para establecer la ruta y parámetros de comunicación con la API.
const API_USUARIOS = SERVER + 'private/usuarios.php?action=';

// Eventos que se ejecutan cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', function () {
    // Petición para consultar si existen usuarios registrados.
    fetch(API_USUARIOS + 'readUsers', {
        method: 'get'
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje en la consola indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si existe una sesión, de lo contrario se revisa si la respuesta es satisfactoria.
                if (response.session) {
                    location.href = 'dashboard.html';
                } else if (response.status) {
                    sweetAlert(4, 'Ingresa el código de verificación', null);
                } else {
                    //Mostramos el mensaje y específicamos la página que se abrirá como siguiente paso-------------------.
                    sweetAlert(3, response.exception, 'first_user.html');
                }
            });
        } else {
            console.log(request.status + ' ' + request.statusText);
        }
    });
});

// Método manejador de eventos que se ejecuta cuando se envía el formulario de iniciar sesión.
document.getElementById('autentication-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    const data = new FormData(document.getElementById('autentication-form'));
    // Petición para autenticación de doble factor.
    fetch(API_USUARIOS + 'checkVerification', {
        method: 'post',
        body: data,
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje en la consola indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                if (response.status == 1) {
                    sweetAlert(1, response.message, 'dashboard.html');
                }
                //Si status = 2, significa que se equivoco al escribir la contraseña
                else if (response.status == 2) {
                    document.getElementById('autentication-form').reset();
                    sweetAlert(2, response.message, null);
                }
                //Si retorna exception significa que el código ya vención y retorna al login
                else {
                    sweetAlert(2, response.exception, 'index.html');
                }

            });
        } else {
            console.log(request.status + ' ' + request.statusText);
        }
    });
});