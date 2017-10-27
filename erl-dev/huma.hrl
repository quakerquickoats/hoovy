%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%%
%%% @end
%%% Created :  6 Sep 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------

-type(uinteger() :: non_neg_integer()).
%%-type(vector2f() :: {float(), float()}).
%%-type(point() :: {float(), float()}).
%%-type(range() :: {uinteger(), uinteger()}).

%%%===================================================================
%%% math
%%%===================================================================

-define(min(A,B), if A<B -> A; A>=B -> B end).
-define(max(A,B), if A>B -> A; A=<B -> B end).

-define(real_isnegative(R), if R < -?EPSILON -> true;
                               _ -> false end).
%%% 他のファイルにもっとがある

%%%===================================================================
%%% random
%%%===================================================================

-type(seed() :: {uinteger(), uinteger(), uinteger()}).

%%%===================================================================
%%% geom
%%%===================================================================

-define(degrees_to_radians(C), C * math:pi() / 180.0).
-define(radians_to_degrees(C), C * 180.0 / math:pi()).

-record(point, {x,y}).
-record(size, {width,height}).
-record(rect, {origin,size}).
-record(circle, {origin,radius}).

%%-type(point, #point{}).

%%%===================================================================
%%% Database
%%%===================================================================

-define(init_table(X,Y),
        huma_db:init_table(X, Y, record_info(fields, X))).
-define(init_table(X,Y,T),
        huma_db:init_table(X, Y, record_info(fields, X), T)).

%%%===================================================================
%%% OTP
%%%===================================================================

-define(APP_ENV(App, Key), case application:get_env(App, Key) of
                               {ok,Value} -> Value;
                               undefined -> undefined
                           end).

%%-define(log, io:format).
