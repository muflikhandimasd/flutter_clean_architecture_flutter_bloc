<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::prefix('v1')->group(function (){
    Route::prefix('auth')->group(function (){
        Route::post('/login', [\App\Http\Controllers\Api\ApiAuthController::class, 'login']);
        Route::post('/register', [\App\Http\Controllers\Api\ApiAuthController::class, 'register']);
        Route::post('/logout', [\App\Http\Controllers\Api\ApiAuthController::class, 'logout'])->middleware('auth:sanctum');
    });



    Route::middleware('auth:sanctum')->prefix('posts')->group(function (){
        Route::get('/', [\App\Http\Controllers\Api\ApiPostController::class, 'index']);
        Route::post('/', [\App\Http\Controllers\Api\ApiPostController::class, 'store']);
        Route::put('/{id}', [\App\Http\Controllers\Api\ApiPostController::class, 'update']);
        Route::delete('/{id}', [\App\Http\Controllers\Api\ApiPostController::class, 'destroy']);
    });
});
