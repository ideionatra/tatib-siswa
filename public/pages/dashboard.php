<?php

require_once __DIR__ . '/../../backend/Dashboard.php';

$dashboardModel = new \Dashboard();

$summary = $dashboardModel->getSummary();
$ranking = $dashboardModel->getViolationRanking(10);

?>

<div class="page-header">
    <div>
        <p class="eyebrow">Ringkasan sekolah</p>
        <h2>Dashboard Admin</h2>

        <p class="muted">
            Ringkasan data kelas, siswa, pelanggaran, dan prestasi.
        </p>
    </div>

    <!-- <a href="<?= e(url('/laporan')) ?>" class="btn btn-primary">
        Tambah Laporan
    </a> -->
</div>

<section class="summary-grid">
    <article class="summary-card summary-blue">
        <span class="summary-icon">K</span>

        <div>
            <p>Jumlah Kelas</p>
            <strong><?= (int) $summary['total_kelas'] ?></strong>
        </div>
    </article>

    <article class="summary-card summary-purple">
        <span class="summary-icon">S</span>

        <div>
            <p>Jumlah Siswa</p>
            <strong><?= (int) $summary['total_siswa'] ?></strong>
        </div>
    </article>

    <article class="summary-card summary-red">
        <span class="summary-icon">P</span>

        <div>
            <p>Poin Pelanggaran</p>
            <strong>
                <?= number_format((int) $summary['total_poin_pelanggaran']) ?>
            </strong>
        </div>
    </article>

    <article class="summary-card summary-green">
        <span class="summary-icon">A</span>

        <div>
            <p>Poin Prestasi</p>
            <strong>
                <?= number_format((int) $summary['total_poin_prestasi']) ?>
            </strong>
        </div>
    </article>
</section>

<section class="section-card">
    <div class="section-heading">
        <div>
            <p class="eyebrow">Peringkat siswa</p>
            <h2>Poin pelanggaran terbanyak</h2>
        </div>

        <a href="<?= e(url('/class-list')) ?>" class="text-link">
            Lihat semua kelas
        </a>
    </div>

    <?php if (!$ranking): ?>
        <div class="empty-state">
            <h3>Belum ada data siswa</h3>
            <p>Tambahkan siswa melalui halaman daftar kelas.</p>
        </div>
    <?php else: ?>
        <div class="table-wrap">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Peringkat</th>
                    <th>Siswa</th>
                    <th>Kelas</th>
                    <th>Pelanggaran</th>
                    <th>Prestasi</th>
                    <th>Total poin</th>
                </tr>
                </thead>

                <tbody>
                <?php foreach ($ranking as $index => $student): ?>
                    <tr>
                        <td>
                            <span class="rank-number">
                                <?= $index + 1 ?>
                            </span>
                        </td>

                        <td>
                            <strong><?= e($student['nama']) ?></strong>
                            <small>NIS: <?= e($student['nis']) ?></small>
                        </td>

                        <td><?= e($student['kelas']) ?></td>

                        <td>
                            <span class="badge badge-danger">
                                <?= (int) $student['poin_pelanggaran'] ?>
                            </span>
                        </td>

                        <td>
                            <span class="badge badge-success">
                                <?= (int) $student['poin_prestasi'] ?>
                            </span>
                        </td>

                        <td>
                            <strong><?= (int) $student['total_poin'] ?></strong>
                        </td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    <?php endif; ?>
</section>