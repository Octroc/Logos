<?php
include 'config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $token = $_POST['token'];
    $nova_senha = password_hash($_POST['nova_senha'], PASSWORD_DEFAULT);

    // Verificar se o token é válido
    $stmt = $pdo->prepare("SELECT * FROM usuarios WHERE token = ?");
    $stmt->execute([$token]);
    $usuario = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($usuario) {
        // Atualizar a senha e remover o token
        $stmt = $pdo->prepare("UPDATE usuarios SET senha = ?, token = NULL WHERE token = ?");
        $stmt->execute([$nova_senha, $token]);

        echo "<script>alert('Senha redefinida com sucesso!'); window.location.href='index.html';</script>";
    } else {
        echo "<script>alert('Token inválido!'); window.location.href='index.html';</script>";
    }
}
?>
