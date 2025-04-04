<?php
include 'config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['email'];

    // Verificar se o e-mail está cadastrado
    $stmt = $pdo->prepare("SELECT * FROM usuarios WHERE email = ?");
    $stmt->execute([$email]);
    $usuario = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($usuario) {
        // Criar um token seguro
        $token = bin2hex(random_bytes(50));
        $stmt = $pdo->prepare("UPDATE usuarios SET token = ? WHERE email = ?");
        $stmt->execute([$token, $email]);

        // Criar link de redefinição de senha
        $link = "http://logos.com/redefinir_senha.php?token=$token";

        // Enviar e-mail (exemplo)
        $assunto = "Recuperação de Senha";
        $mensagem = "Clique no link para redefinir sua senha: $link";
        $cabecalhos = "From: no-reply@seusite.com";
        
        mail($email, $assunto, $mensagem, $cabecalhos);

        echo "<script>alert('E-mail enviado! Verifique sua caixa de entrada.'); window.location.href='index.html';</script>";
    } else {
        echo "<script>alert('E-mail não encontrado!'); window.location.href='esqueci_senha.html';</script>";
    }
}
?>
