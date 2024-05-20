<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Game;
use App\Models\GameVersion;
use App\Models\scores;
use App\Models\User;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\DB;


class GameController extends Controller
{
    public function index(Request $request)
    {
        $page = $request->query('page', 0);
        $size = $request->query('size', 10);
        $sortBy = $request->query('sortBy', 'title');
        $sortDir = $request->query('sortDir', 'asc');

        $validation = Validator::make($request->all(), [
            'page' => 'integer|min:0',
            'size' => 'integer|min:1',
            'sortBy' => 'in:title,popular,uploaddate',
            'sortDir' => 'in:asc,desc',
        ]);
        if ($validation->fails()) {
            return response()->json([
                'status' => 'invalid',
                'errors' => $validation->errors()
            ], 422);
        }
        $request->validate([
            'page' => 'integer|min:0',
            'size' => 'integer|min:1',
            'sortBy' => 'in:title,popular,uploaddate',
            'sortDir' => 'in:asc,desc',
        ]);

        $sortableFields = [
            'title' => 'title',
            'popular' => 'score_count',
            'uploaddate' => 'upload_timestamp',
        ];

        $query = Game::query();

        if (isset($sortableFields[$sortBy])) {
            $query->orderBy($sortableFields[$sortBy], $sortDir);
        }

        $games = $query->paginate($size, ['*'], 'page', $page + 1);

        return response()->json([
            'page' => $games->currentPage() - 1,
            'size' => $games->perPage(),
            'totalElements' => $games->total(),
            'content' => $games->items(),
        ]);
    }
    public function create(Request $request)
    {
        $validation = Validator::make($request->all(), [
            'title' => 'required|unique:games,title|min:3|max:60',
            'description' => 'required|min:0|max:200'
        ]);

        if ($validation->fails()) {
            return response()->json([
                'status' => 'invalid',
                'message' => 'Request body is not valid.',
                'violations' => $validation->errors()
            ], 400);
        }

        $slug = Str::slug($request->title);
        Game::create([
            'title' => $request->title,
            'description' => $request->description,
            'version' => 1,
            'slug' => $slug,
            'author' => $request->user()->username
        ]);

        return response()->json([
            'status' => 'success',
            'slug' => $slug
        ], 200);
    }
    public function getGame(Request $request)
    {

        $game = Game::where('slug', $request->slug)->first();

        if (!$game) {
            return response()->json([
                'status' => 'invalid',
                'message' => 'Game not found'
            ], 404);
        }
        $version = ($game->version != null) ? $game->version : 1;
        return response()->json([
            'slug' => $game->slug,
            'title' => $game->title,
            'decription' => $game->description,
            'thumbnail' => ($game->thumbnail != null) ? '/games/' . $game->slug . '/' . $version . '/thumbnail.png' : null,
            'uploadTimestamp' => $game->upload_at,
            'author' => $game->author,
            'scoreCount' => $game->score_count,
            'gamePath' => '/games/' . $game->slug . '/' . $version . '/'
        ]);
    }
    public function uploadAsset(Request $request)
    {
        // Validate the request inputs
        $validation = Validator::make($request->all(), [
            'game' => 'required|mimes:zip|max:10240', // Max size 10MB
            'thumbnail' => 'required|mimes:jpeg,png,jpg|max:2048', // Max size 2MB
        ]);

        // If validation fails, return a plain text error message
        if ($validation->fails()) {
            return response()->json([
                'status' => 'invalid',
                'message' => 'Request body is not valid.',
                'violations' => $validation->errors()
            ], 400);
        }

        // Retrieve the latest game with the given slug
        $latestGame = Game::where('slug', $request->slug)->with('versions')->first();

        // If the game does not exist, return a 404 error
        if (!$latestGame) {
            return response()->json([
                'status' => 'invalid',
                'message' => 'Game Not Found'
            ], 404);
        }

        // Check if the authenticated user is the author of the game
        if ($latestGame->author != $request->user()->username) {
            return response()->json([
                'status' => 'forbidden',
                'message' => 'You are not the author of this game'
            ], 403);
        }

        // Determine the new version number
        $latestVersion = $latestGame->versions()->latest('version')->first();
        $version = $latestVersion ? $latestVersion->version + 1 : 1;

        // Store the uploaded files
        $thumbnail = $request->file('thumbnail');
        $gameAssets = $request->file('game');
        $pathThumbnail = $thumbnail->storeAs("games/{$request->slug}/{$version}/", 'thumbnail.png');
        $pathAssets = $gameAssets->storeAs("games/{$request->slug}/{$version}", 'game.zip');

        // Save the new game version information
        $gameVersion = new GameVersion();
        $gameVersion->game_id = $latestGame->id;
        $gameVersion->version = 'v'.$version;
        $gameVersion->storage_path = "/games/{$version}/v{$version}/";
        $gameVersion->save();

        // Update the game's thumbnail and latest version
        $latestGame->update([
            'thumbnail' => $pathThumbnail,
            'version' => $version,
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Files uploaded successfully',
        ], 200);
    }

