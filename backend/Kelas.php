<?php

declare(strict_types=1);

require_once __DIR__ . '/Koneksi.php';

class Kelas
{
    private mysqli $db;

    public function __construct()
    {
        $this->db = (new \Koneksi())->connect();
    }

    public function getAll(): array
    {
        $query = '
            SELECT
                k.id,
                k.nama_kelas,
                k.id_tingkat,
                t.index_tingkat,
                CONCAT(t.index_tingkat, " ", k.nama_kelas) AS nama_lengkap
            FROM kelas AS k
            INNER JOIN tingkat AS t
                ON t.id = k.id_tingkat
            ORDER BY
                t.id ASC,
                k.nama_kelas ASC
        ';

        return $this->db
            ->query($query)
            ->fetch_all(MYSQLI_ASSOC);
    }

    public function getAllWithStudentCount(): array
    {
        $query = '
            SELECT
                k.id,
                k.nama_kelas,
                t.index_tingkat,
                CONCAT(t.index_tingkat, " ", k.nama_kelas) AS nama_lengkap,
                COUNT(s.id) AS jumlah_siswa
            FROM kelas AS k
            INNER JOIN tingkat AS t
                ON t.id = k.id_tingkat
            LEFT JOIN siswa AS s
                ON s.id_kelas = k.id
            GROUP BY
                k.id,
                k.nama_kelas,
                t.index_tingkat,
                t.id
            ORDER BY
                t.id ASC,
                k.nama_kelas ASC
        ';

        return $this->db
            ->query($query)
            ->fetch_all(MYSQLI_ASSOC);
    }

    public function getById(int $id): ?array
    {
        $query = '
            SELECT
                k.id,
                k.nama_kelas,
                k.id_tingkat,
                t.index_tingkat,
                CONCAT(t.index_tingkat, " ", k.nama_kelas) AS nama_lengkap
            FROM kelas AS k
            INNER JOIN tingkat AS t
                ON t.id = k.id_tingkat
            WHERE k.id = ?
            LIMIT 1
        ';

        $statement = $this->db->prepare($query);
        $statement->bind_param('i', $id);
        $statement->execute();

        $result = $statement->get_result()->fetch_assoc();

        return $result ?: null;
    }
}