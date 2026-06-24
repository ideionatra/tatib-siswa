<?php

require_once 'Koneksi.php';

class DataPelanggaran{
    private $db;

    public function __construct()
    {
        $koneksi = new \Koneksi();
        $this->db = $koneksi->connect();
    }

    public function getAllDataPelanggaran(){
        $query = "SELECT * FROM data_pelanggaran";
        $result = $this->db->query($query);

        return $result;
    }
}