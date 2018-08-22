<?php

namespace MABEL_BHI_LITE\Controllers {

	use MABEL_BHI_LITE\Core\Config_Manager;
	use MABEL_BHI_LITE\Core\Registry;
	use MABEL_BHI_LITE\Core\Settings_Manager;
	use MABEL_BHI_LITE\Core\Widget;
	use MABEL_BHI_LITE\Core\Widget_Options_Manager;

	if ( ! defined( 'ABSPATH' ) ) {
		die;
	}

	class Widgets_Controller
	{
		private $location_names;

		public function __construct()
		{
			$locations = json_decode(Settings_Manager::get_setting('locations'), true);

			if($locations == null) $locations = array();

			$this->location_names = array();

			if(is_array($locations)) {
				foreach ($locations as $location) {
					array_push($this->location_names, $location['Name']);
				}
			}

			Registry::get_loader()->add_action('widgets_init', $this, 'register_list_widget');
			Registry::get_loader()->add_action('widgets_init', $this, 'register_indicator_widget');
			Registry::get_loader()->add_action('widgets_init', $this, 'register_ifclosed_widget');
			Registry::get_loader()->add_action('widgets_init', $this, 'register_ifopen_widget');
		}

		public function register_ifclosed_widget()
		{
			$option_manager = new Widget_Options_Manager();
			$this->addBasicOptions($option_manager);
			$option_manager->add_textarea_option(
				'content',
				__( 'Content', Config_Manager::$slug ),
				null
			);

			$widget = new Widget(
				'bhi_widget_isclosed',
				__('[BHI] Show only when closed', Config_Manager::$slug),
				__('Show content only when your business is currently closed.', Config_Manager::$slug),
				'mbhi_ifclosed',
				$option_manager
			);
			add_filter('widget_bhi_widget_isclosed_show_title',array($this, 'should_show_ifclosed_title'));
			if(sizeof($this->location_names) === 0)
				$widget->warning = __( "No location found. Go to Settings > Business Hours Indicator to set up locations.",
					Config_Manager::$slug );

			register_widget($widget);
		}

		public function register_ifopen_widget()
		{
			$option_manager = new Widget_Options_Manager();
			$this->addBasicOptions($option_manager);
			$option_manager->add_textarea_option(
				'content',
				__( 'Content', Config_Manager::$slug ),
				null
			);

			$widget = new Widget(
				'bhi_widget_isopen',
				__('[BHI] Show only when open', Config_Manager::$slug),
				__('Show content only when your business is currently open.', Config_Manager::$slug),
				'mbhi_ifopen',
				$option_manager
			);
			add_filter('widget_bhi_widget_isopen_show_title',array($this, 'should_show_ifopen_title'));
			if(sizeof($this->location_names) === 0)
				$widget->warning = __( "No location found. Go to Settings > Business Hours Indicator to set up locations.",
					Config_Manager::$slug );

			register_widget($widget);
		}
		public function should_show_ifopen_title($widget_args)
		{
			return MBHILITE()->is_open($widget_args['location']);
		}

		public function should_show_ifclosed_title($widget_args)
		{
			return MBHILITE()->is_closed($widget_args['location']);
		}
		public function register_indicator_widget()
		{
			$option_manager = new Widget_Options_Manager();
			$this->addBasicOptions($option_manager);

			$widget = new Widget(
				'bhi_widget_displaybusinesshoursindicator',
				__('[BHI] opening hours indicator', Config_Manager::$slug),
				__('Show whether you are currently open or closed.', Config_Manager::$slug),
				'mbhi',
				$option_manager
			);

			if(sizeof($this->location_names) === 0)
				$widget->warning = __( "No location found. Go to Settings > Business Hours Indicator to set up locations.",
					Config_Manager::$slug );

			register_widget($widget);
		}

		public function register_list_widget()
		{

			$option_manager = new Widget_Options_Manager();
			$this->addBasicOptions($option_manager);

			$widget = new Widget(
				'bhi_widget_displayopeninghours',
				__('[BHI] opening hours overview', Config_Manager::$slug),
				__('Show the list of opening times for a location.', Config_Manager::$slug),
				'mbhi_hours',
				$option_manager
			);

			if(sizeof($this->location_names) === 0)
				$widget->warning = __( "No location found. Go to Settings > Business Hours Indicator to set up locations.",
					Config_Manager::$slug );

			register_widget($widget);
		}

		private function addBasicOptions(Widget_Options_Manager $option_manager)
		{
			if(sizeof($this->location_names))
			{
				$option_manager->add_text_option(
					'title',
					__( 'Title', Config_Manager::$slug ),
					null
				);

				$option_manager->add_dropdown_option(
					'location',
					__( 'Location', Config_Manager::$slug ),
					array_combine( $this->location_names, $this->location_names )
				);
			}
		}
	}
}