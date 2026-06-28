<?php

require_once __DIR__ . '/../../backend/Kelas.php';
require_once __DIR__ . '/../../backend/Siswa.php';
require_once __DIR__ . '/../../backend/DataPelanggaran.php';
require_once __DIR__ . '/../../backend/DataPrestasi.php';
require_once __DIR__ . '/../../backend/Laporan.php';

$classModel = new \Kelas();
$studentModel = new \Siswa();
$violationModel = new \DataPelanggaran();
$achievementModel = new \DataPrestasi();
$reportModel = new \Laporan();

$classes = $classModel->getAll();
$students = $studentModel->getAllForSelection();
$violations = $violationModel->getAll();
$achievements = $achievementModel->getAll();

$errors = [];

$form = [
    'id_kelas' => '',
    'id_siswa' => '',
    'jenis_laporan' => 'pelanggaran',
    'id_kategori' => '',
    'tanggal' => date('Y-m-d'),
    'keterangan' => '',
    'sanksi' => '',
];

if (is_post()) {
    verify_csrf();

    $form = [
        'id_kelas' => filter_input(
            INPUT_POST,
            'id_kelas',
            FILTER_VALIDATE_INT
        ) ?: '',

        'id_siswa' => filter_input(
            INPUT_POST,
            'id_siswa',
            FILTER_VALIDATE_INT
        ) ?: '',

        'jenis_laporan' => trim($_POST['jenis_laporan'] ?? ''),

        'id_kategori' => filter_input(
            INPUT_POST,
            'id_kategori',
            FILTER_VALIDATE_INT
        ) ?: '',

        'tanggal' => trim($_POST['tanggal'] ?? ''),
        'keterangan' => trim($_POST['keterangan'] ?? ''),
        'sanksi' => trim($_POST['sanksi'] ?? ''),
    ];

    if (!$classModel->getById((int) $form['id_kelas'])) {
        $errors[] = 'Kelas wajib dipilih.';
    }

    $selectedStudent = $studentModel->getById((int) $form['id_siswa']);

    if ($selectedStudent === null) {
        $errors[] = 'Siswa wajib dipilih.';
    } elseif (
        (int) $selectedStudent['id_kelas'] !== (int) $form['id_kelas']
    ) {
        $errors[] = 'Siswa tidak berada pada kelas yang dipilih.';
    }

    if (
        !in_array(
            $form['jenis_laporan'],
            ['pelanggaran', 'prestasi'],
            true
        )
    ) {
        $errors[] = 'Jenis laporan tidak valid.';
    }

    if (!valid_date($form['tanggal'])) {
        $errors[] = 'Tanggal laporan tidak valid.';
    }

    if ($form['keterangan'] === '') {
        $errors[] = 'Keterangan laporan wajib diisi.';
    }

    if ($form['jenis_laporan'] === 'pelanggaran') {
        if (!$violationModel->getById((int) $form['id_kategori'])) {
            $errors[] = 'Kategori pelanggaran tidak ditemukan.';
        }

        if ($form['sanksi'] === '') {
            $errors[] = 'Sanksi pelanggaran wajib diisi.';
        }

        if (strlen($form['sanksi']) > 500) {
            $errors[] = 'Sanksi maksimal 500 karakter.';
        }
    }

    if ($form['jenis_laporan'] === 'prestasi') {
        if (!$achievementModel->getById((int) $form['id_kategori'])) {
            $errors[] = 'Kategori prestasi tidak ditemukan.';
        }
    }

    if (!$errors) {
        if ($form['jenis_laporan'] === 'pelanggaran') {
            $reportModel->createViolation(
                (int) $form['id_siswa'],
                (int) $form['id_kategori'],
                $form['keterangan'],
                $form['tanggal'],
                $form['sanksi']
            );

            flash('success', 'Laporan pelanggaran berhasil disimpan.');
        } else {
            $reportModel->createAchievement(
                (int) $form['id_siswa'],
                (int) $form['id_kategori'],
                $form['keterangan'],
                $form['tanggal']
            );

            flash('success', 'Laporan prestasi berhasil disimpan.');
        }

        redirect('/laporan');
    }
}

