<?php

declare(strict_types=1);

class Poin
{
    public static function recalculateStudent(mysqli $db, int $studentId): void
    {
        $query = '
            UPDATE siswa AS s

            LEFT JOIN (
                SELECT
                    dp.id_siswa,
                    SUM(p.poin_pelanggaran) AS total_pelanggaran
                FROM detail_pelanggaran AS dp
                INNER JOIN data_pelanggaran AS p
                    ON p.id = dp.id_pelanggaran
                GROUP BY dp.id_siswa
            ) AS pelanggaran
                ON pelanggaran.id_siswa = s.id

            LEFT JOIN (
                SELECT
                    dpr.id_siswa,
                    SUM(pr.poin_prestasi) AS total_prestasi
                FROM detail_prestasi AS dpr
                INNER JOIN data_prestasi AS pr
                    ON pr.id = dpr.id_prestasi
                GROUP BY dpr.id_siswa
            ) AS prestasi
                ON prestasi.id_siswa = s.id

            SET
                s.poin_pelanggaran =
                    COALESCE(pelanggaran.total_pelanggaran, 0),

                s.poin_prestasi =
                    COALESCE(prestasi.total_prestasi, 0),

                s.total_poin =
                    COALESCE(pelanggaran.total_pelanggaran, 0)
                    - COALESCE(prestasi.total_prestasi, 0)

            WHERE s.id = ?
        ';

        $statement = $db->prepare($query);
        $statement->bind_param('i', $studentId);
        $statement->execute();
    }

    public static function recalculateAll(mysqli $db): void
    {
        $query = '
            UPDATE siswa AS s

            LEFT JOIN (
                SELECT
                    dp.id_siswa,
                    SUM(p.poin_pelanggaran) AS total_pelanggaran
                FROM detail_pelanggaran AS dp
                INNER JOIN data_pelanggaran AS p
                    ON p.id = dp.id_pelanggaran
                GROUP BY dp.id_siswa
            ) AS pelanggaran
                ON pelanggaran.id_siswa = s.id

            LEFT JOIN (
                SELECT
                    dpr.id_siswa,
                    SUM(pr.poin_prestasi) AS total_prestasi
                FROM detail_prestasi AS dpr
                INNER JOIN data_prestasi AS pr
                    ON pr.id = dpr.id_prestasi
                GROUP BY dpr.id_siswa
            ) AS prestasi
                ON prestasi.id_siswa = s.id

            SET
                s.poin_pelanggaran =
                    COALESCE(pelanggaran.total_pelanggaran, 0),

                s.poin_prestasi =
                    COALESCE(prestasi.total_prestasi, 0),

                s.total_poin =
                    COALESCE(pelanggaran.total_pelanggaran, 0)
                    - COALESCE(prestasi.total_prestasi, 0)
        ';

        $db->query($query);
    }
}