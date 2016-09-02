//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(function () {
  $(document).foundation();

  // Replace the username <select> with an autocompletion text widget
  var usernameSelect = document.querySelector('#kudo_recipient_id');
  if (usernameSelect) {
    autocomplete(usernameSelect);
  }

  // Do form validation
  var form = document.forms.new_kudo;
  if (form) {
    var recipientIdEl = form.elements.kudo_recipient_id;
    var messageEl = form.elements.kudo_message;
    var categoryEl = form.elements.kudo_category;
    var submitBtn = form.elements.commit;

    var valid = function() {
      return messageEl.value.length !== 0 && recipientIdEl.value.length !== 0 && categoryEl.value.length !== 0;
    };

    var doValidityCheck = function() {
      if (valid()) {
        submitBtn.removeAttribute('disabled');
      } else {
        submitBtn.setAttribute('disabled', '');
      }
    };

    messageEl.addEventListener('keyup', function(e) {
      doValidityCheck();
    });

    recipientIdEl.addEventListener('change', function(e) {
      doValidityCheck();
    });

    categoryEl.addEventListener('change', function(e) {
      doValidityCheck();
    });

    doValidityCheck();
  }

  // Handle form submission
  $('#new_kudo').on('ajax:success', function (e, data, status, xhr) {
    var list = document.querySelector('.kudos-list');
    var div = document.createElement('div');
    div.innerHTML = data;
    div = div.firstChild;
    list.insertBefore(div, list.firstChild);

    // Clear form
    var form = document.forms.new_kudo;
    form.elements.kudo_recipient_id.value = null;
    form.elements.kudo_category.value = null;
    form.elements.kudo_message.value = '';
    form.querySelector('.ah-ac-textfield').value = '';
  }).on('ajax:error', function (e, xhr, status, error) {
    $('#error-message-container').html(xhr.responseText);
  });
});
