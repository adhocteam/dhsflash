//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require foundation
//= require_tree .

$(function () {
  $(document).foundation();

  // Do form validation
  var form = document.forms.new_kudo;
  if (form) {
    var recipientIdEl = form.elements.kudo_recipient_id;
    var recipientEmailEl = form.elements.kudo_recipient_email;
    var messageEl = form.elements.kudo_message;
    var categoryEl = form.elements.kudo_category;
    var submitBtn = form.elements.commit;

    var valid = function() {
      return messageEl.value.length !== 0
        && (recipientIdEl.value.length !== 0 || recipientEmailEl.value.length !== 0)
        && categoryEl.value.length !== 0;
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

    recipientEmailEl.addEventListener('change', function(e) {
      doValidityCheck();
    });

    doValidityCheck();
  }

  // Handle form submission
  $('#new_kudo').on('ajax:success', function (e, data, status, xhr) {
    addKudo(data);
  }).on('ajax:remotipartComplete', function (e, data) {
    addKudo(data.responseText);
  }).on('ajax:error', function (e, xhr, status, error) {
    if(status != 'parsererror') { // remotipart is triggering this error callback
      $('#error-message-container').html(xhr.responseText);
    }
  });

  function addKudo(data) {
    var list = document.querySelector('.kudos-list');
    var div = document.createElement('div');
    div.innerHTML = data;
    div = div.firstChild;
    list.insertBefore(div, list.firstChild);

    // Clear form
    var form = document.forms.new_kudo;
    form.elements.kudo_recipient_id.value = null;
    form.elements.kudo_category.value = null;
    form.elements.kudo_attachment.value = null;
    form.elements.kudo_message.value = '';
  };

  // Table sorter
  $('th').click(function(){
    var table = $(this).parents('table').eq(0);
    table.find('th span.direction').remove();
    var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
    this.asc = !this.asc
    $(this).append("<span class='direction'>" + (this.asc ? '↑' : '↓' ) + "</span>");
    if (!this.asc){rows = rows.reverse()}
    for (var i = 0; i < rows.length; i++){table.append(rows[i])}
  });

  function comparer(index) {
    return function(a, b) {
        var valA = getCellValue(a, index), valB = getCellValue(b, index)
        return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.localeCompare(valB)
    }
  };

  function getCellValue(row, index){
    return $(row).children('td').eq(index).html();
  }
});
