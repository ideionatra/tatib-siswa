<?php

require_once __DIR__ . '/../../backend/DataPelanggaran.php';

$model = new \DataPelanggaran();

$errors = [];

$form = [
    'id' => 0,
    'jenis_pelanggaran' => '',
    'poin_pelanggaran' => '',
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
            flash('error', 'Data pelanggaran tidak ditemukan.');
        } else {
            $model->delete($id);

            flash(
                'success',
                'Data pelanggaran dan detail terkait berhasil dihapus.'
            );
        }

        redirect('/data-pelanggaran');
    }

    if ($action === 'save') {
        $form = [
            'id' => filter_input(
                INPUT_POST,
                'id',
                FILTER_VALIDATE_INT
            ) ?: 0,

            'jenis_pelanggaran' => trim(
                $_POST['jenis_pelanggaran'] ?? ''
            ),

            'poin_pelanggaran' => filter_input(
                INPUT_POST,
                'poin_pelanggaran',
                FILTER_VALIDATE_INT
            ) ?: 0,
        ];

        if (
            $form['jenis_pelanggaran'] === ''
            || strlen($form['jenis_pelanggaran']) > 100
        ) {
            $errors[] = 'Nama pelanggaran wajib diisi dan maksimal 100 karakter.';
        }

        if ((int) $form['poin_pelanggaran'] <= 0) {
            $errors[] = 'Poin pelanggaran harus lebih dari 0.';
        }

        if (
            (int) $form['id'] > 0
            && $model->getById((int) $form['id']) === null
        ) {
            $errors[] = 'Data pelanggaran tidak ditemukan.';
        }

        if (!$errors) {
            if ((int) $form['id'] > 0) {
                $model->update(
                    (int) $form['id'],
                    $form['jenis_pelanggaran'],
                    (int) $form['poin_pelanggaran']
                );

                flash('success', 'Data pelanggaran berhasil diperbarui.');
            } else {
                $model->create(
                    $form['jenis_pelanggaran'],
                    (int) $form['poin_pelanggaran']
                );

                flash('success', 'Data pelanggaran berhasil ditambahkan.');
            }

            redirect('/data-pelanggaran');
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
        <h2>Data Pelanggaran</h2>

        <p class="muted">
            Tambah, edit, dan hapus kategori pelanggaran siswa.
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
                        ? 'Edit pelanggaran'
                        : 'Tambah pelanggaran' ?>
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
                value="<?= (int) $form['id'] ?>">

            <div class="field">
                <label for="jenis_pelanggaran">
                    Nama pelanggaran
                </label>

                <textarea
                    id="jenis_pelanggaran"
                    name="jenis_pelanggaran"
                    rows="4"
                    maxlength="100"
                    required><?= e($form['jenis_pelanggaran']) ?></textarea>
            </div>

            <div class="field">
                <label for="poin_pelanggaran">
                    Poin pelanggaran
                </label>

                <input
                    type="number"
                    id="poin_pelanggaran"
                    name="poin_pelanggaran"
                    min="1"
                    value="<?= e($form['poin_pelanggaran']) ?>"
                    required>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    Simpan
                </button>

                <?php if ((int) $form['id'] > 0): ?>
                    <a
                        href="<?= e(url('/data-pelanggaran')) ?>"
                        class="btn btn-secondary">
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
                <h2><?= count($items) ?> jenis pelanggaran</h2>
            </div>
        </div>

        <?php if (!$items): ?>
            <div class="empty-state">
                <h3>Belum ada data</h3>
                <p>Tambahkan kategori pelanggaran pertama.</p>
            </div>
        <?php else: ?>
            <div class="table-wrap">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Jenis pelanggaran</th>
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
                                        <?= e($item['jenis_pelanggaran']) ?>
                                    </strong>
                                </td>

                                <td>
                                    <span class="badge badge-danger">
                                        <?= (int) $item['poin_pelanggaran'] ?>
                                    </span>
                                </td>

                                <td>
                                    <div class="inline-actions">
                                        <a
                                            href="<?= e(
                                                        url('/data-pelanggaran')
                                                            . '?edit=' . (int) $item['id']
                                                    ) ?>"
                                            class="btn btn-small btn-secondary">
                                            Edit
                                        </a>

                                        <form
                                            method="post"
                                            data-confirm="Menghapus kategori juga menghapus seluruh detail laporan yang menggunakan kategori ini. Lanjutkan?">
                                            <?= csrf_field() ?>

                                            <input
                                                type="hidden"
                                                name="action"
                                                value="delete">

                                            <input
                                                type="hidden"
                                                name="id"
                                                value="<?= (int) $item['id'] ?>">

                                            <button
                                                type="submit"
                                                class="btn btn-small btn-danger">
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