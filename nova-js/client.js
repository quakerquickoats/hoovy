client = 
{
    is_connected: false,
    socket: null,

    init: function()
    {
        $('#user_name').val(localStorage['user_name']);
        $('#login_status').html(text.get('log_in'));
        $('#login_panel').show();
    },

    //---------------
    // interface
    //---------------

    login: function()
    {
        var Creds = {
            user: $("#user_name").val().trim(),
            pass: $("#pass_word").val().trim()
        };

        if (Creds.user == "" || Creds.pass == "")
            return;

        // clear password and remember user name

        $("#pass_word").val("");
        localStorage["user_name"] = Creds.user;

        this.start(Creds);
    },

    send_command: function()
    {
        var Command = $('#command').val().trim();
        if (Command == "")
            return;

        client.send_object({'command': Command});
        $("#command").val("");
    },

    logout: function() { this.socket.close(); },

    //----------------
    // messages
    //----------------

    send_object: function(Object)
    {
        var Message = JSON.stringify(Object);
        console.log("aoeuaoeu: " + Message);
        client.socket.send(Message);
    },

    messages:
    {
        'error': function(Client, Message)
        {
            $('#login_status').html(Message);
            $('#login_panel').show();

            // disconnect..
        },

        'test_response': function(Client, Message)
        {
            log("OK.");
        }
    },

    //-------------------
    // connection
    //-------------------

    start: function(Creds)
    {
        $('#connect_status').html(text.get('connecting'));

        this.is_connected = false;
        this.message_handlers = [client.messages, game.messages];

        var Host =
            window.location.hostname?
            window.location.hostname:"localhost";

        var Socket = new WebSocket("ws://"+Host+":1980/");
        Socket.onopen = function(E)
        {
            client.send_object({'login': [Creds.user,
                                          Creds.pass,
                                          text.language()]});

            client.is_connected = true;
            $('#login_panel').hide();
            $('#game').show();
            $('#connect_status').html(text.get('connect'));
        };

        Socket.onclose = function(E)
        {
            if (!client.is_connected)
                alert("Could not connect to server!");

            client.is_connected = false;
            $('#login_panel').show();
            $('#game').hide();
            $('#connect_status').html(text.get('disconnect'));
        };

        Socket.onerror = function(E)
        {
            alert("socket error:" + E.type);
        };

        Socket.onmessage = function(E)
        {
            var Object = null;
            
            console.log("what did we get: " + E.data);

            try {
                Object = JSON.parse(E.data);
            } catch (x) {
                console.log(E.data);
                console.log("Could not parse JSON!");
            }

            if (!Object)
                return;

            console.log(Object);
            
            for (var Key in Object)
            {
                var Found = null;

                for (var I in client.message_handlers)
                {
                    var Test = client.message_handlers[I][Key];
                    if (Test != undefined)
                    {
                        Found = Test;
                        break;
                    }
                }

                if (Found == null)
                {
                    console.log("Unknown message '" + Key + "'.");
                    continue;
                }
                
                Found(client, Object[Key]);
            }
        };

        this.socket = Socket;
    }
};