    public function serveGameFiles($slug, $version)
    {
        $game = Game::where('slug', $slug)
            ->orderBy('version', 'desc')
            ->first();
        if (!$game) {
            return response('Game Not Found', 404)->header('Content-Type', 'text/plain');
        }

        $gameVersion = $game->where('version', $version)->first();
        if (!$gameVersion) {
            return response('Version Not Found', 404)->header('Content-Type', 'text/plain');
        }

        return Storage::download('/games/' . $slug . '/' . $version . '/game.zip');
    }
    public function updateGame(Request $request)
    {
        $validation = Validator::make($request->all(), [
            'title' => 'required|unique:games,title|min:3|max:60',
            'description' => 'required|min:0|max:200'
        ]);
        if ($validation->fails()) {
            return response()->json([
                'status' => 'invalid',
                'message' => 'Request body is not valid.',
                'violations' => $validation->errors()
            ], 400);
        }

        $game = Game::where('slug', $request->slug)
            ->orderBy('version', 'desc')
            ->first();
        if (!$game) {
            return response('Game Not Found', 404)->header('Content-Type', 'text/plain');
        }
        if($game->author != $request->user()->username){
            return response()->json([
                'status' => 'forbidden',
                'message' => 'You are not the game author'
            ], 403);
        }
        $game->title = $request->title;
        $game->description = $request->description;
        $game->save();

        return response()->json([
            'status' => 'success',
        ], 200);
    }
    public function deleteGame(Request $request)
    {
        $game = Game::where('slug', $request->slug)->first();
        if(!$game){
            return response()->json([
                'status' => 'not-found',
                'message' =>  'Game not found'
            ], 404);
        }

        if($game->author != $request->user()->username){
            return response()->json([
                'status' => 'forbidden',
                'message' => 'You are not this game author'
            ], 403);
        }
        $game->delete();
        return response()->noContent();
    }
    public function getHighestScore(Request $request)
    {
        $game = Game::where('slug', $request->slug)->first();
    
        if (!$game) {
            return response()->json([
                'status' => 'not-found',
                'message' => 'Game not found'
            ], 404);
        }
    
        $scores = [];
        $getScores = scores::where('game_version_id', $game->id)->get();
        
        foreach ($getScores as $score) {
            $username = User::where('id', $score->user_id)->first('username');
            $scores[] = [
                'username' => $username->username,
                'score' => $score->score,
                'timestamp' => $score->created_at
            ];
        }
        
        $sortedScores = collect($scores)->sortByDesc('score')->values()->all();
        
        return response()->json([
            'scores' => $sortedScores
        ], 200);
    }
    
    public function addScore(Request $request)
    {
        $validation = Validator::make($request->all(), [
            'score' => 'required|min:0|int'
        ]);
        if ($validation->fails()) {
            return response()->json([
                'status' => 'invalid',
                'message' => 'Request body is not valid.',
                'violations' => $validation->errors()
            ], 400);
        }
        $game = Game::where('slug', $request->slug)->first();
        if (!$game) {
            return response()->json([
                'status' => 'not-found',
                'message' => 'Game not found'
            ], 404);
        }
        $score = new scores();
        $score->user_id = $request->user()->id;
        $score->game_version_id = $game->id;
        $score->score = $request->score;
        $score->save();

        return response()->json([
            'status' => 'success'
        ], 201);
    }
}
