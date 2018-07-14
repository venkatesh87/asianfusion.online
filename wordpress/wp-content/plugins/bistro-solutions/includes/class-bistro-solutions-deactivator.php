<?php

/**
 * Fired during plugin deactivation
 *
 * @link       https://www.bistrosol.co
 * @since      1.0.0
 *
 * @package    Bistro_Solutions
 * @subpackage Bistro_Solutions/includes
 */

/**
 * Fired during plugin deactivation.
 *
 * This class defines all code necessary to run during the plugin's deactivation.
 *
 * @since      1.0.0
 * @package    Bistro_Solutions
 * @subpackage Bistro_Solutions/includes
 * @author     Alan Zhao <azhao6060@gmail.com>
 */
class Bistro_Solutions_Deactivator {

	/**
	 * Short Description. (use period)
	 *
	 * Long Description.
	 *
	 * @since    1.0.0
	 */
	public static function deactivate() {
    $menu_page_title = __( 'Menu', BISTRO_SOLUTIONS_TEXTDOMAIN );
    $menu_page_check = get_page_by_title($menu_page_title);

    if (isset($menu_page_check->ID)) {
      wp_delete_post($menu_page_check->ID, true);
    }

    remove_role( 'bistrosol_admin' );
    remove_role( 'bistrosol_boss' );
    remove_role( 'bistrosol_manager' );
    remove_role( 'bistrosol_staff' );
	}

}
