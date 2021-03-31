-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 31, 2021 at 04:40 PM
-- Server version: 5.7.31
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vision_optics`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `status`) VALUES
(1, 'admin@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 1);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) CHARACTER SET utf8 NOT NULL,
  `glass_name` varchar(255) NOT NULL,
  `lance_number` varchar(100) CHARACTER SET utf8 NOT NULL,
  `email` varchar(100) CHARACTER SET utf8 NOT NULL,
  `phone_number` bigint(20) NOT NULL,
  `quntity` bigint(20) NOT NULL,
  `price` int(255) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`customer_id`, `firstname`, `glass_name`, `lance_number`, `email`, `phone_number`, `quntity`, `price`) VALUES
(39, 'Ayush', 'VC Pink Transparent Square Eyeglasses', '136865', 'ayushsahni123@gmail.com', 7009849658, 1, 500),
(40, 'Guri', 'Lenskart Air Brown Rectangle Eyeglasses ', '1298225', 'guri123@gmail.com', 9814567354, 1, 94),
(41, 'Rahul singh', 'JJ Pro Titanium Brown Rectangle Eyeglasses ', '11788', 'rahul567@gmail.com', 9380075694, 2, 119),
(42, 'Vishu', 'Air Black Rectangle Eyeglasses ', ' 200', 'vishu08@gmail.com', 9389290075, 1, 94),
(45, 'vishal', '12255', '12255', 'vishal@gmail.com', 5149805427, 1, 120);

-- --------------------------------------------------------

--
-- Table structure for table `one`
--

DROP TABLE IF EXISTS `one`;
CREATE TABLE IF NOT EXISTS `one` (
  `admin1` varchar(255) NOT NULL,
  `password` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
CREATE TABLE IF NOT EXISTS `payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cust_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `cust_name` varchar(255) NOT NULL,
  `cust_email` text NOT NULL,
  `payment_id` text NOT NULL,
  `d_day` bigint(20) NOT NULL,
  `quntity` tinyint(4) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `currency` varchar(100) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `added_date` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`id`, `cust_id`, `product_id`, `cust_name`, `cust_email`, `payment_id`, `d_day`, `quntity`, `price`, `currency`, `total_price`, `added_date`) VALUES
(1, 8, 5, 'Leslie', 'lthompson@example.com', 'pay_Glo857m9EfOyD8', 2, 1, '150.00', 'USD', '150.00', '2021-03-12 10:31:35'),
(2, 9, 5, 'Julie', 'jfirrellli@example.com', 'pay_Glpda2mLlaCzW7', 2, 2, '150.00', 'USD', '300.00', '2021-03-12 11:23:43'),
(3, 1, 6, 'a', 'dmurphy@example.com', 'pay_GlpfeQDNxDh5bB', 1, 1, '120.00', 'USD', '120.00', '2021-03-12 11:25:39'),
(4, 12, 6, 'George', 'gvanauf@example.com', 'pay_GnOH7dS8qvYRjH', 1, 1, '120.00', 'USD', '120.00', '2021-03-16 12:25:44'),
(5, 6, 9, 'Anthony', 'bhoward@example.com', 'pay_GnOLaRJG71SMQW', 1, 1, '115.00', 'USD', '115.00', '2021-03-16 12:29:56'),
(6, 6, 6, 'Anthony', 'bhoward@example.com', 'pay_GnP744qo8Lalq7', 1, 1, '120.00', 'USD', '120.00', '2021-03-16 1:15:59'),
(7, 6, 6, 'Anthony', 'bhoward@example.com', 'pay_Gqaq1U0n5gClw3', 1, 1, '120.00', 'USD', '120.00', '2021-03-24 2:40:08'),
(8, 6, 6, 'Anthony', 'bhoward@example.com', 'pay_Gqb5yF1q65RBja', 1, 1, '120.00', 'USD', '120.00', '2021-03-24 2:55:13'),
(9, 39, 10, 'Ayush', 'ayushsahni123@gmail.com', 'pay_GqxJt4RVcIOQ5b', 1, 1, '113.00', 'USD', '113.00', '2021-03-25 12:39:42'),
(10, 39, 7, 'Ayush', 'ayushsahni123@gmail.com', 'pay_GqxSNP0d3MlXnN', 1, 1, '100.00', 'USD', '100.00', '2021-03-25 12:48:00'),
(11, 39, 6, 'Ayush', 'ayushsahni123@gmail.com', 'pay_GqyUj61lJOERuX', 1, 1, '120.00', 'USD', '120.00', '2021-03-25 1:48:37'),
(12, 39, 6, 'Ayush', 'ayushsahni123@gmail.com', 'pay_GqypEmGTziuFjz', 1, 1, '120.00', 'USD', '120.00', '2021-03-25 2:08:00'),
(13, 39, 6, 'Ayush', 'ayushsahni123@gmail.com', 'pay_Gr1CsmpTNdZilS', 1, 1, '120.00', 'USD', '120.00', '2021-03-25 4:27:46');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text NOT NULL,
  `image` text NOT NULL,
  `size` int(11) NOT NULL,
  `lance_number` decimal(10,2) NOT NULL,
  `added_date` varchar(100) NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `price`, `description`, `image`, `size`, `lance_number`, `added_date`, `status`) VALUES
