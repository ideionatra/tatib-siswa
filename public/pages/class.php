<?php

require_once __DIR__ . '/../../backend/Kelas.php';
require_once __DIR__ . '/../../backend/Siswa.php';

$classModel = new Kelas();
$studentModel = new Siswa();

$classId = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT) ?: 0;
$classData = $classModel->getById($classId);

if ($classData === null):
?>
    <section class="section-card">
        <div class="empty-state">
            <h2>Kelas tidak ditemukan</h2>
            <p>ID kelas tidak valid atau kelas telah dihapus.</p>

            <a href="<?= e(url('/class-list')) ?>" class="btn btn-primary">
                Kembali ke daftar kelas
            </a>
        </div>
    </section>
<?php
    return;
endif;

$allClasses = $classModel->getAll();

$errors = [];
$showForm = false;

$formStudent = [
    'id' => 0,
    'nis' => '',
    'nisn' => '',
    'nama' => '',
    'tempat_lahir' => '',
    'tanggal_lahir' => '',
    'alamat' => '',
    'no_telp' => '',
    'jenis_kelamin' => 'L',
    'agama' => 'Hindu',
    'foto_siswa' => '-',
    'id_kelas' => $classId,
];

if (is_post()) {
    verify_csrf();

    $action = $_POST['action'] ?? '';

    if ($action === 'delete_student') {
        $studentId = filter_input(
            INPUT_POST,
            'student_id',
            FILTER_VALIDATE_INT
        ) ?: 0;

        $student = $studentModel->getById($studentId);

        if ($student === null || (int) $student['id_kelas'] !== $classId) {
            flash('error', 'Data siswa tidak ditemukan.');
        } else {
            $studentModel->delete($studentId);
            flash('success', 'Data siswa berhasil dihapus.');
        }

        redirect('/class?id=' . $classId);
    }

    if ($action === 'save_student') {
        $studentId = filter_input(
            INPUT_POST,
            'student_id',
            FILTER_VALIDATE_INT
        ) ?: 0;

        $formStudent = [
            'id' => $studentId,
            'nis' => trim($_POST['nis'] ?? ''),
            'nisn' => trim($_POST['nisn'] ?? ''),
            'nama' => trim($_POST['nama'] ?? ''),
            'tempat_lahir' => trim($_POST['tempat_lahir'] ?? ''),
            'tanggal_lahir' => trim($_POST['tanggal_lahir'] ?? ''),
            'alamat' => trim($_POST['alamat'] ?? ''),
            'no_telp' => trim($_POST['no_telp'] ?? ''),
            'jenis_kelamin' => trim($_POST['jenis_kelamin'] ?? ''),
            'agama' => trim($_POST['agama'] ?? ''),
            'foto_siswa' => trim($_POST['foto_siswa'] ?? ''),
            'id_kelas' => filter_input(
                INPUT_POST,
                'id_kelas',
                FILTER_VALIDATE_INT
            ) ?: 0,
        ];

        $showForm = true;

        if (!preg_match('/^[0-9]{1,10}$/', $formStudent['nis'])) {
            $errors[] = 'NIS wajib berupa angka dengan maksimal 10 digit.';
        }

        if (!preg_match('/^[0-9]{1,15}$/', $formStudent['nisn'])) {
            $errors[] = 'NISN wajib berupa angka dengan maksimal 15 digit.';
        }

        if ($formStudent['nama'] === '' || strlen($formStudent['nama']) > 100) {
            $errors[] = 'Nama wajib diisi dan maksimal 100 karakter.';
        }

        if (
            $formStudent['tempat_lahir'] === ''
            || strlen($formStudent['tempat_lahir']) > 50
        ) {
            $errors[] = 'Tempat lahir wajib diisi dan maksimal 50 karakter.';
        }

        if (!valid_date($formStudent['tanggal_lahir'])) {
            $errors[] = 'Tanggal lahir tidak valid.';
        }

        if ($formStudent['alamat'] === '' || strlen($formStudent['alamat']) > 100) {
            $errors[] = 'Alamat wajib diisi dan maksimal 100 karakter.';
        }

        if (
            $formStudent['no_telp'] === ''
            || strlen($formStudent['no_telp']) > 15
        ) {
            $errors[] = 'Nomor telepon wajib diisi dan maksimal 15 karakter.';
        }

        if (!in_array($formStudent['jenis_kelamin'], ['L', 'P'], true)) {
            $errors[] = 'Jenis kelamin tidak valid.';
        }

        $allowedReligions = [
            'Islam',
            'Kristen',
            'Katolik',
            'Hindu',
            'Buddha',
            'Konghucu',
        ];

        if (!in_array($formStudent['agama'], $allowedReligions, true)) {
            $errors[] = 'Agama tidak valid.';
        }

        if ($classModel->getById((int) $formStudent['id_kelas']) === null) {
            $errors[] = 'Kelas yang dipilih tidak ditemukan.';
        }

        if ($formStudent['foto_siswa'] === '') {
            $formStudent['foto_siswa'] = '-';
        }

        if (strlen($formStudent['foto_siswa']) > 500) {
            $errors[] = 'Alamat foto maksimal 500 karakter.';
        }

        if (
            $studentModel->identifierExists(
                $formStudent['nis'],
                $formStudent['nisn'],
                $studentId
            )
        ) {
            $errors[] = 'NIS atau NISN sudah digunakan siswa lain.';
        }

        if ($studentId > 0 && $studentModel->getById($studentId) === null) {
            $errors[] = 'Siswa yang akan diedit tidak ditemukan.';
        }

        if (!$errors) {
            if ($studentId > 0) {
                $studentModel->update($studentId, $formStudent);
                flash('success', 'Data siswa berhasil diperbarui.');
            } else {
                $studentModel->create($formStudent);
                flash('success', 'Siswa baru berhasil ditambahkan.');
            }

            redirect('/class?id=' . (int) $formStudent['id_kelas']);
        }
    }
}

