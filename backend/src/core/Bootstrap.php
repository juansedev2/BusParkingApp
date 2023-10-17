<?php
use Jdev2\Apprest\core\App;
use Illuminate\Database\Capsule\Manager as Capsule;

App::set("config", require_once "./src/core/config/Config.php");

if(App::get("config")["production"]){
    ini_set('error_reporting', E_ALL | E_NOTICE | E_STRICT);
    ini_set('display_errors', '0');
    ini_set('track_errors', 'On');
}else{
    ini_set('display_errors', '1');
}

$config = (App::get("config"))["database"];
$capsule = new Capsule();

$capsule->addConnection([
    'driver' => $config["sgbd"],
    'host' => $config["server_ip"],
    'database' => $config["db_name"],
    'username' => $config["user"],
    'password' => $config["password"],
    'charset' => 'utf8',
    'collation' => 'utf8_unicode_ci',
    'prefix' => '',
]);

$capsule->setAsGlobal();
$capsule->bootEloquent();