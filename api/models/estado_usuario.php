<?php
/*


*	Clase para manejar la tabla tipo factura de la base de datos de la tienda.
*   Es una clase hija de Validator.
*/
class EstadoUsuario extends Validator
{
    // Declaración de atributos (propiedades).
    private $id = null;
    private $estado = null;

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

    public function setEstado($value)
    {
        if ($this->validateString($value, 1, 50)) {
            $this->estado = $value;
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

    public function getEstado()

    {
        return $this->estado;
    }


    // Método para leer toda la información de tipo factura existentes-------------------------.
    public function readAll()
    {
        $sql = 'SELECT id_estado_usuario, estado_usuario from estado_usuario;';
        $params = null;
        return Database::getRows($sql, $params);
    }

}