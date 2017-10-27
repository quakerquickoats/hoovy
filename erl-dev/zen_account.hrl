%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%%
%%% @end
%%% Created : 19 Sep 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------

-include("huma.hrl").

%%-define(DEV_ID, 100000).
%%-define(USER_ID, 200000).

-type(language() :: english | japanese).
-type(user_group() :: dev | admin | editor | player).

-record(account,
        {
          id :: uinteger(),
          login :: string(),
          password :: string(),
          name :: string(),
          language = english :: language(),
          games = [] :: [atom()],
          create_time = erlang:localtime(),
          last_time = never,
          last_ip = {0,0,0,0},
          auth_count=0 :: uinteger()
        }).
