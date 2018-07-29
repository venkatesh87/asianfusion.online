(function( $ ) {
	'use strict';

  $(window).ready(function() {

    //
    // Dashboards
    //

    // Account
    if ($('#bistrosol_account_info_widget').length) {
      var account_name = $('#bistrosol-account-name').val();
      var secret_token = $('#bistrosol-secret-token').val();
      var account_url = 'https://www.bistrosol.co/wp-json/bistrosol/v2/account/' + account_name + '/' + secret_token + '/account_info';

      if (!account_name || !secret_token) {
        return false;
      }

      $.getJSON(account_url, function( data ) {
        var items = [];
       
        if (data.alert_text != '') {
          items.push('<li id="bistrosol-alert-text">' + data.alert_text + '</li>');
        }

        if (data.success_text != '') {
          items.push('<li id="bistrosol-success-text">' + data.success_text + '</li>');
        }

        $('<ul/>', {
          'class': '',
          html: items.join('')
        }).replaceAll($('#bistrosol-account').children());
       
      }).fail(function() {
          $('#bistrosol-account').html('<span class="bistrosol-feed-error">' + $('#bistrosol-feed-error').html() + '</span>');
      });
    }

    // News
    if ($('#bistrosol_news_widget').length) {
      var news_url = 'https://www.bistrosol.co/wp-json/wp/v2/news?per_page=5&filter[orderby]=date&order=desc';

      $.getJSON(news_url, function( data ) {
        var items = [];
        
        $.each(data, function(index, item) {
          var title = item.title.rendered;
          var link = item.link;
          var date = item.date;
          items.push( '<li><a href="' + link + '" target="_blank"><span class="bistrosol-news-title">' + title + '</span></a><span class="bistrosol-news-date">' + date + '</span></li>');
        });
       
        $('<ul/>', {
          'class': 'bistrosol-dashboard-info',
          html: items.join('')
        }).replaceAll($('#bistrosol-news').children());
      }).fail(function() {
          $('#bistrosol-news').html('<span class="bistrosol-feed-error">' + $('#bistrosol-feed-error').html() + '</span>');
      });
    }

    // Releases
    if ($('#bistrosol_release_info_widget').length) {
      var release_news_url = 'https://www.bistrosol.co/wp-json/wp/v2/release?per_page=5&filter[orderby]=date&order=desc';
      var release_version_url = 'https://www.bistrosol.co/wp-json/acf/v3/release?per_page=1&filter[orderby]=date&order=desc';

      $.getJSON(release_news_url, function( data ) {
        var items = [];
        
        $.each(data, function(index, item) {
          var title = item.title.rendered;
          var link = item.link;
          var date = item.date;
          items.push( '<li><a href="' + link + '" target="_blank"><span class="bistrosol-release-title">' + title + '</span></a><span class="bistrosol-release-date">' + date + '</span></li>');
        });
       
        $('<ul/>', {
          'class': 'bistrosol-dashboard-info',
          html: items.join('')
        }).replaceAll($('#bistrosol-releases').children());
      }).fail(function() {
          $('#bistrosol-releases').html('<span class="bistrosol-feed-error">' + $('#bistrosol-feed-error').html() + '</span>');
      });

      $.getJSON(release_version_url, function( data ) {
        var name = data[0].acf['name'];
        var version = data[0].acf['version'];

        $('#bistrosol-release-version').html(name + ' ' + version);

      }).fail(function() {
          $('#bistrosol-release-version').html('<span class="bistrosol-feed-error">' + $('#bistrosol-feed-error').html() + '</span>');
      });
    }

    //
    // Database settings form
    //

    var db_fields = ['host', 'name', 'user', 'password', 'port'];

    function check_db_settings() {
      var error = false;
      $('#bistrosol-database-settings-form-error').hide();

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
        $('#bistrosol-database-settings-form-error').show();
      }

      return !error;
    }

    $('#bistrosol-database-settings-form .submit').on('click', function() {
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
