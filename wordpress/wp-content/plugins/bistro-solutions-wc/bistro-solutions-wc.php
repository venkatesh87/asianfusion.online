<?php

/**
 * The plugin bootstrap file
 *
 * This file is read by WordPress to generate the plugin information in the plugin
 * admin area. This file also includes all of the dependencies used by the plugin,
 * registers the activation and deactivation functions, and defines a function
 * that starts the plugin.
 *
 * @link              https://www.bistrosol.co
 * @since             1.0.0
 * @package           Bistro_Solutions_Wc
 *
 * @wordpress-plugin
 * Plugin Name:       Bistro Solutions WooCommerce Integration
 * Plugin URI:        https://www.bistrosol.co
 * Description:       Bistro Solutions and WooCommerce integration plugin.
 * Version:           1.0.0
 * Author:            Alan Zhao
 * Author URI:        https://www.bistrosol.co
 * License:           GPL-2.0+
 * License URI:       http://www.gnu.org/licenses/gpl-2.0.txt
 * Text Domain:       bistro-solutions-wc
 * Domain Path:       /languages
 */

// If this file is called directly, abort.
if ( ! defined( 'WPINC' ) ) {
	die;
}

/**
 * Current plugin version.
 */
define( 'BISTRO_SOLUTIONS_PLUGIN_VERSION', '1.0.0' );

/**
 * Current plugin directory.
 */
define( 'BISTRO_SOLUTIONS_PLUGIN_DIR', basename( dirname( __FILE__ ) ) );

/**
 * Text domain.
 */
define( 'BISTRO_SOLUTIONS_TEXTDOMAIN', 'bistrosol' );



/**
 * The code that runs during plugin activation.
 * This action is documented in includes/class-bistro-solutions-wc-activator.php
 */
function activate_bistro_solutions_wc() {
	require_once plugin_dir_path( __FILE__ ) . 'includes/class-bistro-solutions-wc-activator.php';
	Bistro_Solutions_Wc_Activator::activate();
}

/**
 * The code that runs during plugin deactivation.
 * This action is documented in includes/class-bistro-solutions-wc-deactivator.php
 */
function deactivate_bistro_solutions_wc() {
	require_once plugin_dir_path( __FILE__ ) . 'includes/class-bistro-solutions-wc-deactivator.php';
	Bistro_Solutions_Wc_Deactivator::deactivate();
}

register_activation_hook( __FILE__, 'activate_bistro_solutions_wc' );
register_deactivation_hook( __FILE__, 'deactivate_bistro_solutions_wc' );

/**
 * The core plugin class that is used to define internationalization,
 * admin-specific hooks, and public-facing site hooks.
 */
require plugin_dir_path( __FILE__ ) . 'includes/class-bistro-solutions-wc.php';

/**
 * Begins execution of the plugin.
 *
 * Since everything within the plugin is registered via hooks,
 * then kicking off the plugin from this point in the file does
 * not affect the page life cycle.
 *
 * @since    1.0.0
 */
function run_bistro_solutions_wc() {

	$plugin = new Bistro_Solutions_Wc();
	$plugin->run();

}
run_bistro_solutions_wc();
