jQuery(function ($) {
    $('.aspect_days_tabs a').on('click', function (e) {
        e.preventDefault();
        var parent = $(this).parents('.aspect_days_periods');
        var id = $(this).data('day');

        $(parent).find('.aspect_days_tabs a, .aspect_day_period').removeClass('active').filter(function () {
            return $(this).data('day') === id;
        }).addClass('active');
    }).first().trigger('click');

    $('.aspect_day_period')
        .on('click', '.aspect_day_delete', function (e) {
            e.preventDefault();
            $(this).parents('.aspect_period').remove();
        })
        .on('change', 'input', function () {
            $('.aspect_day_period').find('tbody tr input').removeClass('aspect_day_error');
            $('#submit').removeAttr('disabled');

            var errors = $('.aspect_day_period').find('tbody tr').toArray().filter(function (elem) {
                var start = $(elem).find('.aspect_day_start');
                var end = $(elem).find('.aspect_day_end');
                if (start.val() === '' || end.val() === '') {
                    return false;
                }
                return start.val() >= end.val();
            });

            $('.aspect_day_period .error').remove();
            $('.aspect_day_period').find('tbody').toArray().filter(function (elem) {
                var periods = $(elem).find('tr').toArray();

                periods = periods.map(function (period) {
                    return $(period).find('input').toArray().map(function (input) {
                        return $(input).val();
                    });
                });
                return periods.filter(function (elem, index) {
                        return periods.filter(function (otherElem, otherIndex) {
                                if (otherIndex === index) return false;

                                return elem[0] > otherElem[0] && elem[0] < otherElem[1] || elem[1] > otherElem[0] && elem[1] < otherElem[1];
                            }).length > 0;
                    }).length > 0;
            }).forEach(function (elem) {
                var element = $(elem).parents('.aspect_day_period');
                element.prepend($('<div class="error"/>').text('Period collision'));
                $('#submit').attr('disabled', 'disabled');
            });

            if (errors.length) {
                $('#submit').attr('disabled', 'disabled');
                errors.forEach(function (elem) {
                    $(elem).find('input').addClass('aspect_day_error');
                });
            }
        });

    $('.aspect_day_add').on('click', function (e) {
        e.preventDefault();
        var day = $(this).parents('.aspect_day_period');
        var day_name = day.data('day');
        var name = day.data('base');
        var id = 0;
        if (day.find('.aspect_period').length) {
            id = parseInt(day.find('.aspect_period').last().data('id')) + 1;
        }

        var row = $('<tr class="aspect_period">');
        row.data('id', id);

        row.append($('<td>').append(createPeriodInput(name, 'start', day_name, id)));
        row.append($('<td>').append(createPeriodInput(name, 'end', day_name, id)));
        row.append($('<td><button class="aspect_day_delete button">&times;</button></td>'));

        day.find('tbody').append(row);
    });

    function createPeriodInput(name, type, day, id) {
        var time = $('<input type="time">');
        name += '[' + day + ']';
        name += '[' + id + ']';
        name += '[' + type + ']';
        time.attr('name', name);
        time.addClass('aspect_day_' + type);

        return time;
    }
});