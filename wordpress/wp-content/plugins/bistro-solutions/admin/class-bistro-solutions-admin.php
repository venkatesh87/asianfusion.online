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

    $this->database_options = get_option( 'bistrosol_database_settings' );
    $this->account_options = get_option( 'bistrosol_account_settings' );

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
        'href' => '/checkout', 
        'meta' => array(
            'title' => 'Checkout'
            )
    );
    $wp_admin_bar->add_node($args);
  }

  public function sanitize($input) {
    foreach ($input as $key => $value) {
      $value = sanitize_text_field($value);
      $output[$key] = $value;
    }
    return $output;
  }

  public function init_settings(  ) {

    register_setting( 'bistrosol_database_settings_group', 'bistrosol_database_settings', array('sanitize_callback' => array($this, 'sanitize')) );
    register_setting( 'bistrosol_account_settings_group', 'bistrosol_account_settings', array('sanitize_callback' => array($this, 'sanitize')) );

    // Add capability for the database setting group
    add_filter( 'option_page_capability_bistrosol_database_settings_group', 'bistrosol_user_edit_settings');
    // Add capability for the account setting group
    add_filter( 'option_page_capability_bistrosol_account_settings_group', 'bistrosol_user_edit_settings');

    function bistrosol_user_edit_settings() {
      return 'bistrosol_user_edit_settings';
    }

    add_settings_section(
      'account_section',
      __( 'Account', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'account_section_callback'),
      'bistrosol_account_settings_group'
    );

    add_settings_field(
      'account_name',
      __( 'Name', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'account_name_render'),
      'bistrosol_account_settings_group',
      'account_section',
      array(
        'label_for' => 'account_name',
        'class' => 'account_name_field required'
      )
    );

    add_settings_section(
      'database_section',
      __( 'Database', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_section_callback'),
      'bistrosol_database_settings_group'
    );

    add_settings_field(
      'database_host',
      __( 'Host', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_host_render'),
      'bistrosol_database_settings_group',
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
      'bistrosol_database_settings_group',
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
      'bistrosol_database_settings_group',
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
      'bistrosol_database_settings_group',
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
      'bistrosol_database_settings_group',
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
      'bistrosol_database_settings_group',
      'database_section'
    );

    add_settings_field(
      'database_client_cert',
      __( 'client-cert.pem', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_client_cert_render'),
      'bistrosol_database_settings_group',
      'database_section'
    );

    add_settings_field(
      'database_client_key',
      __( 'client-key.pem', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_client_key_render'),
      'bistrosol_database_settings_group',
      'database_section'
    );
     */
  }

  public function settings_page(  ) { 
    // https://code.tutsplus.com/tutorials/the-wordpress-settings-api-part-5-tabbed-navigation-for-settings--wp-24971
    $active_tab = isset( $_GET[ 'tab' ] ) ? $_GET[ 'tab' ] : 'account';
?>
    <div class="wrap">
    <h2>Settings</h2>

    <?=settings_errors()?>

    <h2 class="nav-tab-wrapper">
        <a href="?page=bistrosol-settings&tab=account" class="nav-tab<?=$active_tab == 'account' ? ' nav-tab-active' : ''?>">Account</a>
        <a href="?page=bistrosol-settings&tab=database" class="nav-tab<?=$active_tab == 'database' ? ' nav-tab-active' : ''?>">Database</a>
    </h2>

    <?php if ($active_tab == 'account') { ?>

    <form enctype='multipart/form-data' id='bistrosol-account-settings-form' action='options.php' method='post' autocomplete='off'>
      <?php
      settings_fields( 'bistrosol_account_settings_group' );
      do_settings_sections( 'bistrosol_account_settings_group' );
      submit_button('Save', 'primary', 'save-account-changes', true, array('id' => 'save-account-changes'));
      ?>
      <span id="bistrosol-account-settings-form-error">
        <?=__( 'Highlighted fields are required.', BISTRO_SOLUTIONS_TEXTDOMAIN )?>
      </span> 
    </form>

    <?php } else if ($active_tab == 'database') { ?>

    <form enctype='multipart/form-data' id='bistrosol-database-settings-form' action='options.php' method='post' autocomplete='off'>
    <?php
      settings_fields( 'bistrosol_database_settings_group' );
      do_settings_sections( 'bistrosol_database_settings_group' );
      $this->test_db_connection_button();
      submit_button('Save', 'primary', 'save-database-changes', true, array('id' => 'save-database-changes'));
      ?>
      <span id="bistrosol-database-settings-form-error">
        <?=__( 'Highlighted fields are required.', BISTRO_SOLUTIONS_TEXTDOMAIN )?>
      </span> 
    </form>
    <?php } ?>
    </div>
    <?php
  }

  public function account_section_callback(  ) { 

    echo __( 'Enter Bistro Solutions account information below.', BISTRO_SOLUTIONS_TEXTDOMAIN );

  }

  public function account_name_render(  ) { 
    ?>
    <input type='text' id='account_name' name='bistrosol_account_settings[account_name]' value='<?=$this->account_options['account_name']; ?>'>
    <?php

  }

  public function database_section_callback(  ) { 

    echo __( 'Enter Bistro Solutions database credential below.', BISTRO_SOLUTIONS_TEXTDOMAIN );

  }

  public function database_host_render(  ) { 
    ?>
    <input type='text' id='database_host' name='bistrosol_database_settings[database_host]' value='<?=$this->database_options['database_host']; ?>'>
    <?php

  }

  public function database_name_render(  ) { 
    ?>
    <input type='text' id='database_name' name='bistrosol_database_settings[database_name]' value='<?=$this->database_options['database_name']; ?>'>
    <?php

  }

  public function database_user_render(  ) { 
    ?>
    <input type='text' id='database_user' name='bistrosol_database_settings[database_user]' value='<?=$this->database_options['database_user']; ?>'>
    <?php

  }

  public function database_password_render(  ) { 
    ?>
    <input type='password' id='database_password' name='bistrosol_database_settings[database_password]' value='<?=$this->database_options['database_password']; ?>'>
    <?php

  }

  public function database_port_render(  ) { 
    ?>
    <input type='text' id='database_port' name='bistrosol_database_settings[database_port]' value='<?=$this->database_options['database_port'] ? $this->database_options['database_port'] : '3306'; ?>'>
    <?php

  }

  public function database_ca_render(  ) { 
    ?>
    <input type='file' accept='.pem' id='database_ca' name='bistrosol_database_settings[database_ca]' value='<?=$this->database_options['database_ca']; ?>'>
    <?php

  }

  public function database_client_cert_render(  ) { 
    ?>
    <input type='file' accept='.pem' id='database_client_cert' name='bistrosol_database_settings[database_client_cert]' value='<?=$this->database_options['database_client_cert']; ?>'>
    <?php

  }

  public function database_client_key_render(  ) { 
    ?>
    <input type='file' accept='.pem' id='database_client_key' name='bistrosol_database_settings[database_client_key]' value='<?=$this->database_options['database_client_key']; ?>'>
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
    
    $response = array('success' => false);

    $db_host = $_POST['database_host'];
    $db_user = $_POST['database_user'];
    $db_name = $_POST['database_name'];
    $db_password = $_POST['database_password'];
    $db_port = $_POST['database_port'];
    
    $bdb = new wpdb( $db_user, $db_password, $db_name, $db_host . ':' . $db_port );

    if ($bdb && $bdb->error) {
      echo json_encode($response);
      exit;
    }

    $server_id = $bdb->get_var('SELECT @@server_id');
    if ($server_id == '1000') {
      $response['success'] = true;
    }

    header( 'Content-Type: application/json' );
    echo json_encode($response);
    exit;
  }

  public function init_bdb() {
    global $bdb;

    ini_set('mysql.connect_timeout', 5);
    ini_set('default_socket_timeout', 5);

    if (!$bdb && !empty($this->database_options['database_name'])
      && !empty($this->database_options['database_host'])
      && !empty($this->database_options['database_user'])
      && !empty($this->database_options['database_password'])
      && !empty($this->database_options['database_port'])) {
      $bdb = new wpdb( $this->database_options['database_user'],
        $this->database_options['database_password'],
        $this->database_options['database_name'],
        $this->database_options['database_host']
        . ':' . $this->database_options['database_port'] );
    }
    
    if (current_user_can('bistrosol_user_edit_settings')) {
      add_action( 'wp_dashboard_setup', array($this, 'master_database_info_widget_setup') );
    }
  }

  public function master_database_info_widget_setup() {
    	wp_add_dashboard_widget(
          'master_database_info_widget',
          'Bistro Solutions Master Database Info',
          array( $this, 'master_database_info_widget_render')
        );

  // Globalize the metaboxes array, this holds all the widgets for wp-admin

 	global $wp_meta_boxes;

 	// Get the regular dashboard widgets array
 	// (which has our new widget already but at the end)

 	$normal_dashboard = $wp_meta_boxes['dashboard']['normal']['core'];

 	// Backup and delete our new dashboard widget from the end of the array

 	$master_database_info_widget_backup = array( 'master_database_info_widget' => $normal_dashboard['master_database_info_widget'] );
 	unset( $normal_dashboard['master_database_info_widget'] );

 	// Merge the two arrays together so our widget is at the beginning

 	$sorted_dashboard = array_merge( $master_database_info_widget_backup, $normal_dashboard );

 	// Save the sorted array back into the original metaboxes

 	$wp_meta_boxes['dashboard']['normal']['core'] = $sorted_dashboard;
  }

  public function master_database_info_widget_render() {
    //echo '<pre>';
    //var_dump($bdb->error);
    //echo '</pre>';

    $db_error = $this->get_db_connect_error();

    if (!$db_error) {
      echo '<div>Database is connected</div>';
    } else {
      echo '<div>Master database error: ' . $db_error . '</div>';
    }

    echo '<ul>';
    echo '<li><strong>Database Version:</strong> ' . $this->get_db_version() . '</li>';
    echo '<li><strong>Database Host:</strong> ' . $this->database_options['database_host'] . '</li>';
    echo '<li><strong>Database User:</strong> ' . $this->database_options['database_user'] . '</li>';
    echo '<li><strong>Database Name:</strong> ' . $this->database_options['database_name'] . '</li>';
    echo '<li><strong>Uptime:</strong> ' . $this->get_db_uptime() . '</li>';
    echo '<li><strong>Connections:</strong></li>';
    echo '<ul class="dashboard-info">';
    echo '<pre>';
    foreach ($this->get_db_connections() as $user => $hosts) {
      echo '<strong>' . $user . "</strong>\n";
      foreach ($hosts as $host) {
        echo "\t" . $host . "\n";
      }
    }
    echo '</pre>';
    echo '</ul>';
    echo '</ul>';
  }

  public function get_db_connect_error() {
    global $bdb;

    $db_error = null;

    if ($bdb->error && $bdb->error->errors) {
      $db_errors = $bdb->error->errors;
      if ($db_errors['db_connect_fail'][0]) {
        $db_error = $db_errors['db_connect_fail'][0];
        $db_error = 'Error establishing a database connection';
      } else if ($db_errors['db_select_fail'][0]) {
        $db_error = $db_errors['db_select_fail'][0];
        $db_error = 'Can’t select database';
      }
    }

    return $db_error;
  }

  public function get_db_version() {
    global $bdb;

    $version = $bdb->get_var('SELECT @@innodb_version');
    return $version;
  }

  public function get_db_uptime() {
    global $bdb;

    $uptime_sec = $bdb->get_var("SELECT VARIABLE_VALUE FROM performance_schema.global_status WHERE VARIABLE_NAME = 'Uptime'");

    function sec_to_time($seconds) {
      $dtF = new \DateTime('@0');
      $dtT = new \DateTime("@$seconds");
      return $dtF->diff($dtT)->format('%a days, %h hours, %i minutes and %s seconds');
    }

    return sec_to_time($uptime_sec);
  }

  public function get_db_users() {
    global $bdb;

    $users = array();

    $query = "SELECT DISTINCT(User) FROM mysql.user WHERE User NOT IN ('root', 'mysql.infoschema', 'mysql.session', 'mysql.sys')";
    $results = $bdb->get_results($query, ARRAY_A);
    
    foreach ($results as $result) {
      $users[] = $result['User'];
    }

    return $users;
  }

  public function get_db_connections() {
    global $bdb;

    $connections = array();

    $query = "SELECT USER, HOST FROM information_schema.PROCESSLIST WHERE USER IN ('" . implode("','", $this->get_db_users()) . "') AND DB = '" . $this->database_options['database_name'] . "'";
    $results = $bdb->get_results($query, ARRAY_A);

    foreach ($results as $result) {
      $connections[$result['USER']][] = $result['HOST'];
    }

    return $connections;
  }

  public function dashboard_page() {
    global $bdb;
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
