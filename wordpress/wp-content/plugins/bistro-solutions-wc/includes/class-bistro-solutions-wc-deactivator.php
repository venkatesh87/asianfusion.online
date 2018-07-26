<?php

/**
 * Fired during plugin deactivation
 *
 * @link       https://www.bistrosol.co
 * @since      1.0.0
 *
 * @package    Bistro_Solutions_Wc
 * @subpackage Bistro_Solutions_Wc/includes
 */

/**
 * Fired during plugin deactivation.
 *
 * This class defines all code necessary to run during the plugin's deactivation.
 *
 * @since      1.0.0
 * @package    Bistro_Solutions_Wc
 * @subpackage Bistro_Solutions_Wc/includes
 * @author     Alan Zhao <azhao6060@gmail.com>
 */
class Bistro_Solutions_Wc_Deactivator {

	/**
	 * Short Description. (use period)
	 *
	 * Long Description.
	 *
	 * @since    1.0.0
	 */
	public static function deactivate() {
    remove_role( 'bistrosol_wc_sync' );
	}

}
