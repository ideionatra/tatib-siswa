<aside class="sidebar" id="sidebar">
    <div class="sidebar-brand">
        <img
            src="<?= e(url('/public/assets/images/logo_tatib.png')) ?>"
            alt="Logo Tatib Siswa"
            class="sidebar-logo">

        <div>
            <strong>Tatib Siswa</strong>
            <span>SMA Bisnis dan Teknologi Indonesia</span>
        </div>
    </div>

    <nav class="sidebar-menu" aria-label="Menu admin">
        <a
            href="/admin"
            class="menu-link <?= ($currentPath ?? '') === '/admin' ? 'active' : '' ?>">
            <span class="menu-symbol">D</span>
            Dashboard
        </a>

        <a
            href="/class-list"
            class="menu-link <?= in_array(($currentPath ?? ''), ['/class-list', '/class'], true) ? 'active' : '' ?>">
            <span class="menu-symbol">K</span>
            Daftar Kelas
        </a>

        <a
            href="/laporan"
            class="menu-link <?= ($currentPath ?? '') === '/laporan' ? 'active' : '' ?>">
            <span class="menu-symbol">L</span>
            Laporan
        </a>

        <a
            href="/data-pelanggaran"
            class="menu-link <?= ($currentPath ?? '') === '/data-pelanggaran' ? 'active' : '' ?>">
            <span class="menu-symbol">P</span>
            Data Pelanggaran
        </a>

        <a
            href="/data-prestasi"
            class="menu-link <?= ($currentPath ?? '') === '/data-prestasi' ? 'active' : '' ?>">
            <span class="menu-symbol">A</span>
            Data Prestasi
        </a>
    </nav>

    <div class="sidebar-footer">
        <a href="/" class="menu-link">
            <span class="menu-symbol">G</span>
            Halaman Guest
        </a>

        <a href="/logout" class="menu-link logout-link">
            <span class="menu-symbol">X</span>
            Logout
        </a>
    </div>
</aside>