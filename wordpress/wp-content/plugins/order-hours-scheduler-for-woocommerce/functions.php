<?php
namespace Zhours;

defined('ABSPATH') or die('No script kiddies please!');

use Zhours\Aspect\InstanceStorage, Zhours\Aspect\Page, Zhours\Aspect\TabPage, Zhours\Aspect\Box;

function get_current_status()
{
    if (!plugin_enabled()) return true;

		list($rewrite, $status) = InstanceStorage::getGlobalStorage()->asCurrentStorage(function () {
			return Page::get('order hours setting')->scope(function () {
				return TabPage::get('schedule')->scope(function (TabPage $schedule) {
					$force_status = Box::get('force status');
					return $force_status->scope(function ($box) use ($schedule) {
							$rewrite = Input::get('force rewrite status');
							$rewrite = $rewrite->getValue($box, null, $schedule);
							$status = Input::get('force status');
							$status = $status->getValue($box, null, $schedule);
							return [$rewrite, $status];
					});
				});
			});
		});

		if($rewrite) { // return force status if enabled
			return $status;
		}

    $periods = InstanceStorage::getGlobalStorage()->asCurrentStorage(function () {
        return Page::get('order hours setting')->scope(function () {
            return TabPage::get('schedule')->scope(function (TabPage $schedule) {
                $days_schedule = Box::get('days schedule');
                $period = Input::get('period');
                return $period->getValue($days_schedule, null, $schedule);
            });
        });
    });

    $days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];

    $current_index = \date_i18n('N') - 1;
    $current_index = $days[$current_index];

    $today = $periods[$current_index];

    if ($today === null) {
        return false;
    }

    $time = \date_i18n('H:i');

    $matches = array_filter($today, function ($element) use ($time) {
        return $time >= $element['start'] && $time <= $element['end'];
    });
    return count($matches) !== 0;
}

function plugin_enabled()
{
    return InstanceStorage::getGlobalStorage()->asCurrentStorage(function () {
            return Page::get('order hours setting')->scope(function () {
                return TabPage::get('schedule')->scope(function (TabPage $schedule) {
                    $status = Box::get('status');
                    $enabled = Input::get('order hours status');
                    return $enabled->getValue($status, null, $schedule);
                });
            });
        }) === '1';
}

function get_alertbutton()
{
    list ($text, $size, $color, $bg_color) = InstanceStorage::getGlobalStorage()->asCurrentStorage(function () {
        return Page::get('order hours setting')->scope(function () {
            return TabPage::get('alert button')->scope(function (TabPage $alertbutton) {
                $options = Box::get('options');
                $text = Input::get('text');
                $size = Input::get('font size');
                $color = Input::get('color');
                $bg_color = Input::get('background color');
                $values = [$text, $size, $color, $bg_color];

                return array_map(function (Input $value) use ($options, $alertbutton) {
                    return $value->getValue($options, null, $alertbutton);
                }, $values);
            });
        });
    });
    $color = ($color) ? $color : 'black';
    $bg_color = ($bg_color) ? $bg_color : 'transparent';
    ?>
    <style>
        .zhours_alertbutton {
            color: <?= $color; ?>;
            background-color: <?= $bg_color; ?>;
            padding: <?= $size; ?>px;
            font-size: <?= $size; ?>px;
            line-height: 1;
        }
    </style>
    <div class="zhours_alertbutton">
        <?= $text; ?>
    </div>
    <?php
}

function get_alertbar()
{
    list($message, $size, $color, $bg_color) = InstanceStorage::getGlobalStorage()->asCurrentStorage(function () {
        return Page::get('order hours setting')->scope(function () {
            return TabPage::get('alert bar')->scope(function (TabPage $alertbar) {
                $options = Box::get('options');
                $message = Input::get('message');
                $size = Input::get('font size');
                $color = Input::get('color');
                $bg_color = Input::get('background color');
                $values = [$message, $size, $color, $bg_color];
                return array_map(function (Input $value) use ($options, $alertbar) {
                    return $value->getValue($options, null, $alertbar);
                }, $values);
            });
        });
    });
    $color = ($color) ? $color : 'black';
    $bg_color = ($bg_color) ? $bg_color : 'white';
    ?>
    <style>
        .zhours_alertbar {
            z-index: 1000;
            position: fixed;
            bottom: 0;
            width: 100%;
            color: <?= $color; ?>;
            background-color: <?= $bg_color; ?>;
            padding: <?= $size; ?>px;
            font-size: <?= $size; ?>px;
            line-height: 1;
            text-align: center;
        }

        .zhours_alertbar-space {
            height: <?=$size*3?>px;
        }
    </style>
    <div class="zhours_alertbar-space"></div>
    <div class="zhours_alertbar">
        <?= $message; ?>
    </div>
    <?php
}

add_filter('pre_option_zhours_current_status', function () {
	return get_current_status() ? "yes" : "no";
});
