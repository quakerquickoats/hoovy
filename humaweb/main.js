// Gamelike client

$(document).ready(function() {
    text.init();

    ('WebSocket' in window)
        ? client.init()
        : alert(text.get('no_websocket'));

    //
    // デバッグで行く!
    //
    return;

    if (0)
        client.start({user: "dev", pass: "dev"});
    else
    {
        client.is_connected = true;

        $("game").show();
        $("login_panel").hide();
    }
});

document.onkeydown = function(E) {
    if (!client.is_connected)
        return;

    var AngleMap = {
        "d": 270,
        "b": 180,
        "f": 90,
        "h": 0,

        "g": 315,
        "i": 45,
        "c": 135,
        "a": 225
    };

    var S = String.fromCharCode(E.which || E.keyCode);

    if (S in AngleMap)
        client.send_object({'move': AngleMap[S]});
		//world.turn ({target: world.player, angle: angle});
	else
		console.log("テスト '" + s + "'");
};

document.onkeyup = function(event)
{
};

