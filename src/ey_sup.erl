-module(ey_sup).

-behaviour(supervisor).

%% API
-export([start_from_cmd_line/0, start_non_otp/0, start_non_otp/1, start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% ===================================================================
%% API functions
%% ===================================================================

start_from_cmd_line() ->
    spawn(?MODULE, start_non_otp, [self()]),
    wait_for_startup().

start_non_otp() ->
    start_link(false).

start_link() ->
    start_link(true).

start_link(IsOtp) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, [IsOtp]).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([IsOtp]) ->
    init([IsOtp, nothing]);
init([IsOtp, RequesterInfo]) ->
    M = embedded_yaws,
    F = case IsOtp of
            false -> start_non_otp;
            true -> start_link
        end, 
    A = case RequesterInfo of
            nothing -> [];
            _ -> [RequesterInfo]
        end,
    Children = [{M, {M, F, A}, permanent, 5000, worker, [M]}],
    {ok, { {one_for_one, 5, 10}, Children} }.

%% ===================================================================
%% Internal
%% ===================================================================

wait_for_startup() ->
    receive
        {done, RetVal} -> RetVal
    end.

start_non_otp(Parent) ->
    Ref = make_ref(),
    RetVal = supervisor:start_link({local, ?MODULE}, ?MODULE, [false, {self(), Ref}]),
    receive
        {done, Ref} -> Parent ! {done, RetVal}
    end,
    persist_sup_proc().

persist_sup_proc() ->
    receive
        _ -> persist_sup_proc()
    end.
