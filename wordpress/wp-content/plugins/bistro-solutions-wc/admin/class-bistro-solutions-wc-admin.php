<?php

/**
 * The admin-specific functionality of the plugin.
 *
 * @link       https://www.bistrosol.co
 * @since      1.0.0
 *
 * @package    Bistro_Solutions_Wc
 * @subpackage Bistro_Solutions_Wc/admin
 */

/**
 * The admin-specific functionality of the plugin.
 *
 * Defines the plugin name, version, and two examples hooks for how to
 * enqueue the admin-specific stylesheet and JavaScript.
 *
 * @package    Bistro_Solutions_Wc
 * @subpackage Bistro_Solutions_Wc/admin
 * @author     Alan Zhao <azhao6060@gmail.com>
 */
class Bistro_Solutions_Wc_Admin {

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
		 * defined in Bistro_Solutions_Wc_Loader as all of the hooks are defined
		 * in that particular class.
		 *
		 * The Bistro_Solutions_Wc_Loader will then create the relationship
		 * between the defined hooks and the functions defined in this
		 * class.
		 */

		wp_enqueue_style( $this->plugin_name, plugin_dir_url( __FILE__ ) . 'css/bistro-solutions-wc-admin.css', array(), $this->version, 'all' );

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
		 * defined in Bistro_Solutions_Wc_Loader as all of the hooks are defined
		 * in that particular class.
		 *
		 * The Bistro_Solutions_Wc_Loader will then create the relationship
		 * between the defined hooks and the functions defined in this
		 * class.
		 */

		wp_enqueue_script( $this->plugin_name, plugin_dir_url( __FILE__ ) . 'js/bistro-solutions-wc-admin.js', array( 'jquery' ), $this->version, false );

  }

  public function woocommerce_customization() {
    $this->disable_product_edit();
    $this->hide_in_stock();
  }

  public function disable_product_edit() {
  }

  public function hide_in_stock() {
  }

  public function add_test_products() {
    // Category: https://wordpress.stackexchange.com/questions/198411/programmatically-create-product-category-and-add-thumbnail-in-woocommerce
    // Product: https://lukasznowicki.info/insert-new-woocommerce-product-programmatically/
    // Product: https://wordpress.stackexchange.com/questions/137501/how-to-add-product-in-woocommerce-with-php-code
    // Order: https://stackoverflow.com/questions/24087886/how-to-create-order-manually-in-woocommerce

    $create_user_id = 1;
    $bswc_user = get_user_by('login', 'bistrosol_wc_sync');
    if ($bswc_user) {
      $create_user_id = $bswc_user->ID;
    }

    $unique_id = date( 'Ymdhis' );

    //
    // Category
    //

    $test_category = array(
      'thumb'       => 'images/uploads/cat11.png',
      'name'        => 'Category ' . $unique_id,
      'description' => 'Category description',
      'slug'        => 'category-' . $unique_id,
      'parent'      => ''
    );

    $test_category_id = wp_insert_term(
        $test_category['name'],
        'product_cat',
        array(
            'description'=> $test_category['description'],
            'slug' => $test_category['slug'],
            'parent' => $test_category['parent']
        )
      );

    if ( !$test_category_id ) {
      var_dump( $test_category_id );
      exit;
    }

    // Update category image
    //update_woocommerce_term_meta( $cid['term_id'], 'thumbnail_id', absint( $thumb_id ) );

    //
    // Simple product
    //

    $test_simple_product = array(
      'name'          => 'Test simple product ' . $unique_id,
      'sku'           => 'test-simple-product-' . $unique_id,
      'description'   => 'test simple product description',
      'regular_price' => '9.99',
      'sale_price'    => '5.99',
      'manage_stock'  => 'yes',
      'stock'         => '999',
      'post_type'     => 'product',
      'product_type'  => 'simple'
    );
    
    $test_simple_product_id = wp_insert_post( array(
        'post_author'   => $create_user_id,
        'post_title'    => $test_simple_product['name'],
        'post_content'  => $test_simple_product['description'],
        'regular_price' => $test_simple_product['regular_price'],
        'sale_price'    => $test_simple_product['sale_price'],
        'manage_stock'  => $test_simple_product['manage_stock'],
        'stock'         => $test_simple_product['stock'],
        'post_status'   => 'publish',
        'post_parent'   => '',
        'post_type'     => $test_simple_product['post_type'],
      ), true );

    if ( !$test_simple_product_id ) {
      var_dump( $test_simple_product_id );
      exit;
    }

    // Set product type
    wp_set_object_terms( $test_simple_product_id, $test_simple_product['product_type'], 'product_type' );

    // Assign product to category @todo
    wp_set_object_terms( $test_simple_product_id, $test_category_id, 'product_cat' );

    // Update product image
    //$attach_id = get_post_meta( $test_simple_product_id, '_thumbnail_id', true );
    //add_post_meta( $post_id, '_thumbnail_id', $attach_id );

    update_post_meta( $test_simple_product_id, '_visibility', 'visible' );
    update_post_meta( $test_simple_product_id, '_stock_status', 'instock');
    update_post_meta( $test_simple_product_id, 'total_sales', '0' );
    update_post_meta( $test_simple_product_id, '_downloadable', 'no' );
    // For downloadable product, set to `yes`
    update_post_meta( $test_simple_product_id, '_virtual', 'no' );
    update_post_meta( $test_simple_product_id, '_price', $test_simple_product['regular_price'] );
    update_post_meta( $test_simple_product_id, '_regular_price', $test_simple_product['regular_price'] );
    update_post_meta( $test_simple_product_id, '_sale_price', $test_simple_product['sale_price'] );
    update_post_meta( $test_simple_product_id, '_purchase_note', '' );
    update_post_meta( $test_simple_product_id, '_featured', 'no' );
    update_post_meta( $test_simple_product_id, '_weight', '' );
    update_post_meta( $test_simple_product_id, '_length', '' );
    update_post_meta( $test_simple_product_id, '_width', '' );
    update_post_meta( $test_simple_product_id, '_height', '' );
    update_post_meta( $test_simple_product_id, '_sku', $test_simple_product['sku'] );
    update_post_meta( $test_simple_product_id, '_product_attributes', array() );
    update_post_meta( $test_simple_product_id, '_sale_price_dates_from', '' );
    update_post_meta( $test_simple_product_id, '_sale_price_dates_to', '' );
    update_post_meta( $test_simple_product_id, '_sold_individually', '' );
    update_post_meta( $test_simple_product_id, '_manage_stock', $test_simple_product['manage_stock'] );
    update_post_meta( $test_simple_product_id, '_stock', $test_simple_product['stock'] );
    update_post_meta( $test_simple_product_id, '_backorders', 'no' );
  }

}
