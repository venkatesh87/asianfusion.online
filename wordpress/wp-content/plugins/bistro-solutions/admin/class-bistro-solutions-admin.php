<?php

/**
 * The admin-specific functionality of the plugin.
 *
 * @link       https://www.bistrosol.co
 * @since      1.0.0
 *
 * @package    Bistro_Solutions
 * @subpackage Bistro_Solutions/admin
 */

/**
 * The admin-specific functionality of the plugin.
 *
 * Defines the plugin name, version, and two examples hooks for how to
 * enqueue the admin-specific stylesheet and JavaScript.
 *
 * @package    Bistro_Solutions
 * @subpackage Bistro_Solutions/admin
 * @author     Alan Zhao <azhao6060@gmail.com>
 */
class Bistro_Solutions_Admin {

	/**
	 * The ID of this plugin.
	 *
	 * @since    1.0.0
	 * @access   private
	 * @var      string    $plugin_name    The ID of this plugin.
	 */
	private $plugin_name;

	/**
	 * The version of this plugin.
	 *
	 * @since    1.0.0
	 * @access   private
	 * @var      string    $version    The current version of this plugin.
	 */
	private $version;

	/**
	 * Initialize the class and set its properties.
	 *
	 * @since    1.0.0
	 * @param      string    $plugin_name       The name of this plugin.
	 * @param      string    $version    The version of this plugin.
	 */
	public function __construct( $plugin_name, $version ) {

		$this->plugin_name = $plugin_name;
    $this->version = $version;

    $this->options = get_option( 'bistrosol_settings' );

	}

	/**
	 * Register the stylesheets for the admin area.
	 *
	 * @since    1.0.0
	 */
	public function enqueue_styles() {

		/**
		 * This function is provided for demonstration purposes only.
		 *
		 * An instance of this class should be passed to the run() function
		 * defined in Bistro_Solutions_Loader as all of the hooks are defined
		 * in that particular class.
		 *
		 * The Bistro_Solutions_Loader will then create the relationship
		 * between the defined hooks and the functions defined in this
		 * class.
		 */

		wp_enqueue_style( $this->plugin_name, plugin_dir_url( __FILE__ ) . 'css/bistro-solutions-admin.css', array(), $this->version, 'all' );

	}

	/**
	 * Register the JavaScript for the admin area.
	 *
	 * @since    1.0.0
	 */
	public function enqueue_scripts() {

		/**
		 * This function is provided for demonstration purposes only.
		 *
		 * An instance of this class should be passed to the run() function
		 * defined in Bistro_Solutions_Loader as all of the hooks are defined
		 * in that particular class.
		 *
		 * The Bistro_Solutions_Loader will then create the relationship
		 * between the defined hooks and the functions defined in this
		 * class.
		 */

		wp_enqueue_script( $this->plugin_name, plugin_dir_url( __FILE__ ) . 'js/bistro-solutions-admin.js', array( 'jquery' ), $this->version, false );

  }

