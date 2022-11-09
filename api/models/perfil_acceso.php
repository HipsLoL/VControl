<?php
/*


*	Clase para manejar la tabla tipo factura de la base de datos de la tienda.
*   Es una clase hija de Validator.
*/
class PerfilAcceso extends Validator
{
    // Declaración de atributos (propiedades).
    private $id = null;
    private $acceso = null;

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

    public function setAcceso($value)
    {
        if ($this->validateString($value, 1, 50)) {
            $this->acceso = $value;
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

    public function getAcceso()

    {
        return $this->acceso;
    }


    // Método para leer toda la información de tipo factura existentes-------------------------.
    public function readAll()
    {
        $sql = 'SELECT id_perfil_acceso, perfil_acceso from perfil_acceso;';
        $params = null;
        return Database::getRows($sql, $params);
    }

}