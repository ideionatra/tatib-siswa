<?php

class Koneksi {

    private $host = 'localhost';
    private $user = 'root';
    private $pass = '';
    private $db = 'tatib_siswa';

    private $conn;

    public function connect()
    {
        if (!$this->conn) {
            $this->conn = new mysqli(
                $this->host, $this->user, $this->pass, $this->db
            );

            if ($this->conn->connect_error) {
                die('Connection failed: ' . $this->conn->connect_error);
            }
        }

        return $this->conn;
    }

    public function connClose()
    {
        if ($this->conn) {
            $this->conn->close();
        }
    }
}