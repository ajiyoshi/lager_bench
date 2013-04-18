-module(embedded_yaws).
-behaviour(gen_server).
-define(SERVER, ?MODULE).

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------

-export([start_link/0]).
-export([start_yaws/0]).

%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------

init(Args) ->
    logger_config:start(),
    self() ! start_yaws,
    {ok, Args}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(start_yaws, State) ->
    start_yaws(),
    {noreply, State};
handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------

start_yaws() ->
    {ok, SCList, GC, ChildSpecs} = make_yaws_conf(),
    [supervisor:start_child(ey_sup, Ch) || Ch <- ChildSpecs],
    yaws_api:setconf(GC, SCList),
    ok.

make_yaws_conf() ->
    Id = "embedded",
    GconfList = [
        {id, Id}
        ,{logdir, "./log"}
    ],
    Docroot = "/tmp",
    SconfList = [{port, 8000},
                 {listen, {127,0,0,1}},
                 {docroot, Docroot},
                 {appmods, [
                         {"/lager_alert", appmod_lager_alert}
                         ,{"/lager_warn", appmod_lager_warn}
                         ,{"/without_lager", appmod_without_lager}
                         ,{"/log4erl", appmod_log4erl}
                     ]}],
    yaws_api:embedded_start_conf(Docroot, SconfList, GconfList, Id).
