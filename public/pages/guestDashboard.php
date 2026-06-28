<?php

require_once __DIR__ . '/../../backend/Dashboard.php';

$dashboardModel = new \Dashboard();
$today = date('Y-m-d');
$violations = $dashboardModel->getTodayViolations($today);

?>

<div class="guest-page">
    <div class="guest-nav-nav">
        <header class="guest-nav">
            <a href="<?= e(url('/')) ?>" class="brand">
                <img
                    src="<?= e(url('/public/assets/images/logo_tatib.png')) ?>"
                    alt="Logo Tatib Siswa"
                    class="brand-logo"
                >
    
                <div>
                    <strong>Tatib Siswa</strong>
                    <span>SMA Bisnis dan Teknologi Indonesia</span>
                </div>
            </a>
    
            <?php if (is_logged_in()): ?>
                <a href="<?= e(url('/admin')) ?>" class="btn btn-primary">
                    Dashboard Admin
                </a>
            <?php else: ?>
                <a href="<?= e(url('/login')) ?>" class="btn btn-primary">
                    Login Admin
                </a>
            <?php endif; ?>
        </header>
    </div>

    <section class="guest-hero">
        <div class="container hero-content">
            <div class="hero-copy">
                <p class="eyebrow">Informasi tata tertib sekolah</p>

                <h1>Daftar pelanggaran siswa hari ini</h1>

                <p>
                    Informasi pelanggaran pada
                    <?= e(date('d-m-Y', strtotime($today))) ?>.
                    Data diperbarui oleh administrator sekolah.
                </p>
            </div>

            <div class="hero-stat">
                <strong><?= count($violations) ?></strong>
                <span>Pelanggaran hari ini</span>
            </div>
        </div>
    </section>

    <main class="container guest-content">
        <section class="section-card">
            <div class="section-heading">
                <div>
                    <p class="eyebrow">Data terbaru</p>
                    <h2>Pelanggaran hari ini</h2>
                </div>

                <span class="badge badge-danger">
                    <?= count($violations) ?> laporan
                </span>
            </div>

            <?php if (!$violations): ?>
                <div class="empty-state">
                    <h3>Belum ada pelanggaran hari ini</h3>
                    <p>
                        Tidak ada data pelanggaran yang tercatat
                        untuk tanggal ini.
                    </p>
                </div>
            <?php else: ?>
                <div class="table-wrap">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>No.</th>
                            <th>Siswa</th>
                            <th>Kelas</th>
                            <th>Pelanggaran</th>
                            <th>Poin</th>
                            <th>Keterangan</th>
                            <th>Sanksi</th>
                        </tr>
                        </thead>

                        <tbody>
                        <?php foreach ($violations as $index => $violation): ?>
                            <tr>
                                <td><?= $index + 1 ?></td>

                                <td>
                                    <strong><?= e($violation['nama']) ?></strong>
                                    <small>NIS: <?= e($violation['nis']) ?></small>
                                </td>

                                <td><?= e($violation['kelas']) ?></td>

                                <td>
                                    <?= e($violation['jenis_pelanggaran']) ?>
                                </td>

                                <td>
                                    <span class="badge badge-danger">
                                        +<?= (int) $violation['poin_pelanggaran'] ?>
                                    </span>
                                </td>

                                <td>
                                    <?= e($violation['keterangan_pelanggaran']) ?>
                                </td>

                                <td>
                                    <?= e($violation['sanksi_pelanggaran']) ?>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            <?php endif; ?>
        </section>
    </main>
</div>