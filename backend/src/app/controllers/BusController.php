<?php
namespace Jdev2\Apprest\app\controllers;
use Exception;
use Pecee\Http\Request;
use Jdev2\Apprest\app\models\Bus;
use Jdev2\Apprest\app\controllers\BaseController;
use Illuminate\Database\Capsule\Manager as Capsule;
class BusController extends BaseController{

    // TODO: HACER LOS DEM�S CONTROLADORES Y PENSAR BIEN EN LA INFORMACI�N A TRATAR EN CRUDS

    public function returnAllBuses(): string{

        try {
            $buses = Capsule::select("CALL consultarBuses()");
        } catch (\Throwable $th) {
            $buses = null;
            return $th;
            //throw new Exception("Error with use the db: {$th}");
        }

        if(is_null($buses)){
            return $this->transformToJson("null");
        }else{
            return $this->transformToJson($buses);
        }
    }

    public function returnOneBus(string|int $id) : string{
        
        try {
            $bus = Bus::where("id", $id)->get()->makeHidden(["created_at", "updated_at"]);
        } catch (\Throwable $th) {
            $bus = null;
            //throw new Exception("Error with use the db: {$th}");
        }

        if(is_null($bus)){
            return $this->transformToJson("null");
        }else{
            return $this->transformCollectToJSON($bus);
        }
    }

    public function returnBusesInParking(string|int $id_parking) : string{

        try {
            $buses_por_parqueadero = Capsule::select("CALL consultarBusesPorParqueadero(?)", [$id_parking]);

        } catch (\Throwable $th) {
            $buses_por_parqueadero = null;
            //throw new Exception("Error with use the db: {$th}");
        }
        if(is_null($buses_por_parqueadero )){
            return $this->transformToJson("null");
        }else if(empty($buses_por_parqueadero)){
            return json_encode(["answer" => "false"]);
        }
        else{
            return $this->transformToJSON($buses_por_parqueadero );
        }
    }

    public function addBus(string $title = "", string $description = "", string $gender = "", string|int $seasons_number = ""){

        if(empty($title) or empty($description) or empty($gender) or empty($seasons_number)){
            return json_encode([1 => "Incomplete data"]);
        }else{

            try {
                $bus = Bus::create([
                    "title" => $title,
                    "description" => $description,
                    "gender" => $gender,
                    "seasons_number" => $seasons_number
                ]);
            } catch (\Throwable $th) {
                $bus = null;
                //throw new Exception("Error with use the db: {$th}");
            }

            if($bus){
                return json_encode([1 => "Successful insert of a new bus"]);
            }else{
                json_encode([1 => "An error on insert, please try again or later"]);
            }

        }
    }

    public function updateBus(){
        
        $id_bus = input("id_bus") ?? "";
        $id_parqueadero = input("id_parqueadero") ?? "";
	$departure_time = input("departure_time") ?? "";
	$arrival_time= input("arrival_time") ?? "";

        if(empty($id_parqueadero) or empty($id_bus) or empty($departure_time) or empty($arrival_time)){
            return json_encode(["answer" => "Incomplete data"]);
        }else{

            try {
                $bus = Bus::where("id", $id_bus)->update([
                    "id_parqueadero" => $id_parqueadero,
		            "hora_salida_origen" => Bus::formatDate($departure_time),
		            "hora_llegada_destino" => Bus::formatDate($arrival_time)
                ]);
            } catch (\Throwable $th) {
                $bus = null;
                return json_encode(["answer" => "Parking bussy"]);
            }

            if($bus){
                return json_encode(["answer" => "true"]);
            }else{
                return json_encode(["answer" => "An error on update, please try again or later, verify the data to update"]);
            }

        }
  
    }

    public function deleteBus(string|int $id = ""){

        if(empty($id)){
            return json_encode([1 => "Incomplete data, ID null"]);
        }else{

            try {
                $bus = Bus::where("id", $id)->delete();
            } catch (\Throwable $th) {
                $bus = null;
                //throw new Exception("Error with use the db: {$th}");
            }

            if($bus){
                return json_encode([0 => "Successful delete the bus by id {$id}"]);
            }else{
                json_encode([1 => "An error on delete, please try again or later, verify the data to update"]);
            }

        }
  
    }
    
}