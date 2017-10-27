game = {};

game_messages =
{
    change_to_room: function(client, dict)
    {
        log("部屋を変更: "+dict);
    },

    add_actor: function(client, dict)
    {
        log("アクターを追加:");
        log(dict);
    }
};
