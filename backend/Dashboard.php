<?php

declare(strict_types=1);

require_once __DIR__ . '/Koneksi.php';

class Dashboard
{
    private mysqli $db;

    public function __construct()
    {
        $this->db = (new \Koneksi())->connect();
    }

    public function getSummary(): array
    {
        $query = '
            SELECT
                (SELECT COUNT(*) FROM kelas) AS total_kelas,
                (SELECT COUNT(*) FROM siswa) AS total_siswa,

                COALESCE(
                    (SELECT SUM(poin_pelanggaran) FROM siswa),
                    0
                ) AS total_poin_pelanggaran,

                COALESCE(
                    (SELECT SUM(poin_prestasi) FROM siswa),
                    0
                ) AS total_poin_prestasi
        ';

        return $this->db
            ->query($query)
            ->fetch_assoc();
    }

    public function getViolationRanking(int $limit = 10): array
    {
        $query = '
            SELECT
                s.id,
                s.nis,
                s.nama,
                s.poin_pelanggaran,
                s.poin_prestasi,
                s.total_poin,
                CONCAT(t.index_tingkat, " ", k.nama_kelas) AS kelas
            FROM siswa AS s
            INNER JOIN kelas AS k ON k.id = s.id_kelas
            INNER JOIN tingkat AS t ON t.id = k.id_tingkat
            ORDER BY
                s.poin_pelanggaran DESC,
                s.nama ASC
            LIMIT ?
        ';

        $statement = $this->db->prepare($query);
        $statement->bind_param('i', $limit);
        $statement->execute();

        return $statement
            ->get_result()
            ->fetch_all(MYSQLI_ASSOC);
    }

    public function getTodayViolations(string $date): array
    {
        $query = '
            SELECT
                dp.id,
                dp.tanggal_pelanggaran,
                dp.keterangan_pelanggaran,
                dp.sanksi_pelanggaran,
                p.jenis_pelanggaran,
                p.poin_pelanggaran,
                s.nama,
                s.nis,
                CONCAT(t.index_tingkat, " ", k.nama_kelas) AS kelas
            FROM detail_pelanggaran AS dp
            INNER JOIN data_pelanggaran AS p
                ON p.id = dp.id_pelanggaran
            INNER JOIN siswa AS s
                ON s.id = dp.id_siswa
            INNER JOIN kelas AS k
                ON k.id = s.id_kelas
            INNER JOIN tingkat AS t
                ON t.id = k.id_tingkat
            WHERE dp.tanggal_pelanggaran = ?
            ORDER BY dp.id DESC
        ';

        $statement = $this->db->prepare($query);
        $statement->bind_param('s', $date);
        $statement->execute();

        return $statement
            ->get_result()
            ->fetch_all(MYSQLI_ASSOC);
    }
}