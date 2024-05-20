<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Admin;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    /**
     * Register a new user.
     */
    public function register(Request $request)
    {
        // Validate the incoming request data
        $validation = Validator::make($request->all(), [
            'username' => 'required|unique:users|min:4|max:60',
            'password' => 'required|min:5|max:10'
        ]);
        
        // If validation fails, return error response
        if ($validation->fails()) {
            return response()->json([
                'status' => 'failed',
                'errors' => $validation->errors()
            ], 422);
        }
        
        // Create a new user
        $user = User::create([
            'username' => $request->username,
            'password' => bcrypt($request->password)
        ]);
        
        // If user creation is successful, generate a token
        if ($user) {
            $token = $user->createToken('auth_token')->plainTextToken;

            return response()->json([
                'status' => 'success',
                'token' => $token
            ], 200);
        } else {
            return response()->json([
                'status' => 'failed',
                'message' => 'User registration failed.'
            ], 500);
        }
    }
    
    public function login(Request $request)
    { 
        $validation = Validator::make($request->all(), [
            'username' => 'required|min:4|max:60',
            'password' => 'required|min:5'
        ]);
        if ($validation->fails()) {
            return response()->json([
                'status' => 'failed',
                'errors' => $validation->errors()
            ], 422);
        }

        if (!Auth::attempt($request->only('username', 'password'))) {
            return response()->json(['message' => 'Invalid login credentials'], 401);
        }
        $user = $request->user();
        $token = $user->createToken('auth_token')->plainTextToken;
        return response()->json([
            'status' => 'success',
            'token' => $token
        ]);

    }
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'Logged out successfully']);
    }
    
    /**
     * Other methods (index, create, store, show, edit, update, destroy)
     * can be defined as needed.
     */
}
