<?php

namespace App\Http\Controllers\Api;

use App\Helpers\ResponseFormatter;
use App\Http\Controllers\Controller;
use App\Models\Post;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class ApiPostController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $userId = auth()->user()->id;
        $posts = Post::with('user')->where('user_id', $userId)->orderBy('id', 'desc')->get();
        return ResponseFormatter::responseSuccess($posts, "Sukses Get All Post");
    }



    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $userId = auth()->user()->id;

        $validator = validator($request->all(), [
            'title'=>'required',
            'body'=>'required'
        ]);

        if($validator->fails()){
            return ResponseFormatter::responseError(Response::HTTP_BAD_REQUEST, $validator->errors()->first());
        }

        $post = Post::create([
            'user_id'=>$userId,
            'title'=>$request->title,
            'body' =>$request->body
        ]);

        return ResponseFormatter::responseSuccess($post, "Berhasil membuat Post");
    }



    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $post = Post::find($id);
        if(!$post){
            return ResponseFormatter::responseError(Response::HTTP_NOT_FOUND, "Post Tidak Ditemukan");
        }
        $userId = auth()->user()->id;
        $validator = validator($request->all(), [
            'title'=> 'required',
            'body'=>'required'
        ]);

        if($validator->fails()){
            return ResponseFormatter::responseError(Response::HTTP_BAD_REQUEST, $validator->errors()->first());
        }

        $post->update([
            'user_id'=>$userId,
            'title'=>$request->title,
            'body'=>$request->body
            ]);

        return  ResponseFormatter::responseSuccess($post, "Berhasil Update Post");
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $post = Post::find($id);
        if(!$post){
            return ResponseFormatter::responseError(Response::HTTP_NOT_FOUND, "Post Tidak Ditemukan");
        }

        $post->delete();
        return ResponseFormatter::responseSuccess(null, "Berhasil hapus post");
    }
}
