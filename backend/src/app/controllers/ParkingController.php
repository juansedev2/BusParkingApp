<?php
namespace Jdev2\Apprest\app\controllers;
use Exception;
use Pecee\Http\Request;
use Jdev2\Apprest\app\models\Parking;
use Jdev2\Apprest\app\controllers\BaseController;
use Illuminate\Database\Capsule\Manager as Capsule;

class ParkingController extends BaseController{

    public function returnAllParkings(): string{

        try {
            $parkings = Capsule::select("CALL consultarMunicipiosParqueaderos()");
            $parkings = Parking::transformPointsData($parkings);
        } catch (\Throwable $th) {
            $parkings = null;
            return $th;
            //throw new Exception("Error with use the db: {$th}");
        }

        if(is_null($parkings)){
            return $this->transformToJson("null");
        }else{
            return $this->transformToJson($parkings);
        }
    }
    
}