-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 31, 2023 at 11:51 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `presensi`
--

-- --------------------------------------------------------

--
-- Table structure for table `jabatan`
--

CREATE TABLE `jabatan` (
  `id` int(11) NOT NULL,
  `nama_jabatan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `jabatan`
--

INSERT INTO `jabatan` (`id`, `nama_jabatan`) VALUES
(1, 'Kepala Sekolah'),
(2, 'Wakil Kepala Sekolah'),
(3, 'Pengajar'),
(4, 'Staff'),
(5, 'Honorer');

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id` int(11) NOT NULL,
  `nama_kelas` varchar(255) NOT NULL,
  `id_pegawai` int(11) NOT NULL,
  `jam_masuk` varchar(255) DEFAULT NULL,
  `jam_pulang` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`id`, `nama_kelas`, `id_pegawai`, `jam_masuk`, `jam_pulang`) VALUES
(1, 'Kelas 3', 2, '09:00', '12:59'),
(2, 'Kelas 4A', 3, '09:00', '12:59'),
(3, 'Kelas 4B', 4, '09:00', NULL),
(4, 'Kelas 5', 6, '09:00', ''),
(5, 'Kelas 6', 2, '09:00', '15:00');

-- --------------------------------------------------------

--
-- Table structure for table `laporan`
--

CREATE TABLE `laporan` (
  `id` int(11) NOT NULL,
  `id_siswa` int(11) NOT NULL,
  `waktu_masuk` datetime DEFAULT NULL,
  `waktu_pulang` datetime DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `laporan`
--

INSERT INTO `laporan` (`id`, `id_siswa`, `waktu_masuk`, `waktu_pulang`, `tanggal`, `status`, `keterangan`) VALUES
(2, 2, '2023-12-29 09:00:00', '2023-12-29 13:00:00', '2023-12-29', 'Hadir', ''),
(3, 3, '2023-12-29 09:00:00', '2023-12-29 13:00:00', '2023-12-29', 'Hadir', ''),
(4, 4, '2023-12-29 09:00:00', '2023-12-29 13:00:00', '2023-12-29', 'Hadir', ''),
(5, 5, '2023-12-29 09:00:00', '2023-12-29 13:00:00', '2023-12-29', 'Hadir', ''),
(38, 2, '2023-12-28 09:00:00', '2023-12-28 13:00:00', '2023-12-28', 'Hadir', 'Bagus'),
(41, 1, '2023-12-29 23:42:18', '0000-00-00 00:00:00', '2023-12-29', 'Hadir', 'oke hadir');

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `id` int(11) NOT NULL,
  `nip_pegawai` varchar(255) DEFAULT NULL,
  `nama_pegawai` varchar(255) DEFAULT NULL,
  `jabatan_id` int(11) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `no_handphone` varchar(20) DEFAULT NULL,
  `foto` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pegawai`
--

INSERT INTO `pegawai` (`id`, `nip_pegawai`, `nama_pegawai`, `jabatan_id`, `keterangan`, `no_handphone`, `foto`) VALUES
(1, '198407132005012007', 'Wahyuni Dianasari, SE, MM', 1, 'Kepsek', '6281293988001', '658ecbd62f8a7_1a3bb44987bace5278d897b683e405834b494323_full.jpg'),
(2, '198106022015022001', 'Tri Widyawati Setyawaiti, SE', 3, 'Wali Kelas 3', '6281293988002', NULL),
(3, '197511262990120089', 'Diana Faizati, S.pd', 3, 'Wali Kelas 4A', '6281293988003', NULL),
(4, '198106022015022041', 'Nindy S.Kom', 3, 'Wali Kelas 4B', '6281293988004', NULL),
(5, '1985030220090211001', 'Eko Budi Santoso, SE, S.Kom', 2, 'Wakasek', '6281293988005', NULL),
(6, '1968020319990322007', 'Sri Wahyuni, S.pd', 3, 'Wali Kelas 5', '6281293988006', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `id` int(11) NOT NULL,
  `nis` varchar(255) DEFAULT NULL,
  `nisn` varchar(255) DEFAULT NULL,
  `nama_lengkap` varchar(255) DEFAULT NULL,
  `id_kelas` int(11) NOT NULL,
  `kelas` varchar(255) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `nama_orang_tua` varchar(255) DEFAULT NULL,
  `no_handphone` varchar(255) DEFAULT NULL,
  `foto` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`id`, `nis`, `nisn`, `nama_lengkap`, `id_kelas`, `kelas`, `alamat`, `nama_orang_tua`, `no_handphone`, `foto`) VALUES
(1, '000000000001', '100000000001', 'Yudha', 4, 'Kelas 5', 'Jalan Kenangan Terindah No.1', 'Risky Purnawan', '02179187676', 'foto1.png'),
(2, '000000000002', '100000000002', 'Erik', 3, 'Kelas 4A', 'Jalan Kenangan Terindah No.2', 'Sopian', '02179187677', 'messi2.jpg'),
(3, '000000000003', '100000000003', 'Kurnia', 2, 'Kelas 4A', 'Jalan Kenangan Terindah No.3', 'Salsabila Kurnia', '02179187678', '658efbf92c1e8_Cristiano_Ronaldo_playing_for_Al_Nassr_FC_against_Persepolis,_September_2023_(cropped).jpg'),
(4, '000000000004', '100000000004', 'Rina', 1, 'Kelas 3', 'Jalan Kenangan Terindah No.4', 'Andre', '02179187679', '658efbbf0bea7_d9bd49180000bad089777beeaed259d2.jpg'),
(5, '000000000005', '100000000005', 'Reni', 4, 'Kelas 5', 'Jalan Kenangan Terindah No.5', 'Reni Sulistia', '02179187680', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `id_pegawai` int(11) NOT NULL,
  `role` varchar(255) NOT NULL,
  `foto` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `id_pegawai`, `role`, `foto`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin@gmail.com', 0, 'admin', '658ed12209706_6550de1595a71_09965-285991339-ph_eriri, sawamura spencer eriri, 1girl, blonde hair, blue eyes, school uniform, twintails, solo, fang, long hair, open mouth.png'),
(2, 'kepsek', 'e99a18c428cb38d5f260853678922e03', 'kepsek@gmail.com', 1, 'pegawai', 'default.jpg'),
(3, 'pengajar1', 'e99a18c428cb38d5f260853678922e03', 'pengajar1@gmail.com', 2, 'pegawai', 'avatar2.jpg'),
(4, 'pengajar2', 'e99a18c428cb38d5f260853678922e03', 'pengajar2@gmail.com', 3, 'pegawai', 'default.jpg'),
(5, 'pengajar3', 'e99a18c428cb38d5f260853678922e03', 'pengajar3@gmail.com', 4, 'pegawai', 'avatar1.jpg'),
(6, 'admin2', '21232f297a57a5a743894a0e4a801fc3', 'admin2@gmail.com', 0, 'admin', '658ecfc61ee1c_5d765cab7394cef6ef23e1edb1f61dad.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jabatan`
--
ALTER TABLE `jabatan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `laporan`
--
ALTER TABLE `laporan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `jabatan`
--
ALTER TABLE `jabatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `laporan`
--
ALTER TABLE `laporan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `pegawai`
--
ALTER TABLE `pegawai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
