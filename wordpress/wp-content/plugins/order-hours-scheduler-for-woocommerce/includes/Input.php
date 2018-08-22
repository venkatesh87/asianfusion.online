<?php
namespace Zhours;

defined('ABSPATH') or die('No script kiddies please!');

class Input extends \Zhours\Aspect\Input
{
    const TYPE_DAYS_PERIODS = 'DaysPeriod';

    public function htmlDaysPeriod($post, $parent)
    {
        $base_name = $this->nameInput($post, $parent);
        $days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
        $value = $this->getValue($parent, null, $post);
        $value = (array)maybe_unserialize($value);

        foreach ($days as $day) {
            if (!isset($value[$day])) {
                $value[$day] = [];
            }
        }
        ?>
        <div class="aspect_days_periods">
            <div class="aspect_days_tabs">
                <?php foreach ($days as $day) { ?>
                    <a href="#" data-day="<?= esc_attr($day); ?>"><?php _e(ucwords($day)); ?></a>
                <?php } ?>
            </div>

            <?php foreach ($days as $day) {
                $day_period = $value[$day];
                $input_name = $base_name . '[' . esc_attr($day) . ']';
                ?>
                <div class="aspect_day_period" data-day="<?= esc_attr($day); ?>" data-base=<?= $base_name; ?>>
                    <table>
                        <thead>
                        <tr>
                            <th>Opening</th>
                            <th>Closing</th>
                            <td>
                                <button class="aspect_day_add button">+</button>
                            </td>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                        if (count($day_period) === 0) {
                            $day_period = [['start' => null, 'end' => null]];
                        }
                        foreach ($day_period as $id => $period) {
                            $name = $input_name . '[' . $id . ']';
                            ?>
                            <tr class="aspect_period" data-id="<?= $id; ?>">
                                <td><input type="time" name="<?= $name; ?>[start]"
                                           class="aspect_day_start"
                                           value="<?= $period['start'] ?>"></td>
                                <td><input type="time" name="<?= $name; ?>[end]"
                                           class="aspect_day_end"
                                           value="<?= $period['end'] ?>"></td>
                                <td>
                                    <button class="aspect_day_delete button">&times;</button>
                                </td>
                            </tr>
                        <?php } ?>
                        </tbody>
                    </table>
                </div>
            <?php } ?>

        </div>
        <?php
    }
}
