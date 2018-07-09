<?php

/**
 * Fired during plugin activation
 *
 * @link       https://www.bistrosol.co
 * @since      1.0.0
 *
 * @package    Bistro_Solutions
 * @subpackage Bistro_Solutions/includes
 */

/**
 * Fired during plugin activation.
 *
 * This class defines all code necessary to run during the plugin's activation.
 *
 * @since      1.0.0
 * @package    Bistro_Solutions
 * @subpackage Bistro_Solutions/includes
 * @author     Alan Zhao <azhao6060@gmail.com>
 */
class Bistro_Solutions_Activator {

	/**
	 * Short Description. (use period)
	 *
	 * Long Description.
	 *
	 * @since    1.0.0
	 */
  public static function activate() {

    //
    // Pages
    //

    $menu_page_title = __( 'Menu', BISTRO_SOLUTIONS_TEXTDOMAIN );
    $menu_page_check = get_page_by_title($menu_page_title);

    if (!isset($menu_page_check->ID)) {
      $menu_page = array(
        'post_title'    => $menu_page_title,
        'post_content'  => __( 'Menu', BISTRO_SOLUTIONS_TEXTDOMAIN ),
        'post_status'   => 'publish',
        'post_author'   => 1,
        'post_type'     => 'page',
      );

      $menu_page_id = wp_insert_post( $menu_page );
      //update_post_meta($menu_page_id, '_wp_page_template', 'bistro-solutions-base.php');

    } else {
      die( __( 'Menu page already exists.', BISTRO_SOLUTIONS_TEXTDOMAIN ) );
    }
  }
}
