<?php

return [
    '/' => [
        'title' => 'DASHBOARD',
        'page' => './public/pages/guestDashboard.php'
    ],
    '/login' => [
        'title' => 'LOGIN',
        'page' => './public/pages/login.php'
    ],
    '/logout' => [
        'title' => 'LOGOUT',
        'page' => './public/pages/login.php'
    ],
    '/class-list' => [
        'title' => 'DAFTAR KELAS',
        'page' => './public/pages/classList.php'
    ],
    '/class?id=' => [
        'title' => 'KELAS',
        'page' => './public/pages/class.php'
    ],
    '/laporan' => [
        'title' => 'BUAT LAPORAN',
        'page' => './public/pages/laporan.php'
    ],
    '/data-pelanggaran' => [
        'title' => 'DATA PELANGGARAN',
        'page' => './public/pages/dataPelanggaran.php'
    ],
    '/data-prestasi' => [
        'title' => 'DATA PRESTASI',
        'page' => './public/pages/dataPrestasi.php'
    ]
];