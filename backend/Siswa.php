<?php

declare(strict_types=1);

require_once __DIR__ . '/Koneksi.php';

class Siswa
{
    private mysqli $db;

    public function __construct()
    {
        $this->db = (new \Koneksi())->connect();
    }

    public function getByClass(int $classId): array
    {
        $query = '
            SELECT *
            FROM siswa
            WHERE id_kelas = ?
            ORDER BY nama ASC
        ';

        $statement = $this->db->prepare($query);
        $statement->bind_param('i', $classId);
        $statement->execute();

        return $statement
            ->get_result()
            ->fetch_all(MYSQLI_ASSOC);
    }

    public function getById(int $id): ?array
    {
        $query = '
            SELECT *
            FROM siswa
            WHERE id = ?
            LIMIT 1
        ';

        $statement = $this->db->prepare($query);
        $statement->bind_param('i', $id);
        $statement->execute();

        $student = $statement->get_result()->fetch_assoc();

        return $student ?: null;
    }

    public function getAllForSelection(): array
    {
        $query = '
            SELECT
                s.id,
                s.nis,
                s.nama,
                s.id_kelas,
                CONCAT(t.index_tingkat, " ", k.nama_kelas) AS kelas
            FROM siswa AS s
            INNER JOIN kelas AS k
                ON k.id = s.id_kelas
            INNER JOIN tingkat AS t
                ON t.id = k.id_tingkat
            ORDER BY
                t.id ASC,
                k.nama_kelas ASC,
                s.nama ASC
        ';

        return $this->db
            ->query($query)
            ->fetch_all(MYSQLI_ASSOC);
    }

    public function identifierExists(
        string $nis,
        string $nisn,
        int $excludeId = 0
    ): bool {
        $query = '
            SELECT id
            FROM siswa
            WHERE (nis = ? OR nisn = ?)
              AND id <> ?
            LIMIT 1
        ';

        $statement = $this->db->prepare($query);
        $statement->bind_param(
            'ssi',
            $nis,
            $nisn,
            $excludeId
        );

        $statement->execute();

        return $statement->get_result()->num_rows > 0;
    }

    public function create(array $data): int
    {
        $query = '
            INSERT INTO siswa (
                nis,
                nisn,
                nama,
                tempat_lahir,
                tanggal_lahir,
                alamat,
                no_telp,
                jenis_kelamin,
                agama,
                foto_siswa,
                id_kelas
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ';

        $nis = $data['nis'];
        $nisn = $data['nisn'];
        $nama = $data['nama'];
        $tempatLahir = $data['tempat_lahir'];
        $tanggalLahir = $data['tanggal_lahir'];
        $alamat = $data['alamat'];
        $noTelp = $data['no_telp'];
        $jenisKelamin = $data['jenis_kelamin'];
        $agama = $data['agama'];
        $foto = $data['foto_siswa'];
        $classId = (int) $data['id_kelas'];

        $statement = $this->db->prepare($query);
        $statement->bind_param(
            'ssssssssssi',
            $nis,
            $nisn,
            $nama,
            $tempatLahir,
            $tanggalLahir,
            $alamat,
            $noTelp,
            $jenisKelamin,
            $agama,
            $foto,
            $classId
        );

        $statement->execute();

        return $this->db->insert_id;
    }

    public function update(int $id, array $data): void
    {
        $query = '
            UPDATE siswa
            SET
                nis = ?,
                nisn = ?,
                nama = ?,
                tempat_lahir = ?,
                tanggal_lahir = ?,
                alamat = ?,
                no_telp = ?,
                jenis_kelamin = ?,
                agama = ?,
                foto_siswa = ?,
                id_kelas = ?
            WHERE id = ?
        ';

        $nis = $data['nis'];
        $nisn = $data['nisn'];
        $nama = $data['nama'];
        $tempatLahir = $data['tempat_lahir'];
        $tanggalLahir = $data['tanggal_lahir'];
        $alamat = $data['alamat'];
        $noTelp = $data['no_telp'];
        $jenisKelamin = $data['jenis_kelamin'];
        $agama = $data['agama'];
        $foto = $data['foto_siswa'];
        $classId = (int) $data['id_kelas'];

        $statement = $this->db->prepare($query);
        $statement->bind_param(
            'ssssssssssii',
            $nis,
            $nisn,
            $nama,
            $tempatLahir,
            $tanggalLahir,
            $alamat,
            $noTelp,
            $jenisKelamin,
            $agama,
            $foto,
            $classId,
            $id
        );

        $statement->execute();
    }

    public function delete(int $id): void
    {
        $query = 'DELETE FROM siswa WHERE id = ?';

        $statement = $this->db->prepare($query);
        $statement->bind_param('i', $id);
        $statement->execute();
    }
}