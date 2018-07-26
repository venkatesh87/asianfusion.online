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

    // Delete menu page
    $menu_page_title = __( 'Menu', BISTRO_SOLUTIONS_TEXTDOMAIN );
    $menu_page_check = get_page_by_title($menu_page_title);

    if (isset($menu_page_check->ID)) {
      wp_delete_post($menu_page_check->ID, true);
    }

    // Delete department page
    $department_page_title = __( 'Department', BISTRO_SOLUTIONS_TEXTDOMAIN );
    $department_page_check = get_page_by_title($menu_page_title);

    if (isset($department_page_check->ID)) {
      wp_delete_post($department_page_check->ID, true);
    }

    // Delete category page
    $category_page_title = __( 'Category', BISTRO_SOLUTIONS_TEXTDOMAIN );
    $category_page_check = get_page_by_title($category_page_title);

    if (isset($category_page_check->ID)) {
      wp_delete_post($category_page_check->ID, true);
    }

    // Delete item page
    $item_page_title = __( 'Item', BISTRO_SOLUTIONS_TEXTDOMAIN );
    $item_page_check = get_page_by_title($item_page_title);

    if (isset($item_page_check->ID)) {
      wp_delete_post($item_page_check->ID, true);
    }

    // Delete cart page
    $cart_page_title = __( 'Cart', BISTRO_SOLUTIONS_TEXTDOMAIN );
    $cart_page_check = get_page_by_title($cart_page_title);

    if (isset($cart_page_check->ID)) {
      wp_delete_post($cart_page_check->ID, true);
    }

    // Delete checkout page
    $checkout_page_title = __( 'Checkout', BISTRO_SOLUTIONS_TEXTDOMAIN );
    $checokut_page_check = get_page_by_title($checkout_page_title);

    if (isset($checkout_page_check->ID)) {
      wp_delete_post($checkout_page_check->ID, true);
    }

    remove_role( 'bistrosol_admin' );
    remove_role( 'bistrosol_boss' );
    remove_role( 'bistrosol_manager' );
    remove_role( 'bistrosol_staff' );
    remove_role( 'bistrosol_customer' );
	}

}
