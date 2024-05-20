<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\GameController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::prefix('v1')->group(function () {
    // Authentication
    Route::prefix('auth')->group(function () {
        Route::post('/signup', [AuthController::class, 'register']);
        Route::post('/signin', [AuthController::class, 'login']);
        Route::post('/signout', [AuthController::class, 'logout']);
    });

    Route::middleware('auth:sanctum')->group(function () {
        // User Informations
        Route::get('/admins', [UserController::class, 'getAdmin']);
        Route::get('/users', [UserController::class, 'getUser']);
        Route::post('/users', [UserController::class, 'addUser']);
        Route::put('/users/{id}', [UserController::class, 'update']);
        Route::delete('/users/{id}', [UserController::class, 'delete']);
        Route::get('/users/{username}', [UserController::class, 'getByUsn']);
        
        // Game Controll
        Route::get('/games', [GameController::class, 'index']);
        Route::get('/games/{slug}', [GameController::class, 'getGame']);
        Route::put('/games/{slug}', [GameController::class, 'updateGame']);
        Route::delete('/games/{slug}', [GameController::class, 'deleteGame']);
        Route::post('/games', [GameController::class, 'create']);
        Route::post('/games/{slug}/upload', [GameController::class, 'uploadAsset']);
    
        // Score Handle
        Route::get('/games/{slug}/scores', [GameController::class, 'getHighestScore']);
        Route::post('/games/{slug}/scores', [GameController::class, 'addScore']);
    });
});