$recentReports = $reportModel->getRecent(10);

?>

<div class="page-header">
    <div>
        <p class="eyebrow">Pencatatan siswa</p>
        <h2>Buat Laporan</h2>

        <p class="muted">
            Catat pelanggaran atau prestasi yang diperoleh siswa.
        </p>
    </div>
</div>

<section class="section-card form-card">
    <div class="section-heading">
        <div>
            <p class="eyebrow">Form laporan</p>
            <h2>Data laporan siswa</h2>
        </div>
    </div>

    <?php if ($errors): ?>
        <div class="alert alert-danger">
            <ul class="error-list">
                <?php foreach ($errors as $error): ?>
                    <li><?= e($error) ?></li>
                <?php endforeach; ?>
            </ul>
        </div>
    <?php endif; ?>

    <form method="post" id="reportForm">
        <?= csrf_field() ?>

        <div class="form-grid">
            <div class="field">
                <label for="reportClass">Kelas</label>

                <select
                    id="reportClass"
                    name="id_kelas"
                    required
                >
                    <option value="">Pilih kelas</option>

                    <?php foreach ($classes as $class): ?>
                        <option
                            value="<?= (int) $class['id'] ?>"
                            <?= (int) $form['id_kelas'] === (int) $class['id']
                                ? 'selected'
                                : '' ?>
                        >
                            <?= e($class['nama_lengkap']) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="field">
                <label for="reportStudent">Siswa</label>

                <select
                    id="reportStudent"
                    name="id_siswa"
                    data-selected="<?= e($form['id_siswa']) ?>"
                    required
                >
                    <option value="">Pilih siswa</option>

                    <?php foreach ($students as $student): ?>
                        <?php if (
                            (int) $student['id_kelas']
                            === (int) $form['id_kelas']
                        ): ?>
                            <option
                                value="<?= (int) $student['id'] ?>"
                                <?= (int) $form['id_siswa'] === (int) $student['id']
                                    ? 'selected'
                                    : '' ?>
                            >
                                <?= e($student['nama'] . ' - ' . $student['nis']) ?>
                            </option>
                        <?php endif; ?>
                    <?php endforeach; ?>
                </select>

                <small>
                    Pilihan siswa akan muncul setelah kelas dipilih.
                </small>
            </div>

            <div class="field span-2">
                <label>Jenis laporan</label>

                <div class="report-type">
                    <label class="type-option">
                        <input
                            type="radio"
                            name="jenis_laporan"
                            value="pelanggaran"
                            <?= $form['jenis_laporan'] === 'pelanggaran'
                                ? 'checked'
                                : '' ?>
                        >

                        <span>
                            <strong>Pelanggaran</strong>
                            <small>Menambah poin pelanggaran siswa</small>
                        </span>
                    </label>

                    <label class="type-option">
                        <input
                            type="radio"
                            name="jenis_laporan"
                            value="prestasi"
                            <?= $form['jenis_laporan'] === 'prestasi'
                                ? 'checked'
                                : '' ?>
                        >

                        <span>
                            <strong>Prestasi</strong>
                            <small>Menambah poin prestasi siswa</small>
                        </span>
                    </label>
                </div>
            </div>

            <div
                class="field span-2 report-category"
                id="violationCategory"
            >
                <label for="violationSelect">
                    Kategori pelanggaran
                </label>

                <select
                    id="violationSelect"
                    name="id_kategori"
                    <?= $form['jenis_laporan'] !== 'pelanggaran'
                        ? 'disabled'
                        : '' ?>
                >
                    <option value="">Pilih pelanggaran</option>

                    <?php foreach ($violations as $violation): ?>
                        <option
                            value="<?= (int) $violation['id'] ?>"
                            <?= (
                                $form['jenis_laporan'] === 'pelanggaran'
                                && (int) $form['id_kategori'] === (int) $violation['id']
                            ) ? 'selected' : '' ?>
                        >
                            <?= e($violation['jenis_pelanggaran']) ?>
                            - <?= (int) $violation['poin_pelanggaran'] ?> poin
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div
                class="field span-2 report-category"
                id="achievementCategory"
            >
                <label for="achievementSelect">
                    Kategori prestasi
                </label>

                <select
                    id="achievementSelect"
                    name="id_kategori"
                    <?= $form['jenis_laporan'] !== 'prestasi'
                        ? 'disabled'
                        : '' ?>
                >
                    <option value="">Pilih prestasi</option>

                    <?php foreach ($achievements as $achievement): ?>
                        <option
                            value="<?= (int) $achievement['id'] ?>"
                            <?= (
                                $form['jenis_laporan'] === 'prestasi'
                                && (int) $form['id_kategori'] === (int) $achievement['id']
                            ) ? 'selected' : '' ?>
                        >
                            <?= e($achievement['jenis_prestasi']) ?>
                            - <?= (int) $achievement['poin_prestasi'] ?> poin
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="field">
                <label for="tanggal">Tanggal</label>

                <input
                    type="date"
                    id="tanggal"
                    name="tanggal"
                    value="<?= e($form['tanggal']) ?>"
                    required
                >
            </div>

            <div class="field">
                <label for="sanksi">Sanksi pelanggaran</label>

                <input
                    type="text"
                    id="sanksi"
                    name="sanksi"
                    maxlength="500"
                    value="<?= e($form['sanksi']) ?>"
                    <?= $form['jenis_laporan'] === 'pelanggaran'
                        ? 'required'
                        : 'disabled' ?>
                >

                <small>Hanya diisi untuk laporan pelanggaran.</small>
            </div>

            <div class="field span-2">
                <label for="keterangan">Keterangan</label>

                <textarea
                    id="keterangan"
                    name="keterangan"
                    rows="5"
                    required
                ><?= e($form['keterangan']) ?></textarea>
            </div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">
                Simpan Laporan
            </button>
        </div>
    </form>

    <script type="application/json" id="studentData">
        <?= json_encode(
            $students,
            JSON_HEX_TAG
            | JSON_HEX_APOS
            | JSON_HEX_AMP
            | JSON_HEX_QUOT
        ) ?>
    </script>
