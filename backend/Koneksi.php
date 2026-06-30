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

        $host = 'localhost';
        $port = 3306;
        $database = 'tatib_siswa';
        $username = 'root';
        $password = '';

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