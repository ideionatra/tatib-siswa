-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 28, 2026 at 06:52 AM
-- Server version: 8.0.30
-- PHP Version: 8.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tatib_siswa`
--

-- --------------------------------------------------------

--
-- Table structure for table `data_pelanggaran`
--

CREATE TABLE `data_pelanggaran` (
  `id` int NOT NULL,
  `jenis_pelanggaran` varchar(100) NOT NULL,
  `poin_pelanggaran` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `data_pelanggaran`
--

INSERT INTO `data_pelanggaran` (`id`, `jenis_pelanggaran`, `poin_pelanggaran`) VALUES
(1, 'Terlambat datang ke sekolah', 5),
(2, 'Tidak memakai atribut sekolah', 5),
(3, 'Berisik di dalam kelas', 5),
(4, 'Tidak memakai seragam lengkap', 10),
(5, 'Tidak mengerjakan tugas', 10),
(6, 'Membuang sampah sembarangan', 10),
(7, 'Menggunakan HP saat pelajaran', 15),
(8, 'Tidak mengikuti upacara tanpa alasan', 20),
(9, 'Membolos saat jam pelajaran', 25),
(10, 'Keluar sekolah tanpa izin', 30),
(11, 'Merokok di lingkungan sekolah', 50),
(12, 'Berkelahi dengan teman', 75),
(13, 'Memalsukan tanda tangan orang tua', 80),
(14, 'Merusak fasilitas sekolah', 100),
(15, 'Membawa barang terlarang ke sekolah', 100);

-- --------------------------------------------------------

--
-- Table structure for table `data_prestasi`
--

CREATE TABLE `data_prestasi` (
  `id` int NOT NULL,
  `jenis_prestasi` varchar(100) NOT NULL,
  `poin_prestasi` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `data_prestasi`
--

INSERT INTO `data_prestasi` (`id`, `jenis_prestasi`, `poin_prestasi`) VALUES
(1, 'Peserta Tingkat Sekolah', 5),
(2, 'Juara 3 Tingkat Sekolah', 10),
(3, 'Juara 2 Tingkat Sekolah', 15),
(4, 'Juara 1 Tingkat Sekolah', 20),
(5, 'Peserta Tingkat Kabupaten/Kota', 25),
(6, 'Juara 3 Tingkat Kabupaten/Kota', 30),
(7, 'Juara 2 Tingkat Kabupaten/Kota', 35),
(8, 'Juara 1 Tingkat Kabupaten/Kota', 40),
(9, 'Peserta Tingkat Provinsi', 45),
(10, 'Juara 3 Tingkat Provinsi', 50),
(11, 'Juara 2 Tingkat Provinsi', 55),
(12, 'Juara 1 Tingkat Provinsi', 60),
(13, 'Peserta Tingkat Nasional', 65),
(14, 'Juara 3 Tingkat Nasional', 70),
(15, 'Juara 2 Tingkat Nasional', 80),
(16, 'Juara 1 Tingkat Nasional', 90),
(17, 'Juara 3 Tingkat Internasional', 100),
(18, 'Juara 2 Tingkat Internasional', 110),
(19, 'Juara 1 Tingkat Internasional', 120);

-- --------------------------------------------------------

--
-- Table structure for table `detail_pelanggaran`
--

CREATE TABLE `detail_pelanggaran` (
  `id` int NOT NULL,
  `id_siswa` int NOT NULL,
  `id_pelanggaran` int NOT NULL,
  `keterangan_pelanggaran` text NOT NULL,
  `tanggal_pelanggaran` date NOT NULL,
  `sanksi_pelanggaran` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detail_prestasi`
--

CREATE TABLE `detail_prestasi` (
  `id` int NOT NULL,
  `id_siswa` int NOT NULL,
  `id_prestasi` int NOT NULL,
  `keterangan_prestasi` text NOT NULL,
  `tanggal_prestasi` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id` int NOT NULL,
  `nama_kelas` varchar(50) NOT NULL,
  `id_tingkat` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`id`, `nama_kelas`, `id_tingkat`) VALUES
(1, 'IPA I', 1),
(2, 'IPA II', 1),
(3, 'IPS I', 1),
(4, 'IPS II', 1),
(5, 'IPA I', 2),
(6, 'IPA II', 2),
(7, 'IPS I', 2),
(8, 'IPS II', 2),
(9, 'IPA I', 3),
(10, 'IPA II', 3),
(11, 'IPS I', 3),
(12, 'IPS II', 3);

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `id` int NOT NULL,
  `nis` varchar(10) NOT NULL,
  `nisn` varchar(15) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `tempat_lahir` varchar(50) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `jenis_kelamin` varchar(1) NOT NULL,
  `agama` varchar(10) NOT NULL,
  `poin_pelanggaran` int NOT NULL DEFAULT '0',
  `poin_prestasi` int NOT NULL DEFAULT '0',
  `total_poin` int NOT NULL DEFAULT '0',
  `foto_siswa` varchar(500) NOT NULL,
  `id_kelas` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`id`, `nis`, `nisn`, `nama`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_telp`, `jenis_kelamin`, `agama`, `poin_pelanggaran`, `poin_prestasi`, `total_poin`, `foto_siswa`, `id_kelas`) VALUES
