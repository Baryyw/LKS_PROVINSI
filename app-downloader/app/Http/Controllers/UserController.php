<?php

namespace App\Http\Controllers;

use App\Models\scores;
use App\Models\User;
// use App\Models\Admin;
use App\Models\Game;
use App\Models\GameVersion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function getAdmin(Request $request)
    {

        if ($request->user()->roles != 'admin') {
            return response()->json([
                'status' => 'forbidden',
                'message' => 'You are not the administrator'
            ], 403);
        }
        $admin = User::where('roles', 'admin')->get();
        return response()->json([
            'totalElements' => $admin->count(),
            'content' => $admin
        ]);
    }
    public function getUser(Request $request)
    {
        if ($request->user()->roles != 'admin') {
            return response()->json([
                'status' => 'forbidden',
                'message' => 'You are not the administrator'
            ], 403);
        }
        $user = User::all();
        return response()->json([
            'totalElements' => $user->count(),
            'content' => $user
        ]);
    }
    public function addUser(Request $request)
    {
        if ($request->user()->roles == 'admin') {
            $validation = Validator::make($request->all(), [
                'username' => 'required|unique:users|min:4|max:60',
                'password' => 'required|min:5|max:10'
            ]);

            // If validation fails, return error response
            if ($validation->fails()) {
                return response()->json([
                    'status' => 'invalid',
                    'message' => 'Request body is not valid.',
                    'violations' => $validation->errors()
                ], 400);
            }
            $user = User::create([
                'username' => $request->username,
                'password' => bcrypt($request->password)
            ]);
            return response()->json([
                'status' => 'success',
                'username' => $request->username
            ], 200);
        } else {
            return response()->json([
                'status' => 'forbidden',
                'message' => 'You are not the administrator'
            ], 403);
        }
    }
    public function update(Request $request)
    {
        if ($request->user()->roles != 'admin') {
            return response()->json([
                'status' => 'forbidden',
                'message' => 'You are not the administrator'
            ], 403);
        }
        $user  = User::find($request->id);

        if(!$user){
            return response()->json([
                'status' => 'not-found',
                'message' => 'User Not Found'
            ], 404);
        }
        $validation = Validator::make($request->all(), [
            'username' => 'required|min:4|max:60',
            'password' => 'required|min:5|max:10'
        ]);
        if ($validation->fails()) {
            return response()->json([
                'status' => 'invalid',
                'message' => 'Request body is not valid.',
                'violations' => $validation->errors()
            ], 400);
        }

        if(User::where('username', $request->username)->exists()){
            return response()->json([
                'status' => 'invalid',
                'message' => "Username already exists"
            ], 400);
        }

        $user = User::find($request->id);
        $user->username = $request->username;
        $user->password = bcrypt($request->password);
        $user->save();

        return response()->json([
            'username' => $request->username,
            'password' => $request->password
        ], 200); 
    }
    
    public function delete(Request $request)
    {
        if ($request->user()->roles != 'admin') {
            return response()->json([
                'status' => 'forbidden',
                'message' => 'You are not the administrator'
            ], 403);
        }
        $user  = User::find($request->id);

        if(!$user){
            return response()->json([
                'status' => 'not-found',
                'message' => 'User Not Found'
            ], 404);
        }

        $user->delete();
        return response()->noContent();
    }
    public function getByUsn(Request $request)
    {
        // Find the user by their username
        $user = User::where('username', $request->username)->first();
    
        // If the user is not found, return a 404 response
        if (!$user) {
            return response()->json([
                'status' => 'not-found',
                'message' => 'User not found'
            ], 404);
        }
    
        // Fetch the games authored by the user
        $authoredGames = Game::where('author', $request->username)->get();
    
        // Fetch the high scores of the user
        $highScores = scores::where('user_id', $user->id)->get();
    
        // Prepare the high scores data in the desired format
        $formattedHighScores = $highScores->map(function ($score) {
            // Fetch game details for the score
            $gameVersion = GameVersion::where('id', $score->game_version_id)->first();
            $game = Game::where('id', $gameVersion->game_id)->first();
    
            return [
                'game' => [
                    'slug' => $game->slug,
                    'title' => $game->title,
                    'description' => $game->description,
                ],
                'score' => $score->score,
                'timestamp' => $score->timestamp,
            ];
        });
    
        // Return the user's information along with authored games and high scores
        return response()->json([
            'username' => $user->username,
            'registeredTimestamp' => $user->created_at->toIso8601String(),
            'authoredGames' => $authoredGames,
            'highscores' => $formattedHighScores,
        ], 200);
    }
    
}

