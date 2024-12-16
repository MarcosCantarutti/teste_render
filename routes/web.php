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
            echo "Primeiro usuario do banco:<b>";
            dd($user->toArray());
        } else {
            dd(['error' => 'Sem dados a serem exibidos']);
        }
    } catch (\Exception $e) {
        // Se houver erro na conexão, retorna um erro
        return response()->json([
            'status' => 'error',
            'message' => 'Erro ao conectar com o banco de dados: ' . $e->getMessage()
        ], 500);
    }
});


