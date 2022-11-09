<?php
/*
*	Clase para manejar la tabla usuarios de la base de datos.
*   Es clase hija de Validator.
*/
class Cliente extends Validator
{
    // Declaración de atributos (propiedades) según nuestra tabla en la base de datos.
    private $id = null;
    private $nombre = null;
    private $apellido = null;
    private $direccion = null;
    private $dui = null;
    private $correo = null;
    private $telefono = null;

    /*
    *   Métodos para validar y asignar valores de los atributos de clientes.
    */
    public function setId($value)
    {
        if ($this->validateString($value, 1, 50)) {
            $this->id = $value;
            return true;
        } else {
            return false;
        }
    }

    
    public function setNombre($value)
    {
        if ($this->validateAlphabetic($value, 1, 50)) {
            $this->nombre = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setApellido($value)
    {
        if ($this->validateAlphabetic($value, 1, 50)) {
            $this->apellido = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setDireccion($value)
    {
        if ($this->validateString($value, 1, 50)) {
            $this->direccion = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setDUI($value)
    {
        if ($this->validateDUI($value)) {
            $this->dui = $value;
            return true;
        } else {
            return false;
        }
        
    }

    public function setCorreo($value)
    {
        if ($this->validateEmail($value)) {
            $this->correo = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setTelefono($value)
    {
        if ($this->validatePhone($value)) {
            $this->telefono = $value;
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

    public function getNombre()
    {
        return $this->nombre;
    }

    public function getApellido()
    {
        return $this->apellido;
    }

    public function getDireccion()
    {
        return $this->direccion;
    }

    public function getDUI()
    {
        return $this->dui;
    }
    
    public function getCorreo()
    {
        return $this->correo;
    }

    public function getTelefono()
    {
        return $this->telefono;
    }

    /* 
    *   Método para comprobar que existen subcategorias registradas en nuestra base de datos
    */

    // Método para leer toda la información de los clientes existentes-------------------------.
    public function readAll()
    {
        $sql = 'SELECT id_cliente, nombre_cliente, apellido_cliente, direccion_cliente, dui_cliente, correo_cliente, telefono_cliente
        FROM cliente
        ORDER BY id_cliente';
        $params = null;
        return Database::getRows($sql, $params);
    }

    // Método para un dato en especifico de los clientes existentes-------------------------.
    public function readOne()
    {
        $sql = 'SELECT id_cliente, nombre_cliente, apellido_cliente, direccion_cliente, dui_cliente, correo_cliente, telefono_cliente
                FROM cliente
                WHERE id_cliente = ?
                ORDER BY id_cliente';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    /*
    *   Métodos para realizar las operaciones SCRUD (search, create, read, update, delete).
    */
    /* SEARCH */
    public function searchRows($value)
    {
        $sql = 'SELECT id_cliente, nombre_cliente, apellido_cliente, direccion_cliente, dui_cliente, correo_cliente, telefono_cliente
                FROM cliente
                WHERE "nombre_cliente" ILIKE ? OR "dui_cliente" ILIKE ?
                ORDER BY "id_cliente"';
        $params = array("%$value%", "%$value%");
        return Database::getRows($sql, $params);
    }

    /* CREATE */
    public function createRow()
    {
        $sql = 'INSERT INTO public.cliente(
            nombre_cliente, apellido_cliente, dui_cliente, direccion_cliente, correo_cliente, telefono_cliente)
            VALUES (?, ?, ?, ?, ?, ?);';
        $params = array($this->nombre, $this->apellido, $this->dui, $this->direccion, $this->correo, $this->telefono);
        return Database::executeRow($sql, $params);
    }

    /* UPDATE */
    public function updateRow()
    {
        $sql = 'UPDATE public.cliente
                SET nombre_cliente = ?, apellido_cliente = ?, dui_cliente = ?, direccion_cliente = ?, correo_cliente = ?, telefono_cliente = ?
                WHERE id_cliente = ?;';
            $params = array($this->nombre, $this->apellido, $this->dui, $this->direccion, $this->correo, $this->telefono, $this->id);
        return Database::executeRow($sql, $params);
    }

    /* DELETE */
    /* Función para inhabilitar un usuario ya que no los borraremos de la base*/
    public function deleteRow()
    {
        $sql = 'DELETE FROM cliente
                WHERE id_cliente = ?;';
        $params = array( $this->id);
        return Database::executeRow($sql, $params);
    }
}
