(function( $ ) {
	'use strict';

	/**
	 * All of the code for your admin-facing JavaScript source
	 * should reside in this file.
	 *
	 * Note: It has been assumed you will write jQuery code here, so the
	 * $ function reference has been prepared for usage within the scope
	 * of this function.
	 *
	 * This enables you to define handlers, for when the DOM is ready:
	 *
	 * $(function() {
	 *
	 * });
	 *
	 * When the window is loaded:
	 *
	 * $( window ).load(function() {
	 *
	 * });
	 *
	 * ...and/or other possibilities.
	 *
	 * Ideally, it is not considered best practise to attach more than a
	 * single DOM-ready or window-load handler for a particular page.
	 * Although scripts in the WordPress core, Plugins and Themes may be
	 * practising this, we should strive to set a better example in our own work.
	 */

  $(window).ready(function() {

    var db_fields = ['host', 'name', 'user', 'password', 'port'];

    function check_db_settings() {
      var error = false;
      $('#bistrosol-db-settings-form-error').hide();

      db_fields.forEach(function(field) {
        var field_container = $('.database_' + field + '_field');
        var field_value = $('#database_' + field).val().trim();
        field_container.removeClass('error');
        if (field_value === '') {
          console.log('database ' + field + ' error');
          field_container.addClass('error');
          error = true;
        }
      });

      if (error) {
        $('#bistrosol-db-settings-form-error').show();
      }

      return !error;
    }

    $('#bistrosol-db-settings-form .submit').on('click', function() {
      if (!check_db_settings()) {
        return false;
      }
    });

    $('#test-db-connection').on('click', function() {
      if (!check_db_settings()) {
        return false;
      }

      $(this).attr('disabled', true);
      $('#test-db-spinner').show();
      $('#test-db-result-connected').hide();
      $('#test-db-result-not-connected').hide();
    
      var form_data = new FormData();

      var database_host = $('#database_host').val().trim();
      var database_name = $('#database_name').val().trim();
      var database_user = $('#database_user').val().trim();
      var database_password = $('#database_password').val().trim();
      var database_port = $('#database_port').val().trim();

      form_data.append('action', 'test_db_connection');
      form_data.append('database_host', database_host);
      form_data.append('database_name', database_name);
      form_data.append('database_user', database_user);
      form_data.append('database_password', database_password);
      form_data.append('database_port', database_port);

      //form_data.append('database_ca', $('#database_ca')[0].files[0]);
      //form_data.append('database_client_cert', $('#database_client_cert')[0].files[0]);
      //form_data.append('database_client_key', $('#database_client_key')[0].files[0]);

      $.ajax({
        type: 'post',
        url: ajaxurl,
        dataType: 'json',
        cache: false,
        contentType: false,
        processData: false,
        data: form_data
      }).done(function(response) {
        if (response.success === true) {
          $('#test-db-result-connected').show();
        } else {
          $('#test-db-result-not-connected').show();
        }
        $('#test-db-spinner').hide();
        // $(this) not available here
        $('#test-db-connection').removeAttr('disabled');
      });
    });
  });

})( jQuery );
