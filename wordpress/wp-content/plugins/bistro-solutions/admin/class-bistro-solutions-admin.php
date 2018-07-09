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
    add_menu_page( 'Bistro Solutions', 'Bistro Solutions', 'manage_options', 'bistrosol', array($this, 'setting_options_page') );
  }

  public function init_settings(  ) {

    register_setting( 'bistrosolPluginPage', 'bistrosol_settings' );

    add_settings_section(
      'database_section',
      __( 'Database', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_section_callback'),
      'bistrosolPluginPage'
    );

    add_settings_field(
      'database_host',
      __( 'Host', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_host_render'),
      'bistrosolPluginPage',
      'database_section'
    );

    add_settings_field(
      'database_name',
      __( 'Name', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_name_render'),
      'bistrosolPluginPage',
      'database_section'
    );

    add_settings_field(
      'database_user',
      __( 'User', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_user_render'),
      'bistrosolPluginPage',
      'database_section'
    );

    add_settings_field(
      'database_password',
      __( 'Password', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_password_render'),
      'bistrosolPluginPage',
      'database_section'
    );

    add_settings_field(
      'database_port',
      __( 'Port', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_port_render'),
      'bistrosolPluginPage',
      'database_section'
    );

    add_settings_field(
      'database_ca',
      __( 'ca.pem', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_ca_render'),
      'bistrosolPluginPage',
      'database_section'
    );

    add_settings_field(
      'database_client_cert',
      __( 'client-cert.pem', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_client_cert_render'),
      'bistrosolPluginPage',
      'database_section'
    );

    add_settings_field(
      'database_client_key',
      __( 'client-key.pem', BISTRO_SOLUTIONS_TEXTDOMAIN ),
      array($this, 'database_client_key_render'),
      'bistrosolPluginPage',
      'database_section'
    );
  }

  public function setting_options_page(  ) { 

    ?>
    <form action='options.php' method='post'>

      <h2>Bistro Solutions</h2>

      <?php
      settings_fields( 'bistrosolPluginPage' );
      do_settings_sections( 'bistrosolPluginPage' );
      $this->test_db_connection_button();
      submit_button();
      ?>

    </form>
    <?php

  }

  public function database_section_callback(  ) { 

    echo __( 'Database section description', BISTRO_SOLUTIONS_TEXTDOMAIN );

  }

  public function database_host_render(  ) { 
    ?>
    <input type='text' name='bistrosol_settings[database_host]' value='<?=$this->options['database_host']; ?>'>
    <?php

  }

  public function database_name_render(  ) { 
    ?>
    <input type='text' name='bistrosol_settings[database_name]' value='<?=$this->options['database_name']; ?>'>
    <?php

  }

  public function database_user_render(  ) { 
    ?>
    <input type='text' name='bistrosol_settings[database_user]' value='<?=$this->options['database_user']; ?>'>
    <?php

  }

  public function database_password_render(  ) { 
    ?>
    <input type='password' name='bistrosol_settings[database_password]' value='<?=$this->options['database_password']; ?>'>
    <?php

  }

  public function database_port_render(  ) { 
    ?>
    <input type='text' name='bistrosol_settings[database_port]' value='<?=$this->options['database_port'] ? $this->options['database_port'] : '3306'; ?>'>
    <?php

  }

  public function database_ca_render(  ) { 
    ?>
    <input type='text' name='bistrosol_settings[database_ca]' value='<?=$this->options['database_ca']; ?>'>
    <?php

  }

  public function database_client_cert_render(  ) { 
    ?>
    <input type='text' name='bistrosol_settings[database_client_cert]' value='<?=$this->options['database_client_cert']; ?>'>
    <?php

  }

  public function database_client_key_render(  ) { 
    ?>
    <input type='text' name='bistrosol_settings[database_client_key]' value='<?=$this->options['database_client_key']; ?>'>
    <?php

  }

  public function test_db_connection_button() {
    ?>
      <input type="button" class="button button-secondary" value="Test Connection" name="test-db-connection" />
    <?php
  }

}
