-- MySQL dump 10.13  Distrib 5.7.21, for osx10.13 (x86_64)
--
-- Host: 18.204.178.18    Database: mybistro_dev
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `wp_commentmeta`
--

DROP TABLE IF EXISTS `wp_commentmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_commentmeta`
--

LOCK TABLES `wp_commentmeta` WRITE;
/*!40000 ALTER TABLE `wp_commentmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_commentmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_comments`
--

DROP TABLE IF EXISTS `wp_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_comments` (
  `comment_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `comment_author` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_author_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`),
  KEY `comment_author_email` (`comment_author_email`(10)),
  KEY `woo_idx_comment_type` (`comment_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_comments`
--

LOCK TABLES `wp_comments` WRITE;
/*!40000 ALTER TABLE `wp_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_links`
--

DROP TABLE IF EXISTS `wp_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) unsigned NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link_rss` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_links`
--

LOCK TABLES `wp_links` WRITE;
/*!40000 ALTER TABLE `wp_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_options`
--

DROP TABLE IF EXISTS `wp_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `option_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `autoload` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB AUTO_INCREMENT=518 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_options`
--

LOCK TABLES `wp_options` WRITE;
/*!40000 ALTER TABLE `wp_options` DISABLE KEYS */;
INSERT INTO `wp_options` VALUES (1,'siteurl','http://localhost:8500','yes'),(2,'home','http://localhost:8500','yes'),(3,'blogname','My Wordpress','yes'),(4,'blogdescription','Just another WordPress site','yes'),(5,'users_can_register','0','yes'),(6,'admin_email','admin@domain.com','yes'),(7,'start_of_week','1','yes'),(8,'use_balanceTags','0','yes'),(9,'use_smilies','1','yes'),(10,'require_name_email','1','yes'),(11,'comments_notify','1','yes'),(12,'posts_per_rss','10','yes'),(13,'rss_use_excerpt','0','yes'),(14,'mailserver_url','mail.example.com','yes'),(15,'mailserver_login','login@example.com','yes'),(16,'mailserver_pass','password','yes'),(17,'mailserver_port','110','yes'),(18,'default_category','1','yes'),(19,'default_comment_status','open','yes'),(20,'default_ping_status','open','yes'),(21,'default_pingback_flag','1','yes'),(22,'posts_per_page','10','yes'),(23,'date_format','F j, Y','yes'),(24,'time_format','g:i a','yes'),(25,'links_updated_date_format','F j, Y g:i a','yes'),(26,'comment_moderation','0','yes'),(27,'moderation_notify','1','yes'),(28,'permalink_structure','/%postname%/','yes'),(29,'rewrite_rules','a:155:{s:24:\"^wc-auth/v([1]{1})/(.*)?\";s:63:\"index.php?wc-auth-version=$matches[1]&wc-auth-route=$matches[2]\";s:22:\"^wc-api/v([1-3]{1})/?$\";s:51:\"index.php?wc-api-version=$matches[1]&wc-api-route=/\";s:24:\"^wc-api/v([1-3]{1})(.*)?\";s:61:\"index.php?wc-api-version=$matches[1]&wc-api-route=$matches[2]\";s:7:\"menu/?$\";s:27:\"index.php?post_type=product\";s:37:\"menu/feed/(feed|rdf|rss|rss2|atom)/?$\";s:44:\"index.php?post_type=product&feed=$matches[1]\";s:32:\"menu/(feed|rdf|rss|rss2|atom)/?$\";s:44:\"index.php?post_type=product&feed=$matches[1]\";s:24:\"menu/page/([0-9]{1,})/?$\";s:45:\"index.php?post_type=product&paged=$matches[1]\";s:11:\"^wp-json/?$\";s:22:\"index.php?rest_route=/\";s:14:\"^wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:21:\"^index.php/wp-json/?$\";s:22:\"index.php?rest_route=/\";s:24:\"^index.php/wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:47:\"category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:42:\"category/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:23:\"category/(.+?)/embed/?$\";s:46:\"index.php?category_name=$matches[1]&embed=true\";s:35:\"category/(.+?)/page/?([0-9]{1,})/?$\";s:53:\"index.php?category_name=$matches[1]&paged=$matches[2]\";s:32:\"category/(.+?)/wc-api(/(.*))?/?$\";s:54:\"index.php?category_name=$matches[1]&wc-api=$matches[3]\";s:17:\"category/(.+?)/?$\";s:35:\"index.php?category_name=$matches[1]\";s:44:\"tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:39:\"tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:20:\"tag/([^/]+)/embed/?$\";s:36:\"index.php?tag=$matches[1]&embed=true\";s:32:\"tag/([^/]+)/page/?([0-9]{1,})/?$\";s:43:\"index.php?tag=$matches[1]&paged=$matches[2]\";s:29:\"tag/([^/]+)/wc-api(/(.*))?/?$\";s:44:\"index.php?tag=$matches[1]&wc-api=$matches[3]\";s:14:\"tag/([^/]+)/?$\";s:25:\"index.php?tag=$matches[1]\";s:45:\"type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:40:\"type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:21:\"type/([^/]+)/embed/?$\";s:44:\"index.php?post_format=$matches[1]&embed=true\";s:33:\"type/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?post_format=$matches[1]&paged=$matches[2]\";s:15:\"type/([^/]+)/?$\";s:33:\"index.php?post_format=$matches[1]\";s:55:\"product-category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?product_cat=$matches[1]&feed=$matches[2]\";s:50:\"product-category/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?product_cat=$matches[1]&feed=$matches[2]\";s:31:\"product-category/(.+?)/embed/?$\";s:44:\"index.php?product_cat=$matches[1]&embed=true\";s:43:\"product-category/(.+?)/page/?([0-9]{1,})/?$\";s:51:\"index.php?product_cat=$matches[1]&paged=$matches[2]\";s:25:\"product-category/(.+?)/?$\";s:33:\"index.php?product_cat=$matches[1]\";s:52:\"product-tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?product_tag=$matches[1]&feed=$matches[2]\";s:47:\"product-tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?product_tag=$matches[1]&feed=$matches[2]\";s:28:\"product-tag/([^/]+)/embed/?$\";s:44:\"index.php?product_tag=$matches[1]&embed=true\";s:40:\"product-tag/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?product_tag=$matches[1]&paged=$matches[2]\";s:22:\"product-tag/([^/]+)/?$\";s:33:\"index.php?product_tag=$matches[1]\";s:35:\"product/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:45:\"product/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:65:\"product/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:60:\"product/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:60:\"product/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:41:\"product/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:24:\"product/([^/]+)/embed/?$\";s:40:\"index.php?product=$matches[1]&embed=true\";s:28:\"product/([^/]+)/trackback/?$\";s:34:\"index.php?product=$matches[1]&tb=1\";s:48:\"product/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:46:\"index.php?product=$matches[1]&feed=$matches[2]\";s:43:\"product/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:46:\"index.php?product=$matches[1]&feed=$matches[2]\";s:36:\"product/([^/]+)/page/?([0-9]{1,})/?$\";s:47:\"index.php?product=$matches[1]&paged=$matches[2]\";s:43:\"product/([^/]+)/comment-page-([0-9]{1,})/?$\";s:47:\"index.php?product=$matches[1]&cpage=$matches[2]\";s:33:\"product/([^/]+)/wc-api(/(.*))?/?$\";s:48:\"index.php?product=$matches[1]&wc-api=$matches[3]\";s:39:\"product/[^/]+/([^/]+)/wc-api(/(.*))?/?$\";s:51:\"index.php?attachment=$matches[1]&wc-api=$matches[3]\";s:50:\"product/[^/]+/attachment/([^/]+)/wc-api(/(.*))?/?$\";s:51:\"index.php?attachment=$matches[1]&wc-api=$matches[3]\";s:32:\"product/([^/]+)(?:/([0-9]+))?/?$\";s:46:\"index.php?product=$matches[1]&page=$matches[2]\";s:24:\"product/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:34:\"product/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:54:\"product/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:49:\"product/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:49:\"product/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:30:\"product/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:12:\"robots\\.txt$\";s:18:\"index.php?robots=1\";s:48:\".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$\";s:18:\"index.php?feed=old\";s:20:\".*wp-app\\.php(/.*)?$\";s:19:\"index.php?error=403\";s:18:\".*wp-register.php$\";s:23:\"index.php?register=true\";s:32:\"feed/(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:27:\"(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:8:\"embed/?$\";s:21:\"index.php?&embed=true\";s:20:\"page/?([0-9]{1,})/?$\";s:28:\"index.php?&paged=$matches[1]\";s:27:\"comment-page-([0-9]{1,})/?$\";s:38:\"index.php?&page_id=8&cpage=$matches[1]\";s:17:\"wc-api(/(.*))?/?$\";s:29:\"index.php?&wc-api=$matches[2]\";s:41:\"comments/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:36:\"comments/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:17:\"comments/embed/?$\";s:21:\"index.php?&embed=true\";s:26:\"comments/wc-api(/(.*))?/?$\";s:29:\"index.php?&wc-api=$matches[2]\";s:44:\"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:39:\"search/(.+)/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:20:\"search/(.+)/embed/?$\";s:34:\"index.php?s=$matches[1]&embed=true\";s:32:\"search/(.+)/page/?([0-9]{1,})/?$\";s:41:\"index.php?s=$matches[1]&paged=$matches[2]\";s:29:\"search/(.+)/wc-api(/(.*))?/?$\";s:42:\"index.php?s=$matches[1]&wc-api=$matches[3]\";s:14:\"search/(.+)/?$\";s:23:\"index.php?s=$matches[1]\";s:47:\"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:42:\"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:23:\"author/([^/]+)/embed/?$\";s:44:\"index.php?author_name=$matches[1]&embed=true\";s:35:\"author/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?author_name=$matches[1]&paged=$matches[2]\";s:32:\"author/([^/]+)/wc-api(/(.*))?/?$\";s:52:\"index.php?author_name=$matches[1]&wc-api=$matches[3]\";s:17:\"author/([^/]+)/?$\";s:33:\"index.php?author_name=$matches[1]\";s:69:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:45:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$\";s:74:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&embed=true\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]\";s:54:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/wc-api(/(.*))?/?$\";s:82:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&wc-api=$matches[5]\";s:39:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$\";s:63:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]\";s:56:\"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:51:\"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:32:\"([0-9]{4})/([0-9]{1,2})/embed/?$\";s:58:\"index.php?year=$matches[1]&monthnum=$matches[2]&embed=true\";s:44:\"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]\";s:41:\"([0-9]{4})/([0-9]{1,2})/wc-api(/(.*))?/?$\";s:66:\"index.php?year=$matches[1]&monthnum=$matches[2]&wc-api=$matches[4]\";s:26:\"([0-9]{4})/([0-9]{1,2})/?$\";s:47:\"index.php?year=$matches[1]&monthnum=$matches[2]\";s:43:\"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:38:\"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:19:\"([0-9]{4})/embed/?$\";s:37:\"index.php?year=$matches[1]&embed=true\";s:31:\"([0-9]{4})/page/?([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&paged=$matches[2]\";s:28:\"([0-9]{4})/wc-api(/(.*))?/?$\";s:45:\"index.php?year=$matches[1]&wc-api=$matches[3]\";s:13:\"([0-9]{4})/?$\";s:26:\"index.php?year=$matches[1]\";s:27:\".?.+?/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\".?.+?/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\".?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\".?.+?/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"(.?.+?)/embed/?$\";s:41:\"index.php?pagename=$matches[1]&embed=true\";s:20:\"(.?.+?)/trackback/?$\";s:35:\"index.php?pagename=$matches[1]&tb=1\";s:40:\"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:35:\"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:28:\"(.?.+?)/page/?([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&paged=$matches[2]\";s:35:\"(.?.+?)/comment-page-([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&cpage=$matches[2]\";s:25:\"(.?.+?)/wc-api(/(.*))?/?$\";s:49:\"index.php?pagename=$matches[1]&wc-api=$matches[3]\";s:28:\"(.?.+?)/order-pay(/(.*))?/?$\";s:52:\"index.php?pagename=$matches[1]&order-pay=$matches[3]\";s:33:\"(.?.+?)/order-received(/(.*))?/?$\";s:57:\"index.php?pagename=$matches[1]&order-received=$matches[3]\";s:25:\"(.?.+?)/orders(/(.*))?/?$\";s:49:\"index.php?pagename=$matches[1]&orders=$matches[3]\";s:29:\"(.?.+?)/view-order(/(.*))?/?$\";s:53:\"index.php?pagename=$matches[1]&view-order=$matches[3]\";s:28:\"(.?.+?)/downloads(/(.*))?/?$\";s:52:\"index.php?pagename=$matches[1]&downloads=$matches[3]\";s:31:\"(.?.+?)/edit-account(/(.*))?/?$\";s:55:\"index.php?pagename=$matches[1]&edit-account=$matches[3]\";s:31:\"(.?.+?)/edit-address(/(.*))?/?$\";s:55:\"index.php?pagename=$matches[1]&edit-address=$matches[3]\";s:34:\"(.?.+?)/payment-methods(/(.*))?/?$\";s:58:\"index.php?pagename=$matches[1]&payment-methods=$matches[3]\";s:32:\"(.?.+?)/lost-password(/(.*))?/?$\";s:56:\"index.php?pagename=$matches[1]&lost-password=$matches[3]\";s:34:\"(.?.+?)/customer-logout(/(.*))?/?$\";s:58:\"index.php?pagename=$matches[1]&customer-logout=$matches[3]\";s:37:\"(.?.+?)/add-payment-method(/(.*))?/?$\";s:61:\"index.php?pagename=$matches[1]&add-payment-method=$matches[3]\";s:40:\"(.?.+?)/delete-payment-method(/(.*))?/?$\";s:64:\"index.php?pagename=$matches[1]&delete-payment-method=$matches[3]\";s:45:\"(.?.+?)/set-default-payment-method(/(.*))?/?$\";s:69:\"index.php?pagename=$matches[1]&set-default-payment-method=$matches[3]\";s:31:\".?.+?/([^/]+)/wc-api(/(.*))?/?$\";s:51:\"index.php?attachment=$matches[1]&wc-api=$matches[3]\";s:42:\".?.+?/attachment/([^/]+)/wc-api(/(.*))?/?$\";s:51:\"index.php?attachment=$matches[1]&wc-api=$matches[3]\";s:24:\"(.?.+?)(?:/([0-9]+))?/?$\";s:47:\"index.php?pagename=$matches[1]&page=$matches[2]\";s:27:\"[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\"[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\"[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\"[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\"[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\"[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"([^/]+)/embed/?$\";s:37:\"index.php?name=$matches[1]&embed=true\";s:20:\"([^/]+)/trackback/?$\";s:31:\"index.php?name=$matches[1]&tb=1\";s:40:\"([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:35:\"([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:28:\"([^/]+)/page/?([0-9]{1,})/?$\";s:44:\"index.php?name=$matches[1]&paged=$matches[2]\";s:35:\"([^/]+)/comment-page-([0-9]{1,})/?$\";s:44:\"index.php?name=$matches[1]&cpage=$matches[2]\";s:25:\"([^/]+)/wc-api(/(.*))?/?$\";s:45:\"index.php?name=$matches[1]&wc-api=$matches[3]\";s:31:\"[^/]+/([^/]+)/wc-api(/(.*))?/?$\";s:51:\"index.php?attachment=$matches[1]&wc-api=$matches[3]\";s:42:\"[^/]+/attachment/([^/]+)/wc-api(/(.*))?/?$\";s:51:\"index.php?attachment=$matches[1]&wc-api=$matches[3]\";s:24:\"([^/]+)(?:/([0-9]+))?/?$\";s:43:\"index.php?name=$matches[1]&page=$matches[2]\";s:16:\"[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:26:\"[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:46:\"[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:41:\"[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:41:\"[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:22:\"[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";}','yes'),(30,'hack_file','0','yes'),(31,'blog_charset','UTF-8','yes'),(32,'moderation_keys','','no'),(33,'active_plugins','a:1:{i:0;s:27:\"woocommerce/woocommerce.php\";}','yes'),(34,'category_base','','yes'),(35,'ping_sites','http://rpc.pingomatic.com/','yes'),(36,'comment_max_links','2','yes'),(37,'gmt_offset','','yes'),(38,'default_email_category','1','yes'),(39,'recently_edited','','no'),(40,'template','astra','yes'),(41,'stylesheet','astra','yes'),(42,'comment_whitelist','1','yes'),(43,'blacklist_keys','','no'),(44,'comment_registration','0','yes'),(45,'html_type','text/html','yes'),(46,'use_trackback','0','yes'),(47,'default_role','subscriber','yes'),(48,'db_version','38590','yes'),(49,'uploads_use_yearmonth_folders','1','yes'),(50,'upload_path','','yes'),(51,'blog_public','1','yes'),(52,'default_link_category','2','yes'),(53,'show_on_front','page','yes'),(54,'tag_base','','yes'),(55,'show_avatars','1','yes'),(56,'avatar_rating','G','yes'),(57,'upload_url_path','','yes'),(58,'thumbnail_size_w','150','yes'),(59,'thumbnail_size_h','150','yes'),(60,'thumbnail_crop','1','yes'),(61,'medium_size_w','300','yes'),(62,'medium_size_h','300','yes'),(63,'avatar_default','mystery','yes'),(64,'large_size_w','1024','yes'),(65,'large_size_h','1024','yes'),(66,'image_default_link_type','none','yes'),(67,'image_default_size','','yes'),(68,'image_default_align','','yes'),(69,'close_comments_for_old_posts','0','yes'),(70,'close_comments_days_old','14','yes'),(71,'thread_comments','1','yes'),(72,'thread_comments_depth','5','yes'),(73,'page_comments','0','yes'),(74,'comments_per_page','50','yes'),(75,'default_comments_page','newest','yes'),(76,'comment_order','asc','yes'),(77,'sticky_posts','a:0:{}','yes'),(78,'widget_categories','a:2:{i:2;a:4:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:12:\"hierarchical\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}','yes'),(79,'widget_text','a:2:{i:1;a:0:{}s:12:\"_multiwidget\";i:1;}','yes'),(80,'widget_rss','a:2:{i:1;a:0:{}s:12:\"_multiwidget\";i:1;}','yes'),(81,'uninstall_plugins','a:0:{}','no'),(82,'timezone_string','America/New_York','yes'),(83,'page_for_posts','0','yes'),(84,'page_on_front','8','yes'),(85,'default_post_format','0','yes'),(86,'link_manager_enabled','0','yes'),(87,'finished_splitting_shared_terms','1','yes'),(88,'site_icon','0','yes'),(89,'medium_large_size_w','768','yes'),(90,'medium_large_size_h','0','yes'),(91,'wp_page_for_privacy_policy','','yes'),(92,'initial_db_version','38590','yes'),(93,'wp_user_roles','a:7:{s:13:\"administrator\";a:2:{s:4:\"name\";s:13:\"Administrator\";s:12:\"capabilities\";a:114:{s:13:\"switch_themes\";b:1;s:11:\"edit_themes\";b:1;s:16:\"activate_plugins\";b:1;s:12:\"edit_plugins\";b:1;s:10:\"edit_users\";b:1;s:10:\"edit_files\";b:1;s:14:\"manage_options\";b:1;s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:6:\"import\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:8:\"level_10\";b:1;s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:12:\"delete_users\";b:1;s:12:\"create_users\";b:1;s:17:\"unfiltered_upload\";b:1;s:14:\"edit_dashboard\";b:1;s:14:\"update_plugins\";b:1;s:14:\"delete_plugins\";b:1;s:15:\"install_plugins\";b:1;s:13:\"update_themes\";b:1;s:14:\"install_themes\";b:1;s:11:\"update_core\";b:1;s:10:\"list_users\";b:1;s:12:\"remove_users\";b:1;s:13:\"promote_users\";b:1;s:18:\"edit_theme_options\";b:1;s:13:\"delete_themes\";b:1;s:6:\"export\";b:1;s:18:\"manage_woocommerce\";b:1;s:24:\"view_woocommerce_reports\";b:1;s:12:\"edit_product\";b:1;s:12:\"read_product\";b:1;s:14:\"delete_product\";b:1;s:13:\"edit_products\";b:1;s:20:\"edit_others_products\";b:1;s:16:\"publish_products\";b:1;s:21:\"read_private_products\";b:1;s:15:\"delete_products\";b:1;s:23:\"delete_private_products\";b:1;s:25:\"delete_published_products\";b:1;s:22:\"delete_others_products\";b:1;s:21:\"edit_private_products\";b:1;s:23:\"edit_published_products\";b:1;s:20:\"manage_product_terms\";b:1;s:18:\"edit_product_terms\";b:1;s:20:\"delete_product_terms\";b:1;s:20:\"assign_product_terms\";b:1;s:15:\"edit_shop_order\";b:1;s:15:\"read_shop_order\";b:1;s:17:\"delete_shop_order\";b:1;s:16:\"edit_shop_orders\";b:1;s:23:\"edit_others_shop_orders\";b:1;s:19:\"publish_shop_orders\";b:1;s:24:\"read_private_shop_orders\";b:1;s:18:\"delete_shop_orders\";b:1;s:26:\"delete_private_shop_orders\";b:1;s:28:\"delete_published_shop_orders\";b:1;s:25:\"delete_others_shop_orders\";b:1;s:24:\"edit_private_shop_orders\";b:1;s:26:\"edit_published_shop_orders\";b:1;s:23:\"manage_shop_order_terms\";b:1;s:21:\"edit_shop_order_terms\";b:1;s:23:\"delete_shop_order_terms\";b:1;s:23:\"assign_shop_order_terms\";b:1;s:16:\"edit_shop_coupon\";b:1;s:16:\"read_shop_coupon\";b:1;s:18:\"delete_shop_coupon\";b:1;s:17:\"edit_shop_coupons\";b:1;s:24:\"edit_others_shop_coupons\";b:1;s:20:\"publish_shop_coupons\";b:1;s:25:\"read_private_shop_coupons\";b:1;s:19:\"delete_shop_coupons\";b:1;s:27:\"delete_private_shop_coupons\";b:1;s:29:\"delete_published_shop_coupons\";b:1;s:26:\"delete_others_shop_coupons\";b:1;s:25:\"edit_private_shop_coupons\";b:1;s:27:\"edit_published_shop_coupons\";b:1;s:24:\"manage_shop_coupon_terms\";b:1;s:22:\"edit_shop_coupon_terms\";b:1;s:24:\"delete_shop_coupon_terms\";b:1;s:24:\"assign_shop_coupon_terms\";b:1;}}s:6:\"editor\";a:2:{s:4:\"name\";s:6:\"Editor\";s:12:\"capabilities\";a:34:{s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;}}s:6:\"author\";a:2:{s:4:\"name\";s:6:\"Author\";s:12:\"capabilities\";a:10:{s:12:\"upload_files\";b:1;s:10:\"edit_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;s:22:\"delete_published_posts\";b:1;}}s:11:\"contributor\";a:2:{s:4:\"name\";s:11:\"Contributor\";s:12:\"capabilities\";a:5:{s:10:\"edit_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;}}s:10:\"subscriber\";a:2:{s:4:\"name\";s:10:\"Subscriber\";s:12:\"capabilities\";a:2:{s:4:\"read\";b:1;s:7:\"level_0\";b:1;}}s:8:\"customer\";a:2:{s:4:\"name\";s:8:\"Customer\";s:12:\"capabilities\";a:1:{s:4:\"read\";b:1;}}s:12:\"shop_manager\";a:2:{s:4:\"name\";s:12:\"Shop manager\";s:12:\"capabilities\";a:92:{s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:4:\"read\";b:1;s:18:\"read_private_pages\";b:1;s:18:\"read_private_posts\";b:1;s:10:\"edit_users\";b:1;s:10:\"edit_posts\";b:1;s:10:\"edit_pages\";b:1;s:20:\"edit_published_posts\";b:1;s:20:\"edit_published_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"edit_private_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:17:\"edit_others_pages\";b:1;s:13:\"publish_posts\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_posts\";b:1;s:12:\"delete_pages\";b:1;s:20:\"delete_private_pages\";b:1;s:20:\"delete_private_posts\";b:1;s:22:\"delete_published_pages\";b:1;s:22:\"delete_published_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:19:\"delete_others_pages\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:17:\"moderate_comments\";b:1;s:12:\"upload_files\";b:1;s:6:\"export\";b:1;s:6:\"import\";b:1;s:10:\"list_users\";b:1;s:18:\"manage_woocommerce\";b:1;s:24:\"view_woocommerce_reports\";b:1;s:12:\"edit_product\";b:1;s:12:\"read_product\";b:1;s:14:\"delete_product\";b:1;s:13:\"edit_products\";b:1;s:20:\"edit_others_products\";b:1;s:16:\"publish_products\";b:1;s:21:\"read_private_products\";b:1;s:15:\"delete_products\";b:1;s:23:\"delete_private_products\";b:1;s:25:\"delete_published_products\";b:1;s:22:\"delete_others_products\";b:1;s:21:\"edit_private_products\";b:1;s:23:\"edit_published_products\";b:1;s:20:\"manage_product_terms\";b:1;s:18:\"edit_product_terms\";b:1;s:20:\"delete_product_terms\";b:1;s:20:\"assign_product_terms\";b:1;s:15:\"edit_shop_order\";b:1;s:15:\"read_shop_order\";b:1;s:17:\"delete_shop_order\";b:1;s:16:\"edit_shop_orders\";b:1;s:23:\"edit_others_shop_orders\";b:1;s:19:\"publish_shop_orders\";b:1;s:24:\"read_private_shop_orders\";b:1;s:18:\"delete_shop_orders\";b:1;s:26:\"delete_private_shop_orders\";b:1;s:28:\"delete_published_shop_orders\";b:1;s:25:\"delete_others_shop_orders\";b:1;s:24:\"edit_private_shop_orders\";b:1;s:26:\"edit_published_shop_orders\";b:1;s:23:\"manage_shop_order_terms\";b:1;s:21:\"edit_shop_order_terms\";b:1;s:23:\"delete_shop_order_terms\";b:1;s:23:\"assign_shop_order_terms\";b:1;s:16:\"edit_shop_coupon\";b:1;s:16:\"read_shop_coupon\";b:1;s:18:\"delete_shop_coupon\";b:1;s:17:\"edit_shop_coupons\";b:1;s:24:\"edit_others_shop_coupons\";b:1;s:20:\"publish_shop_coupons\";b:1;s:25:\"read_private_shop_coupons\";b:1;s:19:\"delete_shop_coupons\";b:1;s:27:\"delete_private_shop_coupons\";b:1;s:29:\"delete_published_shop_coupons\";b:1;s:26:\"delete_others_shop_coupons\";b:1;s:25:\"edit_private_shop_coupons\";b:1;s:27:\"edit_published_shop_coupons\";b:1;s:24:\"manage_shop_coupon_terms\";b:1;s:22:\"edit_shop_coupon_terms\";b:1;s:24:\"delete_shop_coupon_terms\";b:1;s:24:\"assign_shop_coupon_terms\";b:1;}}}','yes'),(94,'fresh_site','0','yes'),(95,'widget_search','a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}','yes'),(96,'widget_recent-posts','a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}','yes'),(97,'widget_recent-comments','a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}','yes'),(98,'widget_archives','a:2:{i:2;a:3:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}','yes'),(99,'widget_meta','a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}','yes'),(100,'widget_pages','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(101,'widget_calendar','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(102,'widget_media_audio','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(103,'widget_media_image','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(104,'sidebars_widgets','a:10:{s:19:\"wp_inactive_widgets\";a:0:{}s:9:\"sidebar-1\";a:6:{i:0;s:8:\"search-2\";i:1;s:14:\"recent-posts-2\";i:2;s:17:\"recent-comments-2\";i:3;s:10:\"archives-2\";i:4;s:12:\"categories-2\";i:5;s:6:\"meta-2\";}s:13:\"header-widget\";a:0:{}s:15:\"footer-widget-1\";a:0:{}s:15:\"footer-widget-2\";a:0:{}s:24:\"advanced-footer-widget-1\";a:0:{}s:24:\"advanced-footer-widget-2\";a:0:{}s:24:\"advanced-footer-widget-3\";a:0:{}s:24:\"advanced-footer-widget-4\";a:0:{}s:13:\"array_version\";i:3;}','yes'),(105,'widget_media_gallery','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(106,'widget_media_video','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(107,'widget_tag_cloud','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(108,'widget_nav_menu','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(109,'widget_custom_html','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(110,'cron','a:171:{i:1527453478;a:1:{s:34:\"wp_privacy_delete_old_export_files\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}}i:1527453503;a:3:{s:16:\"wp_version_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:17:\"wp_update_plugins\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:16:\"wp_update_themes\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1527453508;a:2:{s:19:\"wp_scheduled_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}s:25:\"delete_expired_transients\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1527458171;a:1:{s:30:\"wp_scheduled_auto_draft_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1532581086;a:1:{s:33:\"woocommerce_cleanup_personal_data\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1532581096;a:1:{s:30:\"woocommerce_tracker_send_event\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1532581291;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"34d6500ba88644272ad3dd35e04dcb90\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532581261\";}}}}i:1532581386;a:1:{s:25:\"woocommerce_geoip_updater\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:0:{}}}}i:1532581619;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"fa87815ae4a234cacdc007ce2ba52693\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532581589\";}}}}i:1532581632;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"b20f06f99f1132b63bfb6f3fa022db60\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532581602\";}}}}i:1532581648;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"57a97a4c0735e8a856cc7490ecfad537\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532581618\";}}}}i:1532589970;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"9d261028d13083cc948db69f1a7b0587\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532589940\";}}}}i:1532591886;a:1:{s:24:\"woocommerce_cleanup_logs\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1532592050;a:1:{s:32:\"woocommerce_cancel_unpaid_orders\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:0:{}}}}i:1532602686;a:1:{s:28:\"woocommerce_cleanup_sessions\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1532612021;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"e6efeebb30496daebdf12bb7b13dab02\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532611991\";}}}}i:1532612034;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"3167da02a87f6c6c1a5a9c271dc36120\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532612004\";}}}}i:1532612060;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"3bc17c8eb7f180bc07209191e315ccff\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532612030\";}}}}i:1532612064;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"8e2cf9162785406a9829138a77ebd4c9\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532612034\";}}}}i:1532612088;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"7867e4d66c7c2a7123ff2130b8112f28\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532612058\";}}}}i:1532664000;a:1:{s:27:\"woocommerce_scheduled_sales\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1532911537;a:1:{s:30:\"wp_1_wc_regenerate_images_cron\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:39:\"wp_1_wc_regenerate_images_cron_interval\";s:4:\"args\";a:0:{}s:8:\"interval\";i:300;}}}i:1532911815;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"b726399217eaf2fc5d4962d0b86991a5\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911785\";}}}}i:1532911851;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"f635755f17faeb315fd080088c750648\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911821\";}}}}i:1532911852;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"86d5e8e1eff5783f56850978d40d67ba\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911822\";}}}}i:1532911853;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"22fdb0c7c93b76e434edfa140ed245d7\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911823\";}}}}i:1532911856;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"c652ff3f24dc4239f71c29af45a88528\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911826\";}}}}i:1532911857;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"101ceded1cd3d41f63e0f0423de9f618\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911827\";}}}}i:1532911858;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"10b738ad8e900f73f3126223ddbdf928\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911828\";}}}}i:1532911880;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"7c2db280f4a5b9a13d8c08c8e06b5583\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911850\";}}}}i:1532911914;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"67b5e4f1c19975ef413672fb471f0924\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911884\";}}}}i:1532911915;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"8c8e0115c3087cda11c180787a51ff19\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911885\";}}}}i:1532911918;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"6f9ff22cc2c36261ab1a6b34ff8627e6\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911888\";}}}}i:1532911919;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"eceed6e07c8e09fe5a6b8057a5db685a\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911889\";}}}}i:1532911920;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"a3f1560765a008a27ad36d327c1ba5ab\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911890\";}}}}i:1532911950;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"a7d4c532502c9f15dd27bd926ff4b660\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911920\";}}}}i:1532911951;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"ad612bf87f148a89f56923684d15cd35\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911921\";}}}}i:1532911952;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"fc22b7b3313a24b9a82a3576a4c1694e\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911922\";}}}}i:1532911953;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"a3a9f0c36cf4d8325970fcf19ec7ef6b\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911923\";}}}}i:1532911977;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"1da03849ad000b16cadb47dc704f683d\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911947\";}}}}i:1532912020;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"24de285a53509d620c7932a88a4951e6\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911990\";}}}}i:1532912021;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"5baeaeea3cd353c674d078125fca1778\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911991\";}}}}i:1532912022;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"d73da43ad96f508ab38cb204b76eb468\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532911992\";}}}}i:1532912043;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"1324b98785d32ac790decf3cfdd3175e\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912013\";}}}}i:1532912047;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"9be359eaad87e069244e3d80ccb363cb\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912017\";}}}}i:1532912048;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"3231de58c80e8be43c9fd46c129c5965\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912018\";}}}}i:1532912049;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"fb08b1b24e89a868d7d1564933b01331\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912019\";}}}}i:1532912050;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"15a6d56db90db564bad5bc30b857ef50\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912020\";}}}}i:1532912051;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"a2877bf8442d71fc4ea3dd3d9bc65c19\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912021\";}}}}i:1532912060;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"db510584987df00213c236abf08b35aa\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912030\";}}}}i:1532912064;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"e008caadf1bae33626eeba2e941acf98\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912034\";}}}}i:1532912065;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"e205624684dde8df8bcdf342b8c9d00f\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912035\";}}}}i:1532912066;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"f29bc0dae16faa24c34107625bacd5a5\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912036\";}}}}i:1532912067;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"be2d51cdbb52900c2744962fa4b4675d\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912037\";}}}}i:1532912120;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"b9ea142deb53f4cc3b0b04d6f3f205b4\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912090\";}}}}i:1532912121;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"1db4c3d98c1937e6b83bc1dff1139c16\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912091\";}}}}i:1532912122;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"73f89315f8f7cf1ee220c056e5f2d62a\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912092\";}}}}i:1532912123;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"5d89bf1f812c6b4f3d8dec935bbe3937\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912093\";}}}}i:1532912124;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"e4296a99f39849796479e9b131ea3e56\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912094\";}}}}i:1532912125;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"6deb9742513921e86a7448d531a63e41\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912095\";}}}}i:1532912126;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"088715e3ab02e02429bc1bbec31b4a19\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912096\";}}}}i:1532912127;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"b453f7bdccb61c6e18111d29a3551596\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912097\";}}}}i:1532912146;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"977ab46facdb4cdc95c7d112eee5ae8e\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912116\";}}}}i:1532912147;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"7a823102cf35d7ed92cdd495fa3e380e\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912117\";}}}}i:1532912148;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"f5890385afdfae64a6ded90ab4d76064\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912118\";}}}}i:1532912150;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"98058afe8e72b55fd25650ebfa2b3b1f\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912120\";}}}}i:1532912151;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"26a8df3107830042f6d566c1680382c4\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912121\";}}}}i:1532912152;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"7bdc306dfc9aafcab9488b45eb42a6e0\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912122\";}}}}i:1532912239;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"203fb5e400b7b558992945f419db32ed\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912209\";}}}}i:1532912274;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"8211f8abdac2ef7c31368ff53abdfc13\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912244\";}}}}i:1532912275;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"d4256a84f9f2109fbe096cb7e7c40c02\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912245\";}}}}i:1532912296;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"4fe2b545364a8ee693c6937608549832\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912266\";}}}}i:1532912299;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"52c44edbc669fc5c95221c3432aef3ae\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912269\";}}}}i:1532912300;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"34fbb79570c446bc36f74e0283d16dbf\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912270\";}}}}i:1532912302;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"fb117d3af1600202367de98a96e31463\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912272\";}}}}i:1532912303;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"fbea04091a19a7fba8dee1566f88a7e6\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912273\";}}}}i:1532912311;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"35d0dc2930fadb93855417645ea67658\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912281\";}}}}i:1532912312;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"41aebd1361cc149224396df14b929746\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912282\";}}}}i:1532912313;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"53e2ddf11a16110747ff14c89b5f4440\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912283\";}}}}i:1532912314;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"7427b2ee38531e8f1ba6b077741818ba\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912284\";}}}}i:1532912315;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"94174e570117502fbe51c4263699d50b\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912285\";}}}}i:1532912316;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"f12b6af3df438d8e309eaa53d75606a3\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912286\";}}}}i:1532912321;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"cf33fbad57cd2e8513452b9d5b4de967\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912291\";}}}}i:1532912326;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"bff7f2f326e7786006dfa3043562d855\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912296\";}}}}i:1532912330;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"fd49b0a4e4d4d1be763535bda5f4665d\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912300\";}}}}i:1532912331;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"3432225b6bf967cefec4dbd7f1597c60\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912301\";}}}}i:1532912332;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"c92e1d39179a24575258f19d2642a1aa\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912302\";}}}}i:1532912333;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"13dcd8f027006fe926e40f563423b24e\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912303\";}}}}i:1532912345;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"269082d0fb6a30b72a84e11fbb72b612\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912315\";}}}}i:1532912346;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"be136edd968f136f3db790c5699450a3\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912316\";}}}}i:1532912347;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"a6ed58e2694b7f022b2acaa81d0c6477\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912317\";}}}}i:1532912348;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"8f76fa2518d6d7c7521b5a296d5e6ca3\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912318\";}}}}i:1532912349;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"15d1921fe0b1fa1da1d800ad85c08d0e\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912319\";}}}}i:1532912350;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"220ae16b041363e6c028a29d010b10c3\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912320\";}}}}i:1532912351;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"0ca0deda39e2f036259c2f5565df6f01\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912321\";}}}}i:1532912352;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"44b81b497e35c6d7b16aa8eb6cd241d3\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912322\";}}}}i:1532912355;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"eca669c72fb5dceb984f5125446900c1\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912325\";}}}}i:1532912356;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"2fccc4d40ed738a1de8c41b1f422b0c7\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912326\";}}}}i:1532912357;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"20fdf46784724593fbbba5e4b260d5ec\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912327\";}}}}i:1532912358;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"e2e5c69ea8d9699b4195b9f47b4be340\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912328\";}}}}i:1532912359;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"cdf83dd9786acc24e4b093c708a0f77c\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912329\";}}}}i:1532912360;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"aced1644f6ecc44389953d492d9c42df\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912330\";}}}}i:1532912361;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"38a891652af5c0da167ed40f2c21107d\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912331\";}}}}i:1532912419;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"e1b5f6d9405fd7c1e79845dfce0802d7\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912389\";}}}}i:1532912421;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"62646d8f220fbc4b9da81e1de3d81f63\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912391\";}}}}i:1532912422;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"d66442a9c7c1fbc22e28bbb4769d2cab\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912392\";}}}}i:1532912423;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"3f4bff9b3abc0b916f6889373672c342\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912393\";}}}}i:1532912424;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"dac56baf9ca0b06b3661085fb0bcd913\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912394\";}}}}i:1532912425;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"b56ce8d8f58d6f04d505b8617b6ec17d\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912395\";}}}}i:1532912426;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"3d0d2ab19b80d305175fda07ee8b81e2\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912396\";}}}}i:1532912427;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"ebe57ac9f16ea7e6de103df1d9b51d46\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912397\";}}}}i:1532912433;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"b0040a27aa4bca99eb13b916e2efb2a6\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912403\";}}}}i:1532912434;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"345db446953ce0a06a0d4639a4ada4ae\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912404\";}}}}i:1532912435;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"93a737900d07b46e9bcd3236fc70b561\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912405\";}}}}i:1532912436;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"17413a01d3fa72f666b2045d96a5b7eb\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912406\";}}}}i:1532912437;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"f8fa088a418c6ef3fad6a9c60802eb5b\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912407\";}}}}i:1532912438;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"ac4388caec28f3655c3747f76f90fcdd\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912408\";}}}}i:1532912473;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"63ae2a9e3c237d604c411b4adca0c886\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912443\";}}}}i:1532912503;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"928cc1597e5072fef729430527243582\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912473\";}}}}i:1532912504;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"2ad3f35f667b8df4262ad24e049e38dc\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912474\";}}}}i:1532912507;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"31750be59137e6e9854873c789c4b992\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912477\";}}}}i:1532912508;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"c8314b97ca6de32b7e333a2ca79b08e2\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912478\";}}}}i:1532912509;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"a57f3b36f75ee61aae7ef7604bd3b665\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912479\";}}}}i:1532912510;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"924760d18510d7afc47de4465eb0215e\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912480\";}}}}i:1532912521;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"fd05868defe80e177bdf834a9f428149\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912491\";}}}}i:1532912522;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"b8181ecf279f9f9ab090802301465e0d\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912492\";}}}}i:1532912603;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"b072620d3b5d7a6a25ef166e1e9c7948\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912573\";}}}}i:1532912606;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"ef8de3dfa6790dccd2752c7dfb0fb336\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912576\";}}}}i:1532912607;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"5fe3f622915e13764cd65c69f80e6daf\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912577\";}}}}i:1532912608;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"c90dfde2c62451617aa9cc371177c83a\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912578\";}}}}i:1532912609;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"e128c0cbd76a4cc6809b2e0fc57d77b6\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912579\";}}}}i:1532912634;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"aa2698313d2eee8090b3c950981fc2a1\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912604\";}}}}i:1532912726;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"32ac9ae4cab63eda381118993d0e7dca\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912696\";}}}}i:1532912727;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"1ac9bc9606ce319f99a60a28a42e2b36\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912697\";}}}}i:1532912728;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"5fda0dae8d8b5179d90b824f46315005\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912698\";}}}}i:1532912762;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"918fc7eb56fb8480ce7e339123113663\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912732\";}}}}i:1532912766;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"ef9dee5f3c324745a185e909a498a2f6\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912736\";}}}}i:1532912767;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"c1d0c5ba9b738f5ce9d595a83a5536ac\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912737\";}}}}i:1532912769;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"d231dfccde5a8c7e64d18b4b75ebd28c\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912739\";}}}}i:1532912770;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"d390772b3638784cf1d6cb3d27cec37d\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912740\";}}}}i:1532912775;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"087e00209b9e53789d50ba6eaa41f18a\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912745\";}}}}i:1532912778;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"38615828055eaa89d8854b3532b60ca1\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912748\";}}}}i:1532912779;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"91246f9d9e7ff9ff2a896decb16f8400\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912749\";}}}}i:1532912780;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"5fa54b94e9546790dfb15efee5b60869\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912750\";}}}}i:1532912781;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"28704ed2a2336f3749f5f9366d280fc6\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912751\";}}}}i:1532912827;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"8dc443c9696630fd6f9b8ebdecba4e38\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912797\";}}}}i:1532912828;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"1f52a2e0818157892de19d5c58192aa6\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912798\";}}}}i:1532912829;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"10ef67771c032ac79d83788de099ed39\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912799\";}}}}i:1532912830;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"74e3c5c039db2b4f860707a8b12d3471\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912800\";}}}}i:1532912831;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"3df0e013de9aa5800f1737bf1df337d5\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912801\";}}}}i:1532912832;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"0e126742592d25944bb01537b938c6c9\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912802\";}}}}i:1532912833;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"b2f83bf5f16fe72b20cc83a08e3934ec\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912803\";}}}}i:1532912834;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"27c8b5715d166fbe9d15c9a92dc4e7ae\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912804\";}}}}i:1532912843;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"931a1d53224e433bb89b8ff1fa77041f\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912813\";}}}}i:1532912844;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"c0dc4c73e98d47792b6be685fafdda6d\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912814\";}}}}i:1532912845;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"1a10af8a31a306d5b9bb8bb687659e97\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912815\";}}}}i:1532912846;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"24e6d0922e3d6ca2e7908b37237a6233\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912816\";}}}}i:1532912847;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"733f8d51b687453ba89735e631cd18a3\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912817\";}}}}i:1532912864;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"82a44df036dfca529be1ef6a39e92d65\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912834\";}}}}i:1532912865;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"8a466f5cb81ecbb04c7ca12057c1f7c4\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912835\";}}}}i:1532912935;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"e496b16119ad8f874c88a85a424622b4\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912905\";}}}}i:1532912936;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"620c3c99877aad9483264d8cd0b3341c\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912906\";}}}}i:1532912940;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"8cf730f04a4b146de8eb34866fbd918a\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912910\";}}}}i:1532912941;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"b3e6314895007f4ab614e483827149b5\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912911\";}}}}i:1532912942;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"1d2abaf8ba59c7281603018556c1de04\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912912\";}}}}i:1532912954;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"d9ddd6c73ac7521d013d6a7277fd50ff\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912924\";}}}}i:1532912955;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"045f0b0a0b9474a97286b46329da0cbb\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912925\";}}}}i:1532912956;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"055a7423af5ae21a7fcd48cc43609b41\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912926\";}}}}i:1532912957;a:1:{s:25:\"delete_version_transients\";a:1:{s:32:\"94aaa9e380efc4320ed8931f70c9a90f\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;s:10:\"1532912927\";}}}}i:1533600000;a:1:{s:25:\"woocommerce_geoip_updater\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:7:\"monthly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:2635200;}}}s:7:\"version\";i:2;}','yes'),(111,'_transient_doing_cron','1533104967.1372420787811279296875','yes'),(113,'_site_transient_update_plugins','O:8:\"stdClass\":4:{s:12:\"last_checked\";i:1533104859;s:8:\"response\";a:1:{s:23:\"elementor/elementor.php\";O:8:\"stdClass\":12:{s:2:\"id\";s:23:\"w.org/plugins/elementor\";s:4:\"slug\";s:9:\"elementor\";s:6:\"plugin\";s:23:\"elementor/elementor.php\";s:11:\"new_version\";s:5:\"2.1.6\";s:3:\"url\";s:40:\"https://wordpress.org/plugins/elementor/\";s:7:\"package\";s:58:\"https://downloads.wordpress.org/plugin/elementor.2.1.6.zip\";s:5:\"icons\";a:3:{s:2:\"2x\";s:62:\"https://ps.w.org/elementor/assets/icon-256x256.png?rev=1427768\";s:2:\"1x\";s:54:\"https://ps.w.org/elementor/assets/icon.svg?rev=1426809\";s:3:\"svg\";s:54:\"https://ps.w.org/elementor/assets/icon.svg?rev=1426809\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:65:\"https://ps.w.org/elementor/assets/banner-1544x500.png?rev=1475479\";s:2:\"1x\";s:64:\"https://ps.w.org/elementor/assets/banner-772x250.png?rev=1475479\";}s:11:\"banners_rtl\";a:0:{}s:6:\"tested\";s:5:\"4.9.7\";s:12:\"requires_php\";s:3:\"5.4\";s:13:\"compatibility\";O:8:\"stdClass\":0:{}}}s:12:\"translations\";a:0:{}s:9:\"no_update\";a:19:{s:30:\"advanced-custom-fields/acf.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:36:\"w.org/plugins/advanced-custom-fields\";s:4:\"slug\";s:22:\"advanced-custom-fields\";s:6:\"plugin\";s:30:\"advanced-custom-fields/acf.php\";s:11:\"new_version\";s:6:\"4.4.12\";s:3:\"url\";s:53:\"https://wordpress.org/plugins/advanced-custom-fields/\";s:7:\"package\";s:72:\"https://downloads.wordpress.org/plugin/advanced-custom-fields.4.4.12.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:75:\"https://ps.w.org/advanced-custom-fields/assets/icon-256x256.png?rev=1082746\";s:2:\"1x\";s:75:\"https://ps.w.org/advanced-custom-fields/assets/icon-128x128.png?rev=1082746\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:78:\"https://ps.w.org/advanced-custom-fields/assets/banner-1544x500.jpg?rev=1729099\";s:2:\"1x\";s:77:\"https://ps.w.org/advanced-custom-fields/assets/banner-772x250.jpg?rev=1729102\";}s:11:\"banners_rtl\";a:0:{}}s:19:\"akismet/akismet.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:21:\"w.org/plugins/akismet\";s:4:\"slug\";s:7:\"akismet\";s:6:\"plugin\";s:19:\"akismet/akismet.php\";s:11:\"new_version\";s:5:\"4.0.8\";s:3:\"url\";s:38:\"https://wordpress.org/plugins/akismet/\";s:7:\"package\";s:56:\"https://downloads.wordpress.org/plugin/akismet.4.0.8.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:59:\"https://ps.w.org/akismet/assets/icon-256x256.png?rev=969272\";s:2:\"1x\";s:59:\"https://ps.w.org/akismet/assets/icon-128x128.png?rev=969272\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:61:\"https://ps.w.org/akismet/assets/banner-772x250.jpg?rev=479904\";}s:11:\"banners_rtl\";a:0:{}}s:27:\"astra-sites/astra-sites.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:25:\"w.org/plugins/astra-sites\";s:4:\"slug\";s:11:\"astra-sites\";s:6:\"plugin\";s:27:\"astra-sites/astra-sites.php\";s:11:\"new_version\";s:5:\"1.2.7\";s:3:\"url\";s:42:\"https://wordpress.org/plugins/astra-sites/\";s:7:\"package\";s:60:\"https://downloads.wordpress.org/plugin/astra-sites.1.2.7.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:64:\"https://ps.w.org/astra-sites/assets/icon-256x256.jpg?rev=1712437\";s:2:\"1x\";s:64:\"https://ps.w.org/astra-sites/assets/icon-128x128.jpg?rev=1712437\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:67:\"https://ps.w.org/astra-sites/assets/banner-1544x500.jpg?rev=1712437\";s:2:\"1x\";s:66:\"https://ps.w.org/astra-sites/assets/banner-772x250.jpg?rev=1712437\";}s:11:\"banners_rtl\";a:0:{}}s:36:\"contact-form-7/wp-contact-form-7.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:28:\"w.org/plugins/contact-form-7\";s:4:\"slug\";s:14:\"contact-form-7\";s:6:\"plugin\";s:36:\"contact-form-7/wp-contact-form-7.php\";s:11:\"new_version\";s:5:\"5.0.3\";s:3:\"url\";s:45:\"https://wordpress.org/plugins/contact-form-7/\";s:7:\"package\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.5.0.3.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:66:\"https://ps.w.org/contact-form-7/assets/icon-256x256.png?rev=984007\";s:2:\"1x\";s:66:\"https://ps.w.org/contact-form-7/assets/icon-128x128.png?rev=984007\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:69:\"https://ps.w.org/contact-form-7/assets/banner-1544x500.png?rev=860901\";s:2:\"1x\";s:68:\"https://ps.w.org/contact-form-7/assets/banner-772x250.png?rev=880427\";}s:11:\"banners_rtl\";a:0:{}}s:60:\"cf7-conditional-fields/contact-form-7-conditional-fields.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:36:\"w.org/plugins/cf7-conditional-fields\";s:4:\"slug\";s:22:\"cf7-conditional-fields\";s:6:\"plugin\";s:60:\"cf7-conditional-fields/contact-form-7-conditional-fields.php\";s:11:\"new_version\";s:5:\"1.3.4\";s:3:\"url\";s:53:\"https://wordpress.org/plugins/cf7-conditional-fields/\";s:7:\"package\";s:71:\"https://downloads.wordpress.org/plugin/cf7-conditional-fields.1.3.4.zip\";s:5:\"icons\";a:1:{s:2:\"1x\";s:75:\"https://ps.w.org/cf7-conditional-fields/assets/icon-128x128.png?rev=1429242\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:77:\"https://ps.w.org/cf7-conditional-fields/assets/banner-772x250.png?rev=1429242\";}s:11:\"banners_rtl\";a:0:{}}s:33:\"wpcf7-redirect/wpcf7-redirect.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:28:\"w.org/plugins/wpcf7-redirect\";s:4:\"slug\";s:14:\"wpcf7-redirect\";s:6:\"plugin\";s:33:\"wpcf7-redirect/wpcf7-redirect.php\";s:11:\"new_version\";s:5:\"1.2.7\";s:3:\"url\";s:45:\"https://wordpress.org/plugins/wpcf7-redirect/\";s:7:\"package\";s:57:\"https://downloads.wordpress.org/plugin/wpcf7-redirect.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:67:\"https://ps.w.org/wpcf7-redirect/assets/icon-256x256.png?rev=1732522\";s:2:\"1x\";s:67:\"https://ps.w.org/wpcf7-redirect/assets/icon-128x128.png?rev=1732522\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:70:\"https://ps.w.org/wpcf7-redirect/assets/banner-1544x500.png?rev=1734873\";s:2:\"1x\";s:69:\"https://ps.w.org/wpcf7-redirect/assets/banner-772x250.png?rev=1734873\";}s:11:\"banners_rtl\";a:0:{}}s:43:\"custom-post-type-ui/custom-post-type-ui.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:33:\"w.org/plugins/custom-post-type-ui\";s:4:\"slug\";s:19:\"custom-post-type-ui\";s:6:\"plugin\";s:43:\"custom-post-type-ui/custom-post-type-ui.php\";s:11:\"new_version\";s:5:\"1.5.8\";s:3:\"url\";s:50:\"https://wordpress.org/plugins/custom-post-type-ui/\";s:7:\"package\";s:68:\"https://downloads.wordpress.org/plugin/custom-post-type-ui.1.5.8.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:72:\"https://ps.w.org/custom-post-type-ui/assets/icon-256x256.png?rev=1069557\";s:2:\"1x\";s:72:\"https://ps.w.org/custom-post-type-ui/assets/icon-128x128.png?rev=1069557\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:75:\"https://ps.w.org/custom-post-type-ui/assets/banner-1544x500.png?rev=1069557\";s:2:\"1x\";s:74:\"https://ps.w.org/custom-post-type-ui/assets/banner-772x250.png?rev=1069557\";}s:11:\"banners_rtl\";a:0:{}}s:32:\"emoji-settings/emojisettings.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:28:\"w.org/plugins/emoji-settings\";s:4:\"slug\";s:14:\"emoji-settings\";s:6:\"plugin\";s:32:\"emoji-settings/emojisettings.php\";s:11:\"new_version\";s:5:\"1.1.1\";s:3:\"url\";s:45:\"https://wordpress.org/plugins/emoji-settings/\";s:7:\"package\";s:63:\"https://downloads.wordpress.org/plugin/emoji-settings.1.1.1.zip\";s:5:\"icons\";a:1:{s:7:\"default\";s:65:\"https://s.w.org/plugins/geopattern-icon/emoji-settings_eed0ce.svg\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:69:\"https://ps.w.org/emoji-settings/assets/banner-772x250.jpg?rev=1194688\";}s:11:\"banners_rtl\";a:0:{}}s:21:\"flamingo/flamingo.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:22:\"w.org/plugins/flamingo\";s:4:\"slug\";s:8:\"flamingo\";s:6:\"plugin\";s:21:\"flamingo/flamingo.php\";s:11:\"new_version\";s:3:\"1.8\";s:3:\"url\";s:39:\"https://wordpress.org/plugins/flamingo/\";s:7:\"package\";s:55:\"https://downloads.wordpress.org/plugin/flamingo.1.8.zip\";s:5:\"icons\";a:1:{s:2:\"1x\";s:61:\"https://ps.w.org/flamingo/assets/icon-128x128.png?rev=1540977\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:62:\"https://ps.w.org/flamingo/assets/banner-772x250.png?rev=544829\";}s:11:\"banners_rtl\";a:0:{}}s:43:\"google-analytics-dashboard-for-wp/gadwp.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:47:\"w.org/plugins/google-analytics-dashboard-for-wp\";s:4:\"slug\";s:33:\"google-analytics-dashboard-for-wp\";s:6:\"plugin\";s:43:\"google-analytics-dashboard-for-wp/gadwp.php\";s:11:\"new_version\";s:5:\"5.3.5\";s:3:\"url\";s:64:\"https://wordpress.org/plugins/google-analytics-dashboard-for-wp/\";s:7:\"package\";s:82:\"https://downloads.wordpress.org/plugin/google-analytics-dashboard-for-wp.5.3.5.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:85:\"https://ps.w.org/google-analytics-dashboard-for-wp/assets/icon-256x256.png?rev=970326\";s:2:\"1x\";s:85:\"https://ps.w.org/google-analytics-dashboard-for-wp/assets/icon-128x128.png?rev=970326\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:88:\"https://ps.w.org/google-analytics-dashboard-for-wp/assets/banner-772x250.png?rev=1064664\";}s:11:\"banners_rtl\";a:0:{}}s:19:\"members/members.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:21:\"w.org/plugins/members\";s:4:\"slug\";s:7:\"members\";s:6:\"plugin\";s:19:\"members/members.php\";s:11:\"new_version\";s:5:\"2.1.0\";s:3:\"url\";s:38:\"https://wordpress.org/plugins/members/\";s:7:\"package\";s:56:\"https://downloads.wordpress.org/plugin/members.2.1.0.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:60:\"https://ps.w.org/members/assets/icon-256x256.png?rev=1242689\";s:2:\"1x\";s:60:\"https://ps.w.org/members/assets/icon-128x128.png?rev=1242689\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:63:\"https://ps.w.org/members/assets/banner-1544x500.png?rev=1242689\";s:2:\"1x\";s:62:\"https://ps.w.org/members/assets/banner-772x250.png?rev=1242689\";}s:11:\"banners_rtl\";a:0:{}}s:34:\"minify-html-markup/minify-html.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:32:\"w.org/plugins/minify-html-markup\";s:4:\"slug\";s:18:\"minify-html-markup\";s:6:\"plugin\";s:34:\"minify-html-markup/minify-html.php\";s:11:\"new_version\";s:4:\"1.99\";s:3:\"url\";s:49:\"https://wordpress.org/plugins/minify-html-markup/\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/plugin/minify-html-markup.zip\";s:5:\"icons\";a:1:{s:2:\"1x\";s:71:\"https://ps.w.org/minify-html-markup/assets/icon-128x128.png?rev=1354357\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:74:\"https://ps.w.org/minify-html-markup/assets/banner-1544x500.png?rev=1354339\";s:2:\"1x\";s:73:\"https://ps.w.org/minify-html-markup/assets/banner-772x250.png?rev=1354339\";}s:11:\"banners_rtl\";a:0:{}}s:51:\"restaurant-reservations/restaurant-reservations.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:37:\"w.org/plugins/restaurant-reservations\";s:4:\"slug\";s:23:\"restaurant-reservations\";s:6:\"plugin\";s:51:\"restaurant-reservations/restaurant-reservations.php\";s:11:\"new_version\";s:5:\"1.7.7\";s:3:\"url\";s:54:\"https://wordpress.org/plugins/restaurant-reservations/\";s:7:\"package\";s:72:\"https://downloads.wordpress.org/plugin/restaurant-reservations.1.7.7.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:75:\"https://ps.w.org/restaurant-reservations/assets/icon-256x256.png?rev=975736\";s:2:\"1x\";s:75:\"https://ps.w.org/restaurant-reservations/assets/icon-128x128.png?rev=975736\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:78:\"https://ps.w.org/restaurant-reservations/assets/banner-1544x500.png?rev=910307\";s:2:\"1x\";s:77:\"https://ps.w.org/restaurant-reservations/assets/banner-772x250.png?rev=910307\";}s:11:\"banners_rtl\";a:0:{}}s:48:\"simple-301-redirects/wp-simple-301-redirects.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:34:\"w.org/plugins/simple-301-redirects\";s:4:\"slug\";s:20:\"simple-301-redirects\";s:6:\"plugin\";s:48:\"simple-301-redirects/wp-simple-301-redirects.php\";s:11:\"new_version\";s:4:\"1.07\";s:3:\"url\";s:51:\"https://wordpress.org/plugins/simple-301-redirects/\";s:7:\"package\";s:68:\"https://downloads.wordpress.org/plugin/simple-301-redirects.1.07.zip\";s:5:\"icons\";a:1:{s:7:\"default\";s:64:\"https://s.w.org/plugins/geopattern-icon/simple-301-redirects.svg\";}s:7:\"banners\";a:0:{}s:11:\"banners_rtl\";a:0:{}}s:27:\"woocommerce/woocommerce.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:25:\"w.org/plugins/woocommerce\";s:4:\"slug\";s:11:\"woocommerce\";s:6:\"plugin\";s:27:\"woocommerce/woocommerce.php\";s:11:\"new_version\";s:5:\"3.4.4\";s:3:\"url\";s:42:\"https://wordpress.org/plugins/woocommerce/\";s:7:\"package\";s:60:\"https://downloads.wordpress.org/plugin/woocommerce.3.4.4.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:64:\"https://ps.w.org/woocommerce/assets/icon-256x256.png?rev=1440831\";s:2:\"1x\";s:64:\"https://ps.w.org/woocommerce/assets/icon-128x128.png?rev=1440831\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:67:\"https://ps.w.org/woocommerce/assets/banner-1544x500.png?rev=1629184\";s:2:\"1x\";s:66:\"https://ps.w.org/woocommerce/assets/banner-772x250.png?rev=1629184\";}s:11:\"banners_rtl\";a:0:{}}s:41:\"wordpress-importer/wordpress-importer.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:32:\"w.org/plugins/wordpress-importer\";s:4:\"slug\";s:18:\"wordpress-importer\";s:6:\"plugin\";s:41:\"wordpress-importer/wordpress-importer.php\";s:11:\"new_version\";s:5:\"0.6.4\";s:3:\"url\";s:49:\"https://wordpress.org/plugins/wordpress-importer/\";s:7:\"package\";s:67:\"https://downloads.wordpress.org/plugin/wordpress-importer.0.6.4.zip\";s:5:\"icons\";a:3:{s:2:\"2x\";s:71:\"https://ps.w.org/wordpress-importer/assets/icon-256x256.png?rev=1908375\";s:2:\"1x\";s:63:\"https://ps.w.org/wordpress-importer/assets/icon.svg?rev=1908375\";s:3:\"svg\";s:63:\"https://ps.w.org/wordpress-importer/assets/icon.svg?rev=1908375\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:72:\"https://ps.w.org/wordpress-importer/assets/banner-772x250.png?rev=547654\";}s:11:\"banners_rtl\";a:0:{}}s:31:\"wp-email-smtp/wp_email_smtp.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:27:\"w.org/plugins/wp-email-smtp\";s:4:\"slug\";s:13:\"wp-email-smtp\";s:6:\"plugin\";s:31:\"wp-email-smtp/wp_email_smtp.php\";s:11:\"new_version\";s:5:\"1.0.5\";s:3:\"url\";s:44:\"https://wordpress.org/plugins/wp-email-smtp/\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/plugin/wp-email-smtp.1.0.5.zip\";s:5:\"icons\";a:1:{s:2:\"1x\";s:66:\"https://ps.w.org/wp-email-smtp/assets/icon-128x128.png?rev=1498643\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:69:\"https://ps.w.org/wp-email-smtp/assets/banner-1544x500.png?rev=1498626\";s:2:\"1x\";s:68:\"https://ps.w.org/wp-email-smtp/assets/banner-772x250.png?rev=1498625\";}s:11:\"banners_rtl\";a:0:{}}s:33:\"wps-hide-login/wps-hide-login.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:28:\"w.org/plugins/wps-hide-login\";s:4:\"slug\";s:14:\"wps-hide-login\";s:6:\"plugin\";s:33:\"wps-hide-login/wps-hide-login.php\";s:11:\"new_version\";s:5:\"1.4.3\";s:3:\"url\";s:45:\"https://wordpress.org/plugins/wps-hide-login/\";s:7:\"package\";s:63:\"https://downloads.wordpress.org/plugin/wps-hide-login.1.4.3.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:67:\"https://ps.w.org/wps-hide-login/assets/icon-256x256.png?rev=1820667\";s:2:\"1x\";s:67:\"https://ps.w.org/wps-hide-login/assets/icon-128x128.png?rev=1820667\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:70:\"https://ps.w.org/wps-hide-login/assets/banner-1544x500.jpg?rev=1820667\";s:2:\"1x\";s:69:\"https://ps.w.org/wps-hide-login/assets/banner-772x250.jpg?rev=1820667\";}s:11:\"banners_rtl\";a:0:{}}s:24:\"wordpress-seo/wp-seo.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:27:\"w.org/plugins/wordpress-seo\";s:4:\"slug\";s:13:\"wordpress-seo\";s:6:\"plugin\";s:24:\"wordpress-seo/wp-seo.php\";s:11:\"new_version\";s:3:\"7.9\";s:3:\"url\";s:44:\"https://wordpress.org/plugins/wordpress-seo/\";s:7:\"package\";s:60:\"https://downloads.wordpress.org/plugin/wordpress-seo.7.9.zip\";s:5:\"icons\";a:3:{s:2:\"2x\";s:66:\"https://ps.w.org/wordpress-seo/assets/icon-256x256.png?rev=1834347\";s:2:\"1x\";s:58:\"https://ps.w.org/wordpress-seo/assets/icon.svg?rev=1859687\";s:3:\"svg\";s:58:\"https://ps.w.org/wordpress-seo/assets/icon.svg?rev=1859687\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:69:\"https://ps.w.org/wordpress-seo/assets/banner-1544x500.png?rev=1843435\";s:2:\"1x\";s:68:\"https://ps.w.org/wordpress-seo/assets/banner-772x250.png?rev=1843435\";}s:11:\"banners_rtl\";a:2:{s:2:\"2x\";s:73:\"https://ps.w.org/wordpress-seo/assets/banner-1544x500-rtl.png?rev=1843435\";s:2:\"1x\";s:72:\"https://ps.w.org/wordpress-seo/assets/banner-772x250-rtl.png?rev=1843435\";}}}}','no'),(116,'_site_transient_update_themes','O:8:\"stdClass\":4:{s:12:\"last_checked\";i:1533104860;s:7:\"checked\";a:2:{s:5:\"astra\";s:5:\"1.4.1\";s:15:\"twentyseventeen\";s:3:\"1.6\";}s:8:\"response\";a:1:{s:5:\"astra\";a:4:{s:5:\"theme\";s:5:\"astra\";s:11:\"new_version\";s:5:\"1.4.5\";s:3:\"url\";s:35:\"https://wordpress.org/themes/astra/\";s:7:\"package\";s:53:\"https://downloads.wordpress.org/theme/astra.1.4.5.zip\";}}s:12:\"translations\";a:0:{}}','no'),(131,'can_compress_scripts','1','no'),(132,'theme_mods_twentyseventeen','a:1:{s:16:\"sidebars_widgets\";a:2:{s:4:\"time\";i:1527454426;s:4:\"data\";a:4:{s:19:\"wp_inactive_widgets\";a:0:{}s:9:\"sidebar-1\";a:6:{i:0;s:8:\"search-2\";i:1;s:14:\"recent-posts-2\";i:2;s:17:\"recent-comments-2\";i:3;s:10:\"archives-2\";i:4;s:12:\"categories-2\";i:5;s:6:\"meta-2\";}s:9:\"sidebar-2\";a:0:{}s:9:\"sidebar-3\";a:0:{}}}}','yes'),(133,'current_theme','Astra','yes'),(134,'theme_mods_astra','a:3:{i:0;b:0;s:18:\"nav_menu_locations\";a:1:{s:7:\"primary\";i:2;}s:18:\"custom_css_post_id\";i:-1;}','yes'),(135,'theme_switched','','yes'),(136,'astra-settings','a:5:{s:18:\"theme-auto-version\";s:5:\"1.4.1\";s:19:\"site-sidebar-layout\";s:10:\"no-sidebar\";s:27:\"footer-sml-section-1-credit\";s:40:\"Copyright © [current_year] [site_title]\";s:30:\"mobile-header-toggle-btn-style\";s:4:\"fill\";s:23:\"hide-custom-menu-mobile\";i:0;}','yes'),(138,'_transient_timeout_plugin_slugs','1532668485','no'),(139,'_transient_plugin_slugs','a:23:{i:0;s:30:\"advanced-custom-fields/acf.php\";i:1;s:19:\"akismet/akismet.php\";i:2;s:27:\"astra-sites/astra-sites.php\";i:3;s:37:\"bistro-solutions/bistro-solutions.php\";i:4;s:43:\"bistro-solutions-wc/bistro-solutions-wc.php\";i:5;s:36:\"contact-form-7/wp-contact-form-7.php\";i:6;s:60:\"cf7-conditional-fields/contact-form-7-conditional-fields.php\";i:7;s:33:\"wpcf7-redirect/wpcf7-redirect.php\";i:8;s:43:\"custom-post-type-ui/custom-post-type-ui.php\";i:9;s:23:\"elementor/elementor.php\";i:10;s:31:\"elementor-pro/elementor-pro.php\";i:11;s:32:\"emoji-settings/emojisettings.php\";i:12;s:21:\"flamingo/flamingo.php\";i:13;s:43:\"google-analytics-dashboard-for-wp/gadwp.php\";i:14;s:19:\"members/members.php\";i:15;s:34:\"minify-html-markup/minify-html.php\";i:16;s:51:\"restaurant-reservations/restaurant-reservations.php\";i:17;s:48:\"simple-301-redirects/wp-simple-301-redirects.php\";i:18;s:27:\"woocommerce/woocommerce.php\";i:19;s:41:\"wordpress-importer/wordpress-importer.php\";i:20;s:31:\"wp-email-smtp/wp_email_smtp.php\";i:21;s:33:\"wps-hide-login/wps-hide-login.php\";i:22;s:24:\"wordpress-seo/wp-seo.php\";}','no'),(140,'recently_activated','a:0:{}','yes'),(145,'WPLANG','','yes'),(146,'new_admin_email','admin@domain.com','yes'),(154,'nav_menu_options','a:2:{i:0;b:0;s:8:\"auto_add\";a:0:{}}','yes'),(163,'_site_transient_update_core','O:8:\"stdClass\":4:{s:7:\"updates\";a:1:{i:0;O:8:\"stdClass\":10:{s:8:\"response\";s:6:\"latest\";s:8:\"download\";s:59:\"https://downloads.wordpress.org/release/wordpress-4.9.7.zip\";s:6:\"locale\";s:5:\"en_US\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:59:\"https://downloads.wordpress.org/release/wordpress-4.9.7.zip\";s:10:\"no_content\";s:70:\"https://downloads.wordpress.org/release/wordpress-4.9.7-no-content.zip\";s:11:\"new_bundled\";s:71:\"https://downloads.wordpress.org/release/wordpress-4.9.7-new-bundled.zip\";s:7:\"partial\";b:0;s:8:\"rollback\";b:0;}s:7:\"current\";s:5:\"4.9.7\";s:7:\"version\";s:5:\"4.9.7\";s:11:\"php_version\";s:5:\"5.2.4\";s:13:\"mysql_version\";s:3:\"5.0\";s:11:\"new_bundled\";s:3:\"4.7\";s:15:\"partial_version\";s:0:\"\";}}s:12:\"last_checked\";i:1533104859;s:15:\"version_checked\";s:5:\"4.9.7\";s:12:\"translations\";a:0:{}}','no'),(166,'_site_transient_timeout_browser_eb23ac3a78f591ce5e88aca6638bf9b5','1533185846','no'),(167,'_site_transient_browser_eb23ac3a78f591ce5e88aca6638bf9b5','a:10:{s:4:\"name\";s:6:\"Chrome\";s:7:\"version\";s:12:\"67.0.3396.99\";s:8:\"platform\";s:9:\"Macintosh\";s:10:\"update_url\";s:29:\"https://www.google.com/chrome\";s:7:\"img_src\";s:43:\"http://s.w.org/images/browsers/chrome.png?1\";s:11:\"img_src_ssl\";s:44:\"https://s.w.org/images/browsers/chrome.png?1\";s:15:\"current_version\";s:2:\"18\";s:7:\"upgrade\";b:0;s:8:\"insecure\";b:0;s:6:\"mobile\";b:0;}','no'),(170,'woocommerce_store_address','Business Name','yes'),(171,'woocommerce_store_address_2','Address Line','yes'),(172,'woocommerce_store_city','Saratoga Springs','yes'),(173,'woocommerce_default_country','US:NY','yes'),(174,'woocommerce_store_postcode','12866','yes'),(175,'woocommerce_allowed_countries','specific','yes'),(176,'woocommerce_all_except_countries','a:0:{}','yes'),(177,'woocommerce_specific_allowed_countries','a:1:{i:0;s:2:\"US\";}','yes'),(178,'woocommerce_ship_to_countries','specific','yes'),(179,'woocommerce_specific_ship_to_countries','a:1:{i:0;s:2:\"US\";}','yes'),(180,'woocommerce_default_customer_address','geolocation','yes'),(181,'woocommerce_calc_taxes','no','yes'),(182,'woocommerce_enable_coupons','yes','yes'),(183,'woocommerce_calc_discounts_sequentially','no','no'),(184,'woocommerce_currency','USD','yes'),(185,'woocommerce_currency_pos','left','yes'),(186,'woocommerce_price_thousand_sep',',','yes'),(187,'woocommerce_price_decimal_sep','.','yes'),(188,'woocommerce_price_num_decimals','2','yes'),(189,'woocommerce_shop_page_id','17','yes'),(190,'woocommerce_cart_redirect_after_add','no','yes'),(191,'woocommerce_enable_ajax_add_to_cart','yes','yes'),(192,'woocommerce_weight_unit','lbs','yes'),(193,'woocommerce_dimension_unit','in','yes'),(194,'woocommerce_enable_reviews','yes','yes'),(195,'woocommerce_review_rating_verification_label','no','no'),(196,'woocommerce_review_rating_verification_required','no','no'),(197,'woocommerce_enable_review_rating','no','yes'),(198,'woocommerce_review_rating_required','yes','no'),(199,'woocommerce_manage_stock','yes','yes'),(200,'woocommerce_hold_stock_minutes','60','no'),(201,'woocommerce_notify_low_stock','yes','no'),(202,'woocommerce_notify_no_stock','yes','no'),(203,'woocommerce_stock_email_recipient','admin@domain.com','no'),(204,'woocommerce_notify_low_stock_amount','2','no'),(205,'woocommerce_notify_no_stock_amount','0','yes'),(206,'woocommerce_hide_out_of_stock_items','yes','yes'),(207,'woocommerce_stock_format','no_amount','yes'),(208,'woocommerce_file_download_method','force','no'),(209,'woocommerce_downloads_require_login','yes','no'),(210,'woocommerce_downloads_grant_access_after_payment','yes','no'),(211,'woocommerce_prices_include_tax','no','yes'),(212,'woocommerce_tax_based_on','shipping','yes'),(213,'woocommerce_shipping_tax_class','inherit','yes'),(214,'woocommerce_tax_round_at_subtotal','no','yes'),(215,'woocommerce_tax_classes','Reduced rate\nZero rate','yes'),(216,'woocommerce_tax_display_shop','excl','yes'),(217,'woocommerce_tax_display_cart','excl','yes'),(218,'woocommerce_price_display_suffix','','yes'),(219,'woocommerce_tax_total_display','itemized','no'),(220,'woocommerce_enable_shipping_calc','no','no'),(221,'woocommerce_shipping_cost_requires_address','no','yes'),(222,'woocommerce_ship_to_destination','billing','no'),(223,'woocommerce_shipping_debug_mode','no','yes'),(224,'woocommerce_enable_guest_checkout','yes','no'),(225,'woocommerce_enable_checkout_login_reminder','yes','no'),(226,'woocommerce_enable_signup_and_login_from_checkout','yes','no'),(227,'woocommerce_enable_myaccount_registration','no','no'),(228,'woocommerce_registration_generate_username','yes','no'),(229,'woocommerce_registration_generate_password','yes','no'),(230,'woocommerce_erasure_request_removes_order_data','no','no'),(231,'woocommerce_erasure_request_removes_download_data','no','no'),(232,'woocommerce_registration_privacy_policy_text','Your personal data will be used to support your experience throughout this website, to manage access to your account, and for other purposes described in our [privacy_policy].','yes'),(233,'woocommerce_checkout_privacy_policy_text','Your personal data will be used to process your order, support your experience throughout this website, and for other purposes described in our [privacy_policy].','yes'),(234,'woocommerce_delete_inactive_accounts','a:2:{s:6:\"number\";s:0:\"\";s:4:\"unit\";s:6:\"months\";}','no'),(235,'woocommerce_trash_pending_orders','a:2:{s:6:\"number\";s:0:\"\";s:4:\"unit\";s:4:\"days\";}','no'),(236,'woocommerce_trash_failed_orders','a:2:{s:6:\"number\";s:0:\"\";s:4:\"unit\";s:4:\"days\";}','no'),(237,'woocommerce_trash_cancelled_orders','a:2:{s:6:\"number\";s:0:\"\";s:4:\"unit\";s:4:\"days\";}','no'),(238,'woocommerce_anonymize_completed_orders','a:2:{s:6:\"number\";s:0:\"\";s:4:\"unit\";s:6:\"months\";}','no'),(239,'woocommerce_email_from_name','Business Name','no'),(240,'woocommerce_email_from_address','admin@domain.com','no'),(241,'woocommerce_email_header_image','','no'),(242,'woocommerce_email_footer_text','{site_title}','no'),(243,'woocommerce_email_base_color','#96588a','no'),(244,'woocommerce_email_background_color','#f7f7f7','no'),(245,'woocommerce_email_body_background_color','#ffffff','no'),(246,'woocommerce_email_text_color','#3c3c3c','no'),(247,'woocommerce_cart_page_id','18','yes'),(248,'woocommerce_checkout_page_id','19','yes'),(249,'woocommerce_myaccount_page_id','20','yes'),(250,'woocommerce_terms_page_id','','no'),(251,'woocommerce_force_ssl_checkout','no','yes'),(252,'woocommerce_unforce_ssl_checkout','no','yes'),(253,'woocommerce_checkout_pay_endpoint','order-pay','yes'),(254,'woocommerce_checkout_order_received_endpoint','order-received','yes'),(255,'woocommerce_myaccount_add_payment_method_endpoint','add-payment-method','yes'),(256,'woocommerce_myaccount_delete_payment_method_endpoint','delete-payment-method','yes'),(257,'woocommerce_myaccount_set_default_payment_method_endpoint','set-default-payment-method','yes'),(258,'woocommerce_myaccount_orders_endpoint','orders','yes'),(259,'woocommerce_myaccount_view_order_endpoint','view-order','yes'),(260,'woocommerce_myaccount_downloads_endpoint','downloads','yes'),(261,'woocommerce_myaccount_edit_account_endpoint','edit-account','yes'),(262,'woocommerce_myaccount_edit_address_endpoint','edit-address','yes'),(263,'woocommerce_myaccount_payment_methods_endpoint','payment-methods','yes'),(264,'woocommerce_myaccount_lost_password_endpoint','lost-password','yes'),(265,'woocommerce_logout_endpoint','customer-logout','yes'),(266,'woocommerce_api_enabled','no','yes'),(267,'woocommerce_single_image_width','400','yes'),(268,'woocommerce_thumbnail_image_width','200','yes'),(269,'woocommerce_checkout_highlight_required_fields','yes','yes'),(270,'woocommerce_demo_store','no','no'),(271,'woocommerce_permalinks','a:5:{s:12:\"product_base\";s:7:\"product\";s:13:\"category_base\";s:16:\"product-category\";s:8:\"tag_base\";s:11:\"product-tag\";s:14:\"attribute_base\";s:0:\"\";s:22:\"use_verbose_page_rules\";b:0;}','yes'),(272,'current_theme_supports_woocommerce','yes','yes'),(273,'woocommerce_queue_flush_rewrite_rules','no','yes'),(274,'_transient_wc_attribute_taxonomies','a:0:{}','yes'),(276,'default_product_cat','16','yes'),(279,'woocommerce_version','3.4.4','yes'),(280,'woocommerce_db_version','3.4.4','yes'),(281,'woocommerce_admin_notices','a:2:{i:1;s:20:\"no_secure_connection\";i:2;s:14:\"template_files\";}','yes'),(282,'_transient_woocommerce_webhook_ids','a:0:{}','yes'),(283,'widget_woocommerce_widget_cart','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(284,'widget_woocommerce_layered_nav_filters','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(285,'widget_woocommerce_layered_nav','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(286,'widget_woocommerce_price_filter','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(287,'widget_woocommerce_product_categories','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(288,'widget_woocommerce_product_search','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(289,'widget_woocommerce_product_tag_cloud','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(290,'widget_woocommerce_products','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(291,'widget_woocommerce_recently_viewed_products','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(292,'widget_woocommerce_top_rated_products','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(293,'widget_woocommerce_recent_reviews','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(294,'widget_woocommerce_rating_filter','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(296,'woocommerce_meta_box_errors','a:0:{}','yes'),(297,'woocommerce_product_type','physical','yes'),(298,'woocommerce_allow_tracking','no','yes'),(299,'woocommerce_stripe_settings','a:3:{s:7:\"enabled\";s:2:\"no\";s:14:\"create_account\";b:0;s:5:\"email\";b:0;}','yes'),(300,'woocommerce_ppec_paypal_settings','a:2:{s:16:\"reroute_requests\";b:0;s:5:\"email\";b:0;}','yes'),(301,'woocommerce_cheque_settings','a:1:{s:7:\"enabled\";s:2:\"no\";}','yes'),(302,'woocommerce_bacs_settings','a:1:{s:7:\"enabled\";s:2:\"no\";}','yes'),(303,'woocommerce_cod_settings','a:6:{s:7:\"enabled\";s:3:\"yes\";s:5:\"title\";s:4:\"Cash\";s:11:\"description\";s:88:\"Pay with cash upon pickup or delivery. Other payments are also accepted, please inquire.\";s:12:\"instructions\";s:88:\"Pay with cash upon pickup or delivery. Other payments are also accepted, please inquire.\";s:18:\"enable_for_methods\";s:0:\"\";s:18:\"enable_for_virtual\";s:3:\"yes\";}','yes'),(304,'_transient_shipping-transient-version','1532612058','yes'),(314,'_transient_timeout_external_ip_address_172.23.0.1','1533186118','no'),(315,'_transient_external_ip_address_172.23.0.1','67.248.212.16','no'),(316,'_transient_timeout_wc_shipping_method_count_0_1532581261','1535173560','no'),(317,'_transient_wc_shipping_method_count_0_1532581261','1','no'),(320,'_transient_timeout_wc_shipping_method_count_1_1532581618','1535174053','no'),(321,'_transient_wc_shipping_method_count_1_1532581618','2','no'),(326,'_transient_timeout_wc_shipping_method_count_0_1532589940','1535203948','no'),(327,'_transient_wc_shipping_method_count_0_1532589940','2','no'),(328,'woocommerce_free_shipping_3_settings','a:3:{s:5:\"title\";s:6:\"Pickup\";s:8:\"requires\";s:0:\"\";s:10:\"min_amount\";s:1:\"0\";}','yes'),(329,'woocommerce_free_shipping_4_settings','a:3:{s:5:\"title\";s:8:\"Delivery\";s:8:\"requires\";s:10:\"min_amount\";s:10:\"min_amount\";s:2:\"10\";}','yes'),(342,'woocommerce_shop_page_display','subcategories','yes'),(343,'woocommerce_maybe_regenerate_images_hash','eb0fc883c242461cbd1d0483fc69b579','yes'),(351,'product_cat_children','a:0:{}','yes'),(352,'_transient_product_query-transient-version','1532912927','yes'),(353,'_transient_product-transient-version','1532912927','yes'),(390,'_transient_timeout_wc_related_32','1532998560','no'),(391,'_transient_wc_related_32','a:1:{s:50:\"limit=4&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=32\";a:1:{i:0;s:2:\"31\";}}','no'),(392,'_transient_timeout_wc_related_31','1532998568','no'),(393,'_transient_wc_related_31','a:1:{s:50:\"limit=4&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=31\";a:1:{i:0;s:2:\"32\";}}','no'),(394,'_transient_timeout_wc_product_children_33','1535504202','no'),(395,'_transient_wc_product_children_33','a:2:{s:3:\"all\";a:2:{i:0;i:34;i:1;i:35;}s:7:\"visible\";a:2:{i:0;i:34;i:1;i:35;}}','no'),(396,'_transient_timeout_wc_var_prices_33','1535504419','no'),(397,'_transient_wc_var_prices_33','{\"version\":\"1532912408\",\"e7e26981e45c76941798b0c24d5c686f\":{\"price\":{\"34\":\"4.99\",\"35\":\"3.99\"},\"regular_price\":{\"34\":\"4.99\",\"35\":\"3.99\"},\"sale_price\":{\"34\":\"4.99\",\"35\":\"3.99\"}}}','no'),(434,'_transient_timeout_wc_product_children_36','1535504418','no'),(435,'_transient_wc_product_children_36','a:2:{s:3:\"all\";a:2:{i:0;i:37;i:1;i:38;}s:7:\"visible\";a:2:{i:0;i:37;i:1;i:38;}}','no'),(436,'_transient_timeout_wc_var_prices_36','1535504418','no'),(437,'_transient_wc_var_prices_36','{\"version\":\"1532912408\",\"e7e26981e45c76941798b0c24d5c686f\":{\"price\":{\"37\":\"5.99\",\"38\":\"4.99\"},\"regular_price\":{\"37\":\"5.99\",\"38\":\"4.99\"},\"sale_price\":{\"37\":\"5.99\",\"38\":\"4.99\"}}}','no'),(440,'_transient_timeout_wc_child_has_weight_36','1535504418','no'),(441,'_transient_wc_child_has_weight_36','','no'),(442,'_transient_timeout_wc_child_has_dimensions_36','1535504419','no'),(443,'_transient_wc_child_has_dimensions_36','','no'),(444,'_transient_timeout_wc_related_36','1532998819','no'),(445,'_transient_wc_related_36','a:1:{s:50:\"limit=4&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=36\";a:1:{i:0;s:2:\"33\";}}','no'),(477,'_transient_timeout_wc_product_children_42','1535504821','no'),(478,'_transient_wc_product_children_42','a:2:{s:3:\"all\";a:2:{i:0;i:43;i:1;i:44;}s:7:\"visible\";a:2:{i:0;i:43;i:1;i:44;}}','no'),(479,'_transient_timeout_wc_var_prices_42','1535504932','no'),(480,'_transient_wc_var_prices_42','{\"version\":\"1532912927\",\"1f553edf927912a3673366735fa3f7b3\":{\"price\":{\"43\":\"59.99\",\"44\":\"49.99\"},\"regular_price\":{\"43\":\"59.99\",\"44\":\"49.99\"},\"sale_price\":{\"43\":\"59.99\",\"44\":\"49.99\"}}}','no'),(481,'_transient_timeout_wc_child_has_weight_42','1535504831','no'),(482,'_transient_wc_child_has_weight_42','','no'),(483,'_transient_timeout_wc_child_has_dimensions_42','1535504831','no'),(484,'_transient_wc_child_has_dimensions_42','','no'),(485,'_transient_timeout_wc_related_42','1532999231','no'),(486,'_transient_wc_related_42','a:1:{s:50:\"limit=4&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=42\";a:0:{}}','no'),(488,'_transient_is_multi_author','0','yes'),(489,'_transient_timeout_wc_term_counts','1535504928','no'),(490,'_transient_wc_term_counts','a:5:{i:16;s:1:\"0\";i:17;s:1:\"2\";i:18;s:1:\"2\";i:19;s:1:\"2\";i:20;s:1:\"2\";}','no'),(491,'_transient_wc_count_comments','O:8:\"stdClass\":7:{s:14:\"total_comments\";i:0;s:3:\"all\";i:0;s:9:\"moderated\";i:0;s:8:\"approved\";i:0;s:4:\"spam\";i:0;s:5:\"trash\";i:0;s:12:\"post-trashed\";i:0;}','yes'),(492,'_transient_timeout_wc_related_45','1532999337','no'),(493,'_transient_wc_related_45','a:1:{s:50:\"limit=4&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=45\";a:1:{i:0;s:2:\"42\";}}','no'),(494,'_transient_timeout_external_ip_address_67.248.212.16','1533709635','no'),(495,'_transient_external_ip_address_67.248.212.16','18.204.178.18','no'),(496,'_transient_timeout_wc_related_40','1533191292','no'),(497,'_transient_wc_related_40','a:1:{s:50:\"limit=4&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=40\";a:1:{i:0;s:2:\"41\";}}','no'),(498,'_transient_timeout__woocommerce_helper_subscriptions','1533105759','no'),(499,'_transient__woocommerce_helper_subscriptions','a:0:{}','no'),(500,'_site_transient_timeout_theme_roots','1533106660','no'),(501,'_site_transient_theme_roots','a:2:{s:5:\"astra\";s:7:\"/themes\";s:15:\"twentyseventeen\";s:7:\"/themes\";}','no'),(502,'_transient_timeout__woocommerce_helper_updates','1533148060','no'),(503,'_transient__woocommerce_helper_updates','a:4:{s:4:\"hash\";s:32:\"d751713988987e9331980363e24189ce\";s:7:\"updated\";i:1533104860;s:8:\"products\";a:0:{}s:6:\"errors\";a:1:{i:0;s:10:\"http-error\";}}','no'),(504,'_site_transient_timeout_browser_a431ea9ddcde137d50816c2cdf96bc18','1533709660','no'),(505,'_site_transient_browser_a431ea9ddcde137d50816c2cdf96bc18','a:10:{s:4:\"name\";s:6:\"Chrome\";s:7:\"version\";s:12:\"68.0.3440.75\";s:8:\"platform\";s:9:\"Macintosh\";s:10:\"update_url\";s:29:\"https://www.google.com/chrome\";s:7:\"img_src\";s:43:\"http://s.w.org/images/browsers/chrome.png?1\";s:11:\"img_src_ssl\";s:44:\"https://s.w.org/images/browsers/chrome.png?1\";s:15:\"current_version\";s:2:\"18\";s:7:\"upgrade\";b:0;s:8:\"insecure\";b:0;s:6:\"mobile\";b:0;}','no'),(506,'_transient_timeout_wc_report_sales_by_date','1533191261','no'),(507,'_transient_wc_report_sales_by_date','a:8:{s:32:\"8939ac7240c55a18430894e5562e4acc\";a:0:{}s:32:\"3cbaa2e8524a561aa3b0dffe7172c8c7\";a:0:{}s:32:\"d93b9be1eef7a9ef881fa9b6f2653b66\";a:0:{}s:32:\"0adb64b1c78cf2334ac2e172afaca028\";N;s:32:\"40b0ff47766e013780b56e3f456c70ec\";a:0:{}s:32:\"de514fc919fb5d257ffafaa2a2ca8677\";a:0:{}s:32:\"1c2a0606d8590ca735e17f7008229ae1\";a:0:{}s:32:\"7c5c15af88b8844d862698d3c6f5681e\";a:0:{}}','no'),(508,'_transient_timeout_wc_admin_report','1533191261','no'),(509,'_transient_wc_admin_report','a:1:{s:32:\"7e0ead997066659f27647438b4107540\";a:0:{}}','no'),(510,'_transient_timeout_wc_low_stock_count','1535696861','no'),(511,'_transient_wc_low_stock_count','0','no'),(512,'_transient_timeout_wc_outofstock_count','1535696861','no'),(513,'_transient_wc_outofstock_count','0','no'),(514,'_transient_timeout_wc_related_41','1533191306','no'),(515,'_transient_wc_related_41','a:1:{s:50:\"limit=4&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=41\";a:1:{i:0;s:2:\"40\";}}','no'),(516,'_transient_timeout_wc_shipping_method_count_1_1532612058','1535696906','no'),(517,'_transient_wc_shipping_method_count_1_1532612058','2','no');
/*!40000 ALTER TABLE `wp_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_postmeta`
--

DROP TABLE IF EXISTS `wp_postmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_postmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=657 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_postmeta`
--

LOCK TABLES `wp_postmeta` WRITE;
/*!40000 ALTER TABLE `wp_postmeta` DISABLE KEYS */;
INSERT INTO `wp_postmeta` VALUES (2,3,'_wp_page_template','default'),(9,8,'_edit_last','1'),(10,8,'site-sidebar-layout','default'),(11,8,'site-content-layout','default'),(12,8,'_edit_lock','1527458041:1'),(13,10,'_edit_last','1'),(14,10,'site-sidebar-layout','default'),(15,10,'site-content-layout','default'),(16,10,'_edit_lock','1527458099:1'),(17,12,'_wp_trash_meta_status','publish'),(18,12,'_wp_trash_meta_time','1527458218'),(19,13,'_wp_trash_meta_status','publish'),(20,13,'_wp_trash_meta_time','1527458229'),(21,14,'_menu_item_type','post_type'),(22,14,'_menu_item_menu_item_parent','0'),(23,14,'_menu_item_object_id','10'),(24,14,'_menu_item_object','page'),(25,14,'_menu_item_target',''),(26,14,'_menu_item_classes','a:1:{i:0;s:0:\"\";}'),(27,14,'_menu_item_xfn',''),(28,14,'_menu_item_url',''),(30,15,'_menu_item_type','post_type'),(31,15,'_menu_item_menu_item_parent','0'),(32,15,'_menu_item_object_id','8'),(33,15,'_menu_item_object','page'),(34,15,'_menu_item_target',''),(35,15,'_menu_item_classes','a:1:{i:0;s:0:\"\";}'),(36,15,'_menu_item_xfn',''),(37,15,'_menu_item_url',''),(39,16,'_wp_trash_meta_status','publish'),(40,16,'_wp_trash_meta_time','1527458301'),(41,17,'_edit_lock','1532581353:1'),(42,17,'_edit_last','1'),(43,17,'site-sidebar-layout','default'),(44,17,'site-content-layout','default'),(45,20,'_edit_lock','1532581835:1'),(46,22,'_menu_item_type','post_type'),(47,22,'_menu_item_menu_item_parent','0'),(48,22,'_menu_item_object_id','20'),(49,22,'_menu_item_object','page'),(50,22,'_menu_item_target',''),(51,22,'_menu_item_classes','a:1:{i:0;s:0:\"\";}'),(52,22,'_menu_item_xfn',''),(53,22,'_menu_item_url',''),(54,22,'_menu_item_orphaned','1532581917'),(55,23,'_menu_item_type','post_type'),(56,23,'_menu_item_menu_item_parent','0'),(57,23,'_menu_item_object_id','18'),(58,23,'_menu_item_object','page'),(59,23,'_menu_item_target',''),(60,23,'_menu_item_classes','a:1:{i:0;s:0:\"\";}'),(61,23,'_menu_item_xfn',''),(62,23,'_menu_item_url',''),(63,23,'_menu_item_orphaned','1532581919'),(64,24,'_menu_item_type','post_type'),(65,24,'_menu_item_menu_item_parent','0'),(66,24,'_menu_item_object_id','17'),(67,24,'_menu_item_object','page'),(68,24,'_menu_item_target',''),(69,24,'_menu_item_classes','a:1:{i:0;s:0:\"\";}'),(70,24,'_menu_item_xfn',''),(71,24,'_menu_item_url',''),(72,24,'_menu_item_orphaned','1532581920'),(73,20,'_edit_last','1'),(74,20,'site-sidebar-layout','default'),(75,20,'site-content-layout','default'),(76,26,'_menu_item_type','post_type'),(77,26,'_menu_item_menu_item_parent','0'),(78,26,'_menu_item_object_id','20'),(79,26,'_menu_item_object','page'),(80,26,'_menu_item_target',''),(81,26,'_menu_item_classes','a:1:{i:0;s:0:\"\";}'),(82,26,'_menu_item_xfn',''),(83,26,'_menu_item_url',''),(85,27,'_menu_item_type','post_type'),(86,27,'_menu_item_menu_item_parent','0'),(87,27,'_menu_item_object_id','18'),(88,27,'_menu_item_object','page'),(89,27,'_menu_item_target',''),(90,27,'_menu_item_classes','a:1:{i:0;s:0:\"\";}'),(91,27,'_menu_item_xfn',''),(92,27,'_menu_item_url',''),(94,28,'_menu_item_type','post_type'),(95,28,'_menu_item_menu_item_parent','0'),(96,28,'_menu_item_object_id','17'),(97,28,'_menu_item_object','page'),(98,28,'_menu_item_target',''),(99,28,'_menu_item_classes','a:1:{i:0;s:0:\"\";}'),(100,28,'_menu_item_xfn',''),(101,28,'_menu_item_url',''),(103,29,'_wp_trash_meta_status','publish'),(104,29,'_wp_trash_meta_time','1532911537'),(105,30,'_wp_trash_meta_status','publish'),(106,30,'_wp_trash_meta_time','1532911577'),(107,31,'_wc_review_count','0'),(108,31,'_wc_rating_count','a:0:{}'),(109,31,'_wc_average_rating','0'),(110,31,'_edit_last','1'),(111,31,'_edit_lock','1532911805:1'),(112,31,'_sku',''),(113,31,'_regular_price','3.99'),(114,31,'_sale_price',''),(115,31,'_sale_price_dates_from',''),(116,31,'_sale_price_dates_to',''),(117,31,'total_sales','0'),(118,31,'_tax_status','taxable'),(119,31,'_tax_class',''),(120,31,'_manage_stock','no'),(121,31,'_backorders','no'),(122,31,'_sold_individually','no'),(123,31,'_weight',''),(124,31,'_length',''),(125,31,'_width',''),(126,31,'_height',''),(127,31,'_upsell_ids','a:0:{}'),(128,31,'_crosssell_ids','a:0:{}'),(129,31,'_purchase_note',''),(130,31,'_default_attributes','a:0:{}'),(131,31,'_virtual','no'),(132,31,'_downloadable','no'),(133,31,'_product_image_gallery',''),(134,31,'_download_limit','-1'),(135,31,'_download_expiry','-1'),(136,31,'_stock',NULL),(137,31,'_stock_status','instock'),(138,31,'_product_version','3.4.4'),(139,31,'_price','3.99'),(140,31,'site-sidebar-layout','default'),(141,31,'site-content-layout','default'),(142,32,'_wc_review_count','0'),(143,32,'_wc_rating_count','a:0:{}'),(144,32,'_wc_average_rating','0'),(145,32,'_edit_last','1'),(146,32,'_edit_lock','1532911758:1'),(147,32,'_sku',''),(148,32,'_regular_price','5.99'),(149,32,'_sale_price',''),(150,32,'_sale_price_dates_from',''),(151,32,'_sale_price_dates_to',''),(152,32,'total_sales','0'),(153,32,'_tax_status','taxable'),(154,32,'_tax_class',''),(155,32,'_manage_stock','no'),(156,32,'_backorders','no'),(157,32,'_sold_individually','no'),(158,32,'_weight',''),(159,32,'_length',''),(160,32,'_width',''),(161,32,'_height',''),(162,32,'_upsell_ids','a:0:{}'),(163,32,'_crosssell_ids','a:0:{}'),(164,32,'_purchase_note',''),(165,32,'_default_attributes','a:0:{}'),(166,32,'_virtual','no'),(167,32,'_downloadable','no'),(168,32,'_product_image_gallery',''),(169,32,'_download_limit','-1'),(170,32,'_download_expiry','-1'),(171,32,'_stock',NULL),(172,32,'_stock_status','instock'),(173,32,'_product_version','3.4.4'),(174,32,'_price','5.99'),(175,32,'site-sidebar-layout','default'),(176,32,'site-content-layout','default'),(177,33,'_wc_review_count','0'),(178,33,'_wc_rating_count','a:0:{}'),(179,33,'_wc_average_rating','0'),(180,33,'_edit_last','1'),(181,33,'_edit_lock','1532912060:1'),(182,33,'_sku',''),(185,33,'_sale_price_dates_from',''),(186,33,'_sale_price_dates_to',''),(187,33,'total_sales','0'),(188,33,'_tax_status','taxable'),(189,33,'_tax_class',''),(190,33,'_manage_stock','no'),(191,33,'_backorders','no'),(192,33,'_sold_individually','no'),(193,33,'_weight',''),(194,33,'_length',''),(195,33,'_width',''),(196,33,'_height',''),(197,33,'_upsell_ids','a:0:{}'),(198,33,'_crosssell_ids','a:0:{}'),(199,33,'_purchase_note',''),(200,33,'_default_attributes','a:0:{}'),(201,33,'_virtual','no'),(202,33,'_downloadable','no'),(203,33,'_product_image_gallery',''),(204,33,'_download_limit','-1'),(205,33,'_download_expiry','-1'),(206,33,'_stock',NULL),(207,33,'_stock_status','instock'),(208,33,'_product_attributes','a:1:{s:4:\"size\";a:6:{s:4:\"name\";s:4:\"Size\";s:5:\"value\";s:10:\"Bowl | Cup\";s:8:\"position\";i:0;s:10:\"is_visible\";i:0;s:12:\"is_variation\";i:1;s:11:\"is_taxonomy\";i:0;}}'),(209,33,'_product_version','3.4.4'),(210,34,'_variation_description',''),(211,34,'_sku','french-onion-bowl'),(212,34,'_regular_price','4.99'),(213,34,'_sale_price',''),(214,34,'_sale_price_dates_from',''),(215,34,'_sale_price_dates_to',''),(216,34,'total_sales','0'),(217,34,'_tax_status','taxable'),(218,34,'_tax_class','parent'),(219,34,'_manage_stock','no'),(220,34,'_backorders','no'),(221,34,'_sold_individually','no'),(222,34,'_weight',''),(223,34,'_length',''),(224,34,'_width',''),(225,34,'_height',''),(226,34,'_upsell_ids','a:0:{}'),(227,34,'_crosssell_ids','a:0:{}'),(228,34,'_purchase_note',''),(229,34,'_default_attributes','a:0:{}'),(230,34,'_virtual','no'),(231,34,'_downloadable','no'),(232,34,'_product_image_gallery',''),(233,34,'_download_limit','-1'),(234,34,'_download_expiry','-1'),(235,34,'_stock',NULL),(236,34,'_stock_status','instock'),(237,34,'_wc_average_rating','0'),(238,34,'_wc_rating_count','a:0:{}'),(239,34,'_wc_review_count','0'),(240,34,'_downloadable_files','a:0:{}'),(241,34,'_price','4.99'),(242,34,'_product_version','3.4.4'),(245,35,'_variation_description',''),(246,35,'_sku','french-onion-cup'),(247,35,'_regular_price','3.99'),(248,35,'_sale_price',''),(249,35,'_sale_price_dates_from',''),(250,35,'_sale_price_dates_to',''),(251,35,'total_sales','0'),(252,35,'_tax_status','taxable'),(253,35,'_tax_class','parent'),(254,35,'_manage_stock','no'),(255,35,'_backorders','no'),(256,35,'_sold_individually','no'),(257,35,'_weight',''),(258,35,'_length',''),(259,35,'_width',''),(260,35,'_height',''),(261,35,'_upsell_ids','a:0:{}'),(262,35,'_crosssell_ids','a:0:{}'),(263,35,'_purchase_note',''),(264,35,'_default_attributes','a:0:{}'),(265,35,'_virtual','no'),(266,35,'_downloadable','no'),(267,35,'_product_image_gallery',''),(268,35,'_download_limit','-1'),(269,35,'_download_expiry','-1'),(270,35,'_stock',NULL),(271,35,'_stock_status','instock'),(272,35,'_wc_average_rating','0'),(273,35,'_wc_rating_count','a:0:{}'),(274,35,'_wc_review_count','0'),(275,35,'_downloadable_files','a:0:{}'),(276,35,'attribute_size','Cup'),(277,35,'_price','3.99'),(278,35,'_product_version','3.4.4'),(281,34,'attribute_size','Bowl'),(282,33,'_price','3.99'),(283,33,'_price','4.99'),(284,33,'_regular_price',''),(285,33,'_sale_price',''),(286,33,'site-sidebar-layout','default'),(287,33,'site-content-layout','default'),(288,36,'_wc_review_count','0'),(289,36,'_wc_rating_count','a:0:{}'),(290,36,'_wc_average_rating','0'),(291,36,'_edit_last','1'),(292,36,'_edit_lock','1532912300:1'),(293,36,'_sku',''),(296,36,'_sale_price_dates_from',''),(297,36,'_sale_price_dates_to',''),(298,36,'total_sales','0'),(299,36,'_tax_status','taxable'),(300,36,'_tax_class',''),(301,36,'_manage_stock','no'),(302,36,'_backorders','no'),(303,36,'_sold_individually','no'),(304,36,'_weight',''),(305,36,'_length',''),(306,36,'_width',''),(307,36,'_height',''),(308,36,'_upsell_ids','a:0:{}'),(309,36,'_crosssell_ids','a:0:{}'),(310,36,'_purchase_note',''),(311,36,'_default_attributes','a:0:{}'),(312,36,'_virtual','no'),(313,36,'_downloadable','no'),(314,36,'_product_image_gallery',''),(315,36,'_download_limit','-1'),(316,36,'_download_expiry','-1'),(317,36,'_stock',NULL),(318,36,'_stock_status','instock'),(319,36,'_product_attributes','a:1:{s:4:\"size\";a:6:{s:4:\"name\";s:4:\"Size\";s:5:\"value\";s:10:\"Bowl | Cup\";s:8:\"position\";i:0;s:10:\"is_visible\";i:0;s:12:\"is_variation\";i:1;s:11:\"is_taxonomy\";i:0;}}'),(320,36,'_product_version','3.4.4'),(321,37,'_variation_description',''),(322,37,'_sku','clam-chowder-bowl'),(323,37,'_regular_price','5.99'),(324,37,'_sale_price',''),(325,37,'_sale_price_dates_from',''),(326,37,'_sale_price_dates_to',''),(327,37,'total_sales','0'),(328,37,'_tax_status','taxable'),(329,37,'_tax_class','parent'),(330,37,'_manage_stock','no'),(331,37,'_backorders','no'),(332,37,'_sold_individually','no'),(333,37,'_weight',''),(334,37,'_length',''),(335,37,'_width',''),(336,37,'_height',''),(337,37,'_upsell_ids','a:0:{}'),(338,37,'_crosssell_ids','a:0:{}'),(339,37,'_purchase_note',''),(340,37,'_default_attributes','a:0:{}'),(341,37,'_virtual','no'),(342,37,'_downloadable','no'),(343,37,'_product_image_gallery',''),(344,37,'_download_limit','-1'),(345,37,'_download_expiry','-1'),(346,37,'_stock',NULL),(347,37,'_stock_status','instock'),(348,37,'_wc_average_rating','0'),(349,37,'_wc_rating_count','a:0:{}'),(350,37,'_wc_review_count','0'),(351,37,'_downloadable_files','a:0:{}'),(352,37,'_price','5.99'),(353,37,'_product_version','3.4.4'),(356,37,'attribute_size','Bowl'),(359,38,'_variation_description',''),(360,38,'_sku','clam-chowder-cup'),(361,38,'_regular_price','4.99'),(362,38,'_sale_price',''),(363,38,'_sale_price_dates_from',''),(364,38,'_sale_price_dates_to',''),(365,38,'total_sales','0'),(366,38,'_tax_status','taxable'),(367,38,'_tax_class','parent'),(368,38,'_manage_stock','no'),(369,38,'_backorders','no'),(370,38,'_sold_individually','no'),(371,38,'_weight',''),(372,38,'_length',''),(373,38,'_width',''),(374,38,'_height',''),(375,38,'_upsell_ids','a:0:{}'),(376,38,'_crosssell_ids','a:0:{}'),(377,38,'_purchase_note',''),(378,38,'_default_attributes','a:0:{}'),(379,38,'_virtual','no'),(380,38,'_downloadable','no'),(381,38,'_product_image_gallery',''),(382,38,'_download_limit','-1'),(383,38,'_download_expiry','-1'),(384,38,'_stock',NULL),(385,38,'_stock_status','instock'),(386,38,'_wc_average_rating','0'),(387,38,'_wc_rating_count','a:0:{}'),(388,38,'_wc_review_count','0'),(389,38,'_downloadable_files','a:0:{}'),(390,38,'attribute_size','Cup'),(391,38,'_price','4.99'),(392,38,'_product_version','3.4.4'),(435,36,'_price','4.99'),(436,36,'_price','5.99'),(437,36,'_regular_price',''),(438,36,'_sale_price',''),(439,36,'site-sidebar-layout','default'),(440,36,'site-content-layout','default'),(441,40,'_wc_review_count','0'),(442,40,'_wc_rating_count','a:0:{}'),(443,40,'_wc_average_rating','0'),(444,40,'_edit_last','1'),(445,40,'_edit_lock','1532912349:1'),(446,40,'_sku',''),(447,40,'_regular_price','8.99'),(448,40,'_sale_price',''),(449,40,'_sale_price_dates_from',''),(450,40,'_sale_price_dates_to',''),(451,40,'total_sales','0'),(452,40,'_tax_status','taxable'),(453,40,'_tax_class',''),(454,40,'_manage_stock','no'),(455,40,'_backorders','no'),(456,40,'_sold_individually','no'),(457,40,'_weight',''),(458,40,'_length',''),(459,40,'_width',''),(460,40,'_height',''),(461,40,'_upsell_ids','a:0:{}'),(462,40,'_crosssell_ids','a:0:{}'),(463,40,'_purchase_note',''),(464,40,'_default_attributes','a:0:{}'),(465,40,'_virtual','no'),(466,40,'_downloadable','no'),(467,40,'_product_image_gallery',''),(468,40,'_download_limit','-1'),(469,40,'_download_expiry','-1'),(470,40,'_stock',NULL),(471,40,'_stock_status','instock'),(472,40,'_product_version','3.4.4'),(473,40,'_price','8.99'),(474,40,'site-sidebar-layout','default'),(475,40,'site-content-layout','default'),(476,41,'_wc_review_count','0'),(477,41,'_wc_rating_count','a:0:{}'),(478,41,'_wc_average_rating','0'),(479,41,'_edit_last','1'),(480,41,'_edit_lock','1532912461:1'),(481,41,'_sku',''),(482,41,'_regular_price','7.99'),(483,41,'_sale_price',''),(484,41,'_sale_price_dates_from',''),(485,41,'_sale_price_dates_to',''),(486,41,'total_sales','0'),(487,41,'_tax_status','taxable'),(488,41,'_tax_class',''),(489,41,'_manage_stock','no'),(490,41,'_backorders','no'),(491,41,'_sold_individually','no'),(492,41,'_weight',''),(493,41,'_length',''),(494,41,'_width',''),(495,41,'_height',''),(496,41,'_upsell_ids','a:0:{}'),(497,41,'_crosssell_ids','a:0:{}'),(498,41,'_purchase_note',''),(499,41,'_default_attributes','a:0:{}'),(500,41,'_virtual','no'),(501,41,'_downloadable','no'),(502,41,'_product_image_gallery',''),(503,41,'_download_limit','-1'),(504,41,'_download_expiry','-1'),(505,41,'_stock',NULL),(506,41,'_stock_status','instock'),(507,41,'_product_version','3.4.4'),(508,41,'_price','7.99'),(509,41,'site-sidebar-layout','default'),(510,41,'site-content-layout','default'),(511,42,'_wc_review_count','0'),(512,42,'_wc_rating_count','a:0:{}'),(513,42,'_wc_average_rating','0'),(514,42,'_edit_last','1'),(515,42,'_edit_lock','1532912693:1'),(516,42,'_sku',''),(519,42,'_sale_price_dates_from',''),(520,42,'_sale_price_dates_to',''),(521,42,'total_sales','0'),(522,42,'_tax_status','taxable'),(523,42,'_tax_class',''),(524,42,'_manage_stock','no'),(525,42,'_backorders','no'),(526,42,'_sold_individually','no'),(527,42,'_weight',''),(528,42,'_length',''),(529,42,'_width',''),(530,42,'_height',''),(531,42,'_upsell_ids','a:0:{}'),(532,42,'_crosssell_ids','a:0:{}'),(533,42,'_purchase_note',''),(534,42,'_default_attributes','a:0:{}'),(535,42,'_virtual','no'),(536,42,'_downloadable','no'),(537,42,'_product_image_gallery',''),(538,42,'_download_limit','-1'),(539,42,'_download_expiry','-1'),(540,42,'_stock',NULL),(541,42,'_stock_status','instock'),(542,42,'_product_attributes','a:1:{s:4:\"size\";a:6:{s:4:\"name\";s:4:\"Size\";s:5:\"value\";s:13:\"12 oz | 18 oz\";s:8:\"position\";i:0;s:10:\"is_visible\";i:0;s:12:\"is_variation\";i:1;s:11:\"is_taxonomy\";i:0;}}'),(543,42,'_product_version','3.4.4'),(544,43,'_variation_description',''),(545,43,'_sku','filet-mignon-18oz'),(546,43,'_regular_price','59.99'),(547,43,'_sale_price',''),(548,43,'_sale_price_dates_from',''),(549,43,'_sale_price_dates_to',''),(550,43,'total_sales','0'),(551,43,'_tax_status','taxable'),(552,43,'_tax_class','parent'),(553,43,'_manage_stock','no'),(554,43,'_backorders','no'),(555,43,'_sold_individually','no'),(556,43,'_weight',''),(557,43,'_length',''),(558,43,'_width',''),(559,43,'_height',''),(560,43,'_upsell_ids','a:0:{}'),(561,43,'_crosssell_ids','a:0:{}'),(562,43,'_purchase_note',''),(563,43,'_default_attributes','a:0:{}'),(564,43,'_virtual','no'),(565,43,'_downloadable','no'),(566,43,'_product_image_gallery',''),(567,43,'_download_limit','-1'),(568,43,'_download_expiry','-1'),(569,43,'_stock',NULL),(570,43,'_stock_status','instock'),(571,43,'_wc_average_rating','0'),(572,43,'_wc_rating_count','a:0:{}'),(573,43,'_wc_review_count','0'),(574,43,'_downloadable_files','a:0:{}'),(575,43,'_price','59.99'),(576,43,'_product_version','3.4.4'),(579,44,'_variation_description',''),(580,44,'_sku','filet-mignon-12oz'),(581,44,'_regular_price','49.99'),(582,44,'_sale_price',''),(583,44,'_sale_price_dates_from',''),(584,44,'_sale_price_dates_to',''),(585,44,'total_sales','0'),(586,44,'_tax_status','taxable'),(587,44,'_tax_class','parent'),(588,44,'_manage_stock','no'),(589,44,'_backorders','no'),(590,44,'_sold_individually','no'),(591,44,'_weight',''),(592,44,'_length',''),(593,44,'_width',''),(594,44,'_height',''),(595,44,'_upsell_ids','a:0:{}'),(596,44,'_crosssell_ids','a:0:{}'),(597,44,'_purchase_note',''),(598,44,'_default_attributes','a:0:{}'),(599,44,'_virtual','no'),(600,44,'_downloadable','no'),(601,44,'_product_image_gallery',''),(602,44,'_download_limit','-1'),(603,44,'_download_expiry','-1'),(604,44,'_stock',NULL),(605,44,'_stock_status','instock'),(606,44,'_wc_average_rating','0'),(607,44,'_wc_rating_count','a:0:{}'),(608,44,'_wc_review_count','0'),(609,44,'_downloadable_files','a:0:{}'),(610,44,'attribute_size','12 oz'),(611,44,'_price','49.99'),(612,44,'_product_version','3.4.4'),(615,43,'attribute_size','18 oz'),(616,42,'_price','49.99'),(617,42,'_price','59.99'),(618,42,'_regular_price',''),(619,42,'_sale_price',''),(620,42,'site-sidebar-layout','default'),(621,42,'site-content-layout','default'),(622,45,'_wc_review_count','0'),(623,45,'_wc_rating_count','a:0:{}'),(624,45,'_wc_average_rating','0'),(625,45,'_edit_last','1'),(626,45,'_edit_lock','1532912810:1'),(627,45,'_sku',''),(628,45,'_regular_price','23.99'),(629,45,'_sale_price',''),(630,45,'_sale_price_dates_from',''),(631,45,'_sale_price_dates_to',''),(632,45,'total_sales','0'),(633,45,'_tax_status','taxable'),(634,45,'_tax_class',''),(635,45,'_manage_stock','no'),(636,45,'_backorders','no'),(637,45,'_sold_individually','no'),(638,45,'_weight',''),(639,45,'_length',''),(640,45,'_width',''),(641,45,'_height',''),(642,45,'_upsell_ids','a:0:{}'),(643,45,'_crosssell_ids','a:0:{}'),(644,45,'_purchase_note',''),(645,45,'_default_attributes','a:0:{}'),(646,45,'_virtual','no'),(647,45,'_downloadable','no'),(648,45,'_product_image_gallery',''),(649,45,'_download_limit','-1'),(650,45,'_download_expiry','-1'),(651,45,'_stock',NULL),(652,45,'_stock_status','instock'),(653,45,'_product_version','3.4.4'),(654,45,'_price','23.99'),(655,45,'site-sidebar-layout','default'),(656,45,'site-content-layout','default');
/*!40000 ALTER TABLE `wp_postmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_posts`
--

DROP TABLE IF EXISTS `wp_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_posts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_excerpt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `to_ping` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pinged` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`(191)),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_posts`
--

LOCK TABLES `wp_posts` WRITE;
/*!40000 ALTER TABLE `wp_posts` DISABLE KEYS */;
INSERT INTO `wp_posts` VALUES (3,1,'2018-05-27 20:38:15','2018-05-27 20:38:15','<h2>Who we are</h2><p>Our website address is: http://localhost:8500.</p><h2>What personal data we collect and why we collect it</h2><h3>Comments</h3><p>When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&#8217;s IP address and browser user agent string to help spam detection.</p><p>An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.</p><h3>Media</h3><p>If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.</p><h3>Contact forms</h3><h3>Cookies</h3><p>If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.</p><p>If you have an account and you log in to this site, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.</p><p>When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &quot;Remember Me&quot;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.</p><p>If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.</p><h3>Embedded content from other websites</h3><p>Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.</p><p>These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracing your interaction with the embedded content if you have an account and are logged in to that website.</p><h3>Analytics</h3><h2>Who we share your data with</h2><h2>How long we retain your data</h2><p>If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.</p><p>For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.</p><h2>What rights you have over your data</h2><p>If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.</p><h2>Where we send your data</h2><p>Visitor comments may be checked through an automated spam detection service.</p><h2>Your contact information</h2><h2>Additional information</h2><h3>How we protect your data</h3><h3>What data breach procedures we have in place</h3><h3>What third parties we receive data from</h3><h3>What automated decision making and/or profiling we do with user data</h3><h3>Industry regulatory disclosure requirements</h3>','Privacy Policy','','draft','closed','open','','privacy-policy','','','2018-05-27 20:38:15','2018-05-27 20:38:15','',0,'http://localhost:8500/?page_id=3',0,'page','',0),(4,1,'2018-05-27 20:38:31','0000-00-00 00:00:00','','Auto Draft','','auto-draft','open','open','','','','','2018-05-27 20:38:31','0000-00-00 00:00:00','',0,'http://localhost:8500/?p=4',0,'post','',0),(7,1,'2018-05-27 17:56:11','0000-00-00 00:00:00','','Auto Draft','','auto-draft','open','open','','','','','2018-05-27 17:56:11','0000-00-00 00:00:00','',0,'https://dev.azhao.me/?p=7',0,'post','',0),(8,1,'2018-05-27 17:56:24','2018-05-27 21:56:24','','Home','','publish','closed','closed','','home','','','2018-05-27 17:56:24','2018-05-27 21:56:24','',0,'https://dev.azhao.me/?page_id=8',0,'page','',0),(9,1,'2018-05-27 17:56:24','2018-05-27 21:56:24','','Home','','inherit','closed','closed','','8-revision-v1','','','2018-05-27 17:56:24','2018-05-27 21:56:24','',8,'https://dev.azhao.me/8-revision-v1/',0,'revision','',0),(10,1,'2018-05-27 17:56:29','2018-05-27 21:56:29','','Contact','','publish','closed','closed','','contact','','','2018-05-27 17:56:29','2018-05-27 21:56:29','',0,'https://dev.azhao.me/?page_id=10',0,'page','',0),(11,1,'2018-05-27 17:56:29','2018-05-27 21:56:29','','Contact','','inherit','closed','closed','','10-revision-v1','','','2018-05-27 17:56:29','2018-05-27 21:56:29','',10,'https://dev.azhao.me/10-revision-v1/',0,'revision','',0),(12,1,'2018-05-27 17:56:58','2018-05-27 21:56:58','{\n    \"astra-settings[site-sidebar-layout]\": {\n        \"value\": \"no-sidebar\",\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-05-27 21:56:58\"\n    }\n}','','','trash','closed','closed','','f69e5d6c-0cf1-4546-99c2-5915b4915892','','','2018-05-27 17:56:58','2018-05-27 21:56:58','',0,'https://dev.azhao.me/f69e5d6c-0cf1-4546-99c2-5915b4915892/',0,'customize_changeset','',0),(13,1,'2018-05-27 17:57:09','2018-05-27 21:57:09','{\n    \"astra-settings[footer-sml-section-1-credit]\": {\n        \"value\": \"Copyright \\u00a9 [current_year] [site_title]\",\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-05-27 21:57:09\"\n    }\n}','','','trash','closed','closed','','c77e9a5c-3177-4971-bcda-5c201806eedc','','','2018-05-27 17:57:09','2018-05-27 21:57:09','',0,'https://dev.azhao.me/c77e9a5c-3177-4971-bcda-5c201806eedc/',0,'customize_changeset','',0),(14,1,'2018-05-27 17:57:39','2018-05-27 21:57:39',' ','','','publish','closed','closed','','14','','','2018-07-26 01:13:44','2018-07-26 05:13:44','',0,'https://dev.azhao.me/?p=14',5,'nav_menu_item','',0),(15,1,'2018-05-27 17:57:39','2018-05-27 21:57:39',' ','','','publish','closed','closed','','15','','','2018-07-26 01:13:41','2018-07-26 05:13:41','',0,'https://dev.azhao.me/?p=15',1,'nav_menu_item','',0),(16,1,'2018-05-27 17:58:21','2018-05-27 21:58:21','{\n    \"show_on_front\": {\n        \"value\": \"page\",\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-05-27 21:58:21\"\n    },\n    \"page_on_front\": {\n        \"value\": \"8\",\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-05-27 21:58:21\"\n    }\n}','','','trash','closed','closed','','6dfd7855-8d60-46a0-9c2a-3658a00d21da','','','2018-05-27 17:58:21','2018-05-27 21:58:21','',0,'https://dev.azhao.me/6dfd7855-8d60-46a0-9c2a-3658a00d21da/',0,'customize_changeset','',0),(17,1,'2018-07-26 00:59:11','2018-07-26 04:59:11','','Menu','','publish','closed','closed','','menu','','','2018-07-26 01:04:20','2018-07-26 05:04:20','',0,'http://localhost:9000/shop/',0,'page','',0),(18,1,'2018-07-26 00:59:13','2018-07-26 04:59:13','[woocommerce_cart]','Cart','','publish','closed','closed','','cart','','','2018-07-26 00:59:13','2018-07-26 04:59:13','',0,'http://localhost:9000/cart/',0,'page','',0),(19,1,'2018-07-26 00:59:13','2018-07-26 04:59:13','[woocommerce_checkout]','Checkout','','publish','closed','closed','','checkout','','','2018-07-26 00:59:13','2018-07-26 04:59:13','',0,'http://localhost:9000/checkout/',0,'page','',0),(20,1,'2018-07-26 00:59:14','2018-07-26 04:59:14','[woocommerce_my_account]','My Account','','publish','closed','closed','','my-account','','','2018-07-26 01:12:44','2018-07-26 05:12:44','',0,'http://localhost:9000/my-account/',0,'page','',0),(21,1,'2018-07-26 01:04:20','2018-07-26 05:04:20','','Menu','','inherit','closed','closed','','17-revision-v1','','','2018-07-26 01:04:20','2018-07-26 05:04:20','',17,'http://localhost:9000/17-revision-v1/',0,'revision','',0),(22,1,'2018-07-26 01:11:56','0000-00-00 00:00:00',' ','','','draft','closed','closed','','','','','2018-07-26 01:11:56','0000-00-00 00:00:00','',0,'http://localhost:9000/?p=22',1,'nav_menu_item','',0),(23,1,'2018-07-26 01:11:57','0000-00-00 00:00:00',' ','','','draft','closed','closed','','','','','2018-07-26 01:11:57','0000-00-00 00:00:00','',0,'http://localhost:9000/?p=23',1,'nav_menu_item','',0),(24,1,'2018-07-26 01:11:59','0000-00-00 00:00:00',' ','','','draft','closed','closed','','','','','2018-07-26 01:11:59','0000-00-00 00:00:00','',0,'http://localhost:9000/?p=24',1,'nav_menu_item','',0),(25,1,'2018-07-26 01:12:44','2018-07-26 05:12:44','[woocommerce_my_account]','My Account','','inherit','closed','closed','','20-revision-v1','','','2018-07-26 01:12:44','2018-07-26 05:12:44','',20,'http://localhost:9000/20-revision-v1/',0,'revision','',0),(26,1,'2018-07-26 01:13:44','2018-07-26 05:13:44',' ','','','publish','closed','closed','','26','','','2018-07-26 01:13:44','2018-07-26 05:13:44','',0,'http://localhost:9000/?p=26',4,'nav_menu_item','',0),(27,1,'2018-07-26 01:13:43','2018-07-26 05:13:43',' ','','','publish','closed','closed','','27','','','2018-07-26 01:13:43','2018-07-26 05:13:43','',0,'http://localhost:9000/?p=27',3,'nav_menu_item','',0),(28,1,'2018-07-26 01:13:42','2018-07-26 05:13:42',' ','','','publish','closed','closed','','28','','','2018-07-26 01:13:42','2018-07-26 05:13:42','',0,'http://localhost:9000/?p=28',2,'nav_menu_item','',0),(29,1,'2018-07-29 20:45:37','2018-07-30 00:45:37','{\n    \"woocommerce_shop_page_display\": {\n        \"value\": \"subcategories\",\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-07-30 00:45:37\"\n    }\n}','','','trash','closed','closed','','97bde172-c781-46da-a3a2-05fdfa7c1d43','','','2018-07-29 20:45:37','2018-07-30 00:45:37','',0,'http://localhost:9000/97bde172-c781-46da-a3a2-05fdfa7c1d43/',0,'customize_changeset','',0),(30,1,'2018-07-29 20:46:16','2018-07-30 00:46:16','{\n    \"woocommerce_single_image_width\": {\n        \"value\": \"400\",\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-07-30 00:46:16\"\n    },\n    \"woocommerce_thumbnail_image_width\": {\n        \"value\": \"200\",\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-07-30 00:46:16\"\n    }\n}','','','trash','closed','closed','','1cfedd22-c84a-413a-ba5d-4f8889174152','','','2018-07-29 20:46:16','2018-07-30 00:46:16','',0,'http://localhost:9000/1cfedd22-c84a-413a-ba5d-4f8889174152/',0,'customize_changeset','',0),(31,1,'2018-07-29 20:50:21','2018-07-30 00:50:21','','French Fries','','publish','closed','closed','','french-fries','','','2018-07-29 20:52:02','2018-07-30 00:52:02','',0,'http://localhost:9000/?post_type=product&#038;p=31',0,'product','',0),(32,1,'2018-07-29 20:51:23','2018-07-30 00:51:23','','Mozzarella Sticks','','publish','closed','closed','','mozzarella-sticks','','','2018-07-29 20:51:29','2018-07-30 00:51:29','',0,'http://localhost:9000/?post_type=product&#038;p=32',0,'product','',0),(33,1,'2018-07-29 20:55:16','2018-07-30 00:55:16','','French Onion','','publish','closed','closed','','french-onion','','','2018-07-29 20:55:21','2018-07-30 00:55:21','',0,'http://localhost:9000/?post_type=product&#038;p=33',0,'product','',0),(34,1,'2018-07-29 20:53:32','2018-07-30 00:53:32','','French Onion - Bowl','','publish','closed','closed','','french-onion','','','2018-07-29 20:54:51','2018-07-30 00:54:51','',33,'http://localhost:9000/?post_type=product&#038;p=33',0,'product_variation','',0),(35,1,'2018-07-29 20:53:50','2018-07-30 00:53:50','','French Onion - Cup','','publish','closed','closed','','french-onion-2','','','2018-07-29 20:54:53','2018-07-30 00:54:53','',33,'http://localhost:9000/?post_type=product&#038;p=33',0,'product_variation','',0),(36,1,'2018-07-29 21:00:03','2018-07-30 01:00:03','','Clam Chowder','','publish','closed','closed','','clam-chowder','','','2018-07-29 21:00:06','2018-07-30 01:00:06','',0,'http://localhost:9000/?post_type=product&#038;p=36',0,'product','',0),(37,1,'2018-07-29 20:57:45','2018-07-30 00:57:45','','Clam Chowder - Bowl','','publish','closed','closed','','clam-chowder','','','2018-07-29 20:59:53','2018-07-30 00:59:53','',36,'http://localhost:9000/?post_type=product&#038;p=36',0,'product_variation','',0),(38,1,'2018-07-29 20:58:10','2018-07-30 00:58:10','','Clam Chowder - Cup','','publish','closed','closed','','clam-chowder-2','','','2018-07-29 20:59:51','2018-07-30 00:59:51','',36,'http://localhost:9000/?post_type=product&#038;p=36',0,'product_variation','',0),(40,1,'2018-07-29 21:01:13','2018-07-30 01:01:13','','All American Burger','','publish','closed','closed','','all-american-burger','','','2018-07-29 21:01:19','2018-07-30 01:01:19','',0,'http://localhost:9000/?post_type=product&#038;p=40',0,'product','',0),(41,1,'2018-07-29 21:02:52','2018-07-30 01:02:52','','Grilled Cheese with Bacon','','publish','closed','closed','','grilled-cheese-with-bacon','','','2018-07-29 21:02:58','2018-07-30 01:02:58','',0,'http://localhost:9000/?post_type=product&#038;p=41',0,'product','',0),(42,1,'2018-07-29 21:06:52','2018-07-30 01:06:52','','House Filet Mignon','','publish','closed','closed','','house-filet-mignon','','','2018-07-29 21:06:56','2018-07-30 01:06:56','',0,'http://localhost:9000/?post_type=product&#038;p=42',0,'product','',0),(43,1,'2018-07-29 21:05:32','2018-07-30 01:05:32','','House Filet Mignon - 18 oz','','publish','closed','closed','','house-filet-mignon','','','2018-07-29 21:06:38','2018-07-30 01:06:38','',42,'http://localhost:9000/?post_type=product&#038;p=42',0,'product_variation','',0),(44,1,'2018-07-29 21:05:44','2018-07-30 01:05:44','','House Filet Mignon - 12 oz','','publish','closed','closed','','house-filet-mignon-2','','','2018-07-29 21:06:40','2018-07-30 01:06:40','',42,'http://localhost:9000/?post_type=product&#038;p=42',0,'product_variation','',0),(45,1,'2018-07-29 21:08:24','2018-07-30 01:08:24','','Grilled Alaskan Salmon','','publish','closed','closed','','grilled-alaskan-salmon','','','2018-07-29 21:08:46','2018-07-30 01:08:46','',0,'http://localhost:9000/?post_type=product&#038;p=45',0,'product','',0);
/*!40000 ALTER TABLE `wp_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_term_relationships`
--

DROP TABLE IF EXISTS `wp_term_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_term_relationships` (
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_term_relationships`
--

LOCK TABLES `wp_term_relationships` WRITE;
/*!40000 ALTER TABLE `wp_term_relationships` DISABLE KEYS */;
INSERT INTO `wp_term_relationships` VALUES (14,2,0),(15,2,0),(26,2,0),(27,2,0),(28,2,0),(31,3,0),(31,19,0),(32,3,0),(32,19,0),(33,5,0),(33,20,0),(36,5,0),(36,20,0),(40,3,0),(40,17,0),(41,3,0),(41,17,0),(42,5,0),(42,18,0),(45,3,0),(45,18,0);
/*!40000 ALTER TABLE `wp_term_relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_term_taxonomy`
--

DROP TABLE IF EXISTS `wp_term_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_term_taxonomy`
--

LOCK TABLES `wp_term_taxonomy` WRITE;
/*!40000 ALTER TABLE `wp_term_taxonomy` DISABLE KEYS */;
INSERT INTO `wp_term_taxonomy` VALUES (1,1,'category','',0,0),(2,2,'nav_menu','',0,5),(3,3,'product_type','',0,5),(4,4,'product_type','',0,0),(5,5,'product_type','',0,3),(6,6,'product_type','',0,0),(7,7,'product_visibility','',0,0),(8,8,'product_visibility','',0,0),(9,9,'product_visibility','',0,0),(10,10,'product_visibility','',0,0),(11,11,'product_visibility','',0,0),(12,12,'product_visibility','',0,0),(13,13,'product_visibility','',0,0),(14,14,'product_visibility','',0,0),(15,15,'product_visibility','',0,0),(16,16,'product_cat','',0,0),(17,17,'product_cat','',0,2),(18,18,'product_cat','',0,2),(19,19,'product_cat','',0,2),(20,20,'product_cat','',0,2);
/*!40000 ALTER TABLE `wp_term_taxonomy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_termmeta`
--

DROP TABLE IF EXISTS `wp_termmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_termmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `term_id` (`term_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_termmeta`
--

LOCK TABLES `wp_termmeta` WRITE;
/*!40000 ALTER TABLE `wp_termmeta` DISABLE KEYS */;
INSERT INTO `wp_termmeta` VALUES (1,17,'order','2'),(2,17,'display_type',''),(3,17,'thumbnail_id','0'),(4,18,'order','3'),(5,18,'display_type',''),(6,18,'thumbnail_id','0'),(7,19,'order','4'),(8,19,'display_type',''),(9,19,'thumbnail_id','0'),(10,20,'order','5'),(11,20,'display_type',''),(12,20,'thumbnail_id','0'),(13,16,'order','1'),(14,16,'product_count_product_cat','0'),(15,19,'product_count_product_cat','2'),(16,20,'product_count_product_cat','2'),(17,17,'product_count_product_cat','2'),(18,18,'product_count_product_cat','2');
/*!40000 ALTER TABLE `wp_termmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_terms`
--

DROP TABLE IF EXISTS `wp_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  KEY `slug` (`slug`(191)),
  KEY `name` (`name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_terms`
--

LOCK TABLES `wp_terms` WRITE;
/*!40000 ALTER TABLE `wp_terms` DISABLE KEYS */;
INSERT INTO `wp_terms` VALUES (1,'Uncategorized','uncategorized',0),(2,'Main Menu','main-menu',0),(3,'simple','simple',0),(4,'grouped','grouped',0),(5,'variable','variable',0),(6,'external','external',0),(7,'exclude-from-search','exclude-from-search',0),(8,'exclude-from-catalog','exclude-from-catalog',0),(9,'featured','featured',0),(10,'outofstock','outofstock',0),(11,'rated-1','rated-1',0),(12,'rated-2','rated-2',0),(13,'rated-3','rated-3',0),(14,'rated-4','rated-4',0),(15,'rated-5','rated-5',0),(16,'Uncategorized','uncategorized',0),(17,'Lunch','lunch',0),(18,'Dinner','dinner',0),(19,'Appetizer','appetizer',0),(20,'Soup','soup',0);
/*!40000 ALTER TABLE `wp_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_usermeta`
--

DROP TABLE IF EXISTS `wp_usermeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_usermeta`
--

LOCK TABLES `wp_usermeta` WRITE;
/*!40000 ALTER TABLE `wp_usermeta` DISABLE KEYS */;
INSERT INTO `wp_usermeta` VALUES (1,1,'nickname','admin'),(2,1,'first_name',''),(3,1,'last_name',''),(4,1,'description',''),(5,1,'rich_editing','true'),(6,1,'syntax_highlighting','true'),(7,1,'comment_shortcuts','false'),(8,1,'admin_color','fresh'),(9,1,'use_ssl','0'),(10,1,'show_admin_bar_front','true'),(11,1,'locale',''),(12,1,'wp_capabilities','a:1:{s:13:\"administrator\";b:1;}'),(13,1,'wp_user_level','10'),(14,1,'dismissed_wp_pointers','wp496_privacy'),(15,1,'show_welcome_panel','1'),(16,1,'session_tokens','a:2:{s:64:\"11b49dd81da32c37f3bd37355a056790657633dad45b0f3b208505b2c1580498\";a:4:{s:10:\"expiration\";i:1533799529;s:2:\"ip\";s:10:\"172.23.0.1\";s:2:\"ua\";s:120:\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36\";s:5:\"login\";i:1532589929;}s:64:\"78d840f2b8105252eaf7e0fb21f2f942623577571e10393d334ba172a0f0c037\";a:4:{s:10:\"expiration\";i:1533277659;s:2:\"ip\";s:13:\"67.248.212.16\";s:2:\"ua\";s:120:\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.75 Safari/537.36\";s:5:\"login\";i:1533104859;}}'),(17,1,'wp_dashboard_quick_press_last_post_id','4'),(18,1,'community-events-location','a:1:{s:2:\"ip\";s:12:\"67.248.212.0\";}'),(19,1,'managenav-menuscolumnshidden','a:5:{i:0;s:11:\"link-target\";i:1;s:11:\"css-classes\";i:2;s:3:\"xfn\";i:3;s:11:\"description\";i:4;s:15:\"title-attribute\";}'),(20,1,'metaboxhidden_nav-menus','a:2:{i:0;s:12:\"add-post_tag\";i:1;s:15:\"add-post_format\";}'),(21,1,'wp_user-settings','hidetb=1&editor=tinymce&libraryContent=browse'),(22,1,'wp_user-settings-time','1532581042'),(23,1,'wc_last_active','1533081600'),(24,1,'_woocommerce_persistent_cart_1','a:1:{s:4:\"cart\";a:0:{}}'),(25,1,'nav_menu_recently_edited','2'),(26,1,'closedpostboxes_product','a:0:{}'),(27,1,'metaboxhidden_product','a:2:{i:0;s:10:\"postcustom\";i:1;s:7:\"slugdiv\";}');
/*!40000 ALTER TABLE `wp_usermeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_users`
--

DROP TABLE IF EXISTS `wp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_users` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`),
  KEY `user_email` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_users`
--

LOCK TABLES `wp_users` WRITE;
/*!40000 ALTER TABLE `wp_users` DISABLE KEYS */;
INSERT INTO `wp_users` VALUES (1,'admin','$P$Bl2tq8aUM/k1TNQQZeGVC9/pO2cX4m1','admin','admin@domain.com','','2018-05-27 20:38:14','',0,'admin');
/*!40000 ALTER TABLE `wp_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wc_download_log`
--

DROP TABLE IF EXISTS `wp_wc_download_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_wc_download_log` (
  `download_log_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `permission_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `user_ip_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  PRIMARY KEY (`download_log_id`),
  KEY `permission_id` (`permission_id`),
  KEY `timestamp` (`timestamp`),
  CONSTRAINT `fk_wc_download_log_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `wp_woocommerce_downloadable_product_permissions` (`permission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_download_log`
--

LOCK TABLES `wp_wc_download_log` WRITE;
/*!40000 ALTER TABLE `wp_wc_download_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_download_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wc_webhooks`
--

DROP TABLE IF EXISTS `wp_wc_webhooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_wc_webhooks` (
  `webhook_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `delivery_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `secret` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `topic` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_created_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `api_version` smallint(4) NOT NULL,
  `failure_count` smallint(10) NOT NULL DEFAULT '0',
  `pending_delivery` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`webhook_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_webhooks`
--

LOCK TABLES `wp_wc_webhooks` WRITE;
/*!40000 ALTER TABLE `wp_wc_webhooks` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wc_webhooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_woocommerce_api_keys`
--

DROP TABLE IF EXISTS `wp_woocommerce_api_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_woocommerce_api_keys` (
  `key_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `permissions` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `consumer_key` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `consumer_secret` char(43) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nonces` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `truncated_key` char(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_access` datetime DEFAULT NULL,
  PRIMARY KEY (`key_id`),
  KEY `consumer_key` (`consumer_key`),
  KEY `consumer_secret` (`consumer_secret`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_api_keys`
--

LOCK TABLES `wp_woocommerce_api_keys` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_api_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_api_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_woocommerce_attribute_taxonomies`
--

DROP TABLE IF EXISTS `wp_woocommerce_attribute_taxonomies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_woocommerce_attribute_taxonomies` (
  `attribute_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `attribute_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `attribute_label` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `attribute_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `attribute_orderby` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `attribute_public` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`attribute_id`),
  KEY `attribute_name` (`attribute_name`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_attribute_taxonomies`
--

LOCK TABLES `wp_woocommerce_attribute_taxonomies` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_attribute_taxonomies` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_attribute_taxonomies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_woocommerce_downloadable_product_permissions`
--

DROP TABLE IF EXISTS `wp_woocommerce_downloadable_product_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_woocommerce_downloadable_product_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `download_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `order_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `order_key` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `downloads_remaining` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `access_granted` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access_expires` datetime DEFAULT NULL,
  `download_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`permission_id`),
  KEY `download_order_key_product` (`product_id`,`order_id`,`order_key`(16),`download_id`),
  KEY `download_order_product` (`download_id`,`order_id`,`product_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_downloadable_product_permissions`
--

LOCK TABLES `wp_woocommerce_downloadable_product_permissions` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_downloadable_product_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_downloadable_product_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_woocommerce_log`
--

DROP TABLE IF EXISTS `wp_woocommerce_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_woocommerce_log` (
  `log_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `level` smallint(4) NOT NULL,
  `source` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `context` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`log_id`),
  KEY `level` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_log`
--

LOCK TABLES `wp_woocommerce_log` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_woocommerce_order_itemmeta`
--

DROP TABLE IF EXISTS `wp_woocommerce_order_itemmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_woocommerce_order_itemmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_item_id` bigint(20) unsigned NOT NULL,
  `meta_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `order_item_id` (`order_item_id`),
  KEY `meta_key` (`meta_key`(32))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_order_itemmeta`
--

LOCK TABLES `wp_woocommerce_order_itemmeta` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_order_itemmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_order_itemmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_woocommerce_order_items`
--

DROP TABLE IF EXISTS `wp_woocommerce_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_woocommerce_order_items` (
  `order_item_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_item_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `order_item_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `order_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_order_items`
--

LOCK TABLES `wp_woocommerce_order_items` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_woocommerce_payment_tokenmeta`
--

DROP TABLE IF EXISTS `wp_woocommerce_payment_tokenmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_woocommerce_payment_tokenmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `payment_token_id` bigint(20) unsigned NOT NULL,
  `meta_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `payment_token_id` (`payment_token_id`),
  KEY `meta_key` (`meta_key`(32))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_payment_tokenmeta`
--

LOCK TABLES `wp_woocommerce_payment_tokenmeta` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_payment_tokenmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_payment_tokenmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_woocommerce_payment_tokens`
--

DROP TABLE IF EXISTS `wp_woocommerce_payment_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_woocommerce_payment_tokens` (
  `token_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gateway_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`token_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_payment_tokens`
--

LOCK TABLES `wp_woocommerce_payment_tokens` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_payment_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_payment_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_woocommerce_sessions`
--

DROP TABLE IF EXISTS `wp_woocommerce_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_woocommerce_sessions` (
  `session_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_key` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `session_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `session_expiry` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`session_key`),
  UNIQUE KEY `session_id` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_sessions`
--

LOCK TABLES `wp_woocommerce_sessions` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_sessions` DISABLE KEYS */;
INSERT INTO `wp_woocommerce_sessions` VALUES (10,'1','a:13:{s:4:\"cart\";s:6:\"a:0:{}\";s:11:\"cart_totals\";s:367:\"a:15:{s:8:\"subtotal\";i:0;s:12:\"subtotal_tax\";i:0;s:14:\"shipping_total\";i:0;s:12:\"shipping_tax\";i:0;s:14:\"shipping_taxes\";a:0:{}s:14:\"discount_total\";i:0;s:12:\"discount_tax\";i:0;s:19:\"cart_contents_total\";i:0;s:17:\"cart_contents_tax\";i:0;s:19:\"cart_contents_taxes\";a:0:{}s:9:\"fee_total\";i:0;s:7:\"fee_tax\";i:0;s:9:\"fee_taxes\";a:0:{}s:5:\"total\";i:0;s:9:\"total_tax\";i:0;}\";s:15:\"applied_coupons\";s:6:\"a:0:{}\";s:22:\"coupon_discount_totals\";s:6:\"a:0:{}\";s:26:\"coupon_discount_tax_totals\";s:6:\"a:0:{}\";s:21:\"removed_cart_contents\";s:416:\"a:1:{s:32:\"3416a75f4cea9109507cacd8e2f2aefc\";a:11:{s:3:\"key\";s:32:\"3416a75f4cea9109507cacd8e2f2aefc\";s:10:\"product_id\";i:41;s:12:\"variation_id\";i:0;s:9:\"variation\";a:0:{}s:8:\"quantity\";i:3;s:9:\"data_hash\";s:32:\"b5c1d5ca8bae6d4896cf1807cdf763f0\";s:13:\"line_tax_data\";a:2:{s:8:\"subtotal\";a:0:{}s:5:\"total\";a:0:{}}s:13:\"line_subtotal\";d:23.97;s:17:\"line_subtotal_tax\";i:0;s:10:\"line_total\";d:23.97;s:8:\"line_tax\";i:0;}}\";s:8:\"customer\";s:708:\"a:26:{s:2:\"id\";s:1:\"1\";s:13:\"date_modified\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:4:\"city\";s:0:\"\";s:9:\"address_1\";s:0:\"\";s:7:\"address\";s:0:\"\";s:9:\"address_2\";s:0:\"\";s:5:\"state\";s:2:\"NY\";s:7:\"country\";s:2:\"US\";s:17:\"shipping_postcode\";s:0:\"\";s:13:\"shipping_city\";s:0:\"\";s:18:\"shipping_address_1\";s:0:\"\";s:16:\"shipping_address\";s:0:\"\";s:18:\"shipping_address_2\";s:0:\"\";s:14:\"shipping_state\";s:2:\"NY\";s:16:\"shipping_country\";s:2:\"US\";s:13:\"is_vat_exempt\";s:0:\"\";s:19:\"calculated_shipping\";s:0:\"\";s:10:\"first_name\";s:0:\"\";s:9:\"last_name\";s:0:\"\";s:7:\"company\";s:0:\"\";s:5:\"phone\";s:0:\"\";s:5:\"email\";s:16:\"admin@domain.com\";s:19:\"shipping_first_name\";s:0:\"\";s:18:\"shipping_last_name\";s:0:\"\";s:16:\"shipping_company\";s:0:\"\";}\";s:22:\"shipping_for_package_0\";s:712:\"a:2:{s:12:\"package_hash\";s:40:\"wc_ship_9b93defa73d249a8e90e05dced24bc1a\";s:5:\"rates\";a:2:{s:15:\"free_shipping:3\";O:16:\"WC_Shipping_Rate\":2:{s:7:\"\0*\0data\";a:6:{s:2:\"id\";s:15:\"free_shipping:3\";s:9:\"method_id\";s:13:\"free_shipping\";s:11:\"instance_id\";i:3;s:5:\"label\";s:6:\"Pickup\";s:4:\"cost\";s:4:\"0.00\";s:5:\"taxes\";a:0:{}}s:12:\"\0*\0meta_data\";a:1:{s:5:\"Items\";s:35:\"Grilled Cheese with Bacon &times; 3\";}}s:15:\"free_shipping:4\";O:16:\"WC_Shipping_Rate\":2:{s:7:\"\0*\0data\";a:6:{s:2:\"id\";s:15:\"free_shipping:4\";s:9:\"method_id\";s:13:\"free_shipping\";s:11:\"instance_id\";i:4;s:5:\"label\";s:8:\"Delivery\";s:4:\"cost\";s:4:\"0.00\";s:5:\"taxes\";a:0:{}}s:12:\"\0*\0meta_data\";a:1:{s:5:\"Items\";s:35:\"Grilled Cheese with Bacon &times; 3\";}}}}\";s:25:\"previous_shipping_methods\";s:70:\"a:1:{i:0;a:2:{i:0;s:15:\"free_shipping:3\";i:1;s:15:\"free_shipping:4\";}}\";s:23:\"chosen_shipping_methods\";s:33:\"a:1:{i:0;s:15:\"free_shipping:3\";}\";s:22:\"shipping_method_counts\";s:14:\"a:1:{i:0;i:2;}\";s:10:\"wc_notices\";N;s:21:\"chosen_payment_method\";s:3:\"cod\";}',1533277706);
/*!40000 ALTER TABLE `wp_woocommerce_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_woocommerce_shipping_zone_locations`
--

DROP TABLE IF EXISTS `wp_woocommerce_shipping_zone_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_woocommerce_shipping_zone_locations` (
  `location_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `zone_id` bigint(20) unsigned NOT NULL,
  `location_code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `location_type` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`location_id`),
  KEY `location_id` (`location_id`),
  KEY `location_type_code` (`location_type`(10),`location_code`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_shipping_zone_locations`
--

LOCK TABLES `wp_woocommerce_shipping_zone_locations` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zone_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zone_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_woocommerce_shipping_zone_methods`
--

DROP TABLE IF EXISTS `wp_woocommerce_shipping_zone_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_woocommerce_shipping_zone_methods` (
  `zone_id` bigint(20) unsigned NOT NULL,
  `instance_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `method_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `method_order` bigint(20) unsigned NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`instance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_shipping_zone_methods`
--

LOCK TABLES `wp_woocommerce_shipping_zone_methods` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zone_methods` DISABLE KEYS */;
INSERT INTO `wp_woocommerce_shipping_zone_methods` VALUES (0,3,'free_shipping',3,1),(0,4,'free_shipping',4,1);
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zone_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_woocommerce_shipping_zones`
--

DROP TABLE IF EXISTS `wp_woocommerce_shipping_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_woocommerce_shipping_zones` (
  `zone_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `zone_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `zone_order` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_shipping_zones`
--

LOCK TABLES `wp_woocommerce_shipping_zones` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zones` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_woocommerce_tax_rate_locations`
--

DROP TABLE IF EXISTS `wp_woocommerce_tax_rate_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_woocommerce_tax_rate_locations` (
  `location_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location_code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `tax_rate_id` bigint(20) unsigned NOT NULL,
  `location_type` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`location_id`),
  KEY `tax_rate_id` (`tax_rate_id`),
  KEY `location_type_code` (`location_type`(10),`location_code`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_tax_rate_locations`
--

LOCK TABLES `wp_woocommerce_tax_rate_locations` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_tax_rate_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_tax_rate_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_woocommerce_tax_rates`
--

DROP TABLE IF EXISTS `wp_woocommerce_tax_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_woocommerce_tax_rates` (
  `tax_rate_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tax_rate_country` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate_state` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate_priority` bigint(20) unsigned NOT NULL,
  `tax_rate_compound` int(1) NOT NULL DEFAULT '0',
  `tax_rate_shipping` int(1) NOT NULL DEFAULT '1',
  `tax_rate_order` bigint(20) unsigned NOT NULL,
  `tax_rate_class` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`tax_rate_id`),
  KEY `tax_rate_country` (`tax_rate_country`),
  KEY `tax_rate_state` (`tax_rate_state`(2)),
  KEY `tax_rate_class` (`tax_rate_class`(10)),
  KEY `tax_rate_priority` (`tax_rate_priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_tax_rates`
--

LOCK TABLES `wp_woocommerce_tax_rates` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_tax_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_woocommerce_tax_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_yoast_seo_links`
--

DROP TABLE IF EXISTS `wp_yoast_seo_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_yoast_seo_links` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_id` bigint(20) unsigned NOT NULL,
  `target_post_id` bigint(20) unsigned NOT NULL,
  `type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `link_direction` (`post_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_yoast_seo_links`
--

LOCK TABLES `wp_yoast_seo_links` WRITE;
/*!40000 ALTER TABLE `wp_yoast_seo_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_yoast_seo_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_yoast_seo_meta`
--

DROP TABLE IF EXISTS `wp_yoast_seo_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_yoast_seo_meta` (
  `object_id` bigint(20) unsigned NOT NULL,
  `internal_link_count` int(10) unsigned DEFAULT NULL,
  `incoming_link_count` int(10) unsigned DEFAULT NULL,
  UNIQUE KEY `object_id` (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_yoast_seo_meta`
--

LOCK TABLES `wp_yoast_seo_meta` WRITE;
/*!40000 ALTER TABLE `wp_yoast_seo_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_yoast_seo_meta` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-01  2:29:45
