-module(ey_app).

-behaviour(application).

%% API
-export([start/0]).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% API
%% ===================================================================

start() ->
    application:start(ey).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    ey_sup:start_link().

stop(_State) ->
    ok.
