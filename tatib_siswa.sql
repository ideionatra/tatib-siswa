-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 23, 2026 at 11:20 AM
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

--
-- Dumping data for table `detail_pelanggaran`
--

INSERT INTO `detail_pelanggaran` (`id`, `id_siswa`, `id_pelanggaran`, `keterangan_pelanggaran`, `tanggal_pelanggaran`, `sanksi_pelanggaran`) VALUES
(1, 1, 7, 'Terpantau main dan membeli wild pass', '2026-06-10', 'Teguran dan penyitaan HP');

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

--
-- Dumping data for table `detail_prestasi`
--

INSERT INTO `detail_prestasi` (`id`, `id_siswa`, `id_prestasi`, `keterangan_prestasi`, `tanggal_prestasi`) VALUES
(1, 1, 7, 'Runner Up I Duta Genre Denpasar tahun 2026', '2026-06-10');

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
(1, '1214', '200623111011', 'I Made Dio Kartiana Putra', 'Denpasar', '2006-11-11', 'Jalan Kusuma Bangsa Gang II No.7, Kec. Pemecutan Kaja, Denpasar Utara, Kota Denpasar, Bali ', '085183361214', 'L', 'Hindu', 15, 35, -20, '-', 9);

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tingkat`
--
ALTER TABLE `tingkat`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
