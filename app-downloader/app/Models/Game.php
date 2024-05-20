<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Game extends Model
{
    // Define the table if it's not the plural of the model name
    protected $table = 'games';

    // Define the fillable fields
    protected $fillable = [
        'slug', 'title', 'description', 'thumbnail', 'upload_timestamp', 'author', 'score_count'
    ];

    protected $hidden = [
        'id',
        'created_at',
        'updated_at'
    ];

    // Define the hasMany relationship with GameVersion
    public function versions()
    {
        return $this->hasMany(GameVersion::class);
    }
}
