var BOSH_SERVICE = '/http-bind'
var connection = null;

function log(msg)
{
    $('#log').append('<div></div>').append(document.createTextNode(msg));
}

function rawInput(data)
{
    log('RECV: ' + data);
}

function rawOutput(data)
{
    log('SENT: ' + data);
}

function onMessage(msg) {
    var to = msg.getAttribute('to');
    var from = msg.getAttribute('from');
    var type = msg.getAttribute('type');
    var elems = msg.getElementsByTagName('body');

    if (type == "chat" && elems.length > 0) {
        var body = elems[0];
        log('ECHOBOT: I got a message from ' + from + ': ' +
            Strophe.getText(body));
        var reply = $msg({to: from, from: to, type: 'chat'})
            .cnode(Strophe.copyElement(body));
        connection.send(reply.tree());
        log('ECHOBOT: I sent ' + from + ': ' + Strophe.getText(body));
    }

    // we must return true to keep the handler alive.
    // returning false would remove it after it finishes.
    return true;
}

function onConnect(status)
{
    if (status == Strophe.Status.CONNECTING) {
        log('Connecting XMPP...');
    } else if (status == Strophe.Status.CONNFAIL) {
        log('Failed to connect.');
    } else if (status == Strophe.Status.DISCONNECTING) {
        log('Strophe is disconnecting.');
    } else if (status == Strophe.Status.DISCONNECTED) {
        log('Strophe is disconnected.');
    } else if (status == Strophe.Status.CONNECTED) {
        log('XMPP Connected.');
        log('ECHOBOT: Send a message to ' + connection.jid + ' to talk to me.');
        connection.addHandler(onMessage, null, 'message', null, null,  null);
        connection.send($pres().tree());
        //connection.disconnect();
    }
    // Return true to keep it alive
    return true;
}

$(document).ready(function () {
    connection = new Strophe.Connection(BOSH_SERVICE);
    connection.rawInput = rawInput;
    connection.rawOutput = rawOutput;

    //$('#connect').bind('click', function () {
    connection.connect("solo@localhost", "code", onConnect);
    //connection.disconnect();
});

//TODO: disconnect on close window!!
