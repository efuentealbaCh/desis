<?php
header('Content-Type: application/json');
require_once 'db_config.php';

$input = json_decode(file_get_contents('php://input'), true);
$codigo = $input['codigo'] ?? '';

if (empty($codigo)) {
    echo json_encode(['error' => 'Código no proporcionado']);
    exit;
}

try {
    $stmt = $conn->prepare("SELECT COUNT(*) FROM producto WHERE prod_codigo = ?");
    $stmt->execute([$codigo]);
    $exists = $stmt->fetchColumn() > 0;

    echo json_encode(['exists' => $exists]);
} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
