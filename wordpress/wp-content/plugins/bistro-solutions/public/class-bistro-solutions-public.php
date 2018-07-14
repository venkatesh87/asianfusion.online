<?php

/**
 * The public-facing functionality of the plugin.
 *
 * @link       https://www.bistrosol.co
 * @since      1.0.0
 *
 * @package    Bistro_Solutions
 * @subpackage Bistro_Solutions/public
 */

/**
 * The public-facing functionality of the plugin.
 *
 * Defines the plugin name, version, and two examples hooks for how to
 * enqueue the public-facing stylesheet and JavaScript.
 *
 * @package    Bistro_Solutions
 * @subpackage Bistro_Solutions/public
 * @author     Alan Zhao <azhao6060@gmail.com>
 */
class Bistro_Solutions_Public {

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
	 * @param      string    $plugin_name       The name of the plugin.
	 * @param      string    $version    The version of this plugin.
	 */
	public function __construct( $plugin_name, $version ) {

		$this->plugin_name = $plugin_name;
		$this->version = $version;

	}

	/**
	 * Register the stylesheets for the public-facing side of the site.
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

		wp_enqueue_style( $this->plugin_name, plugin_dir_url( __FILE__ ) . 'css/bistro-solutions-public.css', array(), $this->version, 'all' );

	}

	/**
	 * Register the JavaScript for the public-facing side of the site.
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

		wp_enqueue_script( $this->plugin_name, plugin_dir_url( __FILE__ ) . 'js/bistro-solutions-public.js', array( 'jquery' ), $this->version, false );

  }

  public function register_routes() {
    
    $version = '1';
    $namespace = 'bistrosol/v' . $version;
    $base = 'db';

    register_rest_route( $namespace, '/' . $base . '/(?P<id>\d+)', array(
      'methods' => 'GET',
      'callback' => array($this, 'my_awesome_func'),
      'args' => array(
        'id' => array(
          //'default' => '',
          //'required' => true,
          'validate_callback' => function($param, $request, $key) {
            return is_numeric( $param );
          },
          //'sanitize_callback' => 'sanitize_text_field'
        ),
      ),
      'permission_callback' => array($this, 'permission_check')
    ) );
  }

  public function add_shortcodes() {
    add_shortcode( 'menu', 'render_menu' );
  }

  function render_menu( $atts ) {
    $a = shortcode_atts( array(
        'foo' => 'something',
        'bar' => 'something else',
    ), $atts );

    return "foo = {$a['foo']}";
  }

  public function permission_check( $request ) {
    return true;
  }

  public function my_awesome_func( WP_REST_Request $request ) {

    // You can access parameters via direct array access on the object:
    //$param = $request['some_param'];

    // Or via the helper method:
    //$param = $request->get_param( 'some_param' );

    // You can get the combined, merged set of parameters:
    //$parameters = $request->get_params();

    // The individual sets of parameters are also available, if needed:
    //$parameters = $request->get_url_params();
    //$parameters = $request->get_query_params();
    //$parameters = $request->get_body_params();
    //$parameters = $request->get_json_params();
    //$parameters = $request->get_default_params();

    // Uploads aren't merged in, but can be accessed separately:
    //$parameters = $request->get_file_params();

    if ( empty( $posts ) ) {
      //return new WP_Error( 'no_author', 'Invalid author', array( 'status' => 404 ) );
    }

    $data = array( 'some', 'response', 'data' );

    return new WP_REST_Response( $data, 200 );
  }
}
