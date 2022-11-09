<?php
/*


*	Clase para manejar la tabla tipo factura de la base de datos de la tienda.
*   Es una clase hija de Validator.
*/
class RolUsuario extends Validator
{
    // Declaración de atributos (propiedades).
    private $id = null;
    private $rol = null;

    /*
    *   Métodos para validar y asignar valores de los atributos.
    */
    public function setId($value)
    {
        if ($this->validateString($value, 1, 38)) {
            $this->id = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setRol($value)
    {
        if ($this->validateString($value, 1, 50)) {
            $this->rol = $value;
            return true;
        } else {
            return false;
        }
    }

    /*
    *   Métodos para obtener valores de los atributos.
    */
    public function getId()
    {
        return $this->id;
    }

    public function getRol()

    {
        return $this->rol;
    }


    // Método para leer toda la información de tipo factura existentes-------------------------.
    public function readAll()
    {
        $sql = 'SELECT id_rol_usuario, rol_usuario from rol_usuario;';
        $params = null;
        return Database::getRows($sql, $params);
    }

}