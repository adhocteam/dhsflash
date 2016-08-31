document.addEventListener('DOMContentLoaded', function() {
    var usernameSelect = document.querySelector('#kudo_recipient_id');
    autocomplete(usernameSelect);
});

function autocomplete(selectEl) {
    // Get a list of username/ID pairs, lowercase the usernames for matching, and sort by them
    var usernameIdPairs = [];
    var options = selectEl.options;
    for (var i = 0; i < options.length; i++) {
        usernameIdPairs.push({
            id: options[i].value,
            username: options[i].text.toLowerCase(),
            label: options[i].text
        });
    }
    usernameIdPairs.sort(function(a, b) {
        if (a.username < b.username) return -1;
        if (a.username > b.username) return 1;
        return 0;
    });

    // Hide the <select>
    selectEl.style.display = 'none';

    // Insert the text field to replace it
    var textField = document.createElement('input');
    textField.setAttribute('type', 'text');
    textField.setAttribute('placeholder', 'username');
    textField.classList.add('ah-ac-textfield');
    selectEl.parentNode.insertBefore(textField, selectEl);

    // Add a <div> for the matches to go in
    var matchesDiv = document.createElement('div');
    matchesDiv.classList.add('ah-ac-matches');
    matchesDiv.style.position = 'absolute';
    var tfBbox = textField.getBoundingClientRect();
    matchesDiv.style.top = (tfBbox.top + textField.offsetHeight) + 'px';
    matchesDiv.style.left = tfBbox.left + 'px';
    matchesDiv.style.width = textField.offsetWidth + 'px';
    document.body.appendChild(matchesDiv);

    var matches = [];

    // Fill the autocomplete div with matches
    var updateACMatches = function() {
        if (matches.length === 0) {
            matchesDiv.style.display = 'none';
            selectEl.value = null;
            return;
        }

        matchesDiv.style.display = 'block';
        while (matchesDiv.hasChildNodes()) matchesDiv.removeChild(matchesDiv.lastChild);
        for (var i = 0; i < matches.length; i++) {
            var matchDiv = document.createElement('div');
            matchDiv.setAttribute('data-recipient-id', matches[i].id);
            matchDiv.classList.add('ah-ac-match');
            matchDiv.textContent = matches[i].label;
            matchesDiv.appendChild(matchDiv);
            matchDiv.addEventListener('click', handleACMatchClick);
        }
    };

    updateACMatches();

    // Set the username and id behind the scene when user clicks on an autocomplete match
    var handleACMatchClick = function(e) {
        var id = e.target.getAttribute('data-recipient-id');
        matchesDiv.style.display = 'none';
        // Set the <select>
        selectEl.value = id;
        // Replace the text field's value
        for (var i = 0; i < usernameIdPairs.length; i++) {
            if (id === usernameIdPairs[i].id) {
                textField.value = usernameIdPairs[i].label;
                break;
            }
        }
    };

    // Listen for typing
    var handleTyping = function(e) {
        var entry = e.target.value.toLowerCase();
        matches = [];
        if (entry !== '') {
            for (var i = 0; i < usernameIdPairs.length; i++) {
                var pair = usernameIdPairs[i];
                if (pair.username.startsWith(entry)) {
                    matches.push(pair);
                }
            }
        }
        updateACMatches();
    };
    textField.addEventListener('keypress', handleTyping);

    // Handle [Tab] key -- clears matches but could be changed to cycle through completions
    textField.addEventListener('keydown', function(e) {
        var TAB = 9;
        if (e.which === TAB) {
            matches = [];
            updateACMatches();
        }
    });
}