  public function add_menu() {

    // Add menu for bistrosol users
    
    add_menu_page( 'Bistro Solutions', 'Bistro Solutions', 'bistrosol_user', 'bistrosol', '', 'data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA3MC40OCA3My4xNSI+PGRlZnM+PHN0eWxlPi5jbHMtMXtmaWxsOiNjNjljNmQ7fTwvc3R5bGU+PC9kZWZzPjx0aXRsZT5Bc3NldCAxPC90aXRsZT48ZyBpZD0iTGF5ZXJfMiIgZGF0YS1uYW1lPSJMYXllciAyIj48ZyBpZD0iTGF5ZXJfMS0yIiBkYXRhLW5hbWU9IkxheWVyIDEiPjxwYXRoIGNsYXNzPSJjbHMtMSIgZD0iTTY4LjQ3LDQ3Yy0uMy0uOS0uOC0xLjctMS4xLTIuN2ExMy4xOCwxMy4xOCwwLDAsMS0xLTMuOSwyNiwyNiwwLDAsMC0uNS0zLjksMTAuMTUsMTAuMTUsMCwwLDEsLjktNS40LDkuNTksOS41OSwwLDAsMCwuNy00LjEsNy42LDcuNiwwLDAsMC0uNi0yLjZjLS4xLS4zLS40LS43LS41LTFhMjguNzUsMjguNzUsMCwwLDAtNC4xLTUuOSwxOC43MSwxOC43MSwwLDAsMS0zLjYtNC4zYy0uNC0uNy0xLTEuNC0xLjQtMi4xYTEwLDEwLDAsMCwxLTEuMS01LjksNi4xNSw2LjE1LDAsMCwxLC4xLTEuMywxMC4yNCwxMC4yNCwwLDAsMSwxLTMuNGMuMS0uMywwLS41LS4zLS41YTcuMzIsNy4zMiwwLDAsMC0yLjUuOCw3LjcxLDcuNzEsMCwwLDAtMy4xLDMuMSwxNC40OSwxNC40OSwwLDAsMC0xLjIsMy41LDEwLjY2LDEwLjY2LDAsMCwwLC4xLDQuN2MwLC4xLjEuMS4xLjJzLS4xLjItLjEuMy0uMi4yLS4zLjEtLjItLjEtLjItLjJhMTEuMDUsMTEuMDUsMCwwLDEtLjktMy4xYy0uMS0uNC0uMS0uOC0uMi0xLjJhLjg1Ljg1LDAsMCwwLS4yLS42Yy0uMSwwLS4xLjEtLjIuMnMtLjEuMi0uMS4zYy0uMS43LS4yLDEuMy0uMywyLDAsLjEtLjEuMi0uMi40YS4zOC4zOCwwLDAsMS0uNiwwbC0uMy0uM2EzLjQxLDMuNDEsMCwwLDEsLjYtMy42cTEuNS0yLDMuMy0zLjloMGMxLTEuMi01LjktMi4zLTYuOC0yLjRhMjQuMDksMjQuMDksMCwwLDAtNy4xLS4xYy00LjMuNS05LjMsMS43LTEzLjEsNGExMC44NiwxMC44NiwwLDAsMC0yLjYsMi4yQTEwLjcsMTAuNywwLDAsMCwxOS42Nyw4Yy0uMS4yLS42LDItLjEsMS40YTguMTYsOC4xNiwwLDAsMSwzLjUtMS43LDEyLjIxLDEyLjIxLDAsMCwxLDUuNy4xLDE4LjM4LDE4LjM4LDAsMCwwLDYuMi40aDBjMS41LS4yLjguNy4xLDEuMmE3LjM1LDcuMzUsMCwwLDEtMywuN2MtMS44LjItMy44LDAtNS41LjQtMy4zLjgtNi43LDQuNS04LjgsN2EyMC43NCwyMC43NCwwLDAsMC0xLjksMy4yYy0uMS4zLTEuNCwyLjktMS43LDIuM2EuMzcuMzcsMCwwLDEtLjEtLjMsMTEuMDcsMTEuMDcsMCwwLDEsLjctMi42LDIyLjQsMjIuNCwwLDAsMSwzLjMtNS4zLDE3LjQxLDE3LjQxLDAsMCwwLDEuMi0xLjQsMS40NiwxLjQ2LDAsMCwwLC4zLS41LDEuMTksMS4xOSwwLDAsMC0uNi4yYy01LjIsMi40LTguNSw2LjYtMTIuMSwxMC45YTI5LjE2LDI5LjE2LDAsMCwwLTUuNSw5LjFjLTIuMyw2LjctMS42LDE1LjEsMS4zLDIxLjYsMCwwLDExLjEtMi4xLDIwLjcsOC43czI0LjEsOS43LDI0LjEsOS43Yy0xMS45LTEwLjktNi0zMi44LTYtMzIuOCwxLjguNiwzLjYsMS4yLDUuNCwxLjlhLjUyLjUyLDAsMCwxLC4zLjcsNC44NSw0Ljg1LDAsMCwwLC45LDQuNiwxMC4yMSwxMC4yMSwwLDAsMSwyLjIsNC43LDQuMTYsNC4xNiwwLDAsMS0uMiwyLjIsMzQsMzQsMCwwLDAtMS4yLDMuNCwyLjUzLDIuNTMsMCwwLDAsMSwyLjcsMTAuNTksMTAuNTksMCwwLDEsMS4yLDEsMTAuMjgsMTAuMjgsMCwwLDAsMi45LDIuMSwxLjQ1LDEuNDUsMCwwLDAsLjcuMmMuNy4xLjgtLjEuOS0uOGExMy4yOCwxMy4yOCwwLDAsMC0uNC00YzAtLjMtLjEtLjYtLjEtLjksMC0uOC4yLTEsMS4xLTFhMS41OCwxLjU4LDAsMCwxLDEuOCwxLjZjLjEuOS4xLDEuNy4yLDIuNiwwLDEuMi0uMSwyLjMsMCwzLjVhMy4zOCwzLjM4LDAsMCwwLDMuMywzLjIuNzYuNzYsMCwwLDAsLjUtLjJjLjItLjQuNC0uOC42LTEuMy4xLS4zLjEtLjYuMi0xYTcuMTEsNy4xMSwwLDAsMSwzLjItNC43Yy45LS43LDEuOS0xLjMsMi44LTIuMWE0LDQsMCwwLDAsMS43LTMuNiwxNi4xNCwxNi4xNCwwLDAsMC0uNy00LjlBMTYuMzEsMTYuMzEsMCwwLDEsNjguNDcsNDdaIi8+PC9nPjwvZz48L3N2Zz4=', 2 );

    add_submenu_page( 'bistrosol' , 'Bistro Solutions - Overview', 'Overview', 'bistrosol_user_view_dashboard', 'bistrosol', array($this, 'dashboard_page'));

    add_submenu_page( 'bistrosol' , 'Bistro Solutions - Settings', 'Settings', 'bistrosol_user_edit_settings', 'bistrosol-settings', array($this, 'settings_page') );

    add_submenu_page( 'bistrosol', 'Bistro Solutions - Orders', 'Orders', 'bistrosol_user_view_orders', 'bistrosol-orders', array($this, 'orders_page'));

    add_submenu_page( 'bistrosol', 'Bistro Solutions - Customers', 'Customers', 'bistrosol_user_view_customers', 'bistrosol-customers', array($this, 'customers_page') );

    add_submenu_page( 'bistrosol', 'Bistro Solutions - Reports', 'Reports', 'bistrosol_user_view_reports', 'bistrosol-reports', array($this, 'reports_page') );

    // Add menu for bistrosol customers

    add_menu_page( 'Orders', 'Orders', 'bistrosol_customer_orders', 'orders', array($this, 'customer_orders_page'), 'dashicons-cart');
    add_menu_page( 'Addresses', 'Addresses', 'bistrosol_customer_addresses', 'addresses', array($this, 'customer_addresses_page'), 'dashicons-location');
    add_menu_page( 'Preferences', 'Preferences', 'bistrosol_customer_preferences', 'preferences', array($this, 'customer_preferences_page'), 'dashicons-star-filled');

    if (current_user_can('bistrosol_customer')) {
      add_action('admin_bar_menu', array($this, 'add_customer_admin_bar_links'), 999);
    }

  }

