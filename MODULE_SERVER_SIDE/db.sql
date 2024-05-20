-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 20, 2024 at 06:55 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `app-downloader`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `games`
--

CREATE TABLE `games` (
  `id` bigint UNSIGNED NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `thumbnail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upload_at` timestamp NULL DEFAULT NULL,
  `author` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `score_count` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `games`
--

INSERT INTO `games` (`id`, `slug`, `title`, `description`, `thumbnail`, `upload_at`, `author`, `score_count`, `created_at`, `updated_at`) VALUES
(1, '[value-2]', '[value-3]', '[value-4]', '[value-5]', NULL, '[value-6]', 99, NULL, NULL),
(2, 'value-4', '[value-4]', 'hai', NULL, NULL, '{\"id\":1,\"username\":\"admin\",\"last_login_at\":null,\"created_at\":\"2024-05-14T05:31:44.000000Z\",\"updated_at\":\"2024-05-14T05:31:44.000000Z\"}', 0, '2024-05-18 17:56:22', '2024-05-18 17:56:22'),
(3, 'frist-person-shooter', 'fppgame', 'wkwkkw', 'games/frist-person-shooter/4//thumbnail.png', NULL, 'admin', 0, '2024-05-18 17:58:11', '2024-05-19 19:42:03');

-- --------------------------------------------------------

--
-- Table structure for table `game_versions`
--

CREATE TABLE `game_versions` (
  `id` bigint UNSIGNED NOT NULL,
  `game_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'v1',
  `storage_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `game_versions`
--

INSERT INTO `game_versions` (`id`, `game_id`, `version`, `storage_path`, `created_at`, `updated_at`) VALUES
(1, '3', '1', 'games/frist-person-shooter/1//game.zip', '2024-05-19 19:38:02', '2024-05-19 19:38:02'),
(2, '3', '2', 'games/frist-person-shooter/2//game.zip', '2024-05-19 19:39:08', '2024-05-19 19:39:08'),
(3, '3', '3', 'games/frist-person-shooter/3/game.zip', '2024-05-19 19:40:11', '2024-05-19 19:40:11'),
(4, '3', 'v4', '/games/4/v4/', '2024-05-19 19:42:03', '2024-05-19 19:42:03');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2024_05_17_001936_game', 2),
(6, '2024_05_20_032003_scores', 3),
(7, '2024_05_20_032222_game_versions', 4);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', '6ba76cd2bfccbf1ab1126d80b887914e11c59592b40fd9e05dccf9480fdd4fea', '[\"*\"]', '2024-05-13 21:57:09', NULL, '2024-05-13 21:31:44', '2024-05-13 21:57:09'),
(2, 'App\\Models\\User', 2, 'auth_token', '5184e0690ffbf0fcc69bc243fd6603a4573cdb148d3774353f408b44438d11ad', '[\"*\"]', NULL, NULL, '2024-05-13 21:40:41', '2024-05-13 21:40:41'),
(3, 'App\\Models\\User', 3, 'auth_token', '2aca1686b160d999093458cd2df46437ec65047f3a13cba1ecf60e9e6bf054b2', '[\"*\"]', NULL, NULL, '2024-05-13 21:40:45', '2024-05-13 21:40:45'),
(4, 'App\\Models\\User', 4, 'auth_token', '46b39b4bf238498667fc7731e52b4725b39bec4113716d087dc59bfd971652ff', '[\"*\"]', NULL, NULL, '2024-05-13 22:04:22', '2024-05-13 22:04:22'),
(5, 'App\\Models\\User', 5, 'auth_token', 'd7c03a3f9a3cd4c091992ae8785e8bac89e91b71ca338994c212aefb3b9ebb01', '[\"*\"]', NULL, NULL, '2024-05-13 22:07:06', '2024-05-13 22:07:06'),
(6, 'App\\Models\\User', 6, 'auth_token', '2f897f8e61ba953064fa8422716016b2db3cccb0c6dd3266143c003cd766c68d', '[\"*\"]', NULL, NULL, '2024-05-13 22:10:52', '2024-05-13 22:10:52'),
(7, 'App\\Models\\User', 1, 'auth_token', '45dcb262076ddb76f94204652c9577a164fcafc4f242e0cba32dce4800150bd8', '[\"*\"]', NULL, NULL, '2024-05-13 22:12:02', '2024-05-13 22:12:02'),
(8, 'App\\Models\\User', 7, 'auth_token', '8a08265273ae30d24805743e0c7e4a8e2bb8d41ad1ee5cc99690de1796c53220', '[\"*\"]', NULL, NULL, '2024-05-13 22:12:30', '2024-05-13 22:12:30'),
(9, 'App\\Models\\User', 8, 'auth_token', '395d1221b308031e8c51ec6fa59774821c1e1e9cd98f336e7703f822b2530dde', '[\"*\"]', NULL, NULL, '2024-05-13 22:12:50', '2024-05-13 22:12:50'),
(10, 'App\\Models\\User', 1, 'auth_token', '6a2c3eb70b558e4dc3dd26ed8130e5faf1f3f7ec6772a707b93bbbbc425ee201', '[\"*\"]', '2024-05-16 15:25:19', NULL, '2024-05-13 22:13:07', '2024-05-16 15:25:19'),
(11, 'App\\Models\\User', 9, 'auth_token', 'e4096a0c1d9a78146bf2be76efd311cb93bd1cc52b121f245b36c94ee371684f', '[\"*\"]', NULL, NULL, '2024-05-13 22:13:34', '2024-05-13 22:13:34'),
(12, 'App\\Models\\User', 1, 'auth_token', '8f15f356c7ea9c16430dc3aecf641cb1d3120b7772549db2aeeee8475216435c', '[\"*\"]', NULL, NULL, '2024-05-13 22:21:30', '2024-05-13 22:21:30'),
(13, 'App\\Models\\User', 16, 'auth_token', 'e42d51f208799cea1697a2e203ef677871b6155552afbf2eff65c304b720a482', '[\"*\"]', NULL, NULL, '2024-05-13 22:30:32', '2024-05-13 22:30:32'),
(14, 'App\\Models\\User', 1, 'auth_token', '0e9ee9d38d2fde972bbce461805edd89a7e5c73571f8531ab098669533a24d46', '[\"*\"]', '2024-05-13 22:32:19', NULL, '2024-05-13 22:31:24', '2024-05-13 22:32:19'),
(15, 'App\\Models\\User', 20, 'auth_token', '7363fbe7b0bc4a622e77730f6d77aaa008b8a9fa3cee1f7ec548988252758f10', '[\"*\"]', '2024-05-13 22:32:48', NULL, '2024-05-13 22:32:33', '2024-05-13 22:32:48'),
(16, 'App\\Models\\User', 1, 'auth_token', '93552f6afd2c70633257d030c019b1520ca158ae2da82103e38f9fd6cccaec37', '[\"*\"]', '2024-05-13 22:33:07', NULL, '2024-05-13 22:32:58', '2024-05-13 22:33:07'),
(17, 'App\\Models\\User', 1, 'auth_token', '320b02d2ff47b8a7675970d2081b6f674c54cdd217636e8ea9b390ac81a9a748', '[\"*\"]', '2024-05-18 17:40:43', NULL, '2024-05-16 15:22:14', '2024-05-18 17:40:43'),
(18, 'App\\Models\\User', 1, 'auth_token', 'c49f2a9b2d461d62a1be43c4f92333a7dc2d4f5d42765de4a0b1c6d9a994b3b4', '[\"*\"]', '2024-05-19 21:37:53', NULL, '2024-05-18 17:39:43', '2024-05-19 21:37:53'),
(19, 'App\\Models\\User', 1, 'auth_token', 'f5054fe279bc06cc2c6866062fff7a569c42674c3a57b0a8c9f61ee935285bf0', '[\"*\"]', '2024-05-19 21:58:48', NULL, '2024-05-19 21:40:10', '2024-05-19 21:58:48');

-- --------------------------------------------------------

--
-- Table structure for table `scores`
--

CREATE TABLE `scores` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int NOT NULL,
  `game_version_id` int NOT NULL,
  `score` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `scores`
--

INSERT INTO `scores` (`id`, `user_id`, `game_version_id`, `score`, `created_at`, `updated_at`) VALUES
(1, 1, 4, 100.00, NULL, NULL),
(3, 1, 3, 1.00, NULL, NULL),
(4, 1, 3, 10.00, NULL, NULL),
(5, 1, 3, 10021.00, '2024-05-19 21:03:58', '2024-05-19 21:03:58'),
(6, 1, 3, 0.00, '2024-05-19 21:25:29', '2024-05-19 21:25:29'),
(7, 1, 3, -1.00, '2024-05-19 21:25:32', '2024-05-19 21:25:32'),
(8, 1, 3, 0.00, '2024-05-19 21:53:50', '2024-05-19 21:53:50'),
(9, 1, 3, 0.00, '2024-05-19 21:58:32', '2024-05-19 21:58:32'),
(10, 1, 3, 0.00, '2024-05-19 21:58:48', '2024-05-19 21:58:48');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `last_login_at` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `roles`, `last_login_at`, `created_at`, `updated_at`) VALUES
(1, 'admin', '$2y$10$Dno/BpcIT8srwPOd0TZoreZq2n68aP5cKE89FCIyxMzasCIJNh2ve', 'admin', NULL, '2024-05-13 21:31:44', '2024-05-13 21:31:44'),
(2, 'admin1', '$2y$10$Fx5CVyF1h3FQcPB87tf42uUTGYq9IhVR2MFa9mSM8g50KDs53KDdO', 'user', NULL, '2024-05-13 21:40:41', '2024-05-13 21:40:41'),
(3, 'admin2', '$2y$10$SngqAhmPYi.90YryMLh1veg/AI/3cF93lMSs3guzsQlFr.xmDDxtO', 'user', NULL, '2024-05-13 21:40:45', '2024-05-13 21:40:45'),
(4, 'admin3', '$2y$10$A0eW8hRAFjaxn6fjTntzgOgEpsVHJc2OvDVHSHrIIAlsn4aRsQ7Lu', 'user', NULL, '2024-05-13 22:04:22', '2024-05-13 22:04:22'),
(7, 'shgjhjhss', '$2y$10$Dnnd9t7Vv3VS3y222PKsAe7qasUGPEnBus1ITSVhDnI9b.tg38Q2m', 'user', NULL, '2024-05-13 22:12:30', '2024-05-13 22:12:30'),
(8, 'shgjhjhsss', '$2y$10$k7GeAevxnXqbDqf46sN79.rf8QQMx9G9HD2FwzAT1qEkeuwFUgtvO', 'user', NULL, '2024-05-13 22:12:50', '2024-05-13 22:12:50'),
(9, 'shgjhjhsssi', '$2y$10$NXEak/xXw4L7WN5rTzNvR.jUh/aqOleRDhmCbbidG9Qt5afYRvEMi', 'user', NULL, '2024-05-13 22:13:34', '2024-05-13 22:13:34'),
(10, 'shgjhjhsssis', '$2y$10$gTtGeSiK45rbj0LPiPylUOpMbwNQcD60I73cXAx05bS5Flb.hGTmC', 'user', NULL, '2024-05-13 22:22:06', '2024-05-13 22:22:06'),
(11, 'shgjhjhsssisa', '$2y$10$C0o1r54iN9hmHfxZfT9GcuzwdAI.g7U3jFlL0hYzZNsye3Npobobm', 'user', NULL, '2024-05-13 22:24:27', '2024-05-13 22:24:27'),
(12, 'shgjhjhsssisas', '$2y$10$c16d13K9YenNtDJ8lWeoYeasCuU1CflFyZB3LaUJ8UtlNTMNEP5V6', 'user', NULL, '2024-05-13 22:25:40', '2024-05-13 22:25:40'),
(13, 'shgjhjhsssisasa', '$2y$10$4NWmygf2AK3OpGxkrhamY.z8jBKG0V5EnGRHzsYM2d55dXqTFm7zu', 'user', NULL, '2024-05-13 22:25:46', '2024-05-13 22:25:46'),
(14, 'admin3f', '$2y$10$U5aOjoHWrTe28aDGHXzUqeS9AHjSMDAcu.5nFofTmJP05XpMP3JLy', 'user', NULL, '2024-05-13 22:29:27', '2024-05-13 22:29:27'),
(15, 'admin3fs', '$2y$10$GJUhB0fw2BkMLR5xE2jE/e1JzzWzWwNYf/2aQZnWy3NbcD5a/6yBC', 'user', NULL, '2024-05-13 22:29:30', '2024-05-13 22:29:30'),
(16, 'admin3fsa', '$2y$10$qzZxTPBBAfjmMDXaV4hZteLqqmpHNIu4vkCL/GJIDvhf0UAlx1mnm', 'user', NULL, '2024-05-13 22:30:32', '2024-05-13 22:30:32'),
(19, 'shgjhjhsssisasaa', '$2y$10$nuwv6AnWeE2beTrB3UftLutU7DM.TLv8sEokN6Kr4U46Lb2STTlC.', 'user', NULL, '2024-05-13 22:32:19', '2024-05-13 22:32:19'),
(20, 'admin3fsaa', '$2y$10$.5YbFPerA4YXQYo7C9ixXOzgQ6R7j.qgMBewxY4ntu2CPu2vW6wam', 'user', NULL, '2024-05-13 22:32:33', '2024-05-13 22:32:33');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `games_slug_unique` (`slug`);

--
-- Indexes for table `game_versions`
--
ALTER TABLE `game_versions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `scores`
--
ALTER TABLE `scores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `games`
--
ALTER TABLE `games`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `game_versions`
--
ALTER TABLE `game_versions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `scores`
--
ALTER TABLE `scores`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
