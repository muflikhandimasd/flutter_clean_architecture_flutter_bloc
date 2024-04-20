<?php

namespace App\Helpers;

use Symfony\Component\HttpFoundation\Response;

abstract class ResponseFormatter
{
    static public function responseSuccess( $data,string $message)
    {
        return response()->json([
            'code'=>Response::HTTP_OK,
            'data'=>$data,
            'message'=>$message
        ]);
    }

    static public function responseError(int $code,string $message)
    {
        return response()->json([
            'code' =>$code,
            'data'=>null,
            'message' =>$message
        ], $code);
    }
}
