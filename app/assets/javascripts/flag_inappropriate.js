$(function () {
  $('.flag-inappropriate').on('click', function (e) {
    var $anchor = $(e.target).closest('a');
    var url = $anchor.attr('href');
    $.post(url);
    e.preventDefault();
    return false;
  });
});