if (!$showForm) {
    $mode = $_GET['mode'] ?? '';
    $editId = filter_input(INPUT_GET, 'edit', FILTER_VALIDATE_INT) ?: 0;

    if ($mode === 'add') {
        $showForm = true;
    }

    if ($editId > 0) {
        $editStudent = $studentModel->getById($editId);

        if (
            $editStudent !== null
            && (int) $editStudent['id_kelas'] === $classId
        ) {
            $formStudent = $editStudent;
            $showForm = true;
        }
    }
}

$students = $studentModel->getByClass($classId);

?>

<div class="page-header">
    <div>
        <a href="<?= e(url('/class-list')) ?>" class="back-link">
            &larr; Daftar Kelas
        </a>

        <p class="eyebrow">Data siswa</p>
        <h2>Kelas <?= e($classData['nama_lengkap']) ?></h2>

        <p class="muted">
            Terdapat <?= count($students) ?> siswa di kelas ini.
        </p>
    </div>

    <?php if (!$showForm): ?>
        <a
            href="<?= e(url('/class') . '?id=' . $classId . '&mode=add') ?>"
            class="btn btn-primary"
        >
            Tambah Siswa
        </a>
    <?php endif; ?>
</div>

<?php if ($showForm): ?>
    <section class="section-card form-card">
        <div class="section-heading">
            <div>
                <p class="eyebrow">
                    <?= (int) $formStudent['id'] > 0 ? 'Edit siswa' : 'Siswa baru' ?>
                </p>

                <h2>
                    <?= (int) $formStudent['id'] > 0
                        ? 'Perbarui data siswa'
                        : 'Tambah data siswa' ?>
                </h2>
            </div>

            <a
                href="<?= e(url('/class') . '?id=' . $classId) ?>"
                class="btn btn-secondary"
            >
                Batal
            </a>
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

        <form
            method="post"
            action="<?= e(url('/class') . '?id=' . $classId) ?>"
        >
            <?= csrf_field() ?>

            <input type="hidden" name="action" value="save_student">
            <input
                type="hidden"
                name="student_id"
                value="<?= (int) $formStudent['id'] ?>"
            >

            <div class="form-grid">
                <div class="field">
                    <label for="nis">NIS</label>
                    <input
                        type="text"
                        id="nis"
                        name="nis"
                        maxlength="10"
                        value="<?= e($formStudent['nis']) ?>"
                        required
                    >
                </div>

                <div class="field">
                    <label for="nisn">NISN</label>
                    <input
                        type="text"
                        id="nisn"
                        name="nisn"
                        maxlength="15"
                        value="<?= e($formStudent['nisn']) ?>"
                        required
                    >
                </div>

                <div class="field span-2">
                    <label for="nama">Nama lengkap</label>
                    <input
                        type="text"
                        id="nama"
                        name="nama"
                        maxlength="100"
                        value="<?= e($formStudent['nama']) ?>"
                        required
                    >
                </div>

                <div class="field">
                    <label for="tempat_lahir">Tempat lahir</label>
                    <input
                        type="text"
                        id="tempat_lahir"
                        name="tempat_lahir"
                        maxlength="50"
                        value="<?= e($formStudent['tempat_lahir']) ?>"
                        required
                    >
                </div>

                <div class="field">
                    <label for="tanggal_lahir">Tanggal lahir</label>
                    <input
                        type="date"
                        id="tanggal_lahir"
                        name="tanggal_lahir"
                        value="<?= e($formStudent['tanggal_lahir']) ?>"
                        required
                    >
                </div>

                <div class="field">
                    <label for="jenis_kelamin">Jenis kelamin</label>

                    <select
                        id="jenis_kelamin"
                        name="jenis_kelamin"
                        required
                    >
                        <option
                            value="L"
                            <?= $formStudent['jenis_kelamin'] === 'L' ? 'selected' : '' ?>
                        >
                            Laki-laki
                        </option>

                        <option
                            value="P"
                            <?= $formStudent['jenis_kelamin'] === 'P' ? 'selected' : '' ?>
                        >
                            Perempuan
                        </option>
                    </select>
                </div>

                <div class="field">
                    <label for="agama">Agama</label>

                    <select id="agama" name="agama" required>
                        <?php foreach (
                            ['Islam', 'Kristen', 'Katolik', 'Hindu', 'Buddha', 'Konghucu']
                            as $religion
                        ): ?>
                            <option
                                value="<?= e($religion) ?>"
                                <?= $formStudent['agama'] === $religion ? 'selected' : '' ?>
                            >
                                <?= e($religion) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="field">
                    <label for="no_telp">Nomor telepon</label>

                    <input
                        type="text"
                        id="no_telp"
                        name="no_telp"
                        maxlength="15"
                        value="<?= e($formStudent['no_telp']) ?>"
                        required
                    >
                </div>

                <div class="field">
                    <label for="id_kelas">Kelas</label>

                    <select id="id_kelas" name="id_kelas" required>
                        <?php foreach ($allClasses as $classOption): ?>
                            <option
                                value="<?= (int) $classOption['id'] ?>"
                                <?= (int) $formStudent['id_kelas'] === (int) $classOption['id']
                                    ? 'selected'
                                    : '' ?>
                            >
                                <?= e($classOption['nama_lengkap']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="field span-2">
                    <label for="alamat">Alamat</label>

                    <textarea
                        id="alamat"
                        name="alamat"
                        rows="3"
                        maxlength="100"
                        required
                    ><?= e($formStudent['alamat']) ?></textarea>
                </div>

                <div class="field span-2">
                    <label for="foto_siswa">
                        URL atau lokasi foto siswa
                    </label>

                    <input
                        type="text"
                        id="foto_siswa"
                        name="foto_siswa"
                        maxlength="500"
                        value="<?= e($formStudent['foto_siswa']) ?>"
                    >

                    <small>
                        Isi tanda minus jika siswa belum memiliki foto.
                    </small>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    Simpan Data
                </button>

                <a
                    href="<?= e(url('/class') . '?id=' . $classId) ?>"
                    class="btn btn-secondary"
                >
                    Batal
                </a>
            </div>
        </form>
    </section>
<?php endif; ?>

<section class="section-card">
    <div class="section-heading">
        <div>
            <p class="eyebrow">Daftar siswa</p>
            <h2>Siswa kelas <?= e($classData['nama_lengkap']) ?></h2>
        </div>
    </div>

    <?php if (!$students): ?>
        <div class="empty-state">
            <h3>Belum ada siswa</h3>
            <p>Tambahkan siswa pertama untuk kelas ini.</p>
        </div>
    <?php else: ?>
        <div class="table-wrap">
            <table class="data-table">
                <thead>
                <tr>
                    <th>No.</th>
                    <th>Siswa</th>
                    <th>NISN</th>
                    <th>Jenis kelamin</th>
                    <th>Telepon</th>
                    <th>Pelanggaran</th>
                    <th>Prestasi</th>
                    <th>Aksi</th>
                </tr>
                </thead>

                <tbody>
                <?php foreach ($students as $index => $student): ?>
                    <tr>
                        <td><?= $index + 1 ?></td>

                        <td>
                            <div class="student-name">
                                <span class="avatar">
                                    <?= e(strtoupper(substr($student['nama'], 0, 1))) ?>
                                </span>

                                <div>
                                    <strong><?= e($student['nama']) ?></strong>
                                    <small>NIS: <?= e($student['nis']) ?></small>
                                </div>
                            </div>
                        </td>

                        <td><?= e($student['nisn']) ?></td>

                        <td>
                            <?= $student['jenis_kelamin'] === 'L'
                                ? 'Laki-laki'
                                : 'Perempuan' ?>
                        </td>

                        <td><?= e($student['no_telp']) ?></td>

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
                            <div class="inline-actions">
                                <a
                                    href="<?= e(
                                        url('/class')
                                        . '?id=' . $classId
                                        . '&edit=' . (int) $student['id']
                                    ) ?>"
                                    class="btn btn-small btn-secondary"
                                >
                                    Edit
                                </a>

                                <form
                                    method="post"
                                    action="<?= e(url('/class') . '?id=' . $classId) ?>"
                                    data-confirm="Hapus siswa ini beserta seluruh laporannya?"
                                >
                                    <?= csrf_field() ?>

                                    <input
                                        type="hidden"
                                        name="action"
                                        value="delete_student"
                                    >

                                    <input
                                        type="hidden"
                                        name="student_id"
                                        value="<?= (int) $student['id'] ?>"
                                    >

                                    <button
                                        type="submit"
                                        class="btn btn-small btn-danger"
                                    >
                                        Hapus
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    <?php endif; ?>
</section>