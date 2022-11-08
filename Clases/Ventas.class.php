<?php
require_once "conexion/conexion.php";
require_once "respuestas.class.php";


class ventas extends conexion {
 
    private $table = "venta";
    private $table1 = "producto";
    private $IdVenta = "";
    private $IdProducto = "";
    private $IdPersona = "";
    private $Cantidad = "";
    private $ValorVenta = "";
    private $Stock = "";


//912bc00f049ac8464472020c5cd06759

    public function listaventas($pagina = 1){ //Para controlar la carga de grandes volumenes de datos
        $inicio  = 0 ;
        $cantidad = 100;
        if($pagina > 1){
            $inicio = ($cantidad * ($pagina - 1)) +1 ;
            $cantidad = $cantidad * $pagina;
        }
        $query = "SELECT IdVenta,IdProducto,IdPersona,Cantidad,ValorVenta FROM " . $this->table . " limit $inicio,$cantidad";
        $datos = parent::obtenerDatos($query);
        return ($datos);
    }
    public function obtenerventas($id){
        $query = "SELECT IdVenta,producto.Nombre,Cantidad,ValorVenta FROM " . $this->table . " INNER JOIN producto ON producto.IdProducto = venta.IdProducto
        INNER JOIN persona ON persona.IdPersona = venta.IdPersona WHERE IdVenta = '$id'";
        return parent::obtenerDatos($query);

    }

 

    public function post($json){
        $_respuestas = new respuestas;
        $datos = json_decode($json,true);

        /*if(!isset($datos['token'])){
                return $_respuestas->error_401();
        }else{
            $this->token = $datos['token'];
            $arrayToken =   $this->buscarToken();
            if($arrayToken){*/

                if(!isset($datos['IdProducto']) || !isset($datos['IdPersona']) || !isset($datos['Cantidad']) || !isset($datos['ValorVenta'])){
                    return $_respuestas->error_400();
                }else{
                    $this->IdProducto = $datos['IdProducto'];
                    $this->IdPersona = $datos['IdPersona'];
                    $this->Cantidad = $datos['Cantidad'];
                    $this->ValorVenta = $datos['ValorVenta'];
                   
                  
                    $resp = $this->insertarVenta();
                    if($resp){
                        $respuesta = $_respuestas->response;
                        $respuesta["result"] = array(
                            "IdVenta" => $resp
                        );
                        return $respuesta;
                    }else{
                        return $_respuestas->error_500();
                    }
                }
/*
            }else{
                return $_respuestas->error_401("El Token que envio es invalido o ha caducado");
            }
        }*/


       

    }


    private function insertarVenta(){
        $query = "INSERT INTO " . $this->table . " (IdProducto,IdPersona,Cantidad,ValorVenta)
        values
        ('" . $this->IdProducto . "','" . $this->IdPersona . "','" . $this->Cantidad ."','" . $this->ValorVenta . "')"; 
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
                    
                    if(isset($datos['Stock'])) { $this->Stock = $datos['Stock']; }
        
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
/*
            }else{
                return $_respuestas->error_401("El Token que envio es invalido o ha caducado");
            }
        }*/


    }


    private function modificarProducto(){
        $query = "UPDATE " . $this->table1 . " SET Stock ='" . $this->Stock . 
         "' WHERE IDProducto = '" . $this->IDProducto . "'"; 
        $resp = parent::nonQuery($query);
        if($resp >= 1){
             return $resp;
        }else{
            return 0;
        }
    }
    
   





}





?>