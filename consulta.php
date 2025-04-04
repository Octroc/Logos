<?php
include 'config.php';

try {
    $stmt = $pdo->query("SELECT * FROM usuarios");

    echo "<table border='1' cellpadding='10' style='border-collapse: collapse; width: 100%; text-align: left;'>";
    echo "<tr><th>ID</th><th>Nome</th><th>Email</th></tr>";

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "<tr>";
        echo "<td>" . $row['id'] . "</td>";
        echo "<td>" . $row['nome'] . "</td>";
        echo "<td>" . $row['email'] . "</td>";
        echo "</tr>";
    }

    echo "</table>";
} catch (PDOException $e) {
    echo "Erro ao buscar dados: " . $e->getMessage();
}
?>
