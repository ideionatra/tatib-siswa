<?php

require_once __DIR__ . '/../../backend/Kelas.php';

$classModel = new \Kelas();
$classes = $classModel->getAllWithStudentCount();

?>

<div class="page-header">
    <div>
        <p class="eyebrow">Data sekolah</p>
        <h2>Daftar Kelas</h2>

        <p class="muted">
            Pilih kelas untuk melihat dan mengelola data siswa.
        </p>
    </div>
</div>

<?php if (!$classes): ?>
    <section class="section-card">
        <div class="empty-state">
            <h3>Belum ada kelas</h3>
            <p>Data kelas belum tersedia pada database.</p>
        </div>
    </section>
<?php else: ?>
    <section class="class-grid">
        <?php foreach ($classes as $class): ?>
            <a
                href="<?= e(url('/class') . '?id=' . (int) $class['id']) ?>"
                class="class-card"
            >
                <div class="class-card-top">
                    <span class="class-symbol">
                        <?= e($class['index_tingkat']) ?>
                    </span>

                    <span class="class-arrow">&rarr;</span>
                </div>

                <div>
                    <p>Kelas</p>
                    <h3><?= e($class['nama_lengkap']) ?></h3>
                </div>

                <div class="class-count">
                    <strong><?= (int) $class['jumlah_siswa'] ?></strong>
                    <span>Siswa</span>
                </div>
            </a>
        <?php endforeach; ?>
    </section>
<?php endif; ?>