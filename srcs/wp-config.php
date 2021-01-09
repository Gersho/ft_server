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
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress_db' );

/** MySQL database username */
define( 'DB_USER', 'wordpress_user' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'y=-CJY3|e9?(v6rTrdgh1aq204rC]cUh!~)[[ }xm>-4]n6<KUNKbTC|D)+nN|x_' );
define( 'SECURE_AUTH_KEY',  '6g=TrR*~uDv&MkUumKllTsU~@ZGOC8Qy8(AiFw+|1Q;27P-*k]@MSZk[J?4/WL+(' );
define( 'LOGGED_IN_KEY',    'v 9-JMhaO60tgVC%8cE@[Zy|S?dF5GQRTetF~W;YF+#Q/&3IbCOpP3(+SN&fD>rw' );
define( 'NONCE_KEY',        'vyi/q~<xlNU}q%Yuf{Lz3uZ)j<YYY|<GCqqM^.|O|W<d8%]x%(*ygvY^9olgcw{0' );
define( 'AUTH_SALT',        'y>[2RldM[9jj|7eXc8-T49{!}yVRPjW(m3L*6.(kj-1HJ >Vn9ycNpfMJ*Ae4QI|' );
define( 'SECURE_AUTH_SALT', 'TLv-tI#b@YJSTLNfMRQ5PT:k6[]}vUdLk=G%/g^ f;lyW?n6a;w~VrGN/VI[n@NT' );
define( 'LOGGED_IN_SALT',   '1.+`J5F)a4gs|[|b<Z:&Y]DZA<aEN0^gF: 2R$piTjuo]THCJ#W1p/kKFM!+L#nU' );
define( 'NONCE_SALT',       'Fwxu}.uH4<+P@l/uveeN<vU*VLkAB;5@IG&<vsd(IjHG;J6:Cap*S5N|17,2`-Q%' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
