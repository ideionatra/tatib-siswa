<?php

declare(strict_types=1);

function base_url(): string
{
    $scriptName = str_replace(
        '\\',
        '/',
        $_SERVER['SCRIPT_NAME'] ?? '/index.php'
    );

    $directory = rtrim(dirname($scriptName), '/');

    if ($directory === '.' || $directory === '/') {
        return '';
    }

    return $directory;
}

function url(string $path = '/'): string
{
    $path = '/' . ltrim($path, '/');

    return $path;
}

function redirect(string $path): never
{
    header('Location: ' . url($path));
    exit;
}

function e(mixed $value): string
{
    return htmlspecialchars(
        (string) $value,
        ENT_QUOTES,
        'UTF-8'
    );
}

function is_post(): bool
{
    return ($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'POST';
}

function flash(string $key, ?string $message = null): ?string
{
    if ($message !== null) {
        $_SESSION['_flash'][$key] = $message;
        return null;
    }

    $value = $_SESSION['_flash'][$key] ?? null;
    unset($_SESSION['_flash'][$key]);

    return $value;
}

function csrf_token(): string
{
    if (empty($_SESSION['_csrf_token'])) {
        $_SESSION['_csrf_token'] = bin2hex(random_bytes(32));
    }

    return $_SESSION['_csrf_token'];
}

function csrf_field(): string
{
    return '<input type="hidden" name="_token" value="'
        . e(csrf_token())
        . '">';
}

function verify_csrf(): void
{
    $sessionToken = $_SESSION['_csrf_token'] ?? '';
    $formToken = $_POST['_token'] ?? '';

    if (
        $sessionToken === ''
        || $formToken === ''
        || !hash_equals($sessionToken, $formToken)
    ) {
        http_response_code(419);
        exit('Sesi formulir tidak valid. Muat ulang halaman lalu coba kembali.');
    }
}

function is_logged_in(): bool
{
    return isset($_SESSION['user']['id']);
}

function auth_user(): ?array
{
    return $_SESSION['user'] ?? null;
}

function valid_date(string $date): bool
{
    $dateObject = DateTime::createFromFormat('Y-m-d', $date);

    return $dateObject !== false
        && $dateObject->format('Y-m-d') === $date;
}