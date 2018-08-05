(function( $ ) {
	'use strict';

  $(window).ready(function() {

    $('#create-test-products').on('click', function() {
      $.ajax({
        type: 'post',
        url: ajaxurl,
        data: {
          action: 'create_test_products'
        },
        dataType: 'json'
      }).done(function(response) {
        alert('Success');
      });
    });

  });

})( jQuery );
