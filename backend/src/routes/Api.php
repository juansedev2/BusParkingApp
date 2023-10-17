<?php
use Pecee\Http\Request;
use Pecee\SimpleRouter\SimpleRouter as Router;
use Jdev2\Apprest\app\controllers\BusController;
use Jdev2\Apprest\app\controllers\ParkingController;

// This contains the headers to get and send request of other domains (clients, servers, etc)
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: *");
header("Content-type: application/json");
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Pragma: no-cache");

response()->headers([
    'Access-Control-Allow-Origin: *',
    'Access-Control-Allow-Methods: *',
    'Access-Control-Allow-Headers: *',
    'Content-type: application/json'
]);

Router::get('/', function() {
    return Router::response()->json(["Api of the parking app, please add /api in the URL"]);
});
Router::get('/api', function() {
    return Router::response()->json(["Api of the parking app, to use it, please read the documentation to use with the URL after /api/"]);
});

// GET buses
Router::get("/api/buses", [BusController::class, "returnAllBuses"]);
Router::get("/api/buses/{id}", [BusController::class, "returnOneBus"]);
Router::get("/api/buses-por-parqueadero/{id}", [BusController::class, "returnBusesInParking"]);
Router::get("/api/parqueaderos", [ParkingController::class, "returnAllParkings"]);

// PUT - update bus
Router::put("/api/buses/actualizar-bus/", [BusController::class, "updateBus"]);

Router::options("/api/buses/actualizar-bus/", function(){
    return json_encode(["true to do it"]);
});

Router::error(function($req, $err) {
    Router::response()->httpCode($err->getCode())->json([
        'message' => $err->getCode() == 404 ? 'Not Found' : $err->getMessage()
    ]);
});

Router::start();