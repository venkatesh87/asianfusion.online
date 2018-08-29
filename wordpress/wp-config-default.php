<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */


/** More reliable way to determine https protocol in load balancing environments **/
define('SERVER_PROTOCOL', isset($_SERVER['HTTP_X_FORWARDED_PROTO']) ? $_SERVER['HTTP_X_FORWARDED_PROTO'] : ((isset( $_SERVER["HTTPS"] ) && strtolower( $_SERVER["HTTPS"] ) == "on" ) ? 'https' : 'http')); 

/** Configure server URL dynamically so that multiple environment URLs work **/
$serverUrl = SERVER_PROTOCOL . '://' . $_SERVER['HTTP_HOST'];
define('WP_SITEURL', $serverUrl);
define('WP_HOME', $serverUrl);

/** Disable file editing **/
define('DISALLOW_FILE_EDIT', true);

/** Custom MAMP setup **/
define('WP_NAME', '');

/** MySQL credentials **/
if (!empty($_SERVER['SERVER_NAME']) && $_SERVER['SERVER_NAME'] === WP_NAME) {
  define('DB_USER', 'wordpress');
  define('DB_PASSWORD', 'wordpress');
  define('DB_NAME', WP_NAME);
  define('DB_HOST', '127.0.0.1');
} else {
  define('DB_NAME', 'to-be-replaced');
  define('DB_USER', 'to-be-replaced');
  define('DB_PASSWORD', 'to-be-replaced');
  define('DB_HOST', 'to-be-replaced');
}

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8mb4');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');



/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'jUsBi#KQ9 E54[z15R~}%,O[TNz+tc@)4A>6ZJmbWZ=fgr3GDG6P(]QSdJKpI$%;');
define('SECURE_AUTH_KEY',  '];OVQ`(lFm,zYW.8.c2i:qz-)_F7BO1)H%BO^#ZWem@+G9S*8fAr^Q(Ps+:*]}:x');
define('LOGGED_IN_KEY',    '}<v6zPQWSIt:}q)?_%+<Nuu0(3U%c~C/(:Fnfsk^)95:(e`I/l1,xQKw3tE_W4UW');
define('NONCE_KEY',        'XcfDf/qb`|qy5x6N(o?E:&:.(-M].##5dx dtybTgRZ4MjWE6G0;TVOz{yPd>Hy#');
define('AUTH_SALT',        '6?&+52D^}M/(&piK/vFIP10%Z_{Wz2a^(mk;_j%wn/}~olumH5Yn ?vRv4!oI*dN');
define('SECURE_AUTH_SALT', 'Scvp(981NiM@UqTHf*bt0Rp*Rc<,=E?3UGpaxH0_/;P4cM/3AJ]>.gLaXn.Eei=T');
define('LOGGED_IN_SALT',   'plp?KmEuh#F8D%Llp!e|sF3Sf8Nno,6|,i2Xx0ma}8k5M%{WQU(En4-K{@dvDb.]');
define('NONCE_SALT',       'bf._L~aIItF>.0i7!MWHv@>O.;7B&%i=nGiV])V>}whCSl}]*Mb&4*`}M:x9KKdk');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');

