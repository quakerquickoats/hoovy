%%% -*- erlang -*-

{application, zen,
 [{description, "Zen Server"},
  {vsn, "0.1"},

  {modules, [
             zen_app, zen_sup,
             zen_tcp,
             zen_data,
             zen_irc_sup, zen_irc
            ]},

  {registered, [zen_tcp, zen_data]},

  {mod, {zen_app,[]}},   % only needed if application needs to be started
  {env, [
         {web_port, 8000},

         {tcp_port, 1979},
         {websocket_port, 1980},

         {irc_server, "irc.mibbit.net"},
         {irc_port, 6667},
         {irc_channels, ["#visionire"]},
         {irc_nick, "whomasect"}
        ]},

  {applications, [kernel, stdlib, sasl, mnesia, inets]}
 ]}.

