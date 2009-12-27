$(document).ready(function() {

    $('#extra_fields').hide();

    // toggles the send to a friend div
    $('a#show_extra').click(function() {
        $('#extra_fields').toggle(400);
        return false;
    });
});

