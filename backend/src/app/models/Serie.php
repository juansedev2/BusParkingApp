<?php
namespace Jdev2\Apij\app\models;

use Illuminate\Database\Eloquent\Model;

class Serie extends Model{

    // Attributes of Model
    /**
     * @property string $table
     * Is the name of the table on the database
    */
    protected $table = "series";
    /**
     * @property string $primariKey
     * The primary key associated with the table.
    */
    protected $primaryKey = "id";
    /**
     * The attributes that are mass assignable.
     * @property array $fillable
     */
    protected $fillable = ["title", "description", "gender", "seasons_number"];

    public function __construct(){
        parent::__construct();
    }    

}