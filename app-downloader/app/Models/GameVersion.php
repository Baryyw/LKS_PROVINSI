<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class GameVersion extends Model
{
    protected $table = 'game_versions';

    protected $fillable = [
        'game_id', 'version', 'storage_path'
    ];

    protected $hidden = [
        'created_at', 'updated_at'
    ];

    public function game()
    {
        return $this->belongsTo(Game::class);
    }
}
