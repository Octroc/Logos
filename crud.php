
<?php
include 'config.php';

if (isset($_POST['criar'])) {
    $nome = $_POST['nome'];
    $email = $_POST['email'];
    $senha = password_hash($_POST['senha'], PASSWORD_DEFAULT);
    
    try {
        $stmt = $pdo->prepare("INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)");
        $stmt->execute([$nome, $email, $senha]);
        echo "<script>alert('Usuário cadastrado com sucesso!'); window.location.href='crud.php';</script>";
    } catch (PDOException $e) {
        echo "Erro ao cadastrar: " . $e->getMessage();
    }
}

if (isset($_POST['atualizar'])) {
    $id = $_POST['id'];
    $nome = $_POST['nome'];
    $email = $_POST['email'];
    
    try {
        $stmt = $pdo->prepare("UPDATE usuarios SET nome = ?, email = ? WHERE id = ?");
        $stmt->execute([$nome, $email, $id]);
        echo "<script>alert('Usuário atualizado com sucesso!'); window.location.href='crud.php';</script>";
    } catch (PDOException $e) {
        echo "Erro ao atualizar: " . $e->getMessage();
    }
}

if (isset($_GET['deletar'])) {
    $id = $_GET['deletar'];
    try {
        $stmt = $pdo->prepare("DELETE FROM usuarios WHERE id = ?");
        $stmt->execute([$id]);
        echo "<script>alert('Usuário excluído com sucesso!'); window.location.href='crud.php';</script>";
    } catch (PDOException $e) {
        echo "Erro ao excluir: " . $e->getMessage();
    }
}

$stmt = $pdo->query("SELECT * FROM usuarios");
$usuarios = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRUD Usuários</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Gerenciamento de Usuários</h2>
        
        <form action="crud.php" method="POST">
            <input type="text" name="nome" placeholder="Nome" class="form-control mb-2" required>
            <input type="email" name="email" placeholder="Email" class="form-control mb-2" required>
            <input type="password" name="senha" placeholder="Senha" class="form-control mb-2" required>
            <button type="submit" name="criar" class="btn btn-success w-100">Cadastrar</button>
        </form>

        <hr>

        <h3>Usuários Cadastrados</h3>
        <table class="table table-bordered">
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Email</th>
                <th>Ações</th>
            </tr>
            <?php foreach ($usuarios as $usuario): ?>
                <tr>
                    <td><?= $usuario['id'] ?></td>
                    <td><?= $usuario['nome'] ?></td>
                    <td><?= $usuario['email'] ?></td>
                    <td>
                        <a href="crud.php?editar=<?= $usuario['id'] ?>" class="btn btn-warning btn-sm">Editar</a>
                        <a href="crud.php?deletar=<?= $usuario['id'] ?>" class="btn btn-danger btn-sm" onclick="return confirm('Tem certeza que deseja excluir?')">Excluir</a>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
    </div>

    <?php if (isset($_GET['editar'])): 
        $id = $_GET['editar'];
        $stmt = $pdo->prepare("SELECT * FROM usuarios WHERE id = ?");
        $stmt->execute([$id]);
        $usuario = $stmt->fetch(PDO::FETCH_ASSOC);
    ?>
    <div class="container mt-3">
        <h3>Editar Usuário</h3>
        <form action="crud.php" method="POST">
            <input type="hidden" name="id" value="<?= $usuario['id'] ?>">
            <input type="text" name="nome" value="<?= $usuario['nome'] ?>" class="form-control mb-2" required>
            <input type="email" name="email" value="<?= $usuario['email'] ?>" class="form-control mb-2" required>
            <button type="submit" name="atualizar" class="btn btn-primary w-100">Atualizar</button>
        </form>
    </div>
    <?php endif; ?>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
