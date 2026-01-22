<?php
header('Content-Type: application/json');
require_once 'db_config.php';

try {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        throw new Exception('Método de solicitud no válido');
    }

    $codigo = $_POST['codigo'] ?? '';
    $nombre = $_POST['nombre'] ?? '';
    $precio = $_POST['precio'] ?? '';
    $moneda = $_POST['moneda'] ?? '';
    $descripcion = $_POST['descripcion'] ?? '';
    $materiales = $_POST['material'] ?? [];

    $conn->beginTransaction();

    $prod_material = is_array($materiales) ? implode(',', $materiales) : '';

    $stmt = $conn->prepare("INSERT INTO producto (prod_codigo, mone_codigo, prod_nombre, prod_precio, prod_material, prod_descripcion) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->execute([$codigo, $moneda, $nombre, $precio, $prod_material, $descripcion]);

    if (!empty($materiales) && is_array($materiales)) {
        $stmtMat = $conn->prepare("INSERT INTO producto_materiales (prod_codigo, mate_codigo) VALUES (?, ?)");
        foreach ($materiales as $mate_id) {
            $stmtMat->execute([$codigo, $mate_id]);
        }
    }

    $conn->commit();

    echo json_encode(['success' => true, 'message' => 'Producto guardado exitosamente']);
} catch (Exception $e) {
    if (isset($conn) && $conn->inTransaction()) {
        $conn->rollBack();
    }
    echo json_encode(['error' => $e->getMessage()]);
}
