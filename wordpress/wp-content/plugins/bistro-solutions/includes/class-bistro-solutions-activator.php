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

    // Menu page
    
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

      //$menu_page_id = wp_insert_post( $menu_page );

    } else {
      //die( __( 'Menu page already exists.', BISTRO_SOLUTIONS_TEXTDOMAIN ) );
    }

    // Cart page
    
    $cart_page_title = __( 'Cart', BISTRO_SOLUTIONS_TEXTDOMAIN );
    $cart_page_check = get_page_by_title($cart_page_title);

    if (!isset($cart_page_check->ID)) {
      $cart_page = array(
        'post_title'    => $cart_page_title,
        'post_content'  => __( 'Cart', BISTRO_SOLUTIONS_TEXTDOMAIN ),
        'post_status'   => 'publish',
        'post_author'   => 1,
        'post_type'     => 'page',
      );

    } else {
      //die( __( 'Menu page already exists.', BISTRO_SOLUTIONS_TEXTDOMAIN ) );
    }

    // Checkout page
    
    $checkout_page_title = __( 'Checkout', BISTRO_SOLUTIONS_TEXTDOMAIN );
    $checkout_page_check = get_page_by_title($checkout_page_title);

    if (!isset($checkout_page_check->ID)) {
      $checkout_page = array(
        'post_title'    => $checkout_page_title,
        'post_content'  => __( 'Checkout', BISTRO_SOLUTIONS_TEXTDOMAIN ),
        'post_status'   => 'publish',
        'post_author'   => 1,
        'post_type'     => 'page',
      );

    } else {
      //die( __( 'Menu page already exists.', BISTRO_SOLUTIONS_TEXTDOMAIN ) );
    }

    $wp_roles = new WP_Roles();
    $base_role = $wp_roles->get_role('subscriber');
    $base_caps = $base_role->capabilities;

    $admin_role = $wp_roles->get_role('administrator');

    // Define new roles and capabilities

    add_role(
        'bistrosol_admin',
        __( 'Bistro Solutions Admin',  BISTRO_SOLUTIONS_TEXTDOMAIN ),
        array_merge(
          $base_caps,
          array(
            'bistrosol_user' => true, // Bistro Solutions user's default permission
            'bistrosol_edit_settings' => true,
            'bistrosol_view_dashboard' => true,
            'bistrosol_view_orders' => true,
            'bistrosol_edit_orders' => true,
            'bistrosol_view_reports' => true,
            'bistrosol_view_customers' => true,
            'bistrosol_edit_customers' => true,
          )
        )
      );

    add_role(
        'bistrosol_boss',
        __( 'Bistro Solutions Boss',  BISTRO_SOLUTIONS_TEXTDOMAIN ),
        array_merge(
          $base_caps,
          array(
            'bistrosol_user' => true, // Bistro Solutions user's default permission
            'bistrosol_edit_settings' => false,
            'bistrosol_view_dashboard' => true,
            'bistrosol_view_orders' => true,
            'bistrosol_edit_orders' => true,
            'bistrosol_view_reports' => true,
            'bistrosol_view_customers' => true,
            'bistrosol_edit_customers' => true,
          )
        )
      );

    add_role(
        'bistrosol_manager',
        __( 'Bistro Solutions Manager',  BISTRO_SOLUTIONS_TEXTDOMAIN ),
        array_merge(
          $base_caps,
          array(
            'bistrosol_user' => true, // Bistro Solutions user's default permission
            'bistrosol_edit_settings' => false,
            'bistrosol_view_dashboard' => true,
            'bistrosol_view_orders' => true,
            'bistrosol_edit_orders' => true,
            'bistrosol_view_reports' => true,
            'bistrosol_view_customers' => true,
            'bistrosol_edit_customers' => true,
          )
        )
    );

    add_role(
        'bistrosol_staff',
        __( 'Bistro Solutions Staff',  BISTRO_SOLUTIONS_TEXTDOMAIN ),
        array_merge(
          $base_caps,
          array(
            'bistrosol_user' => true, // Bistro Solutions user's default permission
            'bistrosol_edit_settings' => false,
            'bistrosol_view_dashboard' => true,
            'bistrosol_view_orders' => true,
            'bistrosol_edit_orders' => false,
            'bistrosol_view_reports' => false,
            'bistrosol_view_customers' => true,
            'bistrosol_edit_customers' => false,
          )
        )
      );

    // Add capabilities to admin role
    $admin_role->add_cap('bistrosol_user');
    $admin_role->add_cap('bistrosol_user_edit_settings');
    $admin_role->add_cap('bistrosol_user_view_dashboard');
    $admin_role->add_cap('bistrosol_user_view_orders');
    $admin_role->add_cap('bistrosol_user_edit_orders');
    $admin_role->add_cap('bistrosol_user_view_reports');
    $admin_role->add_cap('bistrosol_user_view_customers');
    $admin_role->add_cap('bistrosol_user_edit_customers');

    add_role(
        'bistrosol_customer',
        __( 'Bistro Solutions Customer',  BISTRO_SOLUTIONS_TEXTDOMAIN ),
        array_merge(
          $base_caps,
          array(
            'bistrosol_customer' => true, // Bistro Solutions customer's default permission
            'bistrosol_customer_orders' => true,
            'bistrosol_customer_addresses' => true,
            'bistrosol_customer_preferences' => true
          )
        )
      );
  }
}
