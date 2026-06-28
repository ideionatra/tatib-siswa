<?php

declare(strict_types=1);

require_once __DIR__ . '/Koneksi.php';
require_once __DIR__ . '/Poin.php';

class DataPelanggaran
{
    private mysqli $db;

    public function __construct()
    {
        $this->db = (new \Koneksi())->connect();
    }

    public function getAll(): array
    {
        $query = '
            SELECT *
            FROM data_pelanggaran
            ORDER BY poin_pelanggaran ASC, jenis_pelanggaran ASC
        ';

        return $this->db
            ->query($query)
            ->fetch_all(MYSQLI_ASSOC);
    }

    public function getById(int $id): ?array
    {
        $query = '
            SELECT *
            FROM data_pelanggaran
            WHERE id = ?
            LIMIT 1
        ';

        $statement = $this->db->prepare($query);
        $statement->bind_param('i', $id);
        $statement->execute();

        $item = $statement->get_result()->fetch_assoc();

        return $item ?: null;
    }

    public function create(string $name, int $point): int
    {
        $query = '
            INSERT INTO data_pelanggaran (
                jenis_pelanggaran,
                poin_pelanggaran
            )
            VALUES (?, ?)
        ';

        $statement = $this->db->prepare($query);
        $statement->bind_param('si', $name, $point);
        $statement->execute();

        return $this->db->insert_id;
    }

    public function update(int $id, string $name, int $point): void
    {
        $this->db->begin_transaction();

        try {
            $query = '
                UPDATE data_pelanggaran
                SET
                    jenis_pelanggaran = ?,
                    poin_pelanggaran = ?
                WHERE id = ?
            ';

            $statement = $this->db->prepare($query);
            $statement->bind_param('sii', $name, $point, $id);
            $statement->execute();

            \Poin::recalculateAll($this->db);

            $this->db->commit();
        } catch (Throwable $exception) {
            $this->db->rollback();
            throw $exception;
        }
    }

    public function delete(int $id): void
    {
        $this->db->begin_transaction();

        try {
            $query = '
                DELETE FROM data_pelanggaran
                WHERE id = ?
            ';

            $statement = $this->db->prepare($query);
            $statement->bind_param('i', $id);
            $statement->execute();

            \Poin::recalculateAll($this->db);

            $this->db->commit();
        } catch (Throwable $exception) {
            $this->db->rollback();
            throw $exception;
        }
    }
}