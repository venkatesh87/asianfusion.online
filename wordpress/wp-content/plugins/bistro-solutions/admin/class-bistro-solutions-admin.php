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

    add_submenu_page( 'bistrosol' , 'Bistro Solutions - Overview', 'Overview', 'bistrosol_user', 'bistrosol', array($this, 'overview_page'));

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

    add_settings_field(
      'secret_token',
      __( 'Secret Token', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'secret_token_render'),
      'bistrosol_account_settings_group',
      'account_section',
      array(
        'label_for' => 'secret_token',
        'class' => 'secret_token_field required'
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

  public function secret_token_render(  ) { 
    ?>
    <input type='text' id='secret_token' name='bistrosol_account_settings[secret_token]' value='<?=$this->account_options['secret_token']; ?>'>
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
      <span id="test-db-spinner" class="bistrosol-loading-indicator">Please wait...</span>
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

    // Shorten MySQL connection timeout
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
  }

  public function add_dashboard_widgets() {
    
    if (current_user_can('bistrosol_user_edit_settings')) {
      add_action( 'wp_dashboard_setup', array($this, 'master_database_info_widget_setup') );
      add_action( 'wp_dashboard_setup', array($this, 'release_info_widget_setup') );
      add_action( 'wp_dashboard_setup', array($this, 'news_widget_setup') );
      add_action( 'wp_dashboard_setup', array($this, 'account_info_widget_setup') );
      add_action( 'wp_dashboard_setup', array($this, 'support_info_widget_setup') );
      add_action( 'wp_dashboard_setup', array($this, 'terminal_info_widget_setup') );
      add_action( 'wp_dashboard_setup', array($this, 'quick_serve_info_widget_setup') );
    }

      add_action( 'wp_dashboard_setup', array($this, 'test_widget_setup') );
  }

  public function test_widget_setup() {
    wp_add_dashboard_widget(
        'bistrosol_test_widget',
        'Bistro Solutions Test',
        array( $this, 'test_widget_render')
      );
  }

  public function test_widget_render() {
    echo '<input type="button" class="button button-secondary" value="Create Test Products" id="create-test-products" name="create-test-products" />';
  }

  public function news_widget_setup() {
    wp_add_dashboard_widget(
        'bistrosol_news_widget',
        'Bistro Solutions News',
        array( $this, 'news_widget_render')
      );
  }

  public function news_widget_render() {
    echo '<span id="bistrosol-feed-error">';
    echo 'Error loading feed, try again later.';
    echo '</span>';

    echo '<div id="bistrosol-news">';
    echo '<span class="bistrosol-loading-indicator">Loading...</span>';
    echo '</div>';
  }


  public function release_info_widget_setup() {
    wp_add_dashboard_widget(
        'bistrosol_release_info_widget',
        'Bistro Solutions Release Info',
        array( $this, 'release_info_widget_render')
      );
  }

  public function release_info_widget_render() {
    echo '<div>Current version is: ';
    echo '<span id="bistrosol-release-version">';
    echo '<span class="bistrosol-loading-indicator">Loading...</span>';
    echo '</span>';
    echo '</div>';

    echo '<div>Releases:</div>';
    echo '<div id="bistrosol-releases">';
    echo '<span class="bistrosol-loading-indicator">Loading...</span>';
    echo '</div>';
  }

  public function account_info_widget_setup() {
    wp_add_dashboard_widget(
        'bistrosol_account_info_widget',
        'Bistro Solutions Account Info',
        array( $this, 'account_info_widget_render')
      );
  }

  public function account_info_widget_render() {
    if (empty($this->account_options['secret_token']) || empty($this->account_options['account_name'])) {
      return false; 
    }
    
    $token = base64_encode(gmdate('Y-m-d-H') . $this->account_options['secret_token']);
    
    echo '<ul>';
    echo '<li><strong>Name:</strong> ' . $this->account_options['account_name'] . '</li>';
    echo '</ul>';
    echo '<input type="hidden" id="bistrosol-account-name" value="' . $this->account_options['account_name'] . '"/>';
    echo '<input type="hidden" id="bistrosol-secret-token" value="' . $token . '"/>';
    echo '<div id="bistrosol-account">';
    echo '<span class="bistrosol-loading-indicator">Loading...</span>';
    echo '</div>';
  }

  public function support_info_widget_setup() {
    wp_add_dashboard_widget(
        'bistrosol_support_info_widget',
        'Bistro Solutions Support Info',
        array( $this, 'support_info_widget_render')
      );
  }

  public function support_info_widget_render() {
  }

  public function terminal_info_widget_setup() {
    wp_add_dashboard_widget(
        'bistrosol_terminal_info_widget',
        'Bistro Solutions Terminal Info',
        array( $this, 'terminal_info_widget_render')
      );
  }

  public function terminal_info_widget_render() {
    global $bdb;

    $db_error = $this->get_db_connect_error();

    if ($db_error) {
      echo '<div class="bistrosol-master-db-error">' . $db_error . '</div>';
      return false;
    }

    // Get upward replication interval
    $query = "SELECT global_config_value_int.value FROM global_configs JOIN global_config_value_int ON (global_configs.id = global_config_value_int.configId) WHERE global_configs.section = 'database' AND global_configs.subsection = 'replication' AND global_configs.name = 'Upward Replication Frequency (Seconds)'";
    $replication_interval = (int)$bdb->get_var($query);

    // 1. Terminals check online status every 10 seconds (hardcode)
    // 2. Upward replication interval
    // 3. Replication lag formular = replication interval x 1
    $this->online_diff = 10 + $replication_interval + ($replication_interval * 1);

    $query = 'SELECT terminals.id AS terminal_id, terminals.name AS terminal_name, terminals.feature, terminals.ipv4, terminals.serverId, TIMESTAMPDIFF(second, terminals.lastOnlineCheck, NOW()) AS last_online_check_time_diff, locations.id AS location_id, locations.name AS location_name FROM terminals JOIN locations ON terminals.locationId = locations.id WHERE locations.active = 1 AND terminals.active = 1 ORDER BY locations.name ASC, terminals.name ASC';

    $results = $bdb->get_results($query, ARRAY_A);

    $terminals = [];
    $locations = [];
    foreach ($results as $result) {
      $locations[$result['location_id']] = $result['location_name'];
      $terminals[$result['location_id']][] = $result;
    }

    echo '<div id="bistrosol-terminals">';
    foreach ($locations as $location_id => $location_name) {
      $location_terminals = $terminals[$location_id];
      echo '<div class="bistrosol-location-name">' . $location_name . '</div>';
      echo '<div>';
      echo '<span class="bistrosol-terminal-name-label">Name</span>';
      echo '<span class="bistrosol-terminal-ip-label">IP</span>';
      echo '<span class="bistrosol-terminal-server-id-label">Server ID</span>';
      echo '<span class="bistrosol-terminal-status-label">Status*</span>';
      echo '</div>';
      foreach ($location_terminals as $terminal) {
        $status = ($terminal['last_online_check_time_diff'] && $terminal['last_online_check_time_diff'] < $this->online_diff) ? '<span class="bistrosol-terminal-status-online">Online</span>' : '<span class="bistrosol-terminal-status-offline">Offline</span>';

        echo '<div class="bistrosol-terminal-row">';
        echo '<span class="bistrosol-terminal-name">';
        echo $terminal['terminal_name'];
        if (!empty($terminal['feature'])) {
          echo '<span class="bistrosol-terminal-feature">' . $terminal['feature'] . '</span>';
        }
        echo '</span>';
        echo '<span class="bistrosol-terminal-ip">' . $terminal['ipv4'] . '</span>';
        echo '<span class="bistrosol-terminal-server-id">' . $terminal['serverId'] . '</span>';
        echo '<span class="bistrosol-terminal-status">' . $status . '</span>';
        echo '</div>';
      }
    }

    echo '<div id="bistrosol-terminal-status-note">*Status report can be delayed by ' . $this->online_diff . ' seconds</div>';
    echo '</div>';
  }

  public function quick_serve_info_widget_setup() {
    wp_add_dashboard_widget(
        'bistrosol_quick_serve_info_widget',
        'Bistro Solutions Quick Serve Info',
        array( $this, 'quick_serve_info_widget_render')
      );
  }

  public function quick_serve_info_widget_render() {
    global $bdb;

    $db_error = $this->get_db_connect_error();

    if ($db_error) {
      echo '<div class="bistrosol-master-db-error">' . $db_error . '</div>';
      return false;
    }

    $query = 'SELECT quick_serve.id AS quick_serve_id, quick_serve.name AS quick_serve_name, quick_serve.feature, quick_serve.ip, quick_serve.model, TIMESTAMPDIFF(second, quick_serve.lastOnlineCheck, NOW()) AS last_online_check_time_diff, locations.id AS location_id, locations.name AS location_name FROM quick_serve JOIN locations ON quick_serve.locationId = locations.id WHERE locations.active = 1 AND quick_serve.active = 1 ORDER BY locations.name ASC, quick_serve.name ASC';

    $results = $bdb->get_results($query, ARRAY_A);

    $quick_serve = [];
    $locations = [];
    foreach ($results as $result) {
      $locations[$result['location_id']] = $result['location_name'];
      $quick_serve[$result['location_id']][] = $result;
    }

    echo '<div id="bistrosol-quick-serve">';
    foreach ($locations as $location_id => $location_name) {
      $location_quick_serve = $quick_serve[$location_id];
      echo '<div class="bistrosol-location-name">' . $location_name . '</div>';
      echo '<div>';
      echo '<span class="bistrosol-quick-serve-name-label">Name</span>';
      echo '<span class="bistrosol-quick-serve-ip-label">IP</span>';
      echo '<span class="bistrosol-quick-serve-model-label">Model</span>';
      echo '<span class="bistrosol-quick-serve-status-label">Status*</span>';
      echo '</div>';
      foreach ($location_quick_serve as $quick_serve) {
        $status = ($quick_serve['last_online_check_time_diff'] && $quick_serve['last_online_check_time_diff'] < $this->online_diff) ? '<span class="bistrosol-quick-serve-status-online">In Use*</span>' : '<span class="bistrosol-quick-serve-status-offline">Not in Use*</span>';

        echo '<div class="bistrosol-quick-serve-row">';
        echo '<span class="bistrosol-quick-serve-name">';
        echo $quick_serve['quick_serve_name'];
        if (!empty($quick_serve['feature'])) {
          echo '<span class="bistrosol-quick-serve-feature">' . $quick_serve['feature'] . '</span>';
        }
        echo '</span>';
        echo '<span class="bistrosol-quick-serve-ip">' . $quick_serve['ip'] . '</span>';
        echo '<span class="bistrosol-quick-serve-model">' . $quick_serve['model'] . '</span>';
        echo '<span class="bistrosol-quick-serve-status">' . $status . '</span>';
        echo '</div>';
      }
    }

    echo '<div id="bistrosol-quick-serve-status-note">*Status report can be delayed by ' . $this->online_diff . ' seconds. <br/>*QuickServe app needs to run in foreground to be consider as In Use.</div>';
    echo '</div>';
  }

  public function master_database_info_widget_setup() {
    wp_add_dashboard_widget(
        'bistrosol_master_database_info_widget',
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
    $db_error = $this->get_db_connect_error();

    if ($db_error) {
      echo '<div class="bistrosol-master-db-error">' . $db_error . '</div>';
      return false;
    } else {
      echo '<div class="bistrosol-master-db-success">Database is connected</div>';
    }

    echo '<ul>';
    echo '<li><strong>Database Version:</strong> ' . $this->get_db_version() . '</li>';
    echo '<li><strong>Database Host:</strong> ' . $this->database_options['database_host'] . '</li>';
    echo '<li><strong>Database User:</strong> ' . $this->database_options['database_user'] . '</li>';
    echo '<li><strong>Database Name:</strong> ' . $this->database_options['database_name'] . '</li>';
    echo '<li><strong>Uptime:</strong> ' . $this->get_db_uptime() . '</li>';
    echo '<li><strong>Connections:</strong></li>';
    echo '<ul class="bistrosol-dashboard-info">';
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

    if (!$bdb) {
      $db_error = 'Database connection setting error';
    } else if ($bdb->error && $bdb->error->errors) {
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

    if (!$bdb) {
      return false;
    }

    $version = $bdb->get_var('SELECT @@innodb_version');

    return $version;
  }

  public function get_db_uptime() {
    global $bdb;

    if (!$bdb) {
      return false;
    }

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

    if (!$bdb) {
      return false;
    }

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

    if (!$bdb) {
      return false;
    }

    $connections = array();

    $query = "SELECT USER, HOST FROM information_schema.PROCESSLIST WHERE USER IN ('" . implode("','", $this->get_db_users()) . "') AND DB = '" . $this->database_options['database_name'] . "'";
    $results = $bdb->get_results($query, ARRAY_A);

    foreach ($results as $result) {
      $connections[$result['USER']][] = $result['HOST'];
    }

    return $connections;
  }

  public function overview_page() {
    echo '<h2>Overview</h2>'; 
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


  public function add_test_products_wc_way() {


    //
    // Convert Bistro Solutions product to WC product
    // Convert WC order to Bistro Solutions Order
    // Convert WC customer to Bistro Solutions Customer
    //


    date_default_timezone_set('America/New_York');

    $create_user_id = 1;
    $bswc_user = get_user_by('login', 'bistrosol_wc_sync');
    if ($bswc_user) {
      $create_user_id = $bswc_user->ID;
    }

    $unique_id = date( 'Ymdhis' );

    //
    // Category
    //

    $category_data = array(
      'thumb'       => 'images/uploads/cat11.png',
      'name'        => 'Category ' . $unique_id,
      'description' => 'Category description',
      'slug'        => 'category-' . $unique_id,
      'parent'      => ''
    );

    $test_category = wp_insert_term(
        $category_data['name'],
        'product_cat',
        array(
            'description'=> $category_data['description'],
            'slug' => $category_data['slug'],
            'parent' => $category_data['parent']
        )
      );

    if ( !$test_category ) {
      echo 'Category not found';
      exit;
    }

    $test_category_id = $test_category['term_id'];

    /*

    //
    // Simple product
    //

    $sp_data = array(
      'name'          => 'Simple product ' . $unique_id,
      'slug'          => 'simple-product-' . $unique_id,
      'sku'           => 'simple-product-' . $unique_id,
      'description'   => 'Simple product description',
      'regular_price' => '9.99',
      'sale_price'    => '5.99',
      'stock_qty'     => '999',
      'post_type'     => 'product',
      'product_type'  => 'simple'
    );

    try {

      // Code: wordpress/wp-content/plugins/woocommerce/includes/abstracts/abstract-wc-product.php
      // Manual: https://docs.woocommerce.com/wc-apidocs/source-class-WC_Product.html
      
      $sp = new WC_Product_Simple();
      $sp->set_name( $sp_data['name'] . ' - wc');
      $sp->set_slug( $sp_data['slug'] . '-wc' );
      $sp->set_sku( $sp_data['sku'] . '-wc' );
      $sp->set_date_created( date('Y-m-d h:i:s') );
      $sp->set_date_modified( date('Y-m-d h:i:s') );
      $sp->set_status( 'publish' );
      $sp->set_featured( false );
      $sp->set_catalog_visibility( 'visible' );
      $sp->set_description( $sp_data['description'] );
      // $sp->set_short_description( '' );
      $sp->set_price( $sp_data['price'] );
      $sp->set_regular_price( $sp_data['regular_price'] );
      // $sp->set_sale_price( $sp_data['sale_price'] );
      // $sp->set_date_on_sale_from();
      // $sp->set_date_on_sale_to();
      // $sp->set_total_sales( 1 );
      // taxable, shipping or none
      $sp->set_tax_status( 'none' );
      // $sp->set_tax_class( '' );
      if ( isset($sp_data['stock_qty']) && is_numeric($sp_data['stock_qty']) ) {
        $sp->set_manage_stock( true );
        $sp->set_stock_quantity( $sp_data['stock_qty'] );
        $sp->set_stock_status( 'instock' );
      } else {
        $sp->set_manage_stock( false );
      }
      $sp->set_backorders( 'no' );
      $sp->set_sold_individually( false );
      // $sp->set_weight( 1 );
      // $sp->set_length( 1 );
      // $sp->set_width( 1 );
      // $sp->set_height( 1 );
      // $sp->set_upsell_ids( 1, 2, 3 ) ;
      // $sp->set_cross_sell_ids( 1, 2, 3 );
      // $sp->set_parent_id( 1 );
      // $sp->set_reviews_allowed( false );
      // $sp->set_purchase_note( '' );

      $sp->set_menu_order( 1 );
      $sp->set_category_ids( array($test_category_id) );
      // $sp->set_tag_ids( array(1) );
      $sp->set_virtual( false );
      // $sp->set_shipping_class_id( 1 );
      // $sp->set_downloadable( false );
      // $sp->set_downloads();
      // $sp->set_download_limit( 1 );
      // $sp->set_download_expiry( '' );
      // $sp->set_gallery_image_ids( array(1, 2, 3) );
      // $sp->set_image_id( 1 );
      // $sp->set_rating_counts( 1 );
      // $sp->set_average_rating(  5 );
      // $sp->set_review_counts( 5 );

      $sp_id = $sp->save();

    } catch ( Exception $e ) {
      echo $e->getMessage();
      exit;
    }

     */

    //
    // Variable product
    //

    $vp_data = array(
      'name'          => 'Variable product ' . $unique_id,
      'slug'          => 'variable-product-' . $unique_id,
      'sku'           => 'variable-product-' . $unique_id,
      'description'   => 'Variable product description',
      'regular_price' => '9.99',
      'sale_price'    => '5.99',
      'stock_qty'     => '999',
      'post_type'     => 'product',
      'product_type'  => 'variable'
    );

    try {

      // Attribute 1
      $a1 = new WC_Product_Attribute();
      //$a1->set_id( 0 );
      $a1->set_name( 'Size' );
      $a1->set_options( array(
        'Small',
        'Large'
      ) );
      $a1->set_position( 1 );
      $a1->set_visible( false );;
      $a1->set_variation( true );

      // Attribute 2
      $a2 = new WC_Product_Attribute();
      //$a2->set_id( 0 );
      $a2->set_name( 'Color' );
      $a2->set_options( array(
        'Black',
        'White'
      ) );
      $a2->set_position( 2 );
      $a2->set_visible( false );;
      $a2->set_variation( true );

      $vp = new WC_Product_Variable();
      $vp->set_name( $vp_data['name'] . ' - wc');
      $vp->set_slug( $vp_data['slug'] . '-wc' );
      $vp->set_date_created( date('Y-m-d H:i:s') );
      $vp->set_date_modified( date('Y-m-d H:i:s') );
      $vp->set_status( 'publish' );
      $vp->set_featured( false );
      $vp->set_catalog_visibility( 'visible' );
      $vp->set_description( $vp_data['description'] );
      // $vp->set_short_description( '' );
      //$vp->set_price( $vp_data['price'] );
      //$vp->set_regular_price( $vp_data['regular_price'] );
      // $vp->set_sale_price( $vp_data['sale_price'] );
      // $vp->set_date_on_sale_from();
      // $vp->set_date_on_sale_to();
      // $vp->set_total_sales( 1 );
      // taxable, shipping or none
      $vp->set_tax_status( 'none' );
      // $vp->set_tax_class( '' );
      $vp->set_sold_individually( false );
      // $vp->set_weight( 1 );
      // $vp->set_length( 1 );
      // $vp->set_width( 1 );
      // $vp->set_height( 1 );
      // $vp->set_upsell_ids( 1, 2, 3 ) ;
      // $vp->set_cross_sell_ids( 1, 2, 3 );
      // $vp->set_parent_id( 1 );
      // $vp->set_reviews_allowed( false );
      // $vp->set_purchase_note( '' );
      $vp->set_menu_order( 1 );
      $vp->set_category_ids( array($test_category_id) );
      // $sp->set_tag_ids( array(1) );

      $vp->set_attributes( array($a1, $a2) );
      /*
      $vp->set_default_attributes( array(
        'size'  => 'Small',
        'color' => 'White'
      ) );
       */
      
      $vp_id = $vp->save();

      // Variation 1
      $v1 = new WC_Product_Variation();
      $v1->set_sku( $vp_data['sku'] . '-wc-sm-wh' );
      $v1->set_description( '' );
      $v1->set_regular_price( $vp_data['regular_price'] );
      $v1->set_parent_id( $vp_id );
      if ( isset($vp_data['stock_qty']) && is_numeric($vp_data['stock_qty']) ) {
        $v1->set_manage_stock( true );
        $v1->set_stock_quantity( $vp_data['stock_qty'] );
        $v1->set_stock_status( 'instock' );
      } else {
        $v1->set_manage_stock( false );
      }
      $v1->set_backorders( 'no' );
      $v1->set_virtual( false );

      $v1->set_attributes( array(
        'size' => 'Small',
        'color' => 'White'
      ) );

      $v1_id = $v1->save();

      // Variation 2
      $v2 = new WC_Product_Variation();
      $v2->set_sku( $vp_data['sku'] . '-wc-lg-bk' );
      $v2->set_description( '' );
      $v2->set_regular_price( $vp_data['regular_price'] );
      $v2->set_parent_id( $vp_id );
      if ( isset($vp_data['stock_qty']) && is_numeric($vp_data['stock_qty']) ) {
        $v2->set_manage_stock( true );
        $v2->set_stock_quantity( $vp_data['stock_qty'] );
        $v2->set_stock_status( 'instock' );
      } else {
        $v2->set_manage_stock( false );
      }
      $v2->set_backorders( 'no' );
      $v2->set_virtual( false );

      $v2->set_attributes( array(
        'size' => 'Large',
        'color' => 'Black'
      ) );

      $v2_id = $v2->save();

    } catch ( Exception $e) {
      echo $e->getMessage();
      exit;
    }


    // 
    // Order
    //

    $order = new WC_Order();

    $address = array(
        'first_name' => 'Alan',
        'last_name'  => 'Zhao',
        'company'    => 'Bistro Solutions',
        'email'      => 'azhao6060@gmail.com',
        'phone'      => '777-777-7777',
        'address_1'  => '555 Main Street',
        'address_2'  => '', 
        'city'       => 'Saratoga Springs',
        'state'      => 'NY',
        'postcode'   => '12866',
        'country'    => 'US'
    );

    $order->add_product( wc_get_product($v1_id), $quantity);
    $order->add_product( wc_get_product($v2_id), $quantity);
    $order->set_address( $address, 'billing' );
    $order->set_address( $address, 'shipping' );

    $order->calculate_totals();

    $response = array('success' => true);

    header( 'Content-Type: application/json' );
    echo json_encode($response);
    exit;
  }

}
