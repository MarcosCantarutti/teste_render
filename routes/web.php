<?php

use Illuminate\Support\Facades\Route;
use App\Models\User;

Route::get('/', function () {
    return view('welcome');
});


Route::get('/test-db', function () {
    try {
        // Tente buscar o primeiro usuário (caso exista)
        $user = User::first();
        
        // Verifique se o usuário foi encontrado
        if ($user) {
            return response()->json([
                'status' => 'success',
                'message' => 'Conexão com o banco de dados PostgreSQL funcionando!',
                'user' => $user
            ]);
        } else {
            return response()->json([
                'status' => 'success',
                'message' => 'Banco de dados conectado, mas nenhum usuário encontrado.'
            ]);
        }
    } catch (\Exception $e) {
        // Se houver erro na conexão, retorna um erro
        return response()->json([
            'status' => 'error',
            'message' => 'Erro ao conectar com o banco de dados: ' . $e->getMessage()
        ], 500);
    }
});

