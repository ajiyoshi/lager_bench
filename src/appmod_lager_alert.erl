-module(appmod_lager_alert).
-export([out/1]).

out(_) ->
    lager:alert("hoge"),
    {content, "text/plain", "hello with lagger"}.
