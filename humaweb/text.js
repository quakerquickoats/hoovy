//////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////

text =
{
    _text: {
        'japanese': {
            'hoovy_studio': "Hoovyスタジオ",
            'login_user': "ID:",
            'login_pass': "パスワード",
            'login_connect': "ログイン",
            'login_disconnect': "ログアウト",
            'no_websocket': "このブラウザーにWebSocketの能力が見つかれません。",
            'log_in': "ログインして下さい。",
            'connect': "接続しました。",
            'disconnect': "接続が切りました",
            'connect_status': "接続がありません。",
            'connecting': "通信中..."
        },

        'english': {
            'hoovy_studio': "Hoovy Studio",
            'login_user': "ID:",
            'login_pass': "password:",
            'login_connect': "Connect",
            'login_disconnect': "Disconnect",
            'no_websocket': "WebSocket is not supported in this browser.",
            'log_in': "Please log in.",
            'connect': "Connected.",
            'disconnect': "Disconnected.",
            'connect_status': "Not connected.",
            'connecting': "Connecting..."
        }
    },

    language: function()
    {
        if (navigator.language == "ja-jp")
            return 'japanese';
        else
            return 'english';
    },

    get: function(Key)
    {
        return text._text[text.language()][Key];
    },

    init: function()
    {
        var Keys = [
            'hoovy_studio',
            'login_user', 'login_pass', 'login_connect', 'login_disconnect',
            'connect_status'
        ];

        for (var I in Keys)
        {
            Key = Keys[I];
            $('#' + Key).html(text.get(Key));
        }
    }
};
