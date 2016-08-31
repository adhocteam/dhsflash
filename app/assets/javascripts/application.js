//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

$(function () {
  $(document).foundation();

  $('#new_kudo').on('ajax:success', function (e, data, status, xhr) {
    console.log(data);
  }).on('ajax:error', function (e, xhr, status, error) {
    console.log(e);
    console.log(xhr.responseText);
  });
});
