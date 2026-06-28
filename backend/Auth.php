<?php

declare(strict_types=1);

require_once __DIR__ . '/Koneksi.php';

class Auth
{
    private mysqli $db;

    public function __construct()
    {
        $this->db = (new \Koneksi())->connect();
    }

    public function attempt(string $username, string $password): ?array
    {
        $query = '
            SELECT id, username, password
            FROM `user`
            WHERE username = ?
            LIMIT 1
        ';

        $statement = $this->db->prepare($query);
        $statement->bind_param('s', $username);
        $statement->execute();

        $user = $statement->get_result()->fetch_assoc();

        if (!$user) {
            return null;
        }

        if (!hash_equals((string) $user['password'], $password)) {
            return null;
        }

        return [
            'id' => (int) $user['id'],
            'username' => $user['username'],
        ];
    }
}