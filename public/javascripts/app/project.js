$(document).ready(function() {

    $('#send_friend_div').hide();

    // toggles the send to a friend div
    $('a#send_friend_a').click(function() {
        $('#send_friend_div').toggle(400);
        return false;
    });
});

