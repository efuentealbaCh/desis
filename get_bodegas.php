<?php
header('Content-Type: application/json');
require_once 'db_config.php';

try {
    $stmt = $conn->prepare("SELECT bode_codigo, bode_nombre FROM bodega");
    $stmt->execute();

    $bodegas = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($bodegas);
} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
