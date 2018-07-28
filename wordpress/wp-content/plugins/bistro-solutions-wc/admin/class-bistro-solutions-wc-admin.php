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

    $sp_data = array(
      'name'          => 'Simple product ' . $unique_id,
      'slug'          => 'simple-product-' . $unique_id,
      'sku'           => 'simple-product-' . $unique_id,
      'description'   => 'Simple product description',
      'regular_price' => '9.99',
      'sale_price'    => '5.99',
      'manage_stock'  => 'yes',
      'stock_qty'     => '999',
      'post_type'     => 'product',
      'product_type'  => 'simple'
    );

    $sp_id = wp_insert_post( array(
        'post_author'   => $create_user_id,
        'post_title'    => $sp_data['name'],
        'post_content'  => $sp_data['description'],
        'regular_price' => $sp_data['regular_price'],
        'sale_price'    => $sp_data['sale_price'],
        'manage_stock'  => $sp_data['manage_stock'],
        'stock'         => $sp_data['stock_qty'],
        'post_status'   => 'publish',
        'post_parent'   => '',
        'post_type'     => $sp_data['post_type'],
      ), true );

    if ( !$sp_id ) {
      var_dump( $sp_id );
      exit;
    }

    // Set product type
    wp_set_object_terms( $sp_id, $sp_data['product_type'], 'product_type' );

    // Assign product to category
    wp_set_object_terms( $sp_id, $test_category_id, 'product_cat' );

    // Update product image
    //$attach_id = get_post_meta( $sp_id, '_thumbnail_id', true );
    //add_post_meta( $post_id, '_thumbnail_id', $attach_id );

    update_post_meta( $sp_id, '_visibility', 'visible' );
    update_post_meta( $sp_id, '_stock_status', 'instock');
    update_post_meta( $sp_id, 'total_sales', '0' );
    update_post_meta( $sp_id, '_downloadable', 'no' );
    // For downloadable product, set to `yes`
    update_post_meta( $sp_id, '_virtual', 'no' );
    update_post_meta( $sp_id, '_price', $sp_data['regular_price'] );
    update_post_meta( $sp_id, '_regular_price', $sp_data['regular_price'] );
    update_post_meta( $sp_id, '_sale_price', $sp_data['sale_price'] );
    update_post_meta( $sp_id, '_purchase_note', '' );
    update_post_meta( $sp_id, '_featured', 'no' );
    update_post_meta( $sp_id, '_weight', '' );
    update_post_meta( $sp_id, '_length', '' );
    update_post_meta( $sp_id, '_width', '' );
    update_post_meta( $sp_id, '_height', '' );
    update_post_meta( $sp_id, '_sku', $sp_data['sku'] );
    update_post_meta( $sp_id, '_product_attributes', array() );
    update_post_meta( $sp_id, '_sale_price_dates_from', '' );
    update_post_meta( $sp_id, '_sale_price_dates_to', '' );
    update_post_meta( $sp_id, '_sold_individually', '' );
    update_post_meta( $sp_id, '_manage_stock', $sp_data['manage_stock'] );
    update_post_meta( $sp_id, '_stock', $sp_data['stock_qty'] );
    update_post_meta( $sp_id, '_backorders', 'no' );
  }

  public function add_test_products_wc_way() {
    // todo: author
    // add wordpress product id field to bistrosol db

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
      'manage_stock'  => 'yes',
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
      $sp->set_date_created( date('y-m-d h:i:s') );
      $sp->set_date_modified( date('y-m-d h:i:s') );
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
      $sp->set_manage_stock( $sp_data['manage_stock'] );
      $sp->set_stock_quantity( $sp_data['stock_qty'] );
      $sp->set_stock_status( 'instock' );
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

      /*$sp->set_attributes(array(
        'id'        => 0,
        'name'      => 'Colors',
        'options'   => 'Red, Green',
        'position'  => 1,
        'visible'   => false,
        'variation' => true
      ));*/
      
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
      'manage_stock'  => 'yes',
      'stock_qty'     => '999',
      'post_type'     => 'product',
      'product_type'  => 'variable'
    );

    try {

      // Attribute 1
      $a1 = new WC_Product_Attribute();
      // Any positive value is interpreted as is_taxonomy = true
      $a1->set_id( 0 );
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
      // Any positive value is interpreted as is_taxonomy = true
      $a2->set_id( 0 );
      $a2->set_name( 'Color' );
      $a2->set_options( array(
        'Black',
        'White'
      ) );
      $a2->set_position( 2 );
      $a2->set_visible( false );;
      $a2->set_variation( true );

      $vp = new WC_Product_Variable();
      $vp->set_name( $vp_data['name'] . ' - wc2');
      $vp->set_slug( $vp_data['slug'] . '-wc2' );
      $vp->set_date_created( date('y-m-d h:i:s') );
      $vp->set_date_modified( date('y-m-d h:i:s') );
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

      $vp->set_attributes( array($a1, $a2) );
      $vp->set_default_attributes( array(
        'Size'  => 'Small',
        'Color' => 'White'
      ) );
      
      $vp_id = $vp->save();

      // Variation 1
      $v1 = new WC_Product_Variation();
      $v1->set_sku( $vp_data['sku'] . '-wc-sm-wh' );
      $v1->set_regular_price( $vp_data['regular_price'] );
      $v1->set_parent_id( $vp_id );
      $v1->set_manage_stock( $vp_data['manage_stock'] );
      $v1->set_stock_quantity( $vp_data['stock_qty'] );
      $v1->set_stock_status( 'instock' );
      $v1->set_backorders( 'no' );

      $v1->set_attributes( array(
        'Size' => 'Small',
        'Color' => 'White'
      ) );

      $v1->save();

      // Variation 2
      $v2 = new WC_Product_Variation();
      $v2->set_sku( $vp_data['sku'] . '-wc-lg-bk' );
      $v2->set_regular_price( $vp_data['regular_price'] );
      $v2->set_parent_id( $vp_id );
      $v2->set_manage_stock( $vp_data['manage_stock'] );
      $v2->set_stock_quantity( $vp_data['stock_qty'] );
      $v2->set_stock_status( 'instock' );
      $v2->set_backorders( 'no' );

      $v2->set_attributes( array(
        'Size' => 'Large',
        'Color' => 'Black'
      ) );

      $v2->save();

    } catch ( Exception $e) {
      echo $e->getMessage();
      exit;
    }


    // 
    // Order
    //

    $order = new Wc_Order();
  }
}
