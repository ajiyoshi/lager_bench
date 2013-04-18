-module(logger_config).

%% API
-export([start/0]).

-define(HANDLERS, 
        [
         {lager_file_backend, [
          [{"log/lager_alert.log", alert, 10485760, "$D05", 5}, {lager_default_formatter, [date, " (", time, "),", message, "\n"]}]
          ,[{"log/lager_warn.log", warning, 10485760, "$D05", 5}, {lager_default_formatter, [date, " (", time, "),", message, "\n"]}]
        ]}]).

start() ->
    start_lager(),
    start_log4erl(),
    ok.

start_lager() ->
    application:load(lager),
    application:set_env(lager, handlers, ?HANDLERS),
    application:set_env(lager, error_logger_redirect, false),
    application:start(lager),
    ok.

start_log4erl() ->
    application:start(log4erl),
    log4erl:conf("priv/log4erl.conf"),
    ok.
