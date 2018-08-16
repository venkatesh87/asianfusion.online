<?php

namespace Zhours;

class Setup
{
	public function __construct()
	{
		add_action('plugins_loaded', [$this, 'init']);
	}

	public function init()
	{
		if (!class_exists('WooCommerce')) {
			add_action('admin_notices', function () {
				?>
				<div class="notice notice-error is-dismissible">
					<p>Order Hours Scheduler for WooCommerce require WooCommerce</p>
				</div>
				<?php
			});
			return;
		}

		require_once PLUGIN_ROOT . '/setting/setting.php';
		require_once PLUGIN_ROOT . '/functions.php';

		if (!get_current_status()) {
			\add_action('wp', function () {
				if (is_checkout()) {
					header('Location:' . wc_get_cart_url());
					exit;
				}
			});

			\remove_action('woocommerce_proceed_to_checkout', 'woocommerce_button_proceed_to_checkout', 20);
			\add_action('woocommerce_proceed_to_checkout', '\Zhours\get_alertbutton');


			\add_action('woocommerce_widget_shopping_cart_before_buttons', function () {
				\ob_start();
			});
			\add_action('woocommerce_after_mini_cart', function () {
				if (!WC()->cart->is_empty()) :
					\ob_end_clean();
					get_alertbutton();
				endif;
			});

			\add_action('wp_footer', '\Zhours\get_alertbar');
		}

		/** Break html5 cart caching */
		\add_action('wp_enqueue_scripts', function () {
			\wp_deregister_script('wc-cart-fragments');
			\wp_enqueue_script('wc-cart-fragments', plugin_dir_url(PLUGIN_ROOT_FILE) . '/cart-fragments.js', array('jquery', 'jquery-cookie'), '1.0', true);
		}, 100);

	}
}
