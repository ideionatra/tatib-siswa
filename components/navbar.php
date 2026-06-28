<header class="topbar">
    <div class="topbar-left">
        <button
            type="button"
            class="menu-toggle"
            id="menuToggle"
            aria-label="Buka menu"
        >
            ☰
        </button>

        <div>
            <p class="topbar-label">Halaman Admin</p>
            <h1><?= e($title ?? 'TATIB SISWA') ?></h1>
        </div>
    </div>

    <div class="topbar-user">
        <div class="user-avatar">
            <?= e(strtoupper(substr(auth_user()['username'] ?? 'A', 0, 1))) ?>
        </div>

        <div>
            <strong><?= e(auth_user()['username'] ?? 'Admin') ?></strong>
            <span>Administrator</span>
        </div>
    </div>
</header>