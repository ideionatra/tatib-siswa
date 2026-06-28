<?php

require_once __DIR__ . '/../../backend/Auth.php';

$error = '';
$username = '';

if (is_post()) {
    verify_csrf();

    $username = $_POST['username'] ?? '';
    $password = (string) ($_POST['password'] ?? '');

    if ($username === '' || $password === '') {
        $error = 'Username dan password wajib diisi.';
    } else {
        $auth = new \Auth();
        $user = $auth->attempt($username, $password);

        if ($user === null) {
            $error = 'Username atau password tidak sesuai.';
        } else {
            session_regenerate_id(true);

            $_SESSION['user'] = $user;

            flash('success', 'Login berhasil. Selamat datang.');
            redirect('/admin');
        }
    }
}

?>

<main class="login-page">
    <section class="login-card">
        <div class="login-side">
            <a href="<?= e(url('/')) ?>" class="brand brand-light">
                <img
                    src="<?= e(url('/public/assets/images/logo_tatib.png')) ?>"
                    alt="Logo Tatib Siswa"
                    class="brand-logo"
                >

                <div>
                    <strong>Tatib Siswa</strong>
                    <span>Sistem Tata Tertib Sekolah</span>
                </div>
            </a>

            <div>
                <p class="eyebrow">Area administrator</p>
                <h1>Kelola tata tertib siswa dengan lebih mudah.</h1>

                <p>
                    Masuk untuk mengelola siswa, pelanggaran,
                    prestasi, dan laporan sekolah.
                </p>
            </div>
        </div>

        <div class="login-form-wrapper">
            <a href="<?= e(url('/')) ?>" class="back-link">
                &larr; Kembali ke halaman utama
            </a>

            <div class="login-heading">
                <p class="eyebrow">Login admin</p>
                <h2>Masuk ke sistem</h2>
                <p>Gunakan akun administrator dari database.</p>
            </div>

            <?php if ($error !== ''): ?>
                <div class="alert alert-danger">
                    <?= e($error) ?>
                </div>
            <?php endif; ?>

            <form method="post" class="login-form">
                <?= csrf_field() ?>

                <div class="field">
                    <label for="username">Username</label>

                    <input
                        type="text"
                        id="username"
                        name="username"
                        maxlength="50"
                        value="<?= e($username) ?>"
                        autocomplete="username"
                        required
                        autofocus
                    >
                </div>

                <div class="field">
                    <label for="password">Password</label>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        maxlength="50"
                        autocomplete="current-password"
                        required
                    >
                </div>

                <button type="submit" class="btn btn-primary btn-block">
                    Login
                </button>
            </form>
        </div>
    </section>
</main>