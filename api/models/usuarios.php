<?php
/*
*	Clase para manejar la tabla usuarios de la base de datos.
*/
class Usuarios extends Validator
{
    // Declaración de atributos.
    private $id = null;
    private $nombres = null;
    private $apellidos = null;
    private $correo = null;
    private $password = null;
    private $rol = null;
    private $estado = null;

    private $estado_activo = '1';
    private $estado_inhabilitado = '3';

    /*
    *   Métodos para validar y asignar valores de los atributos.
    */
    public function setId($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->id = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setNombres($value)
    {
        if ($this->validateAlphabetic($value, 1, 50)) {
            $this->nombres = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setApellidos($value)
    {
        if ($this->validateAlphabetic($value, 1, 50)) {
            $this->apellidos = $value;
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

    public function setPassword($value)
    {
        if ($this->validatePassword($value)) {
            $this->password = password_hash($value, PASSWORD_DEFAULT);
            return true;
        } else {
            return false;
        }
    }

    public function setRol($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->rol = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setEstado($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->estado = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setPerfil($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->perfil = $value;
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

    public function getNombres()
    {
        return $this->nombres;
    }

    public function getApellidos()
    {
        return $this->apellidos;
    }

    public function getCorreo()
    {
        return $this->correo;
    }

    public function getPassword()
    {
        return $this->password;
    }

    public function getRol()
    {
        return $this->rol;
    }

    public function getEstado()
    {
        return $this->estado;
    }

    public function getPerfil()
    {
        return $this->perfil;
    }

    /*
    *   Métodos para gestionar la cuenta del usuario.
    */
    public function checkUser($correo)
    {
        $sql = 'SELECT id_usuario, id_estado_usuario FROM usuario WHERE correo_usuario = ?';
        $params = array($correo);
        if ($data = Database::getRow($sql, $params)) {
            $this->id = $data['id_usuario'];
            $this->estado = $data['id_estado_usuario'];
            return true;
        } else {
            return false;
        }
    }

    public function checkPassword($password)
    {
        $sql = 'SELECT contrasena_usuario FROM usuario WHERE id_usuario = ?';
        $params = array($this->id);
        $data = Database::getRow($sql, $params);
        // Se verifica si la contraseña coincide con el hash almacenado en la base de datos.
        if (password_verify($password, $data['contrasena_usuario'])) {
            return true;
        } else {
            return false;
        }
    }

    // Método para comprobar si el empleado está bloqueado (login)-------------------------.
    public function checkBlockedUser()
    {
        $sql = 'SELECT id_usuario from usuario where id_usuario = ? and id_estado_usuario = ?';
        $params = array($this->id, $this->estado_activo);

        if (Database::getRow($sql, $params)) {
            return true;
        } else {
            return false;
        }
    }

    public function readProfile()
    {
        $sql = 'SELECT id_usuario, nombres_usuario, apellidos_usuario, correo_usuario, alias_usuario
                FROM usuarios
                WHERE id_usuario = ?';
        $params = array($_SESSION['id_usuario']);
        return Database::getRow($sql, $params);
    }

    public function editProfile()
    {
        $sql = 'UPDATE usuarios
                SET nombres_usuario = ?, apellidos_usuario = ?, correo_usuario = ?
                WHERE id_usuario = ?';
        $params = array($this->nombres, $this->apellidos, $this->correo, $_SESSION['id_usuario']);
        return Database::executeRow($sql, $params);
    }

    /*
    *   Métodos para realizar las operaciones SCRUD (search, create, read, update, delete).
    */
    public function searchRows($value)
    {
        $sql = 'SELECT id_usuario, nombre_usuario, apellido_usuario, correo_usuario, contrasena_usuario, id_rol_usuario, id_estado_usuario, id_perfil_acceso
                FROM usuario
                WHERE apellido_usuario ILIKE ? OR nombre_usuario ILIKE ?
                ORDER BY nombre_usuario';
        $params = array("%$value%", "%$value%");
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        $sql = 'INSERT INTO usuario(nombre_usuario, apellido_usuario, correo_usuario, contrasena_usuario, id_rol_usuario, id_estado_usuario, id_perfil_acceso)
                VALUES(?, ?, ?, ?, ?, ?, ?)';
        $params = array($this->nombres, $this->apellidos, $this->correo, $this->password, $this->rol, $this->estado, $this->perfil);
        return Database::executeRow($sql, $params);
    }

    public function readAll()
    {
        $sql = 'SELECT id_usuario, nombre_usuario, apellido_usuario, correo_usuario, rol_usuario, estado_usuario, perfil_acceso
                FROM usuario
                INNER JOIN rol_usuario using (id_rol_usuario)
                INNER JOIN estado_usuario using (id_estado_usuario)
                INNER JOIN perfil_acceso using (id_perfil_acceso)
                ORDER BY nombre_usuario';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readOne()
    {
        $sql = 'SELECT id_usuario, nombre_usuario, apellido_usuario, correo_usuario, id_rol_usuario, id_estado_usuario, id_perfil_acceso
                FROM usuario
                WHERE id_usuario = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {
        $sql = 'UPDATE usuario
                SET nombre_usuario = ?, apellido_usuario = ?, correo_usuario = ?, id_rol_usuario = ?, id_estado_usuario = ?, id_perfil_acceso = ?
                WHERE id_usuario = ?';
        $params = array($this->nombres, $this->apellidos, $this->correo, $this->rol, $this->estado, $this->perfil, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'UPDATE usuario
                SET id_estado_usuario = ?
                WHERE id_usuario = ?';
        $params = array($this->estado_inhabilitado, $this->id);
        return Database::executeRow($sql, $params);
    }
}