</section>

<section class="section-card">
    <div class="section-heading">
        <div>
            <p class="eyebrow">Riwayat terbaru</p>
            <h2>10 laporan terakhir</h2>
        </div>
    </div>

    <?php if (!$recentReports): ?>
        <div class="empty-state">
            <h3>Belum ada laporan</h3>
            <p>Laporan yang baru dibuat akan tampil di sini.</p>
        </div>
    <?php else: ?>
        <div class="table-wrap">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Tanggal</th>
                    <th>Siswa</th>
                    <th>Kelas</th>
                    <th>Jenis</th>
                    <th>Kategori</th>
                    <th>Poin</th>
                    <th>Keterangan</th>
                </tr>
                </thead>

                <tbody>
                <?php foreach ($recentReports as $report): ?>
                    <tr>
                        <td>
                            <?= e(date(
                                'd-m-Y',
                                strtotime($report['tanggal'])
                            )) ?>
                        </td>

                        <td>
                            <strong><?= e($report['nama']) ?></strong>
                            <small>NIS: <?= e($report['nis']) ?></small>
                        </td>

                        <td><?= e($report['kelas']) ?></td>

                        <td>
                            <span class="badge <?= $report['jenis_laporan'] === 'Pelanggaran'
                                ? 'badge-danger'
                                : 'badge-success' ?>">
                                <?= e($report['jenis_laporan']) ?>
                            </span>
                        </td>

                        <td><?= e($report['kategori']) ?></td>
                        <td><?= (int) $report['poin'] ?></td>
                        <td><?= e($report['keterangan']) ?></td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    <?php endif; ?>
</section>