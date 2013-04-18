-module(appmod_without_lager).
-export([out/1]).

out(_) ->
    error_logger:format("~p~n", ["hoge"]),
    {content, "text/plain", "hello without lagger"}.