  public function add_customer_admin_bar_links($wp_admin_bar) {
    $args = array(
        'id' => 'view-cart',
        'title' => '<span class="ab-icon"></span><span>View Cart</span>', 
        'href' => '/cart', 
        'meta' => array(
            'title' => 'View Cart'
            )
    );
    $wp_admin_bar->add_node($args);

    $args = array(
        'id' => 'checkout',
        'title' => '<span class="ab-icon"></span><span>Checkout</a>', 
        'href' => '/cart', 
        'meta' => array(
            'title' => 'Checkout'
            )
    );
    $wp_admin_bar->add_node($args);
  }

  public function init_settings(  ) {

    register_setting( 'bistrosol_settings_group', 'bistrosol_settings' );

    // Add capability for the setting group
    add_filter( 'option_page_capability_bistrosol_settings_group', 'bistrosol_user_edit_settings');

    function bistrosol_user_edit_settings() {
      return 'bistrosol_user_edit_settings';
    }

    add_settings_section(
      'database_section',
      __( 'Database', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_section_callback'),
      'bistrosol_settings_group'
    );

    add_settings_field(
      'database_host',
      __( 'Host', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_host_render'),
      'bistrosol_settings_group',
      'database_section',
      array(
        'label_for' => 'database_host',
        'class' => 'database_host_field required'
      )
    );

    add_settings_field(
      'database_name',
      __( 'Name', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_name_render'),
      'bistrosol_settings_group',
      'database_section',
      array(
        'label_for' => 'database_name',
        'class' => 'database_name_field required'
      )
    );

    add_settings_field(
      'database_user',
      __( 'User', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_user_render'),
      'bistrosol_settings_group',
      'database_section',
      array(
        'label_for' => 'database_user',
        'class' => 'database_user_field required'
      )
    );

    add_settings_field(
      'database_password',
      __( 'Password', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_password_render'),
      'bistrosol_settings_group',
      'database_section',
      array(
        'label_for' => 'database_password',
        'class' => 'database_password_field required'
      )
    );

    add_settings_field(
      'database_port',
      __( 'Port', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_port_render'),
      'bistrosol_settings_group',
      'database_section',
      array(
        'label_for' => 'database_port',
        'class' => 'database_port_field required'
      )
    );

    /*
    add_settings_field(
      'database_ca',
      __( 'ca.pem', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_ca_render'),
      'bistrosol_settings_group',
      'database_section'
    );

    add_settings_field(
      'database_client_cert',
      __( 'client-cert.pem', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_client_cert_render'),
      'bistrosol_settings_group',
      'database_section'
    );

    add_settings_field(
      'database_client_key',
      __( 'client-key.pem', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_client_key_render'),
      'bistrosol_settings_group',
      'database_section'
    );
     */
  }

  public function settings_page(  ) { 
    ?>
    <form enctype='multipart/form-data' id='bistrosol-db-settings-form' action='options.php' method='post' autocomplete='off'>

      <h2>Bistro Solutions</h2>

      <?php
      settings_fields( 'bistrosol_settings_group' );
      do_settings_sections( 'bistrosol_settings_group' );
      $this->test_db_connection_button();
      submit_button();
      ?>
      <span id="bistrosol-db-settings-form-error">
        <?=__( 'Highlighted fields are required.', BISTRO_SOLUTIONS_TEXTDOMAIN )?>
      <span> 

    </form>
    <?php

  }

  public function database_section_callback(  ) { 

    echo __( 'Enter Bistro Solutions database credential below.', BISTRO_SOLUTIONS_TEXTDOMAIN );

  }

  public function database_host_render(  ) { 
    ?>
    <input type='text' id='database_host' name='bistrosol_settings[database_host]' value='<?=$this->options['database_host']; ?>'>
    <?php

  }

  public function database_name_render(  ) { 
    ?>
    <input type='text' id='database_name' name='bistrosol_settings[database_name]' value='<?=$this->options['database_name']; ?>'>
    <?php

  }

  public function database_user_render(  ) { 
    ?>
    <input type='text' id='database_user' name='bistrosol_settings[database_user]' value='<?=$this->options['database_user']; ?>'>
    <?php

  }

  public function database_password_render(  ) { 
    ?>
    <input type='password' id='database_password' name='bistrosol_settings[database_password]' value='<?=$this->options['database_password']; ?>'>
    <?php

  }

  public function database_port_render(  ) { 
    ?>
    <input type='text' id='database_port' name='bistrosol_settings[database_port]' value='<?=$this->options['database_port'] ? $this->options['database_port'] : '3306'; ?>'>
    <?php

  }

  public function database_ca_render(  ) { 
    ?>
    <input type='file' accept='.pem' id='database_ca' name='bistrosol_settings[database_ca]' value='<?=$this->options['database_ca']; ?>'>
    <?php

  }

  public function database_client_cert_render(  ) { 
    ?>
    <input type='file' accept='.pem' id='database_client_cert' name='bistrosol_settings[database_client_cert]' value='<?=$this->options['database_client_cert']; ?>'>
    <?php

  }

  public function database_client_key_render(  ) { 
    ?>
    <input type='file' accept='.pem' id='database_client_key' name='bistrosol_settings[database_client_key]' value='<?=$this->options['database_client_key']; ?>'>
    <?php

  }

  public function test_db_connection_button() {
    ?>
      <input type="button" class="button button-secondary" value="Test Database Connection" id="test-db-connection" name="test-db-connection" />
      <span id="test-db-result-connected">
        <?=__( 'Database is connected.', BISTRO_SOLUTIONS_TEXTDOMAIN )?>
      </span>
      <span id="test-db-result-not-connected">
        <?=__( 'Database is not connected.', BISTRO_SOLUTIONS_TEXTDOMAIN )?>
      </span>
      <span id="test-db-spinner">Please wait...</span>
    <?php
  }

  public function test_db_connection_ajax() {
    //var_dump($_POST);
    //var_dump($_FILES);
    define( 'WP_DEBUG_DISPLAY', false );
    define( 'WP_DEBUG', true );
    define( 'WP_DEBUG_LOG', true );
    
    $response = array('success' => false);

    $db_host = $_POST['database_host'];
    $db_user = $_POST['database_user'];
    $db_name = $_POST['database_name'];
    $db_password = $_POST['database_password'];
    $db_port = $_POST['database_port'];
    
    $bistrosol_db = new wpdb( $db_user, $db_password, $db_name, $db_host . ':' . $db_port );

    if ($bistrosol_db && $bistrosol_db->error) {
      echo json_encode($response);
      exit;
    }

    $server_id = $bistrosol_db->get_var('SELECT @@server_id');
    if ($server_id == '1000') {
      $response['success'] = true;
    }

    header( 'Content-Type: application/json' );
    echo json_encode($response);
    exit;
  }

  public function dashboard_page() {
    echo '<h2>Dashboard</h2>'; 
  }

  public function orders_page() {
    echo '<h2>Orders</h2>'; 
  }

  public function customers_page() {
    echo '<h2>Customers</h2>'; 
  }

  public function reports_page() {
    echo '<h2>Reports</h2>'; 
  }

  public function customer_orders_page() {
    echo '<h2>Orders</h2>'; 
  }

  public function customer_addresses_page() {
    echo '<h2>Addresses</h2>'; 
  }

  public function customer_preferences_page() {
    echo '<h2>Preferences</h2>'; 
  }
}
