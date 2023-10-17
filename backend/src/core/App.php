<?php
namespace Jdev2\Apprest\core;

/**
 * This class is the Injector dependency of the app
*/

class App{

    protected static Array $dependencies = [];

    public static function set(string $key, mixed $value){
        static::$dependencies[$key] = $value;
    }

    public static function get(string $key){
        return static::$dependencies[$key];
    }
}