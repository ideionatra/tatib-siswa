<?php

declare(strict_types=1);

ob_start();

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

date_default_timezone_set('Asia/Makassar');

// $helper = require_once __DIR__ . '/backend/helpers.php';
require_once __DIR__ . '/backend/helpers.php';

$routes = require __DIR__ . '/routes/web.php';

$requestPath = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/';
$basePath = base_url();

if (
    $basePath !== ''
    && (
        $requestPath === $basePath
        || str_starts_with($requestPath, $basePath . '/')
    )
) {
    $requestPath = substr($requestPath, strlen($basePath));
}

$currentPath = '/' . trim($requestPath, '/');

if ($currentPath === '//') {
    $currentPath = '/';
}

$route = $routes[$currentPath] ?? null;

if ($route === null) {
    http_response_code(404);

    $route = [
        'title' => 'Halaman Tidak Ditemukan',
        'page' => 'public/pages/404.php',
        'layout' => 'guest',
        'auth' => false,
    ];
}

if (($route['auth'] ?? false) && !is_logged_in()) {
    flash('error', 'Silakan login terlebih dahulu.');
    redirect('/login');
}

if (($route['guest_only'] ?? false) && is_logged_in()) {
    redirect('/admin');
}

$title = $route['title'] ?? 'Tatib Siswa';
$layout = $route['layout'] ?? 'admin';
$pagePath = __DIR__ . '/' . ltrim($route['page'], '/');

if (!is_file($pagePath)) {
    http_response_code(500);
    exit('File halaman tidak ditemukan.');
}

require __DIR__ . '/public/index.php';