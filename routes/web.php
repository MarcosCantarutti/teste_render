<?php

use Illuminate\Support\Facades\Route;
use App\Models\User;

Route::get('/', function () {
    return view('welcome');
});


Route::get('/test-db', function () {
    try {
        // Tente buscar o primeiro usu�rio (caso exista)
        $user = User::first();
        
        // Verifique se o usu�rio foi encontrado
        if ($user) {
            return response()->json([
                'status' => 'success',
                'message' => 'Conex�o com o banco de dados PostgreSQL funcionando!',
                'user' => $user
            ]);
        } else {
            return response()->json([
                'status' => 'success',
                'message' => 'Banco de dados conectado, mas nenhum usu�rio encontrado.'
            ]);
        }
    } catch (\Exception $e) {
        // Se houver erro na conex�o, retorna um erro
        return response()->json([
            'status' => 'error',
            'message' => 'Erro ao conectar com o banco de dados: ' . $e->getMessage()
        ], 500);
    }
});

