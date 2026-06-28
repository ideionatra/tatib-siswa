<?php

declare(strict_types=1);

require_once __DIR__ . '/Koneksi.php';
require_once __DIR__ . '/Poin.php';

class Laporan
{
    private mysqli $db;

    public function __construct()
    {
        $this->db = (new \Koneksi())->connect();
    }

    public function createViolation(
        int $studentId,
        int $violationId,
        string $description,
        string $date,
        string $sanction
    ): int {
        $this->db->begin_transaction();

        try {
            $query = '
                INSERT INTO detail_pelanggaran (
                    id_siswa,
                    id_pelanggaran,
                    keterangan_pelanggaran,
                    tanggal_pelanggaran,
                    sanksi_pelanggaran
                )
                VALUES (?, ?, ?, ?, ?)
            ';

            $statement = $this->db->prepare($query);
            $statement->bind_param(
                'iisss',
                $studentId,
                $violationId,
                $description,
                $date,
                $sanction
            );

            $statement->execute();
            $reportId = $this->db->insert_id;

            \Poin::recalculateStudent($this->db, $studentId);

            $this->db->commit();

            return $reportId;
        } catch (Throwable $exception) {
            $this->db->rollback();
            throw $exception;
        }
    }

    public function createAchievement(
        int $studentId,
        int $achievementId,
        string $description,
        string $date
    ): int {
        $this->db->begin_transaction();

        try {
            $query = '
                INSERT INTO detail_prestasi (
                    id_siswa,
                    id_prestasi,
                    keterangan_prestasi,
                    tanggal_prestasi
                )
                VALUES (?, ?, ?, ?)
            ';

            $statement = $this->db->prepare($query);
            $statement->bind_param(
                'iiss',
                $studentId,
                $achievementId,
                $description,
                $date
            );

            $statement->execute();
            $reportId = $this->db->insert_id;

            \Poin::recalculateStudent($this->db, $studentId);

            $this->db->commit();

            return $reportId;
        } catch (Throwable $exception) {
            $this->db->rollback();
            throw $exception;
        }
    }

    public function getRecent(int $limit = 10): array
    {
        $query = '
            SELECT *
            FROM (
                SELECT
                    dp.id AS detail_id,
                    "Pelanggaran" AS jenis_laporan,
                    dp.tanggal_pelanggaran AS tanggal,
                    dp.keterangan_pelanggaran AS keterangan,
                    p.jenis_pelanggaran AS kategori,
                    p.poin_pelanggaran AS poin,
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

                UNION ALL

                SELECT
                    dpr.id AS detail_id,
                    "Prestasi" AS jenis_laporan,
                    dpr.tanggal_prestasi AS tanggal,
                    dpr.keterangan_prestasi AS keterangan,
                    pr.jenis_prestasi AS kategori,
                    pr.poin_prestasi AS poin,
                    s.nama,
                    s.nis,
                    CONCAT(t.index_tingkat, " ", k.nama_kelas) AS kelas
                FROM detail_prestasi AS dpr
                INNER JOIN data_prestasi AS pr
                    ON pr.id = dpr.id_prestasi
                INNER JOIN siswa AS s
                    ON s.id = dpr.id_siswa
                INNER JOIN kelas AS k
                    ON k.id = s.id_kelas
                INNER JOIN tingkat AS t
                    ON t.id = k.id_tingkat
            ) AS laporan
            ORDER BY tanggal DESC, detail_id DESC
            LIMIT ?
        ';

        $statement = $this->db->prepare($query);
        $statement->bind_param('i', $limit);
        $statement->execute();

        return $statement
            ->get_result()
            ->fetch_all(MYSQLI_ASSOC);
    }
}