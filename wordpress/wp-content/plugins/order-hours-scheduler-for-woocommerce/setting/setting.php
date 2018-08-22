<?php
namespace Zhours;

use \Zhours\Aspect\Page, \Zhours\Aspect\TabPage, \Zhours\Aspect\Box;

defined('ABSPATH') or die('No script kiddies please!');

require_once __DIR__ . '/../functions.php';

$setting = new Page('order hours setting');

add_action('init', function (){
		$roles = ['shop_manager','administrator'];
		array_walk($roles, function ($role_name) {
				$role = get_role($role_name);
				$role->add_cap('zhours_manage_options', true);
		});
});

$setting
		->setArgument('capability', 'zhours_manage_options')
		->setArgument('parent_slug', 'woocommerce');

$setting->scope(function (Page $setting) {
    if ($setting->isRequested()) {
        wp_enqueue_style('zhours-style', plugin_dir_url(__FILE__) . '/setting.css');
        wp_enqueue_script('zhours-script', plugin_dir_url(__FILE__) . '/setting.js', ['jquery']);
    }


    $schedule = new TabPage('schedule');
    $schedule->setArgument('capability', 'zhours_manage_options');

    $alertbar = new TabPage('alert bar');
    $alertbar->setArgument('capability', 'zhours_manage_options');

    $alertbutton = new TabPage('alert button');
    $alertbar->setArgument('capability', 'zhours_manage_options');

    $setting->attach($schedule, $alertbar, $alertbutton);

    $schedule->scope(function (TabPage $schedule) {
        $status = new Box('status');
        $status->attachTo($schedule);

        $enable = new Input('order hours status');

				$force_status = new Box('force status');
				$force_status
					->setLabel('singular_name', 'Force Override Store Schedule')
					->attachTo($schedule)
					->scope(function ($box) {
						$rewrite = new Input('force rewrite status');
						$rewrite
							->setLabel('singular_name', 'Turn-on Force Override')
							->setArgument('default', false)
							->attachTo($box)
							->attach([true, ''])
							->setType(Input::TYPE_CHECKBOX);

						$status = new Input('force status');
						$status
							->setLabel('singular_name', 'Ordering Status')
							->setArgument('default', false)
							->attachTo($box)
							->setType(Input::TYPE_SELECT)
							->attach([false, 'Disabled'], [true, 'Enabled']);
					});

        $days_schedule = new Box('days schedule');
        $days_schedule->attachTo($schedule);

        $period = new Input('period');
        $period
            ->attachTo($days_schedule)
            ->setType(Input::TYPE_DAYS_PERIODS);

        $description = call_user_func(function () {
            if (get_current_status()) {
                $color = 'green';
                $current_status = 'open';
            } else {
                $color = 'red';
                $current_status = 'closed';
            }
            $current_status = strtoupper($current_status);
            $time = \date_i18n('H:i');
            return "<span style='background-color: $color; padding: 10px; display: inline-block; color: white; font-style: normal; line-height: 1;'>Current time: $time. Status: $current_status</span>";;
        });

        $enable
            ->setArgument('default', 0)
            ->setArgument('description', $description)
            ->attachTo($status)
            ->setType(Input::TYPE_SELECT)
            ->attach([0, 'Disabled'], [1, 'Enabled']);
    });


    $alertbar->scope(function (TabPage $alertbar) {
        $options = new Box('options');
        $options
            ->attachTo($alertbar)
            ->setLabel('singular_name', 'Alertbar Options');

        $message = new Input('message');
        $message
            ->setLabel('singular_name', 'Alertbar Message');

        $size = new Input('font size');
        $size
            ->setArgument('default', 16)
            ->setArgument('min', 1)
            ->setType(Input::TYPE_NUMBER)
            ->setLabel('singular_name', 'Alertbar Font Size');

        $color = new Input('color');
        $color
            ->setType(Input::TYPE_COLOR)
            ->setLabel('singular_name', 'Alertbar Color');

        $bg_color = new Input('background color');
        $bg_color
            ->setType(Input::TYPE_COLOR)
            ->setLabel('singular_name', 'Alertbar Background Color');

        $options->attach($message, $size, $color, $bg_color);
    });

    $alertbutton->scope(function (TabPage $alertbutton) {
        $options = new Box('options');
        $options
            ->attachTo($alertbutton)
            ->setLabel('singular_name', 'Alertbutton Options');

        $text = new Input('text');
        $text->setLabel('singular_name', 'Alertbutton Text');

        $size = new Input('font size');
        $size
            ->setArgument('default', 16)
            ->setArgument('min', 1)
            ->setType(Input::TYPE_NUMBER)
            ->setLabel('singular_name', 'Alertbutton Font Size');

        $color = new Input('color');
        $color
            ->setType(Input::TYPE_COLOR)
            ->setLabel('singular_name', 'Alertbutton Color');

        $bg_color = new Input('background color');
        $bg_color
            ->setType(Input::TYPE_COLOR)
            ->setLabel('singular_name', 'Alertbutton Background Color');

        $options->attach($text, $size, $color, $bg_color);
    });
});
