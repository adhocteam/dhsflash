$(function () {
  $('#kudo-filter').on('change', function () {
    $.get('/kudos', { filter: $(this).val() }, function (data) {
      $('#kudo-stream').html($(data));
    });
  });
});