(3, '7000001020', '900000000001020', 'Ni Komang Zahra 0120', 'Denpasar', '2010-01-12', 'Jalan Pendidikan No. 20, Denpasar, Bali', '081301002000', 'P', 'Kristen', 0, 0, 0, '-', 1),
(4, '7000001019', '900000000001019', 'I Kadek Yoga 0119', 'Bangli', '2010-11-21', 'Jalan Pendidikan No. 19, Denpasar, Bali', '081301001900', 'L', 'Hindu', 0, 0, 0, '-', 1),
(5, '7000001018', '900000000001018', 'Ni Putu Sari 0118', 'Tabanan', '2010-11-04', 'Jalan Pendidikan No. 18, Denpasar, Bali', '081301001800', 'P', 'Islam', 0, 0, 0, '-', 1),
(6, '7000001017', '900000000001017', 'I Wayan Rama 0117', 'Gianyar', '2010-10-18', 'Jalan Pendidikan No. 17, Denpasar, Bali', '081301001700', 'L', 'Konghucu', 0, 0, 0, '-', 1),
(7, '7000001016', '900000000001016', 'Ni Made Puspita 0116', 'Badung', '2010-10-01', 'Jalan Pendidikan No. 16, Denpasar, Bali', '081301001600', 'P', 'Buddha', 0, 0, 0, '-', 1),
(8, '7000001015', '900000000001015', 'I Komang Oka 0115', 'Denpasar', '2010-09-14', 'Jalan Pendidikan No. 15, Denpasar, Bali', '081301001500', 'L', 'Katolik', 0, 0, 0, '-', 1),
(9, '7000001014', '900000000001014', 'Ni Kadek Nadia 0114', 'Bangli', '2010-08-28', 'Jalan Pendidikan No. 14, Denpasar, Bali', '081301001400', 'P', 'Kristen', 0, 0, 0, '-', 1),
(10, '7000001013', '900000000001013', 'I Putu Mahendra 0113', 'Tabanan', '2010-08-11', 'Jalan Pendidikan No. 13, Denpasar, Bali', '081301001300', 'L', 'Hindu', 0, 0, 0, '-', 1),
(11, '7000001012', '900000000001012', 'Ni Wayan Kartika 0112', 'Gianyar', '2010-07-25', 'Jalan Pendidikan No. 12, Denpasar, Bali', '081301001200', 'P', 'Islam', 0, 0, 0, '-', 1),
(12, '7000001011', '900000000001011', 'I Made Jaya 0111', 'Badung', '2010-07-08', 'Jalan Pendidikan No. 11, Denpasar, Bali', '081301001100', 'L', 'Konghucu', 0, 0, 0, '-', 1),
(13, '7000001010', '900000000001010', 'Ni Komang Indah 0110', 'Denpasar', '2010-06-21', 'Jalan Pendidikan No. 10, Denpasar, Bali', '081301001000', 'P', 'Buddha', 0, 0, 0, '-', 1),
(14, '7000001009', '900000000001009', 'I Kadek Hendra 0109', 'Bangli', '2010-06-04', 'Jalan Pendidikan No. 9, Denpasar, Bali', '081301000900', 'L', 'Katolik', 0, 0, 0, '-', 1),
(15, '7000001008', '900000000001008', 'Ni Putu Gita 0108', 'Tabanan', '2010-05-18', 'Jalan Pendidikan No. 8, Denpasar, Bali', '081301000800', 'P', 'Kristen', 0, 0, 0, '-', 1),
(16, '7000001007', '900000000001007', 'I Wayan Fajar 0107', 'Gianyar', '2010-05-01', 'Jalan Pendidikan No. 7, Denpasar, Bali', '081301000700', 'L', 'Hindu', 0, 0, 0, '-', 1),
(17, '7000001006', '900000000001006', 'Ni Made Eka 0106', 'Badung', '2010-04-14', 'Jalan Pendidikan No. 6, Denpasar, Bali', '081301000600', 'P', 'Islam', 0, 0, 0, '-', 1),
(18, '7000001005', '900000000001005', 'I Komang Dimas 0105', 'Denpasar', '2010-03-28', 'Jalan Pendidikan No. 5, Denpasar, Bali', '081301000500', 'L', 'Konghucu', 0, 0, 0, '-', 1),
(19, '7000001004', '900000000001004', 'Ni Kadek Citra 0104', 'Bangli', '2010-03-11', 'Jalan Pendidikan No. 4, Denpasar, Bali', '081301000400', 'P', 'Buddha', 0, 0, 0, '-', 1),
(20, '7000001003', '900000000001003', 'I Putu Bagus 0103', 'Tabanan', '2010-02-22', 'Jalan Pendidikan No. 3, Denpasar, Bali', '081301000300', 'L', 'Katolik', 0, 0, 0, '-', 1),
(21, '7000001002', '900000000001002', 'Ni Luh Ayu 0102', 'Gianyar', '2010-02-05', 'Jalan Pendidikan No. 2, Denpasar, Bali', '081301000200', 'P', 'Kristen', 0, 0, 0, '-', 1),
(22, '7000001001', '900000000001001', 'I Made Aditya 0101', 'Badung', '2010-01-19', 'Jalan Pendidikan No. 1, Denpasar, Bali', '081301000100', 'L', 'Hindu', 0, 0, 0, '-', 1),
(23, '7000002020', '900000000002020', 'Ni Komang Zahra 0220', 'Denpasar', '2010-01-13', 'Jalan Pendidikan No. 20, Denpasar, Bali', '081302002000', 'P', 'Kristen', 0, 0, 0, '-', 2),
(24, '7000002019', '900000000002019', 'I Kadek Yoga 0219', 'Bangli', '2010-11-22', 'Jalan Pendidikan No. 19, Denpasar, Bali', '081302001900', 'L', 'Hindu', 0, 0, 0, '-', 2),
(25, '7000002018', '900000000002018', 'Ni Putu Sari 0218', 'Tabanan', '2010-11-05', 'Jalan Pendidikan No. 18, Denpasar, Bali', '081302001800', 'P', 'Islam', 0, 0, 0, '-', 2),
(26, '7000002017', '900000000002017', 'I Wayan Rama 0217', 'Gianyar', '2010-10-19', 'Jalan Pendidikan No. 17, Denpasar, Bali', '081302001700', 'L', 'Konghucu', 0, 0, 0, '-', 2),
(27, '7000002016', '900000000002016', 'Ni Made Puspita 0216', 'Badung', '2010-10-02', 'Jalan Pendidikan No. 16, Denpasar, Bali', '081302001600', 'P', 'Buddha', 0, 0, 0, '-', 2),
(28, '7000002015', '900000000002015', 'I Komang Oka 0215', 'Denpasar', '2010-09-15', 'Jalan Pendidikan No. 15, Denpasar, Bali', '081302001500', 'L', 'Katolik', 0, 0, 0, '-', 2),
(29, '7000002014', '900000000002014', 'Ni Kadek Nadia 0214', 'Bangli', '2010-08-29', 'Jalan Pendidikan No. 14, Denpasar, Bali', '081302001400', 'P', 'Kristen', 0, 0, 0, '-', 2),
(30, '7000002013', '900000000002013', 'I Putu Mahendra 0213', 'Tabanan', '2010-08-12', 'Jalan Pendidikan No. 13, Denpasar, Bali', '081302001300', 'L', 'Hindu', 0, 0, 0, '-', 2),
(31, '7000002012', '900000000002012', 'Ni Wayan Kartika 0212', 'Gianyar', '2010-07-26', 'Jalan Pendidikan No. 12, Denpasar, Bali', '081302001200', 'P', 'Islam', 0, 0, 0, '-', 2),
(32, '7000002011', '900000000002011', 'I Made Jaya 0211', 'Badung', '2010-07-09', 'Jalan Pendidikan No. 11, Denpasar, Bali', '081302001100', 'L', 'Konghucu', 0, 0, 0, '-', 2),
(33, '7000002010', '900000000002010', 'Ni Komang Indah 0210', 'Denpasar', '2010-06-22', 'Jalan Pendidikan No. 10, Denpasar, Bali', '081302001000', 'P', 'Buddha', 0, 0, 0, '-', 2),
(34, '7000002009', '900000000002009', 'I Kadek Hendra 0209', 'Bangli', '2010-06-05', 'Jalan Pendidikan No. 9, Denpasar, Bali', '081302000900', 'L', 'Katolik', 0, 0, 0, '-', 2),
(35, '7000002008', '900000000002008', 'Ni Putu Gita 0208', 'Tabanan', '2010-05-19', 'Jalan Pendidikan No. 8, Denpasar, Bali', '081302000800', 'P', 'Kristen', 0, 0, 0, '-', 2),
(36, '7000002007', '900000000002007', 'I Wayan Fajar 0207', 'Gianyar', '2010-05-02', 'Jalan Pendidikan No. 7, Denpasar, Bali', '081302000700', 'L', 'Hindu', 0, 0, 0, '-', 2),
(37, '7000002006', '900000000002006', 'Ni Made Eka 0206', 'Badung', '2010-04-15', 'Jalan Pendidikan No. 6, Denpasar, Bali', '081302000600', 'P', 'Islam', 0, 0, 0, '-', 2),
(38, '7000002005', '900000000002005', 'I Komang Dimas 0205', 'Denpasar', '2010-03-29', 'Jalan Pendidikan No. 5, Denpasar, Bali', '081302000500', 'L', 'Konghucu', 0, 0, 0, '-', 2),
(39, '7000002004', '900000000002004', 'Ni Kadek Citra 0204', 'Bangli', '2010-03-12', 'Jalan Pendidikan No. 4, Denpasar, Bali', '081302000400', 'P', 'Buddha', 0, 0, 0, '-', 2),
(40, '7000002003', '900000000002003', 'I Putu Bagus 0203', 'Tabanan', '2010-02-23', 'Jalan Pendidikan No. 3, Denpasar, Bali', '081302000300', 'L', 'Katolik', 0, 0, 0, '-', 2),
(41, '7000002002', '900000000002002', 'Ni Luh Ayu 0202', 'Gianyar', '2010-02-06', 'Jalan Pendidikan No. 2, Denpasar, Bali', '081302000200', 'P', 'Kristen', 0, 0, 0, '-', 2),
(42, '7000002001', '900000000002001', 'I Made Aditya 0201', 'Badung', '2010-01-20', 'Jalan Pendidikan No. 1, Denpasar, Bali', '081302000100', 'L', 'Hindu', 0, 0, 0, '-', 2),
(43, '7000003020', '900000000003020', 'Ni Komang Zahra 0320', 'Denpasar', '2010-01-14', 'Jalan Pendidikan No. 20, Denpasar, Bali', '081303002000', 'P', 'Kristen', 0, 0, 0, '-', 3),
(44, '7000003019', '900000000003019', 'I Kadek Yoga 0319', 'Bangli', '2010-11-23', 'Jalan Pendidikan No. 19, Denpasar, Bali', '081303001900', 'L', 'Hindu', 0, 0, 0, '-', 3),
(45, '7000003018', '900000000003018', 'Ni Putu Sari 0318', 'Tabanan', '2010-11-06', 'Jalan Pendidikan No. 18, Denpasar, Bali', '081303001800', 'P', 'Islam', 0, 0, 0, '-', 3),
(46, '7000003017', '900000000003017', 'I Wayan Rama 0317', 'Gianyar', '2010-10-20', 'Jalan Pendidikan No. 17, Denpasar, Bali', '081303001700', 'L', 'Konghucu', 0, 0, 0, '-', 3),
(47, '7000003016', '900000000003016', 'Ni Made Puspita 0316', 'Badung', '2010-10-03', 'Jalan Pendidikan No. 16, Denpasar, Bali', '081303001600', 'P', 'Buddha', 0, 0, 0, '-', 3),
(48, '7000003015', '900000000003015', 'I Komang Oka 0315', 'Denpasar', '2010-09-16', 'Jalan Pendidikan No. 15, Denpasar, Bali', '081303001500', 'L', 'Katolik', 0, 0, 0, '-', 3),
(49, '7000003014', '900000000003014', 'Ni Kadek Nadia 0314', 'Bangli', '2010-08-30', 'Jalan Pendidikan No. 14, Denpasar, Bali', '081303001400', 'P', 'Kristen', 0, 0, 0, '-', 3),
(50, '7000003013', '900000000003013', 'I Putu Mahendra 0313', 'Tabanan', '2010-08-13', 'Jalan Pendidikan No. 13, Denpasar, Bali', '081303001300', 'L', 'Hindu', 0, 0, 0, '-', 3),
(51, '7000003012', '900000000003012', 'Ni Wayan Kartika 0312', 'Gianyar', '2010-07-27', 'Jalan Pendidikan No. 12, Denpasar, Bali', '081303001200', 'P', 'Islam', 0, 0, 0, '-', 3),
(52, '7000003011', '900000000003011', 'I Made Jaya 0311', 'Badung', '2010-07-10', 'Jalan Pendidikan No. 11, Denpasar, Bali', '081303001100', 'L', 'Konghucu', 0, 0, 0, '-', 3),
(53, '7000003010', '900000000003010', 'Ni Komang Indah 0310', 'Denpasar', '2010-06-23', 'Jalan Pendidikan No. 10, Denpasar, Bali', '081303001000', 'P', 'Buddha', 0, 0, 0, '-', 3),
(54, '7000003009', '900000000003009', 'I Kadek Hendra 0309', 'Bangli', '2010-06-06', 'Jalan Pendidikan No. 9, Denpasar, Bali', '081303000900', 'L', 'Katolik', 0, 0, 0, '-', 3),
(55, '7000003008', '900000000003008', 'Ni Putu Gita 0308', 'Tabanan', '2010-05-20', 'Jalan Pendidikan No. 8, Denpasar, Bali', '081303000800', 'P', 'Kristen', 0, 0, 0, '-', 3),
(56, '7000003007', '900000000003007', 'I Wayan Fajar 0307', 'Gianyar', '2010-05-03', 'Jalan Pendidikan No. 7, Denpasar, Bali', '081303000700', 'L', 'Hindu', 0, 0, 0, '-', 3),
(57, '7000003006', '900000000003006', 'Ni Made Eka 0306', 'Badung', '2010-04-16', 'Jalan Pendidikan No. 6, Denpasar, Bali', '081303000600', 'P', 'Islam', 0, 0, 0, '-', 3),
(58, '7000003005', '900000000003005', 'I Komang Dimas 0305', 'Denpasar', '2010-03-30', 'Jalan Pendidikan No. 5, Denpasar, Bali', '081303000500', 'L', 'Konghucu', 0, 0, 0, '-', 3),
(59, '7000003004', '900000000003004', 'Ni Kadek Citra 0304', 'Bangli', '2010-03-13', 'Jalan Pendidikan No. 4, Denpasar, Bali', '081303000400', 'P', 'Buddha', 0, 0, 0, '-', 3),
(60, '7000003003', '900000000003003', 'I Putu Bagus 0303', 'Tabanan', '2010-02-24', 'Jalan Pendidikan No. 3, Denpasar, Bali', '081303000300', 'L', 'Katolik', 0, 0, 0, '-', 3),
(61, '7000003002', '900000000003002', 'Ni Luh Ayu 0302', 'Gianyar', '2010-02-07', 'Jalan Pendidikan No. 2, Denpasar, Bali', '081303000200', 'P', 'Kristen', 0, 0, 0, '-', 3),
(62, '7000003001', '900000000003001', 'I Made Aditya 0301', 'Badung', '2010-01-21', 'Jalan Pendidikan No. 1, Denpasar, Bali', '081303000100', 'L', 'Hindu', 0, 0, 0, '-', 3),
(63, '7000004020', '900000000004020', 'Ni Komang Zahra 0420', 'Denpasar', '2010-01-15', 'Jalan Pendidikan No. 20, Denpasar, Bali', '081304002000', 'P', 'Kristen', 0, 0, 0, '-', 4),
(64, '7000004019', '900000000004019', 'I Kadek Yoga 0419', 'Bangli', '2010-11-24', 'Jalan Pendidikan No. 19, Denpasar, Bali', '081304001900', 'L', 'Hindu', 0, 0, 0, '-', 4),
(65, '7000004018', '900000000004018', 'Ni Putu Sari 0418', 'Tabanan', '2010-11-07', 'Jalan Pendidikan No. 18, Denpasar, Bali', '081304001800', 'P', 'Islam', 0, 0, 0, '-', 4),
(66, '7000004017', '900000000004017', 'I Wayan Rama 0417', 'Gianyar', '2010-10-21', 'Jalan Pendidikan No. 17, Denpasar, Bali', '081304001700', 'L', 'Konghucu', 0, 0, 0, '-', 4),
(67, '7000004016', '900000000004016', 'Ni Made Puspita 0416', 'Badung', '2010-10-04', 'Jalan Pendidikan No. 16, Denpasar, Bali', '081304001600', 'P', 'Buddha', 0, 0, 0, '-', 4),
(68, '7000004015', '900000000004015', 'I Komang Oka 0415', 'Denpasar', '2010-09-17', 'Jalan Pendidikan No. 15, Denpasar, Bali', '081304001500', 'L', 'Katolik', 0, 0, 0, '-', 4),
(69, '7000004014', '900000000004014', 'Ni Kadek Nadia 0414', 'Bangli', '2010-08-31', 'Jalan Pendidikan No. 14, Denpasar, Bali', '081304001400', 'P', 'Kristen', 0, 0, 0, '-', 4),
(70, '7000004013', '900000000004013', 'I Putu Mahendra 0413', 'Tabanan', '2010-08-14', 'Jalan Pendidikan No. 13, Denpasar, Bali', '081304001300', 'L', 'Hindu', 0, 0, 0, '-', 4),
(71, '7000004012', '900000000004012', 'Ni Wayan Kartika 0412', 'Gianyar', '2010-07-28', 'Jalan Pendidikan No. 12, Denpasar, Bali', '081304001200', 'P', 'Islam', 0, 0, 0, '-', 4),
(72, '7000004011', '900000000004011', 'I Made Jaya 0411', 'Badung', '2010-07-11', 'Jalan Pendidikan No. 11, Denpasar, Bali', '081304001100', 'L', 'Konghucu', 0, 0, 0, '-', 4),
(73, '7000004010', '900000000004010', 'Ni Komang Indah 0410', 'Denpasar', '2010-06-24', 'Jalan Pendidikan No. 10, Denpasar, Bali', '081304001000', 'P', 'Buddha', 0, 0, 0, '-', 4),
(74, '7000004009', '900000000004009', 'I Kadek Hendra 0409', 'Bangli', '2010-06-07', 'Jalan Pendidikan No. 9, Denpasar, Bali', '081304000900', 'L', 'Katolik', 0, 0, 0, '-', 4),
(75, '7000004008', '900000000004008', 'Ni Putu Gita 0408', 'Tabanan', '2010-05-21', 'Jalan Pendidikan No. 8, Denpasar, Bali', '081304000800', 'P', 'Kristen', 0, 0, 0, '-', 4),
(76, '7000004007', '900000000004007', 'I Wayan Fajar 0407', 'Gianyar', '2010-05-04', 'Jalan Pendidikan No. 7, Denpasar, Bali', '081304000700', 'L', 'Hindu', 0, 0, 0, '-', 4),
(77, '7000004006', '900000000004006', 'Ni Made Eka 0406', 'Badung', '2010-04-17', 'Jalan Pendidikan No. 6, Denpasar, Bali', '081304000600', 'P', 'Islam', 0, 0, 0, '-', 4),
(78, '7000004005', '900000000004005', 'I Komang Dimas 0405', 'Denpasar', '2010-03-31', 'Jalan Pendidikan No. 5, Denpasar, Bali', '081304000500', 'L', 'Konghucu', 0, 0, 0, '-', 4),
(79, '7000004004', '900000000004004', 'Ni Kadek Citra 0404', 'Bangli', '2010-03-14', 'Jalan Pendidikan No. 4, Denpasar, Bali', '081304000400', 'P', 'Buddha', 0, 0, 0, '-', 4),
(80, '7000004003', '900000000004003', 'I Putu Bagus 0403', 'Tabanan', '2010-02-25', 'Jalan Pendidikan No. 3, Denpasar, Bali', '081304000300', 'L', 'Katolik', 0, 0, 0, '-', 4),
(81, '7000004002', '900000000004002', 'Ni Luh Ayu 0402', 'Gianyar', '2010-02-08', 'Jalan Pendidikan No. 2, Denpasar, Bali', '081304000200', 'P', 'Kristen', 0, 0, 0, '-', 4),
(82, '7000004001', '900000000004001', 'I Made Aditya 0401', 'Badung', '2010-01-22', 'Jalan Pendidikan No. 1, Denpasar, Bali', '081304000100', 'L', 'Hindu', 0, 0, 0, '-', 4),
(83, '7000005020', '900000000005020', 'Ni Komang Zahra 0520', 'Denpasar', '2009-01-16', 'Jalan Pendidikan No. 20, Denpasar, Bali', '081305002000', 'P', 'Kristen', 0, 0, 0, '-', 5),
(84, '7000005019', '900000000005019', 'I Kadek Yoga 0519', 'Bangli', '2009-11-25', 'Jalan Pendidikan No. 19, Denpasar, Bali', '081305001900', 'L', 'Hindu', 0, 0, 0, '-', 5),
(85, '7000005018', '900000000005018', 'Ni Putu Sari 0518', 'Tabanan', '2009-11-08', 'Jalan Pendidikan No. 18, Denpasar, Bali', '081305001800', 'P', 'Islam', 0, 0, 0, '-', 5),
(86, '7000005017', '900000000005017', 'I Wayan Rama 0517', 'Gianyar', '2009-10-22', 'Jalan Pendidikan No. 17, Denpasar, Bali', '081305001700', 'L', 'Konghucu', 0, 0, 0, '-', 5),
(87, '7000005016', '900000000005016', 'Ni Made Puspita 0516', 'Badung', '2009-10-05', 'Jalan Pendidikan No. 16, Denpasar, Bali', '081305001600', 'P', 'Buddha', 0, 0, 0, '-', 5),
(88, '7000005015', '900000000005015', 'I Komang Oka 0515', 'Denpasar', '2009-09-18', 'Jalan Pendidikan No. 15, Denpasar, Bali', '081305001500', 'L', 'Katolik', 0, 0, 0, '-', 5),
(89, '7000005014', '900000000005014', 'Ni Kadek Nadia 0514', 'Bangli', '2009-09-01', 'Jalan Pendidikan No. 14, Denpasar, Bali', '081305001400', 'P', 'Kristen', 0, 0, 0, '-', 5),
(90, '7000005013', '900000000005013', 'I Putu Mahendra 0513', 'Tabanan', '2009-08-15', 'Jalan Pendidikan No. 13, Denpasar, Bali', '081305001300', 'L', 'Hindu', 0, 0, 0, '-', 5),
(91, '7000005012', '900000000005012', 'Ni Wayan Kartika 0512', 'Gianyar', '2009-07-29', 'Jalan Pendidikan No. 12, Denpasar, Bali', '081305001200', 'P', 'Islam', 0, 0, 0, '-', 5),
(92, '7000005011', '900000000005011', 'I Made Jaya 0511', 'Badung', '2009-07-12', 'Jalan Pendidikan No. 11, Denpasar, Bali', '081305001100', 'L', 'Konghucu', 0, 0, 0, '-', 5),
(93, '7000005010', '900000000005010', 'Ni Komang Indah 0510', 'Denpasar', '2009-06-25', 'Jalan Pendidikan No. 10, Denpasar, Bali', '081305001000', 'P', 'Buddha', 0, 0, 0, '-', 5),
(94, '7000005009', '900000000005009', 'I Kadek Hendra 0509', 'Bangli', '2009-06-08', 'Jalan Pendidikan No. 9, Denpasar, Bali', '081305000900', 'L', 'Katolik', 0, 0, 0, '-', 5),
(95, '7000005008', '900000000005008', 'Ni Putu Gita 0508', 'Tabanan', '2009-05-22', 'Jalan Pendidikan No. 8, Denpasar, Bali', '081305000800', 'P', 'Kristen', 0, 0, 0, '-', 5),
(96, '7000005007', '900000000005007', 'I Wayan Fajar 0507', 'Gianyar', '2009-05-05', 'Jalan Pendidikan No. 7, Denpasar, Bali', '081305000700', 'L', 'Hindu', 0, 0, 0, '-', 5),
(97, '7000005006', '900000000005006', 'Ni Made Eka 0506', 'Badung', '2009-04-18', 'Jalan Pendidikan No. 6, Denpasar, Bali', '081305000600', 'P', 'Islam', 0, 0, 0, '-', 5),
(98, '7000005005', '900000000005005', 'I Komang Dimas 0505', 'Denpasar', '2009-04-01', 'Jalan Pendidikan No. 5, Denpasar, Bali', '081305000500', 'L', 'Konghucu', 0, 0, 0, '-', 5),
(99, '7000005004', '900000000005004', 'Ni Kadek Citra 0504', 'Bangli', '2009-03-15', 'Jalan Pendidikan No. 4, Denpasar, Bali', '081305000400', 'P', 'Buddha', 0, 0, 0, '-', 5),
(100, '7000005003', '900000000005003', 'I Putu Bagus 0503', 'Tabanan', '2009-02-26', 'Jalan Pendidikan No. 3, Denpasar, Bali', '081305000300', 'L', 'Katolik', 0, 0, 0, '-', 5),
(101, '7000005002', '900000000005002', 'Ni Luh Ayu 0502', 'Gianyar', '2009-02-09', 'Jalan Pendidikan No. 2, Denpasar, Bali', '081305000200', 'P', 'Kristen', 0, 0, 0, '-', 5),
(102, '7000005001', '900000000005001', 'I Made Aditya 0501', 'Badung', '2009-01-23', 'Jalan Pendidikan No. 1, Denpasar, Bali', '081305000100', 'L', 'Hindu', 0, 0, 0, '-', 5),
(103, '7000006020', '900000000006020', 'Ni Komang Zahra 0620', 'Denpasar', '2009-01-17', 'Jalan Pendidikan No. 20, Denpasar, Bali', '081306002000', 'P', 'Kristen', 0, 0, 0, '-', 6),
(104, '7000006019', '900000000006019', 'I Kadek Yoga 0619', 'Bangli', '2009-11-26', 'Jalan Pendidikan No. 19, Denpasar, Bali', '081306001900', 'L', 'Hindu', 0, 0, 0, '-', 6),
(105, '7000006018', '900000000006018', 'Ni Putu Sari 0618', 'Tabanan', '2009-11-09', 'Jalan Pendidikan No. 18, Denpasar, Bali', '081306001800', 'P', 'Islam', 0, 0, 0, '-', 6),
(106, '7000006017', '900000000006017', 'I Wayan Rama 0617', 'Gianyar', '2009-10-23', 'Jalan Pendidikan No. 17, Denpasar, Bali', '081306001700', 'L', 'Konghucu', 0, 0, 0, '-', 6),
(107, '7000006016', '900000000006016', 'Ni Made Puspita 0616', 'Badung', '2009-10-06', 'Jalan Pendidikan No. 16, Denpasar, Bali', '081306001600', 'P', 'Buddha', 0, 0, 0, '-', 6),
(108, '7000006015', '900000000006015', 'I Komang Oka 0615', 'Denpasar', '2009-09-19', 'Jalan Pendidikan No. 15, Denpasar, Bali', '081306001500', 'L', 'Katolik', 0, 0, 0, '-', 6),
(109, '7000006014', '900000000006014', 'Ni Kadek Nadia 0614', 'Bangli', '2009-09-02', 'Jalan Pendidikan No. 14, Denpasar, Bali', '081306001400', 'P', 'Kristen', 0, 0, 0, '-', 6),
(110, '7000006013', '900000000006013', 'I Putu Mahendra 0613', 'Tabanan', '2009-08-16', 'Jalan Pendidikan No. 13, Denpasar, Bali', '081306001300', 'L', 'Hindu', 0, 0, 0, '-', 6),
(111, '7000006012', '900000000006012', 'Ni Wayan Kartika 0612', 'Gianyar', '2009-07-30', 'Jalan Pendidikan No. 12, Denpasar, Bali', '081306001200', 'P', 'Islam', 0, 0, 0, '-', 6),
(112, '7000006011', '900000000006011', 'I Made Jaya 0611', 'Badung', '2009-07-13', 'Jalan Pendidikan No. 11, Denpasar, Bali', '081306001100', 'L', 'Konghucu', 0, 0, 0, '-', 6),
(113, '7000006010', '900000000006010', 'Ni Komang Indah 0610', 'Denpasar', '2009-06-26', 'Jalan Pendidikan No. 10, Denpasar, Bali', '081306001000', 'P', 'Buddha', 0, 0, 0, '-', 6),
(114, '7000006009', '900000000006009', 'I Kadek Hendra 0609', 'Bangli', '2009-06-09', 'Jalan Pendidikan No. 9, Denpasar, Bali', '081306000900', 'L', 'Katolik', 0, 0, 0, '-', 6),
(115, '7000006008', '900000000006008', 'Ni Putu Gita 0608', 'Tabanan', '2009-05-23', 'Jalan Pendidikan No. 8, Denpasar, Bali', '081306000800', 'P', 'Kristen', 0, 0, 0, '-', 6),
(116, '7000006007', '900000000006007', 'I Wayan Fajar 0607', 'Gianyar', '2009-05-06', 'Jalan Pendidikan No. 7, Denpasar, Bali', '081306000700', 'L', 'Hindu', 0, 0, 0, '-', 6),
(117, '7000006006', '900000000006006', 'Ni Made Eka 0606', 'Badung', '2009-04-19', 'Jalan Pendidikan No. 6, Denpasar, Bali', '081306000600', 'P', 'Islam', 0, 0, 0, '-', 6),
(118, '7000006005', '900000000006005', 'I Komang Dimas 0605', 'Denpasar', '2009-04-02', 'Jalan Pendidikan No. 5, Denpasar, Bali', '081306000500', 'L', 'Konghucu', 0, 0, 0, '-', 6),
(119, '7000006004', '900000000006004', 'Ni Kadek Citra 0604', 'Bangli', '2009-03-16', 'Jalan Pendidikan No. 4, Denpasar, Bali', '081306000400', 'P', 'Buddha', 0, 0, 0, '-', 6),
(120, '7000006003', '900000000006003', 'I Putu Bagus 0603', 'Tabanan', '2009-02-27', 'Jalan Pendidikan No. 3, Denpasar, Bali', '081306000300', 'L', 'Katolik', 0, 0, 0, '-', 6),
(121, '7000006002', '900000000006002', 'Ni Luh Ayu 0602', 'Gianyar', '2009-02-10', 'Jalan Pendidikan No. 2, Denpasar, Bali', '081306000200', 'P', 'Kristen', 0, 0, 0, '-', 6),
(122, '7000006001', '900000000006001', 'I Made Aditya 0601', 'Badung', '2009-01-24', 'Jalan Pendidikan No. 1, Denpasar, Bali', '081306000100', 'L', 'Hindu', 0, 0, 0, '-', 6),
(123, '7000007020', '900000000007020', 'Ni Komang Zahra 0720', 'Denpasar', '2009-01-18', 'Jalan Pendidikan No. 20, Denpasar, Bali', '081307002000', 'P', 'Kristen', 0, 0, 0, '-', 7),
(124, '7000007019', '900000000007019', 'I Kadek Yoga 0719', 'Bangli', '2009-01-01', 'Jalan Pendidikan No. 19, Denpasar, Bali', '081307001900', 'L', 'Hindu', 0, 0, 0, '-', 7),
(125, '7000007018', '900000000007018', 'Ni Putu Sari 0718', 'Tabanan', '2009-11-10', 'Jalan Pendidikan No. 18, Denpasar, Bali', '081307001800', 'P', 'Islam', 0, 0, 0, '-', 7),
(126, '7000007017', '900000000007017', 'I Wayan Rama 0717', 'Gianyar', '2009-10-24', 'Jalan Pendidikan No. 17, Denpasar, Bali', '081307001700', 'L', 'Konghucu', 0, 0, 0, '-', 7),
(127, '7000007016', '900000000007016', 'Ni Made Puspita 0716', 'Badung', '2009-10-07', 'Jalan Pendidikan No. 16, Denpasar, Bali', '081307001600', 'P', 'Buddha', 0, 0, 0, '-', 7),
(128, '7000007015', '900000000007015', 'I Komang Oka 0715', 'Denpasar', '2009-09-20', 'Jalan Pendidikan No. 15, Denpasar, Bali', '081307001500', 'L', 'Katolik', 0, 0, 0, '-', 7),
(129, '7000007014', '900000000007014', 'Ni Kadek Nadia 0714', 'Bangli', '2009-09-03', 'Jalan Pendidikan No. 14, Denpasar, Bali', '081307001400', 'P', 'Kristen', 0, 0, 0, '-', 7),
(130, '7000007013', '900000000007013', 'I Putu Mahendra 0713', 'Tabanan', '2009-08-17', 'Jalan Pendidikan No. 13, Denpasar, Bali', '081307001300', 'L', 'Hindu', 0, 0, 0, '-', 7),
(131, '7000007012', '900000000007012', 'Ni Wayan Kartika 0712', 'Gianyar', '2009-07-31', 'Jalan Pendidikan No. 12, Denpasar, Bali', '081307001200', 'P', 'Islam', 0, 0, 0, '-', 7),
(132, '7000007011', '900000000007011', 'I Made Jaya 0711', 'Badung', '2009-07-14', 'Jalan Pendidikan No. 11, Denpasar, Bali', '081307001100', 'L', 'Konghucu', 0, 0, 0, '-', 7),
(133, '7000007010', '900000000007010', 'Ni Komang Indah 0710', 'Denpasar', '2009-06-27', 'Jalan Pendidikan No. 10, Denpasar, Bali', '081307001000', 'P', 'Buddha', 0, 0, 0, '-', 7),
(134, '7000007009', '900000000007009', 'I Kadek Hendra 0709', 'Bangli', '2009-06-10', 'Jalan Pendidikan No. 9, Denpasar, Bali', '081307000900', 'L', 'Katolik', 0, 0, 0, '-', 7),
(135, '7000007008', '900000000007008', 'Ni Putu Gita 0708', 'Tabanan', '2009-05-24', 'Jalan Pendidikan No. 8, Denpasar, Bali', '081307000800', 'P', 'Kristen', 0, 0, 0, '-', 7),
(136, '7000007007', '900000000007007', 'I Wayan Fajar 0707', 'Gianyar', '2009-05-07', 'Jalan Pendidikan No. 7, Denpasar, Bali', '081307000700', 'L', 'Hindu', 0, 0, 0, '-', 7),
(137, '7000007006', '900000000007006', 'Ni Made Eka 0706', 'Badung', '2009-04-20', 'Jalan Pendidikan No. 6, Denpasar, Bali', '081307000600', 'P', 'Islam', 0, 0, 0, '-', 7),
(138, '7000007005', '900000000007005', 'I Komang Dimas 0705', 'Denpasar', '2009-04-03', 'Jalan Pendidikan No. 5, Denpasar, Bali', '081307000500', 'L', 'Konghucu', 0, 0, 0, '-', 7),
(139, '7000007004', '900000000007004', 'Ni Kadek Citra 0704', 'Bangli', '2009-03-17', 'Jalan Pendidikan No. 4, Denpasar, Bali', '081307000400', 'P', 'Buddha', 0, 0, 0, '-', 7),
(140, '7000007003', '900000000007003', 'I Putu Bagus 0703', 'Tabanan', '2009-02-28', 'Jalan Pendidikan No. 3, Denpasar, Bali', '081307000300', 'L', 'Katolik', 0, 0, 0, '-', 7),
(141, '7000007002', '900000000007002', 'Ni Luh Ayu 0702', 'Gianyar', '2009-02-11', 'Jalan Pendidikan No. 2, Denpasar, Bali', '081307000200', 'P', 'Kristen', 0, 0, 0, '-', 7),
(142, '7000007001', '900000000007001', 'I Made Aditya 0701', 'Badung', '2009-01-25', 'Jalan Pendidikan No. 1, Denpasar, Bali', '081307000100', 'L', 'Hindu', 0, 0, 0, '-', 7),
(143, '7000008020', '900000000008020', 'Ni Komang Zahra 0820', 'Denpasar', '2009-01-19', 'Jalan Pendidikan No. 20, Denpasar, Bali', '081308002000', 'P', 'Kristen', 0, 0, 0, '-', 8),
(144, '7000008019', '900000000008019', 'I Kadek Yoga 0819', 'Bangli', '2009-01-02', 'Jalan Pendidikan No. 19, Denpasar, Bali', '081308001900', 'L', 'Hindu', 0, 0, 0, '-', 8),
(145, '7000008018', '900000000008018', 'Ni Putu Sari 0818', 'Tabanan', '2009-11-11', 'Jalan Pendidikan No. 18, Denpasar, Bali', '081308001800', 'P', 'Islam', 0, 0, 0, '-', 8),
(146, '7000008017', '900000000008017', 'I Wayan Rama 0817', 'Gianyar', '2009-10-25', 'Jalan Pendidikan No. 17, Denpasar, Bali', '081308001700', 'L', 'Konghucu', 0, 0, 0, '-', 8),
(147, '7000008016', '900000000008016', 'Ni Made Puspita 0816', 'Badung', '2009-10-08', 'Jalan Pendidikan No. 16, Denpasar, Bali', '081308001600', 'P', 'Buddha', 0, 0, 0, '-', 8),
(148, '7000008015', '900000000008015', 'I Komang Oka 0815', 'Denpasar', '2009-09-21', 'Jalan Pendidikan No. 15, Denpasar, Bali', '081308001500', 'L', 'Katolik', 0, 0, 0, '-', 8),
(149, '7000008014', '900000000008014', 'Ni Kadek Nadia 0814', 'Bangli', '2009-09-04', 'Jalan Pendidikan No. 14, Denpasar, Bali', '081308001400', 'P', 'Kristen', 0, 0, 0, '-', 8),
(150, '7000008013', '900000000008013', 'I Putu Mahendra 0813', 'Tabanan', '2009-08-18', 'Jalan Pendidikan No. 13, Denpasar, Bali', '081308001300', 'L', 'Hindu', 0, 0, 0, '-', 8),
(151, '7000008012', '900000000008012', 'Ni Wayan Kartika 0812', 'Gianyar', '2009-08-01', 'Jalan Pendidikan No. 12, Denpasar, Bali', '081308001200', 'P', 'Islam', 0, 0, 0, '-', 8),
(152, '7000008011', '900000000008011', 'I Made Jaya 0811', 'Badung', '2009-07-15', 'Jalan Pendidikan No. 11, Denpasar, Bali', '081308001100', 'L', 'Konghucu', 0, 0, 0, '-', 8),
(153, '7000008010', '900000000008010', 'Ni Komang Indah 0810', 'Denpasar', '2009-06-28', 'Jalan Pendidikan No. 10, Denpasar, Bali', '081308001000', 'P', 'Buddha', 0, 0, 0, '-', 8),
(154, '7000008009', '900000000008009', 'I Kadek Hendra 0809', 'Bangli', '2009-06-11', 'Jalan Pendidikan No. 9, Denpasar, Bali', '081308000900', 'L', 'Katolik', 0, 0, 0, '-', 8),
(155, '7000008008', '900000000008008', 'Ni Putu Gita 0808', 'Tabanan', '2009-05-25', 'Jalan Pendidikan No. 8, Denpasar, Bali', '081308000800', 'P', 'Kristen', 0, 0, 0, '-', 8),
(156, '7000008007', '900000000008007', 'I Wayan Fajar 0807', 'Gianyar', '2009-05-08', 'Jalan Pendidikan No. 7, Denpasar, Bali', '081308000700', 'L', 'Hindu', 0, 0, 0, '-', 8),
(157, '7000008006', '900000000008006', 'Ni Made Eka 0806', 'Badung', '2009-04-21', 'Jalan Pendidikan No. 6, Denpasar, Bali', '081308000600', 'P', 'Islam', 0, 0, 0, '-', 8),
(158, '7000008005', '900000000008005', 'I Komang Dimas 0805', 'Denpasar', '2009-04-04', 'Jalan Pendidikan No. 5, Denpasar, Bali', '081308000500', 'L', 'Konghucu', 0, 0, 0, '-', 8),
(159, '7000008004', '900000000008004', 'Ni Kadek Citra 0804', 'Bangli', '2009-03-18', 'Jalan Pendidikan No. 4, Denpasar, Bali', '081308000400', 'P', 'Buddha', 0, 0, 0, '-', 8),
(160, '7000008003', '900000000008003', 'I Putu Bagus 0803', 'Tabanan', '2009-03-01', 'Jalan Pendidikan No. 3, Denpasar, Bali', '081308000300', 'L', 'Katolik', 0, 0, 0, '-', 8),
(161, '7000008002', '900000000008002', 'Ni Luh Ayu 0802', 'Gianyar', '2009-02-12', 'Jalan Pendidikan No. 2, Denpasar, Bali', '081308000200', 'P', 'Kristen', 0, 0, 0, '-', 8),
(162, '7000008001', '900000000008001', 'I Made Aditya 0801', 'Badung', '2009-01-26', 'Jalan Pendidikan No. 1, Denpasar, Bali', '081308000100', 'L', 'Hindu', 0, 0, 0, '-', 8),
(163, '7000009020', '900000000009020', 'Ni Komang Zahra 0920', 'Denpasar', '2008-01-20', 'Jalan Pendidikan No. 20, Denpasar, Bali', '081309002000', 'P', 'Kristen', 0, 0, 0, '-', 9),
(164, '7000009019', '900000000009019', 'I Kadek Yoga 0919', 'Bangli', '2008-01-03', 'Jalan Pendidikan No. 19, Denpasar, Bali', '081309001900', 'L', 'Hindu', 0, 0, 0, '-', 9),
(165, '7000009018', '900000000009018', 'Ni Putu Sari 0918', 'Tabanan', '2008-11-11', 'Jalan Pendidikan No. 18, Denpasar, Bali', '081309001800', 'P', 'Islam', 0, 0, 0, '-', 9),
(166, '7000009017', '900000000009017', 'I Wayan Rama 0917', 'Gianyar', '2008-10-25', 'Jalan Pendidikan No. 17, Denpasar, Bali', '081309001700', 'L', 'Konghucu', 0, 0, 0, '-', 9),
(167, '7000009016', '900000000009016', 'Ni Made Puspita 0916', 'Badung', '2008-10-08', 'Jalan Pendidikan No. 16, Denpasar, Bali', '081309001600', 'P', 'Buddha', 0, 0, 0, '-', 9),
(168, '7000009015', '900000000009015', 'I Komang Oka 0915', 'Denpasar', '2008-09-21', 'Jalan Pendidikan No. 15, Denpasar, Bali', '081309001500', 'L', 'Katolik', 0, 0, 0, '-', 9),
(169, '7000009014', '900000000009014', 'Ni Kadek Nadia 0914', 'Bangli', '2008-09-04', 'Jalan Pendidikan No. 14, Denpasar, Bali', '081309001400', 'P', 'Kristen', 0, 0, 0, '-', 9),
(170, '7000009013', '900000000009013', 'I Putu Mahendra 0913', 'Tabanan', '2008-08-18', 'Jalan Pendidikan No. 13, Denpasar, Bali', '081309001300', 'L', 'Hindu', 0, 0, 0, '-', 9),
(171, '7000009012', '900000000009012', 'Ni Wayan Kartika 0912', 'Gianyar', '2008-08-01', 'Jalan Pendidikan No. 12, Denpasar, Bali', '081309001200', 'P', 'Islam', 0, 0, 0, '-', 9),
(172, '7000009011', '900000000009011', 'I Made Jaya 0911', 'Badung', '2008-07-15', 'Jalan Pendidikan No. 11, Denpasar, Bali', '081309001100', 'L', 'Konghucu', 0, 0, 0, '-', 9),
(173, '7000009010', '900000000009010', 'Ni Komang Indah 0910', 'Denpasar', '2008-06-28', 'Jalan Pendidikan No. 10, Denpasar, Bali', '081309001000', 'P', 'Buddha', 0, 0, 0, '-', 9),
(174, '7000009009', '900000000009009', 'I Kadek Hendra 0909', 'Bangli', '2008-06-11', 'Jalan Pendidikan No. 9, Denpasar, Bali', '081309000900', 'L', 'Katolik', 0, 0, 0, '-', 9),
(175, '7000009008', '900000000009008', 'Ni Putu Gita 0908', 'Tabanan', '2008-05-25', 'Jalan Pendidikan No. 8, Denpasar, Bali', '081309000800', 'P', 'Kristen', 0, 0, 0, '-', 9),
(176, '7000009007', '900000000009007', 'I Wayan Fajar 0907', 'Gianyar', '2008-05-08', 'Jalan Pendidikan No. 7, Denpasar, Bali', '081309000700', 'L', 'Hindu', 0, 0, 0, '-', 9),
(177, '7000009006', '900000000009006', 'Ni Made Eka 0906', 'Badung', '2008-04-21', 'Jalan Pendidikan No. 6, Denpasar, Bali', '081309000600', 'P', 'Islam', 0, 0, 0, '-', 9),
(178, '7000009005', '900000000009005', 'I Komang Dimas 0905', 'Denpasar', '2008-04-04', 'Jalan Pendidikan No. 5, Denpasar, Bali', '081309000500', 'L', 'Konghucu', 0, 0, 0, '-', 9),
(179, '7000009004', '900000000009004', 'Ni Kadek Citra 0904', 'Bangli', '2008-03-18', 'Jalan Pendidikan No. 4, Denpasar, Bali', '081309000400', 'P', 'Buddha', 0, 0, 0, '-', 9),
(180, '7000009003', '900000000009003', 'I Putu Bagus 0903', 'Tabanan', '2008-03-01', 'Jalan Pendidikan No. 3, Denpasar, Bali', '081309000300', 'L', 'Katolik', 0, 0, 0, '-', 9),
(181, '7000009002', '900000000009002', 'Ni Luh Ayu 0902', 'Gianyar', '2008-02-13', 'Jalan Pendidikan No. 2, Denpasar, Bali', '081309000200', 'P', 'Kristen', 0, 0, 0, '-', 9),
(182, '7000009001', '900000000009001', 'I Made Aditya 0901', 'Badung', '2008-01-27', 'Jalan Pendidikan No. 1, Denpasar, Bali', '081309000100', 'L', 'Hindu', 0, 0, 0, '-', 9),
(183, '7000010020', '900000000010020', 'Ni Komang Zahra 1020', 'Denpasar', '2008-01-21', 'Jalan Pendidikan No. 20, Denpasar, Bali', '081310002000', 'P', 'Kristen', 0, 0, 0, '-', 10),
(184, '7000010019', '900000000010019', 'I Kadek Yoga 1019', 'Bangli', '2008-01-04', 'Jalan Pendidikan No. 19, Denpasar, Bali', '081310001900', 'L', 'Hindu', 0, 0, 0, '-', 10),
(185, '7000010018', '900000000010018', 'Ni Putu Sari 1018', 'Tabanan', '2008-11-12', 'Jalan Pendidikan No. 18, Denpasar, Bali', '081310001800', 'P', 'Islam', 0, 0, 0, '-', 10),
(186, '7000010017', '900000000010017', 'I Wayan Rama 1017', 'Gianyar', '2008-10-26', 'Jalan Pendidikan No. 17, Denpasar, Bali', '081310001700', 'L', 'Konghucu', 0, 0, 0, '-', 10),
(187, '7000010016', '900000000010016', 'Ni Made Puspita 1016', 'Badung', '2008-10-09', 'Jalan Pendidikan No. 16, Denpasar, Bali', '081310001600', 'P', 'Buddha', 0, 0, 0, '-', 10),
(188, '7000010015', '900000000010015', 'I Komang Oka 1015', 'Denpasar', '2008-09-22', 'Jalan Pendidikan No. 15, Denpasar, Bali', '081310001500', 'L', 'Katolik', 0, 0, 0, '-', 10),
(189, '7000010014', '900000000010014', 'Ni Kadek Nadia 1014', 'Bangli', '2008-09-05', 'Jalan Pendidikan No. 14, Denpasar, Bali', '081310001400', 'P', 'Kristen', 0, 0, 0, '-', 10),
(190, '7000010013', '900000000010013', 'I Putu Mahendra 1013', 'Tabanan', '2008-08-19', 'Jalan Pendidikan No. 13, Denpasar, Bali', '081310001300', 'L', 'Hindu', 0, 0, 0, '-', 10),
(191, '7000010012', '900000000010012', 'Ni Wayan Kartika 1012', 'Gianyar', '2008-08-02', 'Jalan Pendidikan No. 12, Denpasar, Bali', '081310001200', 'P', 'Islam', 0, 0, 0, '-', 10),
(192, '7000010011', '900000000010011', 'I Made Jaya 1011', 'Badung', '2008-07-16', 'Jalan Pendidikan No. 11, Denpasar, Bali', '081310001100', 'L', 'Konghucu', 0, 0, 0, '-', 10),
(193, '7000010010', '900000000010010', 'Ni Komang Indah 1010', 'Denpasar', '2008-06-29', 'Jalan Pendidikan No. 10, Denpasar, Bali', '081310001000', 'P', 'Buddha', 0, 0, 0, '-', 10),
(194, '7000010009', '900000000010009', 'I Kadek Hendra 1009', 'Bangli', '2008-06-12', 'Jalan Pendidikan No. 9, Denpasar, Bali', '081310000900', 'L', 'Katolik', 0, 0, 0, '-', 10),
(195, '7000010008', '900000000010008', 'Ni Putu Gita 1008', 'Tabanan', '2008-05-26', 'Jalan Pendidikan No. 8, Denpasar, Bali', '081310000800', 'P', 'Kristen', 0, 0, 0, '-', 10),
(196, '7000010007', '900000000010007', 'I Wayan Fajar 1007', 'Gianyar', '2008-05-09', 'Jalan Pendidikan No. 7, Denpasar, Bali', '081310000700', 'L', 'Hindu', 0, 0, 0, '-', 10),
(197, '7000010006', '900000000010006', 'Ni Made Eka 1006', 'Badung', '2008-04-22', 'Jalan Pendidikan No. 6, Denpasar, Bali', '081310000600', 'P', 'Islam', 0, 0, 0, '-', 10),
(198, '7000010005', '900000000010005', 'I Komang Dimas 1005', 'Denpasar', '2008-04-05', 'Jalan Pendidikan No. 5, Denpasar, Bali', '081310000500', 'L', 'Konghucu', 0, 0, 0, '-', 10),
(199, '7000010004', '900000000010004', 'Ni Kadek Citra 1004', 'Bangli', '2008-03-19', 'Jalan Pendidikan No. 4, Denpasar, Bali', '081310000400', 'P', 'Buddha', 0, 0, 0, '-', 10),
(200, '7000010003', '900000000010003', 'I Putu Bagus 1003', 'Tabanan', '2008-03-02', 'Jalan Pendidikan No. 3, Denpasar, Bali', '081310000300', 'L', 'Katolik', 0, 0, 0, '-', 10),
(201, '7000010002', '900000000010002', 'Ni Luh Ayu 1002', 'Gianyar', '2008-02-14', 'Jalan Pendidikan No. 2, Denpasar, Bali', '081310000200', 'P', 'Kristen', 0, 0, 0, '-', 10),
(202, '7000010001', '900000000010001', 'I Made Aditya 1001', 'Badung', '2008-01-28', 'Jalan Pendidikan No. 1, Denpasar, Bali', '081310000100', 'L', 'Hindu', 0, 0, 0, '-', 10),
(203, '7000011020', '900000000011020', 'Ni Komang Zahra 1120', 'Denpasar', '2008-01-22', 'Jalan Pendidikan No. 20, Denpasar, Bali', '081311002000', 'P', 'Kristen', 0, 0, 0, '-', 11),
(204, '7000011019', '900000000011019', 'I Kadek Yoga 1119', 'Bangli', '2008-01-05', 'Jalan Pendidikan No. 19, Denpasar, Bali', '081311001900', 'L', 'Hindu', 0, 0, 0, '-', 11),
(205, '7000011018', '900000000011018', 'Ni Putu Sari 1118', 'Tabanan', '2008-11-13', 'Jalan Pendidikan No. 18, Denpasar, Bali', '081311001800', 'P', 'Islam', 0, 0, 0, '-', 11),
(206, '7000011017', '900000000011017', 'I Wayan Rama 1117', 'Gianyar', '2008-10-27', 'Jalan Pendidikan No. 17, Denpasar, Bali', '081311001700', 'L', 'Konghucu', 0, 0, 0, '-', 11),
(207, '7000011016', '900000000011016', 'Ni Made Puspita 1116', 'Badung', '2008-10-10', 'Jalan Pendidikan No. 16, Denpasar, Bali', '081311001600', 'P', 'Buddha', 0, 0, 0, '-', 11),
(208, '7000011015', '900000000011015', 'I Komang Oka 1115', 'Denpasar', '2008-09-23', 'Jalan Pendidikan No. 15, Denpasar, Bali', '081311001500', 'L', 'Katolik', 0, 0, 0, '-', 11),
(209, '7000011014', '900000000011014', 'Ni Kadek Nadia 1114', 'Bangli', '2008-09-06', 'Jalan Pendidikan No. 14, Denpasar, Bali', '081311001400', 'P', 'Kristen', 0, 0, 0, '-', 11),
(210, '7000011013', '900000000011013', 'I Putu Mahendra 1113', 'Tabanan', '2008-08-20', 'Jalan Pendidikan No. 13, Denpasar, Bali', '081311001300', 'L', 'Hindu', 0, 0, 0, '-', 11),
(211, '7000011012', '900000000011012', 'Ni Wayan Kartika 1112', 'Gianyar', '2008-08-03', 'Jalan Pendidikan No. 12, Denpasar, Bali', '081311001200', 'P', 'Islam', 0, 0, 0, '-', 11),
(212, '7000011011', '900000000011011', 'I Made Jaya 1111', 'Badung', '2008-07-17', 'Jalan Pendidikan No. 11, Denpasar, Bali', '081311001100', 'L', 'Konghucu', 0, 0, 0, '-', 11),
(213, '7000011010', '900000000011010', 'Ni Komang Indah 1110', 'Denpasar', '2008-06-30', 'Jalan Pendidikan No. 10, Denpasar, Bali', '081311001000', 'P', 'Buddha', 0, 0, 0, '-', 11),
(214, '7000011009', '900000000011009', 'I Kadek Hendra 1109', 'Bangli', '2008-06-13', 'Jalan Pendidikan No. 9, Denpasar, Bali', '081311000900', 'L', 'Katolik', 0, 0, 0, '-', 11),
(215, '7000011008', '900000000011008', 'Ni Putu Gita 1108', 'Tabanan', '2008-05-27', 'Jalan Pendidikan No. 8, Denpasar, Bali', '081311000800', 'P', 'Kristen', 0, 0, 0, '-', 11),
(216, '7000011007', '900000000011007', 'I Wayan Fajar 1107', 'Gianyar', '2008-05-10', 'Jalan Pendidikan No. 7, Denpasar, Bali', '081311000700', 'L', 'Hindu', 0, 0, 0, '-', 11),
(217, '7000011006', '900000000011006', 'Ni Made Eka 1106', 'Badung', '2008-04-23', 'Jalan Pendidikan No. 6, Denpasar, Bali', '081311000600', 'P', 'Islam', 0, 0, 0, '-', 11),
(218, '7000011005', '900000000011005', 'I Komang Dimas 1105', 'Denpasar', '2008-04-06', 'Jalan Pendidikan No. 5, Denpasar, Bali', '081311000500', 'L', 'Konghucu', 0, 0, 0, '-', 11),
(219, '7000011004', '900000000011004', 'Ni Kadek Citra 1104', 'Bangli', '2008-03-20', 'Jalan Pendidikan No. 4, Denpasar, Bali', '081311000400', 'P', 'Buddha', 0, 0, 0, '-', 11),
(220, '7000011003', '900000000011003', 'I Putu Bagus 1103', 'Tabanan', '2008-03-03', 'Jalan Pendidikan No. 3, Denpasar, Bali', '081311000300', 'L', 'Katolik', 0, 0, 0, '-', 11),
(221, '7000011002', '900000000011002', 'Ni Luh Ayu 1102', 'Gianyar', '2008-02-15', 'Jalan Pendidikan No. 2, Denpasar, Bali', '081311000200', 'P', 'Kristen', 0, 0, 0, '-', 11),
(222, '7000011001', '900000000011001', 'I Made Aditya 1101', 'Badung', '2008-01-29', 'Jalan Pendidikan No. 1, Denpasar, Bali', '081311000100', 'L', 'Hindu', 0, 0, 0, '-', 11),
(223, '7000012020', '900000000012020', 'Ni Komang Zahra 1220', 'Denpasar', '2008-01-23', 'Jalan Pendidikan No. 20, Denpasar, Bali', '081312002000', 'P', 'Kristen', 0, 0, 0, '-', 12),
(224, '7000012019', '900000000012019', 'I Kadek Yoga 1219', 'Bangli', '2008-01-06', 'Jalan Pendidikan No. 19, Denpasar, Bali', '081312001900', 'L', 'Hindu', 0, 0, 0, '-', 12),
(225, '7000012018', '900000000012018', 'Ni Putu Sari 1218', 'Tabanan', '2008-11-14', 'Jalan Pendidikan No. 18, Denpasar, Bali', '081312001800', 'P', 'Islam', 0, 0, 0, '-', 12),
(226, '7000012017', '900000000012017', 'I Wayan Rama 1217', 'Gianyar', '2008-10-28', 'Jalan Pendidikan No. 17, Denpasar, Bali', '081312001700', 'L', 'Konghucu', 0, 0, 0, '-', 12),
(227, '7000012016', '900000000012016', 'Ni Made Puspita 1216', 'Badung', '2008-10-11', 'Jalan Pendidikan No. 16, Denpasar, Bali', '081312001600', 'P', 'Buddha', 0, 0, 0, '-', 12),
(228, '7000012015', '900000000012015', 'I Komang Oka 1215', 'Denpasar', '2008-09-24', 'Jalan Pendidikan No. 15, Denpasar, Bali', '081312001500', 'L', 'Katolik', 0, 0, 0, '-', 12),
(229, '7000012014', '900000000012014', 'Ni Kadek Nadia 1214', 'Bangli', '2008-09-07', 'Jalan Pendidikan No. 14, Denpasar, Bali', '081312001400', 'P', 'Kristen', 0, 0, 0, '-', 12),
(230, '7000012013', '900000000012013', 'I Putu Mahendra 1213', 'Tabanan', '2008-08-21', 'Jalan Pendidikan No. 13, Denpasar, Bali', '081312001300', 'L', 'Hindu', 0, 0, 0, '-', 12),
(231, '7000012012', '900000000012012', 'Ni Wayan Kartika 1212', 'Gianyar', '2008-08-04', 'Jalan Pendidikan No. 12, Denpasar, Bali', '081312001200', 'P', 'Islam', 0, 0, 0, '-', 12),
(232, '7000012011', '900000000012011', 'I Made Jaya 1211', 'Badung', '2008-07-18', 'Jalan Pendidikan No. 11, Denpasar, Bali', '081312001100', 'L', 'Konghucu', 0, 0, 0, '-', 12),
(233, '7000012010', '900000000012010', 'Ni Komang Indah 1210', 'Denpasar', '2008-07-01', 'Jalan Pendidikan No. 10, Denpasar, Bali', '081312001000', 'P', 'Buddha', 0, 0, 0, '-', 12),
(234, '7000012009', '900000000012009', 'I Kadek Hendra 1209', 'Bangli', '2008-06-14', 'Jalan Pendidikan No. 9, Denpasar, Bali', '081312000900', 'L', 'Katolik', 0, 0, 0, '-', 12),
(235, '7000012008', '900000000012008', 'Ni Putu Gita 1208', 'Tabanan', '2008-05-28', 'Jalan Pendidikan No. 8, Denpasar, Bali', '081312000800', 'P', 'Kristen', 0, 0, 0, '-', 12),
(236, '7000012007', '900000000012007', 'I Wayan Fajar 1207', 'Gianyar', '2008-05-11', 'Jalan Pendidikan No. 7, Denpasar, Bali', '081312000700', 'L', 'Hindu', 0, 0, 0, '-', 12),
(237, '7000012006', '900000000012006', 'Ni Made Eka 1206', 'Badung', '2008-04-24', 'Jalan Pendidikan No. 6, Denpasar, Bali', '081312000600', 'P', 'Islam', 0, 0, 0, '-', 12),
(238, '7000012005', '900000000012005', 'I Komang Dimas 1205', 'Denpasar', '2008-04-07', 'Jalan Pendidikan No. 5, Denpasar, Bali', '081312000500', 'L', 'Konghucu', 0, 0, 0, '-', 12),
(239, '7000012004', '900000000012004', 'Ni Kadek Citra 1204', 'Bangli', '2008-03-21', 'Jalan Pendidikan No. 4, Denpasar, Bali', '081312000400', 'P', 'Buddha', 0, 0, 0, '-', 12),
(240, '7000012003', '900000000012003', 'I Putu Bagus 1203', 'Tabanan', '2008-03-04', 'Jalan Pendidikan No. 3, Denpasar, Bali', '081312000300', 'L', 'Katolik', 0, 0, 0, '-', 12),
(241, '7000012002', '900000000012002', 'Ni Luh Ayu 1202', 'Gianyar', '2008-02-16', 'Jalan Pendidikan No. 2, Denpasar, Bali', '081312000200', 'P', 'Kristen', 0, 0, 0, '-', 12),
(242, '7000012001', '900000000012001', 'I Made Aditya 1201', 'Badung', '2008-01-30', 'Jalan Pendidikan No. 1, Denpasar, Bali', '081312000100', 'L', 'Hindu', 0, 0, 0, '-', 12);

