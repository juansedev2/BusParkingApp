<?php
namespace Jdev2\Apprest\app\models;
use Illuminate\Database\Eloquent\Model;

class Parking extends Model{

    // Attributes of the Bus model
    /**
     * @property string $table
     * Is the name of the table on the database
    */
    protected $table = "parqueaderos";
    /**
     * @property string $primariKey
     * The primary key associated with the table.
    */
    protected $primaryKey = "id";
    /**
     * The attributes that are mass assignable.
     * @property array $fillable
     */
    protected $fillable = ["id_municipio", "ubicacion"];

    public function __construct(){
        parent::__construct();
    }    

    // This function transform the binary data of the point data of the bd, in a format of float data type
    // Thanks StackOverflow: https://stackoverflow.com/questions/24689852/fetching-mysql-geo-point-data-and-storing-result-in-php-variable
    private static function rawPointToFloatPair($data): array{   
        $res = unpack("lSRID/CByteOrder/lTypeInfo/dX/dY", $data);
        return [$res['X'],$res['Y']];
    }

    public static function transformPointsData(array $parkings){
        return array_map(function ($parking) {
            $parking->ubicacion = Parking::rawPointToFloatPair($parking->ubicacion);
            return $parking;
        }, $parkings);
    }
    
}