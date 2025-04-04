<?php
include 'config.php'; 

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nome = $_POST['nome'];
    $email = $_POST['email'];
    $senha = $_POST['senha'];
    $confirm_senha = $_POST['confirm_senha'];

    if ($senha !== $confirm_senha) {
        header("Location: cadastro.html?msg=As senhas não coincidem!&tipo=danger");
        exit;
    }

 
    $senha_hash = password_hash($senha, PASSWORD_DEFAULT);

    try {
     
        $stmt = $pdo->prepare("SELECT COUNT(*) FROM usuarios WHERE email = ?");
        $stmt->execute([$email]);
        $existe = $stmt->fetchColumn();

        if ($existe > 0) {
            header("Location: cadastro.html?msg=Este e-mail já está cadastrado!&tipo=danger");
            exit;
        }

        $stmt = $pdo->prepare("INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)");
        $stmt->execute([$nome, $email, $senha_hash]);

        header("Location: cadastro.html?msg=Cadastro realizado com sucesso!&tipo=success");
        exit;
    } catch (PDOException $e) {
        header("Location: cadastro.html?msg=Erro ao cadastrar: " . $e->getMessage() . "&tipo=danger");
        exit;
    }
}
?>



