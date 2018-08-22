<?php 

//
// Woocommerce customizations
//

// Change text
add_filter( 'gettext', 'change_woocommerce_return_to_shop_text', 20, 3 );
function change_woocommerce_return_to_shop_text( $translated_text, $text, $domain ) {
  switch ( $translated_text ) {
    case 'Product' :
      $translated_text = __( 'Item', 'woocommerce' );
      break;
    case 'Return to shop' :
      $translated_text = __( 'Return to menu', 'woocommerce' );
      break;
    case 'Go shop' :
      $translated_text = __( 'Go to menu', 'woocommerce' );
      break;
    case 'Ship to a different address?' :
      $translated_text = __( 'Check here if this is a <strong>delivery order</strong> and delivery address is different from billing.', 'woocommerce' );
      break;
    case 'Search products&hellip;' :
      $translated_text = __( 'Search menu&hellip;', 'woocommerce' );
    break;
  }
  return $translated_text;
}

// Remove country fields from checkout
function custom_override_checkout_fields( $fields ) {
  unset($fields['shipping']['shipping_country']);
  unset($fields['billing']['billing_country']);
  return $fields;
}
add_filter('woocommerce_checkout_fields','custom_override_checkout_fields');
