<?php 

//
// Woocommerce customizations
//

$timezone = get_custom( 'timezone' );
if ( !$timezone ) {
  $timezone = 'America/New_York';
}

$default_state = get_custom( 'default_state' );
if ( !$default_state ) {
  $default_state = 'NY';
}

$menu_items_per_page = get_custom( 'menu_items_per_page' );
if ( !$menu_items_per_page ) {
  $menu_items_per_page = 100;
}

$item_select_button_text = get_custom( 'item_select_button_text' );
if ( !$item_select_button_text ) {
  $item_select_button_text = 'Select options'; 
}

define( 'TIMEZONE', $timezone );
define( 'DEFAULT_STATE', $default_state );
define( 'MENU_ITEMS_PER_PAGE', $menu_items_per_page );
define( 'ITEM_SELECT_BUTTON_TEXT', $item_select_button_text );

// Make sure correct timezone is used
date_default_timezone_set( TIMEZONE );

// Change the default state on the checkout page
add_filter( 'default_checkout_billing_state', 'change_default_checkout_state' );
add_filter( 'default_checkout_shipping_state', 'change_default_checkout_state' );
function change_default_checkout_state() {
  return DEFAULT_STATE;
}

// Change number of products that are displayed per page (shop page)
add_filter( 'loop_shop_per_page', 'new_loop_shop_per_page', 20 );
function new_loop_shop_per_page( $cols ) {
  return MENU_ITEMS_PER_PAGE;
}

//
// Change text
//
add_filter( 'gettext', 'change_woocommerce_return_to_shop_text', 20, 3 );
function change_woocommerce_return_to_shop_text( $translated_text, $text, $domain ) {
  switch ( $translated_text ) {
  case 'Select options':
      if ( ITEM_SELECT_BUTTON_TEXT !== 'Select options') {
        $translated_text = __( ITEM_SELECT_BUTTON_TEXT, 'woocommerce' );
      }
      break;
    case 'Product':
      $translated_text = __( 'Item', 'woocommerce' );
      break;
    case 'Related products':
      $translated_text = __( 'You might also like', 'woocommerce' );
      break;
    case 'Return to shop':
      $translated_text = __( 'Return to menu', 'woocommerce' );
      break;
    case 'Go shop':
      $translated_text = __( 'Go to menu', 'woocommerce' );
      break;
    case 'Ship to a different address?':
      $translated_text = __( 'Check here if this is a <strong>delivery order</strong> and delivery address is different from billing.', 'woocommerce' );
      break;
    case 'Search products&hellip;':
      $translated_text = __( 'Search menu&hellip;', 'woocommerce' );
    break;
  }
  return $translated_text;
}

//
// Disable sorting
//
remove_action( 'woocommerce_before_shop_loop', 'woocommerce_catalog_ordering', 30 );

//
// Remove country fields from checkout
//
function custom_override_checkout_fields( $fields ) {
  unset($fields['shipping']['shipping_country']);
  unset($fields['billing']['billing_country']);
  return $fields;
}
add_filter('woocommerce_checkout_fields','custom_override_checkout_fields');


// https://gist.github.com/nadeem-khan/adaa4e7efab373535294

//
// Add phone extension field to billing
//
add_filter('woocommerce_checkout_fields', 'custom_override_billing_checkout_fields');

function custom_override_billing_checkout_fields($fields) {
  $fields['billing']['billing_phone_ext'] = array(
      'type' => 'text',
      'label' => __('Phone Extension', 'woocommerce'),
      'clear' => false,
      'required' => false
  );

  return $fields;
}

//
// Add phone and extension fields to shipping
//
add_filter('woocommerce_checkout_fields', 'custom_override_shipping_checkout_fields');

function custom_override_shipping_checkout_fields($fields) {
  $fields['shipping']['shipping_phone'] = array(
      'type' => 'text',
      'label' => __('Phone', 'woocommerce'),
      'clear' => false,
      'required' => true
  );
  $fields['shipping']['shipping_phone_ext'] = array(
      'type' => 'text',
      'label' => __('Phone Extension', 'woocommerce'),
      'clear' => false,
      'required' => false
  );

  return $fields;
}

//
// Re-order billing fields
//
add_filter('woocommerce_checkout_fields', 'order_billing_fields');

function order_billing_fields($fields) {

  $order = array(
      'billing_first_name',
      'billing_last_name',
      'billing_company',
      'billing_address_1',
      'billing_address_2',
      'billing_city',
      'billing_state',
      'billing_postcode',
      'billing_phone',
      'billing_phone_ext',
      'billing_email',
  );
  foreach ($order as $field) {
      $ordered_fields[$field] = $fields['billing'][$field];
  }

  $fields['billing'] = $ordered_fields;
  return $fields;
}

//
// Re-order shipping fields
//
add_filter('woocommerce_checkout_fields', 'order_shipping_fields');

function order_shipping_fields($fields) {

  $order = array(
      'shipping_first_name',
      'shipping_last_name',
      'shipping_company',
      'shipping_address_1',
      'shipping_address_2',
      'shipping_city',
      'shipping_state',
      'shipping_postcode',
      'shipping_phone',
      'shipping_phone_ext'
  );
  foreach ($order as $field) {
      $ordered_fields[$field] = $fields['shipping'][$field];
  }

  $fields['shipping'] = $ordered_fields;
  return $fields;
}

//
// Update the order meta with custom fields values
//
add_action('woocommerce_checkout_update_order_meta', 'checkout_field_update_order_meta');

function checkout_field_update_order_meta($order_id) {

  if (!empty($_POST['billing']['billing_phone_ext'])) {
      update_post_meta($order_id, 'Billing Phone Extension', esc_attr($_POST['billing']['billing_phone_ext']));
  }

  if (!empty($_POST['shipping']['shipping_phone'])) {
      update_post_meta($order_id, 'Shipping Phone', esc_attr($_POST['shipping']['shipping_phone']));
  }

  if (!empty($_POST['shipping']['shipping_phone_ext'])) {
      update_post_meta($order_id, 'Shipping Phone Extension', esc_attr($_POST['shipping']['shipping_phone_ext']));
  }
}

//
// Display custom shipping in admin
//
add_action('woocommerce_admin_order_data_after_shipping_address', 'shipping_display_admin_order_meta', 10, 1);

function shipping_display_admin_order_meta($order) {
  $shipping_phone = get_post_meta($order->id, '_shipping_phone', true);
  $shipping_phone_ext = get_post_meta($order->id, '_shipping_phone_ext', true);
  if (!empty($shipping_phone)) {
    echo '<p><strong>' . __('Phone') . ':</strong><br> ' . $shipping_phone . '</p>';
    if (!empty($shipping_phone_ext)) {
      echo '<p><strong>' . __('Phone Extension') . ':</strong><br> ' . $shipping_phone_ext . '</p>';
    }
  }
}


//
// Display custom billing in admin
//
add_action('woocommerce_admin_order_data_after_billing_address', 'billing_display_admin_order_meta', 10, 1);

function billing_display_admin_order_meta($order) {
  $billing_phone_ext = get_post_meta($order->id, '_billing_phone_ext', true);
  if (!empty($billing_phone_ext)) {
    echo '<p><strong>' . __('Phone Extension') . ':</strong><br> ' . $billing_phone_ext . '</p>';
  }
}

