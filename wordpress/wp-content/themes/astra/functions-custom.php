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

// example custom dashboard widget
function custom_dashboard_widget() {
	echo "<p>Dearest Client, Here&rsquo;s how to do that thing I told you about yesterday...</p>";
}

function add_custom_dashboard_widget() {
	wp_add_dashboard_widget('custom_dashboard_widget', 'How to Do Something in WordPress', 'custom_dashboard_widget');
}

add_action('wp_dashboard_setup', 'add_custom_dashboard_widget');
