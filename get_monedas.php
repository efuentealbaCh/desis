<?php
header('Content-Type: application/json');
require_once 'db_config.php';

try {
    $stmt = $conn->prepare("SELECT mone_codigo, mone_nombre FROM moneda");
    $stmt->execute();

    $monedas = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($monedas);
} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
