//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

$(function () {
  $(document).foundation();

  $('#new_kudo').on('ajax:success', function (e, data, status, xhr) {
    var list = document.querySelector('.kudos-list');
    var div = document.createElement('div');
    div.innerHTML = data;
    div = div.firstChild;
    list.insertBefore(div, list.firstChild);

    // Clear form
    var form = document.forms.new_kudo;
    form.elements.kudo_recipient_id.value = null;
    form.elements.kudo_message.value = '';
    form.querySelector('.ah-ac-textfield').value = '';
  }).on('ajax:error', function (e, xhr, status, error) {
    $('#error-message-container').html(xhr.responseText);
  });
});