(5, 'Aquacolor Spicy Grey Candy Pack Color Lenses (2 Lens/box/Plano)', '150.00', 'Be it in the school or out in the ground, wherever your little munchkins go, make sure they flaunt stylishness. Vincent Chase brings to you the new addition to its wide variety of fashionable and attractive kid eyeglasses. Purple Half Rim Rectangle Kids (8 yrs) Vincent Chase Online Owlers 004 -31 Screen Time Protection Glasses come in a striking combination of colours which is in complete sync with the lively and jolly attitude of the kids. These rectangular half rims are considerately constructed with acetate and stainless steel material that lessens the weight of these glasses to 19 gram', 'l1.webp', 2, '5.21', '1615132217742', 1),
(6, 'Aquacolor Naughty Brown Candy Pack Color Lenses (2 Lens/box/Plano)', '120.00', 'The acetate frame material is handcrafted and offers excellent resistance attrition, whereas the stainless steel make these spectacles exceptionally comfortable, lightweight and enduring. Rectangulars are favoured choice for kids and they are also prominent among celeb kids. These frames are perfect for those kids who love colours and cool things.', 'l2.webp', 1, '1.10', '1615132373107', 1),
(7, 'Aquacolor Spicy Blue Candy Pack Color Lenses (2 Lens/box/Plano)', '100.00', 'Be it in the school or out in the ground, wherever your little munchkins go, make sure they flaunt stylishness. Vincent Chase brings to you the new addition to its wide variety of fashionable and attractive kid eyeglasses. Purple Half Rim Rectangle Kids (8 yrs) Vincent Chase Online Owlers 004 -31 Screen Time Protection Glasses come in a striking combination of colours which is in complete sync with the lively and jolly attitude of the kids. These rectangular half rims are considerately constructed with acetate and stainless steel material that lessens the weight of these glasses to 19 gram', 'l3.webp', 1, '2.50', '1615573415136', 1),
(8, 'Aquacolor Spicy black Candy Pack Color Lenses (2 Lens/box/Plano)', '200.00', 'Be it in the school or out in the ground, wherever your little munchkins go, make sure they flaunt stylishness. Vincent Chase brings to you the new addition to its wide variety of fashionable and attractive kid eyeglasses. Purple Half Rim Rectangle Kids (8 yrs) Vincent Chase Online Owlers 004 -31 Screen Time Protection Glasses come in a striking combination of colours which is in complete sync with the lively and jolly attitude of the kids. These rectangular half rims are considerately constructed with acetate and stainless steel material that lessens the weight of these glasses to 19 gram', 'l4.webp', 1, '1.50', '1615573456526', 1),
(9, 'VC Polarized Gunmetal Hexagonal Sunglasses - 137024', '115.00', 'Frame Size:	Medium\r\nFrame Width:	137 mm\r\nFrame Dimensions:	55-21-140\r\nFrame colour:	Gunmetal\r\nFrame Material:	Metal\r\nTemple Material:	Metal\r\nGender:	Unisex\r\nHeight:	47 mm', 'vincent-chase-vc-s12917-c3-sunglasses_vincent-chase-vc-s12917-c3-sunglasses_g_4524_1_897fefa8-5727-42c2-b426-8c59d65e4b4a_1024x1024.jpg', 2, '1.50', '1615912146406', 1),
(10, 'VC Pink Transparent Square Eyeglasses ', '113.00', 'Frame Size:	Medium\r\nFrame Width:	133 mm\r\nFrame Dimensions:	51-16-143\r\nFrame colour:	Pink Transparent\r\nFrame Material:	HD Acetate\r\nTemple Material:	HD Acetate\r\nGender:	Unisex\r\nHeight:	37 mm', 'vincent-chase-vc-e12897-c2-eyeglasses_j_2868_1024x1024 (1).jpg', 2, '136865.00', '1616690332766', 1),
(11, 'JJ Gunmetal Wayfarer Eyeglasses ', '119.00', 'Frame Details\r\nFrame Size:	Medium\r\nFrame Width:	133 mm\r\nFrame Dimensions:	50-19-145\r\nFrame colour:	Gunmetal\r\nFrame Material:	Stainless Steel\r\nTemple Material:	Stainless Steel\r\nGender:	Unisex\r\nHeight:	38 mm', 'john-jacobs-jj-e11678-c2-eyeglasses_john-jacobs-jj-e11678-c2-eyeglasses_g_0400_9ed4928d-0a57-49e4-afce-39784617ed5c_1024x1024.jpg', 2, '131420.00', '1616692276757', 1),
(12, 'Air Brown Rectangle Eyeglasses ', '113.00', 'Frame Details\r\nFrame Size:	Large\r\nFrame Width:	143 mm\r\nFrame Dimensions:	55-16-140\r\nFrame colour:	Brown\r\nFrame Material:	Clip on\r\nTemple Material:	Clip on\r\nGender:	Unisex\r\nHeight:	36 mm', 'vincent-chase-vc-e11413-c2-eyeglasses_129822_1_cdb22d7f-2625-4dd3-94c9-821cac4b8f67_1024x1024.jpg', 3, '129822.00', '1616692373723', 1);

-- --------------------------------------------------------

--
-- Table structure for table `size`
--

DROP TABLE IF EXISTS `size`;
CREATE TABLE IF NOT EXISTS `size` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `size` varchar(100) NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `size`
--

INSERT INTO `size` (`id`, `size`, `status`) VALUES
(1, 'small', 1),
(2, 'medium', 1),
(3, 'large', 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
