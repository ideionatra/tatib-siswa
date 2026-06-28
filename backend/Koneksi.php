<?php

declare(strict_types=1);

class Koneksi
{
    private static ?mysqli $connection = null;

    public function connect(): mysqli
    {
        if (self::$connection instanceof mysqli) {
            return self::$connection;
        }

        mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

        $host = getenv('DB_HOST') ?: 'localhost';
        $port = (int) (getenv('DB_PORT') ?: 3306);
        $database = getenv('DB_DATABASE') ?: 'tatib_siswa';
        $username = getenv('DB_USERNAME') ?: 'root';
        $password = getenv('DB_PASSWORD') ?: '';

        self::$connection = new mysqli(
            $host,
            $username,
            $password,
            $database,
            $port
        );

        self::$connection->set_charset('utf8mb4');

        return self::$connection;
    }
}