<?php
session_start();
include 'config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['email'];
    $senha = $_POST['senha'];

    $stmt = $pdo->prepare("SELECT * FROM usuarios WHERE email = ?");
    $stmt->execute([$email]);
    $usuario = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$usuario) {
        header("Location: index.html?msg=E-mail não encontrado!&tipo=danger");
        exit;
    }

    if (!password_verify($senha, $usuario['senha'])) {
        header("Location: index.html?msg=Senha incorreta!&tipo=warning");
        exit;
    }

    $_SESSION['user_id'] = $usuario['id'];
    $_SESSION['user_name'] = $usuario['nome'];
    header("Location: projeto_final.html"); 
    exit;
}
?>
