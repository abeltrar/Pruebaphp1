<?php
require_once "conexion/conexion.php";
require_once "respuestas.class.php";


class productos extends conexion {
 
    private $table = "producto";
    private $IDProducto = "";
    private $Nombre = "";
    private $Referencia = "";
    private $Precio = "";
    private $Peso = "";
    private $IdCategoria = "";
    private $Stock = "";
    private $FechaCreacion = "0000-00-00";
    private $token = "";
//912bc00f049ac8464472020c5cd06759

    public function listaproductos($pagina = 1){
        $inicio  = 0 ;
        $cantidad = 100;
        if($pagina > 1){
            $inicio = ($cantidad * ($pagina - 1)) +1 ;
            $cantidad = $cantidad * $pagina;
        }
        $query = "SELECT Nombre,Referencia,Precio,Peso,IdCategoria,Stock,FechaCreacion FROM " . $this->table . " limit $inicio,$cantidad";
        $datos = parent::obtenerDatos($query);
        return ($datos);
    }

    public function obtenerproducto($id){
        $query = "SELECT * FROM " . $this->table . " WHERE IDProducto = '$id'";
        return parent::obtenerDatos($query);

    }

    public function post($json){
        $_respuestas = new respuestas;
        $datos = json_decode($json,true);

       /* if(!isset($datos['token'])){
                return $_respuestas->error_401();
        }else{
            $this->token = $datos['token'];
            $arrayToken =   $this->buscarToken();
            if($arrayToken){*/

                if(!isset($datos['Nombre']) || !isset($datos['Stock']) || !isset($datos['Precio']) || !isset($datos['Referencia'])|| !isset($datos['Peso'])|| !isset($datos['IdCategoria'])|| !isset($datos['FechaCreacion'])){
                    return $_respuestas->error_400();
                }else{
                    $this->Nombre = $datos['Nombre'];
                    $this->Stock = $datos['Stock'];
                    $this->Precio = $datos['Precio'];
                    $this->Referencia = $datos['Referencia'];
                    $this->Peso = $datos['Peso'];
                    $this->IdCategoria = $datos['IdCategoria'];
                    $this->FechaCreacion = $datos['FechaCreacion'];
                  
                    $resp = $this->insertarProducto();
                    if($resp){
                        $respuesta = $_respuestas->response;
                        $respuesta["result"] = array(
                            "IDProducto" => $resp
                        );
                        return $respuesta;
                    }else{
                        return $_respuestas->error_500();
                    }
                }

           /* }else{
                return $_respuestas->error_401("El Token que envio es invalido o ha caducado");
            }
        }*/


       

    }


    private function insertarProducto(){
        $query = "INSERT INTO " . $this->table . " (Nombre,Referencia,Precio,Peso,IdCategoria,Stock,FechaCreacion)
        values
        ('" . $this->Nombre . "','" . $this->Referencia . "','" . $this->Precio ."','" . $this->Peso . "','"  . $this->IdCategoria . "','" . $this->Stock  . "','" . $this->FechaCreacion . "')"; 
        $resp = parent::nonQueryId($query);
        if($resp){
             return $resp;
        }else{
            return 0;
        }
    }
    
    public function put($json){
        $_respuestas = new respuestas;
        $datos = json_decode($json,true);

        /*if(!isset($datos['token'])){
            return $_respuestas->error_401();
        }else{
            $this->token = $datos['token'];
            $arrayToken =   $this->buscarToken();
            if($arrayToken){*/
                if(!isset($datos['IDProducto'])){
                    return $_respuestas->error_400();
                }else{
                    $this->IDProducto = $datos['IDProducto'];
                    if(isset($datos['Nombre'])) { $this->Nombre = $datos['Nombre']; }
                    if(isset($datos['Stock'])) { $this->Stock = $datos['Stock']; }
                    if(isset($datos['Precio'])) { $this->Precio = $datos['Precio']; }
                    if(isset($datos['Referencia'])) { $this->Referencia = $datos['Referencia']; }
                    if(isset($datos['Peso'])) { $this->Peso = $datos['Peso']; }
                    if(isset($datos['IdCategoria'])) { $this->IdCategoria = $datos['IdCategoria']; }
                    if(isset($datos['FechaCreacion'])) { $this->FechaCreacion = $datos['FechaCreacion']; }
                    if(isset($datos['token'])) { $this->token = $datos['token']; }
        
                    $resp = $this->modificarProducto();
                    if($resp){
                        $respuesta = $_respuestas->response;
                        $respuesta["result"] = array(
                            "IDProducto" => $this->IDProducto
                        );
                        return $respuesta;
                    }else{
                        return $_respuestas->error_500();
                    }
                }

          /*  }else{
                return $_respuestas->error_401("El Token que envio es invalido o ha caducado");
            }
        }*/


    }


    private function modificarProducto(){
        $query = "UPDATE " . $this->table . " SET Nombre ='" . $this->Nombre . "',Referencia = '" . $this->Referencia . "', Precio = '" . $this->Precio . "', Peso = '" .
        $this->Peso . "', IdCategoria = '" . $this->IdCategoria . "', Stock = '" . $this->Stock . "', FechaCreacion = '" . $this->FechaCreacion . 
         "' WHERE IDProducto = '" . $this->IDProducto . "'"; 
        $resp = parent::nonQuery($query);
        if($resp >= 1){
             return $resp;
        }else{
            return 0;
        }
    }


    public function delete($json){
        $_respuestas = new respuestas;
        $datos = json_decode($json,true);

      /*  if(!isset($datos['token'])){
            return $_respuestas->error_401();
        }else{
            $this->token = $datos['token'];
            $arrayToken =   $this->buscarToken();
            if($arrayToken){*/

                if(!isset($datos['IDProducto'])){
                    return $_respuestas->error_400();
                }else{
                    $this->IDProducto = $datos['IDProducto'];
                    $resp = $this->eliminarProducto();
                    if($resp){
                        $respuesta = $_respuestas->response;
                        $respuesta["result"] = array(
                            "IDProducto" => $this->IDProducto
                        );
                        return $respuesta;
                    }else{
                        return $_respuestas->error_500();
                    }
                }

           /* }else{
                return $_respuestas->error_401("El Token que envio es invalido o ha caducado");
            }
        }*/



     
    }


    private function eliminarProducto(){
        $query = "DELETE FROM " . $this->table . " WHERE IDProducto= '" . $this->IDProducto . "'";
        $resp = parent::nonQuery($query);
        if($resp >= 1 ){
            return $resp;
        }else{
            return 0;
        }
    }


    private function buscarToken(){
        $query = "SELECT  IdToken,UsuarioId,Estado from usuarios_token WHERE Token = '" . $this->token . "' AND Estado = 1";
        $resp = parent::obtenerDatos($query);
        if($resp){
            return $resp;
        }else{
            return 0;
        }
    }


    private function actualizarToken($IdToken){
        $date = date("Y-m-d H:i");
        $query = "UPDATE usuarios_token SET Fecha = '$date' WHERE IdToken = '$IdToken' ";
        $resp = parent::nonQuery($query);
        if($resp >= 1){
            return $resp;
        }else{
            return 0;
        }
    }



}





?>