-- --------------------------------------------------------

--
-- Table structure for table `tingkat`
--

CREATE TABLE `tingkat` (
  `id` int NOT NULL,
  `index_tingkat` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tingkat`
--

INSERT INTO `tingkat` (`id`, `index_tingkat`) VALUES
(1, 'X'),
(2, 'XI'),
(3, 'XII');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`) VALUES
(1, 'admin', '12345');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data_pelanggaran`
--
ALTER TABLE `data_pelanggaran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_prestasi`
--
ALTER TABLE `data_prestasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `detail_pelanggaran`
--
ALTER TABLE `detail_pelanggaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pelanggaran` (`id_pelanggaran`),
  ADD KEY `id_siswa_pelanggaran` (`id_siswa`);

--
-- Indexes for table `detail_prestasi`
--
ALTER TABLE `detail_prestasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_prestasi` (`id_prestasi`),
  ADD KEY `id_siswa_prestasi` (`id_siswa`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tingkat` (`id_tingkat`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_kelas` (`id_kelas`);

--
-- Indexes for table `tingkat`
--
ALTER TABLE `tingkat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `data_pelanggaran`
--
ALTER TABLE `data_pelanggaran`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `data_prestasi`
--
ALTER TABLE `data_prestasi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `detail_pelanggaran`
--
ALTER TABLE `detail_pelanggaran`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `detail_prestasi`
--
ALTER TABLE `detail_prestasi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=258;

--
-- AUTO_INCREMENT for table `tingkat`
--
ALTER TABLE `tingkat`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_pelanggaran`
--
ALTER TABLE `detail_pelanggaran`
  ADD CONSTRAINT `id_pelanggaran` FOREIGN KEY (`id_pelanggaran`) REFERENCES `data_pelanggaran` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `id_siswa_pelanggaran` FOREIGN KEY (`id_siswa`) REFERENCES `siswa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `detail_prestasi`
--
ALTER TABLE `detail_prestasi`
  ADD CONSTRAINT `id_prestasi` FOREIGN KEY (`id_prestasi`) REFERENCES `data_prestasi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `id_siswa_prestasi` FOREIGN KEY (`id_siswa`) REFERENCES `siswa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kelas`
--
ALTER TABLE `kelas`
  ADD CONSTRAINT `id_tingkat` FOREIGN KEY (`id_tingkat`) REFERENCES `tingkat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `siswa`
--
ALTER TABLE `siswa`
  ADD CONSTRAINT `id_kelas` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
