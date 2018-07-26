<?php

/**
 * Fired during plugin activation
 *
 * @link       https://www.bistrosol.co
 * @since      1.0.0
 *
 * @package    Bistro_Solutions_Wc
 * @subpackage Bistro_Solutions_Wc/includes
 */

/**
 * Fired during plugin activation.
 *
 * This class defines all code necessary to run during the plugin's activation.
 *
 * @since      1.0.0
 * @package    Bistro_Solutions_Wc
 * @subpackage Bistro_Solutions_Wc/includes
 * @author     Alan Zhao <azhao6060@gmail.com>
 */
class Bistro_Solutions_Wc_Activator {

	/**
	 * Short Description. (use period)
	 *
	 * Long Description.
	 *
	 * @since    1.0.0
	 */
	public static function activate() {
    $wp_roles = new WP_Roles();
    $base_role = $wp_roles->get_role('subscriber');
    $base_caps = $base_role->capabilities;

    $admin_role = $wp_roles->get_role('administrator');
    $admin_caps = $admin_role->capabilities;

    // Define new roles and capabilities

    add_role(
        'bistrosol_wc_sync',
        __( 'BSWC Sync',  BISTRO_SOLUTIONS_TEXTDOMAIN ),
        array_merge(
          $admin_caps,
          array('bistrosol_wc_sync' => true)
        )
      );
	}

}
