<?php
header('Content-Type: application/json');
require_once 'db_config.php';

if (isset($_GET['bode_codigo'])) {
    $bode_codigo = $_GET['bode_codigo'];

    try {
        $stmt = $conn->prepare("SELECT sucu_codigo, sucu_nombre FROM sucursal WHERE bode_codigo = :bode_codigo");
        $stmt->bindParam(':bode_codigo', $bode_codigo);
        $stmt->execute();

        $sucursales = $stmt->fetchAll(PDO::FETCH_ASSOC);

        echo json_encode($sucursales);
    } catch (PDOException $e) {
        echo json_encode(['error' => $e->getMessage()]);
    }
} else {
    echo json_encode([]);
}
