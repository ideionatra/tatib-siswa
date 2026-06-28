<?php

require_once __DIR__ . '/../../backend/DataPrestasi.php';

$model = new DataPrestasi();

$errors = [];

$form = [
    'id' => 0,
    'jenis_prestasi' => '',
    'poin_prestasi' => '',
];

if (is_post()) {
    verify_csrf();

    $action = $_POST['action'] ?? '';

    if ($action === 'delete') {
        $id = filter_input(
            INPUT_POST,
            'id',
            FILTER_VALIDATE_INT
        ) ?: 0;

        if ($model->getById($id) === null) {
            flash('error', 'Data prestasi tidak ditemukan.');
        } else {
            $model->delete($id);

            flash(
                'success',
                'Data prestasi dan detail terkait berhasil dihapus.'
            );
        }

        redirect('/data-prestasi');
    }

    if ($action === 'save') {
        $form = [
            'id' => filter_input(
                INPUT_POST,
                'id',
                FILTER_VALIDATE_INT
            ) ?: 0,

            'jenis_prestasi' => trim(
                $_POST['jenis_prestasi'] ?? ''
            ),

            'poin_prestasi' => filter_input(
                INPUT_POST,
                'poin_prestasi',
                FILTER_VALIDATE_INT
            ) ?: 0,
        ];

        if (
            $form['jenis_prestasi'] === ''
            || strlen($form['jenis_prestasi']) > 100
        ) {
            $errors[] = 'Nama prestasi wajib diisi dan maksimal 100 karakter.';
        }

        if ((int) $form['poin_prestasi'] <= 0) {
            $errors[] = 'Poin prestasi harus lebih dari 0.';
        }

        if (
            (int) $form['id'] > 0
            && $model->getById((int) $form['id']) === null
        ) {
            $errors[] = 'Data prestasi tidak ditemukan.';
        }

        if (!$errors) {
            if ((int) $form['id'] > 0) {
                $model->update(
                    (int) $form['id'],
                    $form['jenis_prestasi'],
                    (int) $form['poin_prestasi']
                );

                flash('success', 'Data prestasi berhasil diperbarui.');
            } else {
                $model->create(
                    $form['jenis_prestasi'],
                    (int) $form['poin_prestasi']
                );

                flash('success', 'Data prestasi berhasil ditambahkan.');
            }

            redirect('/data-prestasi');
        }
    }
}

if (!$errors) {
    $editId = filter_input(INPUT_GET, 'edit', FILTER_VALIDATE_INT) ?: 0;

    if ($editId > 0) {
        $editData = $model->getById($editId);

        if ($editData !== null) {
            $form = $editData;
        }
    }
}

$items = $model->getAll();

?>

<div class="page-header">
    <div>
        <p class="eyebrow">Kategori laporan</p>
        <h2>Data Prestasi</h2>

        <p class="muted">
            Tambah, edit, dan hapus kategori prestasi siswa.
        </p>
    </div>
</div>

<div class="two-column-layout">
    <section class="section-card form-card compact-form">
        <div class="section-heading">
            <div>
                <p class="eyebrow">
                    <?= (int) $form['id'] > 0 ? 'Edit data' : 'Data baru' ?>
                </p>

                <h2>
                    <?= (int) $form['id'] > 0
                        ? 'Edit prestasi'
                        : 'Tambah prestasi' ?>
                </h2>
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

        <form method="post">
            <?= csrf_field() ?>

            <input type="hidden" name="action" value="save">
            <input
                type="hidden"
                name="id"
                value="<?= (int) $form['id'] ?>"
            >

            <div class="field">
                <label for="jenis_prestasi">
                    Nama prestasi
                </label>

                <textarea
                    id="jenis_prestasi"
                    name="jenis_prestasi"
                    rows="4"
                    maxlength="100"
                    required
                ><?= e($form['jenis_prestasi']) ?></textarea>
            </div>

            <div class="field">
                <label for="poin_prestasi">
                    Poin prestasi
                </label>

                <input
                    type="number"
                    id="poin_prestasi"
                    name="poin_prestasi"
                    min="1"
                    value="<?= e($form['poin_prestasi']) ?>"
                    required
                >
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    Simpan
                </button>

                <?php if ((int) $form['id'] > 0): ?>
                    <a
                        href="<?= e(url('/data-prestasi')) ?>"
                        class="btn btn-secondary"
                    >
                        Batal
                    </a>
                <?php endif; ?>
            </div>
        </form>
    </section>

    <section class="section-card">
        <div class="section-heading">
            <div>
                <p class="eyebrow">Daftar kategori</p>
                <h2><?= count($items) ?> jenis prestasi</h2>
            </div>
        </div>

        <?php if (!$items): ?>
            <div class="empty-state">
                <h3>Belum ada data</h3>
                <p>Tambahkan kategori prestasi pertama.</p>
            </div>
        <?php else: ?>
            <div class="table-wrap">
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>Jenis prestasi</th>
                        <th>Poin</th>
                        <th>Aksi</th>
                    </tr>
                    </thead>

                    <tbody>
                    <?php foreach ($items as $index => $item): ?>
                        <tr>
                            <td><?= $index + 1 ?></td>

                            <td>
                                <strong>
                                    <?= e($item['jenis_prestasi']) ?>
                                </strong>
                            </td>

                            <td>
                                <span class="badge badge-success">
                                    <?= (int) $item['poin_prestasi'] ?>
                                </span>
                            </td>

                            <td>
                                <div class="inline-actions">
                                    <a
                                        href="<?= e(
                                            url('/data-prestasi')
                                            . '?edit=' . (int) $item['id']
                                        ) ?>"
                                        class="btn btn-small btn-secondary"
                                    >
                                        Edit
                                    </a>

                                    <form
                                        method="post"
                                        data-confirm="Menghapus kategori juga menghapus seluruh detail laporan yang menggunakan kategori ini. Lanjutkan?"
                                    >
                                        <?= csrf_field() ?>

                                        <input
                                            type="hidden"
                                            name="action"
                                            value="delete"
                                        >

                                        <input
                                            type="hidden"
                                            name="id"
                                            value="<?= (int) $item['id'] ?>"
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
</div>