-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 27, 2020 at 04:36 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bond`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit`
--

CREATE TABLE `audit` (
  `audit_id` int(11) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  `details` varchar(45) DEFAULT NULL,
  `machine_name` varchar(45) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `audit`
--

INSERT INTO `audit` (`audit_id`, `username`, `TS`, `details`, `machine_name`, `ip`) VALUES
(1, 'david06', '2020-07-23 00:00:00', 'bond', 'pc', '192.168.0.1'),
(3, 'david06', '0000-00-00 00:00:00', 'user logged in', 'DESKTOP-0HGIVFC', '192.168.0.107'),
(22, 'david06', '0000-00-00 00:00:00', 'user logged in', 'DESKTOP-0HGIVFC', '192.168.0.107'),
(23, 'david06', '0000-00-00 00:00:00', 'user logged in', 'DESKTOP-0HGIVFC', '192.168.0.107'),
(24, 'david06', '0000-00-00 00:00:00', 'user logged in', 'DESKTOP-0HGIVFC', '192.168.0.107'),
(25, 'david06', '0000-00-00 00:00:00', 'user logged in', 'DESKTOP-0HGIVFC', '192.168.0.107'),
(26, 'david06', '0000-00-00 00:00:00', 'bond', 'DESKTOP-0HGIVFC', '192.168.0.107'),
(27, 'david06', '0000-00-00 00:00:00', 'user logged in', 'DESKTOP-0HGIVFC', '192.168.0.107'),
(28, 'david06', '0000-00-00 00:00:00', 'bond', 'DESKTOP-0HGIVFC', '192.168.0.107'),
(30, 'david06', '0000-00-00 00:00:00', 'user logged in', 'DESKTOP-0HGIVFC', '192.168.0.107'),
(31, 'david06', '0000-00-00 00:00:00', 'user logged in', 'DESKTOP-0HGIVFC', '192.168.0.107'),
(32, 'david06', '0000-00-00 00:00:00', 'user logged in', 'DESKTOP-0HGIVFC', '192.168.0.107'),
(33, 'david06', '0000-00-00 00:00:00', 'user logged in', 'DESKTOP-0HGIVFC', '192.168.0.107'),
(34, 'david06', '0000-00-00 00:00:00', 'bond', 'DESKTOP-0HGIVFC', '192.168.0.107');

-- --------------------------------------------------------

--
-- Table structure for table `bond`
--

CREATE TABLE `bond` (
  `name` varchar(40) NOT NULL,
  `version` int(11) NOT NULL DEFAULT 1,
  `audit_id` int(11) DEFAULT NULL,
  `interest_rate` double DEFAULT NULL,
  `ccy` varchar(45) DEFAULT NULL,
  `principal` int(11) DEFAULT NULL,
  `day_counting_convention` varchar(45) DEFAULT 'ACT/365',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bond`
--

INSERT INTO `bond` (`name`, `version`, `audit_id`, `interest_rate`, `ccy`, `principal`, `day_counting_convention`, `start_date`, `end_date`) VALUES
('bond1', 3, 1, 1.8, 'eur', 1000, 'ACT/365', '2020-07-10', '2020-10-17'),
('bond2', 1, 1, 2, 'ron', 987, 'ACT/365', '2020-07-28', '2021-01-29'),
('test', 1, 26, 1, 'ron', 1000, 'ACT/365', '0000-00-00', '0000-00-00'),
('test2', 1, 26, 3, 'ron', 1000, 'ACT/365', '0000-00-00', '0000-00-00');

--
-- Triggers `bond`
--
DELIMITER $$
CREATE TRIGGER `insert_in_bond_hist` AFTER INSERT ON `bond` FOR EACH ROW insert into bond_hist (audit_id,bond_name,version,interest_rate,ccy,principal,day_counting_convention,start_date,end_date)

select audit_id,name,version,interest_rate,ccy,principal,day_counting_convention,start_date,end_date
FROM bond as b
WHERE b.name=new.name
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_in_bond_hist` AFTER UPDATE ON `bond` FOR EACH ROW insert into bond_hist (audit_id,bond_name,version,interest_rate,ccy,principal,day_counting_convention,start_date,end_date)

select audit_id,name,version,interest_rate,ccy,principal,day_counting_convention,start_date,end_date
FROM bond as b
where b.name=new.name
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_version_bond` BEFORE UPDATE ON `bond` FOR EACH ROW set new.version=old.version+1
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bond_hist`
--

CREATE TABLE `bond_hist` (
  `hist_id` int(11) NOT NULL,
  `audit_id` int(11) DEFAULT NULL,
  `bond_name` varchar(20) NOT NULL,
  `version` int(11) NOT NULL DEFAULT 1,
  `interest_rate` double DEFAULT NULL,
  `ccy` varchar(45) DEFAULT NULL,
  `principal` int(11) DEFAULT NULL,
  `day_counting_convention` varchar(45) DEFAULT 'ACT/365',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bond_hist`
--

INSERT INTO `bond_hist` (`hist_id`, `audit_id`, `bond_name`, `version`, `interest_rate`, `ccy`, `principal`, `day_counting_convention`, `start_date`, `end_date`) VALUES
(1, 1, 'bond1', 1, 1.8, 'eur', 1000, 'ACT/365', '2020-07-10', '2020-10-17'),
(6, 1, 'bond1', 2, 1.7, 'eur', 1000, 'ACT/365', '2020-07-10', '2020-10-17'),
(7, 1, 'bond1', 3, 1.8, 'eur', 1000, 'ACT/365', '2020-07-10', '2020-10-17'),
(8, 1, 'bond2', 1, 2, 'ron', 987, 'ACT/365', '2020-07-28', '2021-01-29'),
(11, 26, 'test', 1, 1, 'ron', 1000, 'ACT/365', '0000-00-00', '0000-00-00'),
(12, 26, 'test2', 1, 3, 'ron', 1000, 'ACT/365', '0000-00-00', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `fxr`
--

CREATE TABLE `fxr` (
  `name` varchar(20) NOT NULL,
  `version` double NOT NULL DEFAULT 1,
  `as_of_date` date NOT NULL,
  `ccy1` varchar(5) NOT NULL,
  `ccy2` varchar(5) NOT NULL,
  `term` varchar(11) NOT NULL DEFAULT 'SPOT',
  `rate` double NOT NULL,
  `audit_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `fxr`
--
DELIMITER $$
CREATE TRIGGER `insert_in_fxr_hist` AFTER INSERT ON `fxr` FOR EACH ROW insert into fxr_hist 
(name,version,as_of_date,ccy1,ccy2,term,rate)

SELECT name,version,as_of_date,ccy1,ccy2,term,rate

from fxr as f

where f.name=new.name
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_in_fxr_hist` AFTER UPDATE ON `fxr` FOR EACH ROW insert into fxr_hist 
(name,version,as_of_date,ccy1,ccy2,term,rate)

SELECT name,version,as_of_date,ccy1,ccy2,term,rate

from fxr as f

where f.name=new.name
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_version_fxr` BEFORE UPDATE ON `fxr` FOR EACH ROW set new.version=old.version+1
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `fxr_hist`
--

CREATE TABLE `fxr_hist` (
  `name` varchar(20) NOT NULL,
  `version` double NOT NULL DEFAULT 1,
  `as_of_date` date NOT NULL,
  `ccy1` varchar(5) NOT NULL,
  `ccy2` varchar(5) NOT NULL,
  `term` varchar(11) NOT NULL DEFAULT 'SPOT',
  `rate` double NOT NULL,
  `audit_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `interest_rate`
--

CREATE TABLE `interest_rate` (
  `name` varchar(45) NOT NULL,
  `version` int(11) NOT NULL DEFAULT 1,
  `as_of_date` date NOT NULL,
  `term` varchar(12) NOT NULL,
  `date` date NOT NULL,
  `audit_id` int(11) NOT NULL,
  `rate` double NOT NULL,
  `ccy` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `interest_rate`
--

INSERT INTO `interest_rate` (`name`, `version`, `as_of_date`, `term`, `date`, `audit_id`, `rate`, `ccy`) VALUES
('bcr', 1, '0000-00-00', '3y', '2020-11-20', 1, 1.3, 'ron'),
('ing', 2, '0000-00-00', '1y', '2021-07-23', 1, 1.5, 'ron');

--
-- Triggers `interest_rate`
--
DELIMITER $$
CREATE TRIGGER `insert_in_interest_hist` AFTER INSERT ON `interest_rate` FOR EACH ROW insert into interest_rate_hist(name,as_of_date,version,term,date,rate,ccy) 
   
   select name,as_of_date,version,term,date,rate,ccy
   from interest_rate as r
   where r.name=new.name AND
   		r.as_of_date=new.as_of_date AND
        r.term=new.term AND
        r.date=new.date
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_in_interest_hist` AFTER UPDATE ON `interest_rate` FOR EACH ROW insert into interest_rate_hist(name,as_of_date,version,term,date,rate,ccy) 
   
   select name,as_of_date,version,term,date,rate,ccy
   from interest_rate as r
   where r.name=new.name AND
   		r.as_of_date=new.as_of_date AND
        r.term=new.term AND
        r.date=new.date
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_version_interest` BEFORE UPDATE ON `interest_rate` FOR EACH ROW set new.version=old.version+1
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `interest_rate_hist`
--

CREATE TABLE `interest_rate_hist` (
  `interest_hist_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `version` int(11) NOT NULL,
  `as_of_date` date NOT NULL DEFAULT current_timestamp(),
  `term` varchar(12) NOT NULL,
  `date` date NOT NULL,
  `rate` double NOT NULL,
  `ccy` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `interest_rate_hist`
--

INSERT INTO `interest_rate_hist` (`interest_hist_id`, `name`, `version`, `as_of_date`, `term`, `date`, `rate`, `ccy`) VALUES
(4, 'ing', 1, '0000-00-00', '1y', '2021-07-23', 1.5, 'ron'),
(5, 'ing', 2, '0000-00-00', '1y', '2021-07-23', 1.5, 'ron'),
(7, 'bcr', 1, '0000-00-00', '3y', '2020-11-20', 1.3, 'ron');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `bond_name` varchar(11) NOT NULL,
  `ref_day` date NOT NULL,
  `coupon_day` date NOT NULL,
  `audit_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `username` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `version` double NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `email`, `first_name`, `last_name`, `password`, `version`) VALUES
('david06', 'suciudavid6@gmail.com', 'david', 'suciu', '12', 1);

--
-- Triggers `user`
--
DELIMITER $$
CREATE TRIGGER `insert_in_user_hist` AFTER INSERT ON `user` FOR EACH ROW insert into user_hist (username,first_name,last_name,email,password) 
	
    select user_id,first_name,last_name,email,password
  
    from user as u
    where u.username=new.username
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_in_user_hist` AFTER UPDATE ON `user` FOR EACH ROW insert into user_hist (username,first_name,last_name,email,password) 
	
    select user_id,first_name,last_name,email,password
  
    from user as u
    where u.username=new.username
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_version_user` BEFORE UPDATE ON `user` FOR EACH ROW set new.version=old.version+1
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_hist`
--

CREATE TABLE `user_hist` (
  `id_hist` bigint(20) NOT NULL,
  `version` double NOT NULL,
  `username` varchar(45) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(32) NOT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_hist`
--

INSERT INTO `user_hist` (`id_hist`, `version`, `username`, `email`, `password`, `first_name`, `last_name`) VALUES
(17, 1, 'david06', 'suciudavid6@gmail.com', '1234', 'david', 'suciu'),
(18, 2, 'david06', 'suciudavid6@gmail.com', '123', 'david', 'suciu'),
(19, 3, 'david06', 'suciudavid6@gmail.com', '12', 'david', 'suciu');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit`
--
ALTER TABLE `audit`
  ADD PRIMARY KEY (`audit_id`),
  ADD KEY `user_id_idx` (`username`);

--
-- Indexes for table `bond`
--
ALTER TABLE `bond`
  ADD PRIMARY KEY (`name`),
  ADD KEY `audit_id` (`audit_id`) USING BTREE;

--
-- Indexes for table `bond_hist`
--
ALTER TABLE `bond_hist`
  ADD PRIMARY KEY (`hist_id`),
  ADD KEY `bond_name` (`bond_name`),
  ADD KEY `audit_id` (`audit_id`) USING BTREE;

--
-- Indexes for table `fxr`
--
ALTER TABLE `fxr`
  ADD PRIMARY KEY (`name`),
  ADD KEY `audit_id` (`audit_id`);

--
-- Indexes for table `fxr_hist`
--
ALTER TABLE `fxr_hist`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `interest_rate`
--
ALTER TABLE `interest_rate`
  ADD PRIMARY KEY (`name`,`as_of_date`,`term`,`date`),
  ADD KEY `audit_id` (`audit_id`);

--
-- Indexes for table `interest_rate_hist`
--
ALTER TABLE `interest_rate_hist`
  ADD PRIMARY KEY (`interest_hist_id`),
  ADD KEY `name` (`name`,`as_of_date`,`term`,`date`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD KEY `bond_name_schedule` (`bond_name`),
  ADD KEY `audit_id` (`audit_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `user_hist`
--
ALTER TABLE `user_hist`
  ADD PRIMARY KEY (`id_hist`),
  ADD KEY `username_idx` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit`
--
ALTER TABLE `audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `bond_hist`
--
ALTER TABLE `bond_hist`
  MODIFY `hist_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `interest_rate_hist`
--
ALTER TABLE `interest_rate_hist`
  MODIFY `interest_hist_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_hist`
--
ALTER TABLE `user_hist`
  MODIFY `id_hist` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit`
--
ALTER TABLE `audit`
  ADD CONSTRAINT `user_id` FOREIGN KEY (`username`) REFERENCES `user` (`username`);

--
-- Constraints for table `bond`
--
ALTER TABLE `bond`
  ADD CONSTRAINT `audit_bond` FOREIGN KEY (`audit_id`) REFERENCES `audit` (`audit_id`);

--
-- Constraints for table `bond_hist`
--
ALTER TABLE `bond_hist`
  ADD CONSTRAINT `audit_id_bond_hist` FOREIGN KEY (`audit_id`) REFERENCES `audit` (`audit_id`),
  ADD CONSTRAINT `bond_name_hist` FOREIGN KEY (`bond_name`) REFERENCES `bond` (`name`);

--
-- Constraints for table `fxr`
--
ALTER TABLE `fxr`
  ADD CONSTRAINT `audit_fxr` FOREIGN KEY (`audit_id`) REFERENCES `audit` (`audit_id`);

--
-- Constraints for table `interest_rate`
--
ALTER TABLE `interest_rate`
  ADD CONSTRAINT `audit_interest` FOREIGN KEY (`audit_id`) REFERENCES `audit` (`audit_id`);

--
-- Constraints for table `interest_rate_hist`
--
ALTER TABLE `interest_rate_hist`
  ADD CONSTRAINT `interest_con` FOREIGN KEY (`name`,`as_of_date`,`term`,`date`) REFERENCES `interest_rate` (`name`, `as_of_date`, `term`, `date`) ON UPDATE NO ACTION;

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `audit_id` FOREIGN KEY (`audit_id`) REFERENCES `audit` (`audit_id`),
  ADD CONSTRAINT `bond_name_schedule` FOREIGN KEY (`bond_name`) REFERENCES `bond` (`name`);

--
-- Constraints for table `user_hist`
--
ALTER TABLE `user_hist`
  ADD CONSTRAINT `username` FOREIGN KEY (`username`) REFERENCES `user` (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
