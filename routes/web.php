<?php

return [
    '/' => [
        'title' => 'Pelanggaran Hari Ini',
        'page' => 'public/pages/guestDashboard.php',
        'layout' => 'guest',
        'auth' => false,
    ],

    '/login' => [
        'title' => 'Login Admin',
        'page' => 'public/pages/login.php',
        'layout' => 'login',
        'auth' => false,
        'guest_only' => true,
    ],

    '/logout' => [
        'title' => 'Logout',
        'page' => 'public/pages/logout.php',
        'layout' => 'admin',
        'auth' => true,
    ],

    '/admin' => [
        'title' => 'Dashboard Admin',
        'page' => 'public/pages/dashboard.php',
        'layout' => 'admin',
        'auth' => true,
    ],

    '/class-list' => [
        'title' => 'Daftar Kelas',
        'page' => 'public/pages/classList.php',
        'layout' => 'admin',
        'auth' => true,
    ],

    '/class' => [
        'title' => 'Data Siswa',
        'page' => 'public/pages/class.php',
        'layout' => 'admin',
        'auth' => true,
    ],

    '/laporan' => [
        'title' => 'Buat Laporan',
        'page' => 'public/pages/laporan.php',
        'layout' => 'admin',
        'auth' => true,
    ],

    '/data-pelanggaran' => [
        'title' => 'Data Pelanggaran',
        'page' => 'public/pages/dataPelanggaran.php',
        'layout' => 'admin',
        'auth' => true,
    ],

    '/data-prestasi' => [
        'title' => 'Data Prestasi',
        'page' => 'public/pages/dataPrestasi.php',
        'layout' => 'admin',
        'auth' => true,
    ],
];