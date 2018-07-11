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
    // Todo: add icon URL
    // https://developer.wordpress.org/reference/functions/add_menu_page/
    add_menu_page( 'Bistro Solutions', 'Bistro Solutions', 'manage_options', 'bistrosol' );

    add_submenu_page( 'bistrosol' , 'Bistro Solutions - Overview', 'Overview', 'manage_options', 'bistrosol' );

    add_submenu_page( 'bistrosol' , 'Bistro Solutions - Settings', 'Settings', 'manage_options', 'bistrosol-settings', array($this, 'settings_page') );

    add_submenu_page( 'bistrosol', 'Bistro Solutions - Orders', 'Orders', 'manage_options', 'bistrosol-orders' );

    add_submenu_page( 'bistrosol', 'Bistro Solutions - Customers', 'Customers', 'manage_options', 'bistrosol-customers' );
  }

  public function init_settings(  ) {

    register_setting( 'bistrosol_settings_page', 'bistrosol_settings' );

    add_settings_section(
      'database_section',
      __( 'Database', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_section_callback'),
      'bistrosol_settings_page'
    );

    add_settings_field(
      'database_host',
      __( 'Host', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_host_render'),
      'bistrosol_settings_page',
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
      'bistrosol_settings_page',
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
      'bistrosol_settings_page',
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
      'bistrosol_settings_page',
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
      'bistrosol_settings_page',
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
      'bistrosol_settings_page',
      'database_section'
    );

    add_settings_field(
      'database_client_cert',
      __( 'client-cert.pem', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_client_cert_render'),
      'bistrosol_settings_page',
      'database_section'
    );

    add_settings_field(
      'database_client_key',
      __( 'client-key.pem', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_client_key_render'),
      'bistrosol_settings_page',
      'database_section'
    );
     */
  }

  public function settings_page(  ) { 

    ?>
    <form enctype='multipart/form-data' id='bistrosol-db-settings-form' action='options.php' method='post' autocomplete='off'>

      <h2>Bistro Solutions</h2>

      <?php
      settings_fields( 'bistrosol_settings_page' );
      do_settings_sections( 'bistrosol_settings_page' );
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

}
