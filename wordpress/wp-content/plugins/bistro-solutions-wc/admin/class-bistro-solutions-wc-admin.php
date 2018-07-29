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

  public function add_dashboard_widgets() {
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

  public function add_test_products_wc_way() {


    //
    // Convert Bistro Solutions product to WC product
    // Convert WC order to Bistro Solutions Order
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
