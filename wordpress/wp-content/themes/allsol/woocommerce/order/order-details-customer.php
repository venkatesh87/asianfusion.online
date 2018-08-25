<?php
/**
 * Order Customer Details
 *
 * This template can be overridden by copying it to yourtheme/woocommerce/order/order-details-customer.php.
 *
 * HOWEVER, on occasion WooCommerce will need to update template files and you
 * (the theme developer) will need to copy the new files to your theme to
 * maintain compatibility. We try to do this as little as possible, but it does
 * happen. When this occurs the version of the template file will be bumped and
 * the readme will list any important changes.
 *
 * @see     https://docs.woocommerce.com/document/template-structure/
 * @package WooCommerce/Templates
 * @version 3.4.4
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}
$show_shipping = ! wc_ship_to_billing_address_only() && $order->needs_shipping_address();
?>
<section class="woocommerce-customer-details">

	<?php if ( $show_shipping ) : ?>

	<section class="woocommerce-columns woocommerce-columns--2 woocommerce-columns--addresses col2-set addresses">
		<div class="woocommerce-column woocommerce-column--1 woocommerce-column--billing-address col-1">

	<?php endif; ?>

	<h2 class="woocommerce-column__title"><?php esc_html_e( 'Billing address', 'woocommerce' ); ?></h2>

	<address>
		<?php echo wp_kses_post( $order->get_formatted_billing_address( __( 'N/A', 'woocommerce' ) ) ); ?>

		<?php if ( $order->get_billing_phone() ) : ?>
      <p class="woocommerce-customer-details--phone">
        <?php echo esc_html( $order->get_billing_phone() ); ?>

    <?php
      // Customization block: add billing phone extension
      $billing_phone_ext = get_post_meta($order->id, '_billing_phone_ext', true);
      if (!empty($billing_phone_ext)) {
        echo 'ext. ' . esc_html( $billing_phone_ext );
      }
    ?>

      </p>
    <?php endif; ?>

		<?php if ( $order->get_billing_email() ) : ?>
			<p class="woocommerce-customer-details--email"><?php echo esc_html( $order->get_billing_email() ); ?></p>
		<?php endif; ?>
	</address>

	<?php if ( $show_shipping ) : ?>

		</div><!-- /.col-1 -->

		<div class="woocommerce-column woocommerce-column--2 woocommerce-column--shipping-address col-2">
			<h2 class="woocommerce-column__title"><?php esc_html_e( 'Shipping address', 'woocommerce' ); ?></h2>
			<address>
        <?php echo wp_kses_post( $order->get_formatted_shipping_address( __( 'N/A', 'woocommerce' ) ) ); ?>

        <?php
          // Customization block: add shipping phone and extension
          $shipping_phone = get_post_meta($order->id, '_shipping_phone', true);
          $shipping_phone_ext = get_post_meta($order->id, '_shipping_phone_ext', true);
          if (!empty($shipping_phone)) {
            echo '<br/>' . esc_html( $shipping_phone );
            if (!empty($shipping_phone_ext)) {
              echo ' ext. ' . esc_html( $shipping_phone_ext );
            }
          }
        ?>

			</address>
		</div><!-- /.col-2 -->

	</section><!-- /.col2-set -->

	<?php endif; ?>

	<?php do_action( 'woocommerce_order_details_after_customer_details', $order ); ?>

</section>
