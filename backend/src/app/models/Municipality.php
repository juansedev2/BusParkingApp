<?php
namespace Jdev2\Apprest\app\models;
use Illuminate\Database\Eloquent\Model;

class Municipality extends Model{

    // Attributes of the Bus model
    /**
     * @property string $table
     * Is the name of the table on the database
    */
    protected $table = "municipios";
    /**
     * @property string $primariKey
     * The primary key associated with the table.
    */
    protected $primaryKey = "id";
    /**
     * The attributes that are mass assignable.
     * @property array $fillable
     */
    protected $fillable = ["nombre", "ubicacion"];

    public function __construct(){
        parent::__construct();
    }    
    
}