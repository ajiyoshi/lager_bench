-module(appmod_log4erl).
-export([out/1]).

out(_) ->
    log4erl:warn("hoge"),
    {content, "text/plain", "hello with log4erl"}.
