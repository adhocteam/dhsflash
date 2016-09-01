$(function () {
  var handleThumbsUp = function (event, elem) {
    var $anchor = $(elem).closest('a');
    var url = $anchor.attr('href');
    $.post(url, function (data) {
      $newThing = $(data);
      $newThing.on('click', function (e) {
        handleThumbsUp(e, this);
        return false;
      });

      $anchor.replaceWith($newThing);
    });

    event.preventDefault();
  };

  $('.thumbs-up').on('click', function (e) {
    handleThumbsUp(e, this);
    return false;
  });
});
