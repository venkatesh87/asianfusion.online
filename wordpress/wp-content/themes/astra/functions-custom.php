<?php

// Custom login logo
function my_login_logo() { ?>
    <style type="text/css">
        #login h1 a, .login h1 a {
            background-image: url(<?php echo get_stylesheet_directory_uri(); ?>/assets/images/login-logo.jpeg);
		        height: 80px;
		        width: 80px;
		        background-size: 80px 80px;
		        background-repeat: no-repeat;
        	  padding-bottom: 30px;
        }
    </style>
<?php }

add_action('login_enqueue_scripts', 'my_login_logo');

// Clean up dashboard
function disable_default_dashboard_widgets() {
	remove_meta_box('dashboard_right_now', 'dashboard', 'core');
	remove_meta_box('dashboard_activity', 'dashboard', 'core');
	remove_meta_box('dashboard_recent_comments', 'dashboard', 'core');
	remove_meta_box('dashboard_incoming_links', 'dashboard', 'core');
	remove_meta_box('dashboard_plugins', 'dashboard', 'core');
	remove_meta_box('dashboard_quick_press', 'dashboard', 'core');
	remove_meta_box('dashboard_recent_drafts', 'dashboard', 'core');
	remove_meta_box('dashboard_primary', 'dashboard', 'core');
  remove_meta_box('dashboard_secondary', 'dashboard', 'core');
  // Yoast SEO
  remove_meta_box('wpseo-dashboard-overview', 'dashboard', 'side');
  // Elementor
  remove_meta_box('e-dashboard-overview', 'dashboard', 'normal');
}
add_action('admin_menu', 'disable_default_dashboard_widgets');

// Remove welcome panel
remove_action('welcome_panel', 'wp_welcome_panel');

// Remove Yoast SEO link from admin bar
add_action('wp_before_admin_bar_render', 'seo_admin_bar');
function seo_admin_bar() {
  global $wp_admin_bar;
  $wp_admin_bar->remove_menu('wpseo-menu');
}

// Remove help tab
function remove_help_tabs($old_help, $screen_id, $screen) {
    $screen->remove_help_tabs();
    return $old_help;
}
add_filter('contextual_help', 'remove_help_tabs', 999, 3);

// Remove screen option tab
add_filter( 'screen_options_show_screen', '__return_false');

// Disable notice for all users
function hide_update_noticee_to_all_but_admin_users() {
    //if (!is_super_admin()) {
        remove_all_actions('admin_notices');
    //}
}
add_action('admin_head', 'hide_update_noticee_to_all_but_admin_users', 1);

// Remove admin menu items
function remove_menus() {  

  //remove_menu_page( 'index.php' );                  //Dashboard  
  //remove_menu_page( 'edit.php' );                   //Posts  
  //remove_menu_page( 'upload.php' );                 //Media  
  //remove_menu_page( 'edit.php?post_type=page' );    //Pages  
  //remove_menu_page( 'edit-comments.php' );          //Comments  
  //remove_menu_page( 'themes.php' );                 //Appearance  
  //remove_menu_page( 'plugins.php' );                //Plugins  
  //remove_menu_page( 'users.php' );                  //Users  
  //remove_menu_page( 'tools.php' );                  //Tools  
  //remove_menu_page( 'options-general.php' );        //Settings  

}  
add_action( 'admin_menu', 'remove_menus' );  

// example custom dashboard widget
function custom_dashboard_widget() {
  global $wpdb;
  echo "<style>.dashboard-info { display: block; border: 1px solid #c0c0c0; padding: 10px; border-radius: 5px; margin: 10px 0; }</style>";
  echo "<ul>";
  echo "<li><strong>Site URL:</strong> " . WP_HOME . "</li>";
  echo "<li><strong>Database Host:</strong> " . DB_HOST . "</li>";
  echo "<li><strong>Database Name:</strong> " . DB_NAME . "</li>";
  echo "<li><strong>Server Settings:</strong></li>";
  echo "<ul class=\"dashboard-info\">";
  echo "<li><strong>PHP version: " . phpversion() . "</li>";
  echo "<li><strong>MySQL version: " . $wpdb->db_version() . "</li>";
  echo "</ul>";
  echo "<li><strong>PHP Settings:</strong></li>";
  echo "<ul class=\"dashboard-info\">";
  echo "<li><strong>memory_limit:</strong> " . ini_get('memory_limit') . "</li>";
  echo "<li><strong>max_execution_time:</strong> " . ini_get('max_execution_time') . "</li>";
  echo "<li><strong>upload_max_filesize:</strong> " . ini_get('upload_max_filesize') . "</li>";
  echo "<li><strong>post_max_size:</strong> " . ini_get('post_max_size') . "</li>";
  echo "<li><strong>zlib.output_compression:</strong> " . (ini_get('zlib.output_compression') ? 'On' : 'Off') . "</li>";
  echo "<li><strong>allow_url_fopen:</strong> " . (ini_get('allow_url_fopen') ? 'On' : 'Off') . "</li>";
  echo "<li><strong>display_errors:</strong> " . (ini_get('display_errors') ? 'On' : 'Off') . "</li>";
  echo "</ul>";
  echo "</ul>";
}

function add_custom_dashboard_widget() {
	wp_add_dashboard_widget('custom_dashboard_widget', 'Environment Info', 'custom_dashboard_widget');
}

add_action('wp_dashboard_setup', 'add_custom_dashboard_widget');

// Hide plugins
function hide_plugins() {
  global $wp_list_table;
  $hideplugin = array(
    'advanced-custom-fields/acf.php',
    'akismet/akismet.php',
    'astra-sites/astra-sites.php',
    'cf7-conditional-fields/contact-form-7-conditional-fields.php',
    'contact-form-7/wp-contact-form-7.php',
    'custom-post-type-ui/custom-post-type-ui.php',
    'elementor/elementor.php',
    'emoji-settings/emojisettings.php',
    'flamingo/flamingo.php',
    'google-analytics-dashboard-for-wp/gadwp.php',
    'minify-html-markup/minify-html.php',
    'simple-301-redirects/wp-simple-301-redirects.php',
    'wordpress-importer/wordpress-importer.php',
    'wordpress-seo/wp-seo.php',
    'wp-email-smtp/wp_email_smtp.php',
    'wpcf7-redirect/wpcf7-redirect.php',
    'wps-hide-login/wps-hide-login.php'
  );
  $mypluginslist = $wp_list_table->items;
  foreach ($mypluginslist as $key => $val) {
    if (in_array($key,$hideplugin)) {
      unset($wp_list_table->items[$key]);
    }
  }
}

//add_action('pre_current_active_plugins', 'hide_plugins');
