<?php

namespace App\Http\Controllers\Api;

use App\Helpers\ResponseFormatter;
use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class ApiAuthController extends Controller
{


    public function login(Request $request)
    {

        $validator= validator($request->all(), [
            'email'=>'required|email|min:3|max:255',
            'password' =>'required|min:8'

        ]);

        if($validator->fails()){
            return ResponseFormatter::responseError(Response::HTTP_BAD_REQUEST, $validator->errors()->first());
        }

        if(auth()->attempt([
            'email'=>$request->email,
            'password'=>$request->password
        ])){
           $user = auth()->user();
            $token=   $user->createToken('api_token')->plainTextToken;

            return ResponseFormatter::responseSuccess([
                'user'=>$user,
                'token'=>$token
            ], "Berhasil Login");

        }else{
            return ResponseFormatter::responseError(401,"Email atau Password salah" );
        }

    }

    public  function register(Request $request)
    {

        $validator = validator($request->all(), [
            'name' => 'required|min:3|max:255',
            'email'=>'required|min:3|max:255|email|unique:users,email',
            'password'=>'required|min:8'
        ]);

        if($validator->fails()){
            return ResponseFormatter::responseError(Response::HTTP_BAD_REQUEST, $validator->errors()->first());
        }

        $user = User::create($request->only(['name','email', 'password']));

     $token=   $user->createToken('api_token')->plainTextToken;

     return ResponseFormatter::responseSuccess([
         'user'=>$user,
         'token' =>$token
     ], "Berhasil Register");



    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return ResponseFormatter::responseSuccess(null, "Berhasil Logout");
    }


}
