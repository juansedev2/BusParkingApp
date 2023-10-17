<?php
namespace Jdev2\Apprest\app\models;
use Illuminate\Database\Eloquent\Model;

class Bus extends Model{

    // Attributes of the Bus model
    /**
     * @property string $table
     * Is the name of the table on the database
    */
    protected $table = "buses";
    /**
     * @property string $primariKey
     * The primary key associated with the table.
    */
    protected $primaryKey = "id";
    /**
     * The attributes that are mass assignable.
     * @property array $fillable
     */
    protected $fillable = ["id_parqueadero", "id_punto_origen", "id_punto_destino","tiempo_estadia", "hora_salida_origen", "hora_llegada_destion"];

    public function __construct(){
        parent::__construct();
    }    

    public static function formatDate(string $date) : string{
        return date("d-m-y h:i:s" ,strtotime($date));
    }
    
}