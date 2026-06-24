<?php 
require_once __DIR__ . '/../../backend/DataPelanggaran.php';

$model = new \DataPelanggaran();
$data = $model->getAllDataPelanggaran();
?>
<?php while($row = $data->fetch_assoc()): ?>
    <li><?= $row['jenis_pelanggaran']; ?></li>
<?php endwhile; ?>