-module(appmod_with_lager).
-export([out/1]).

out(_) ->
    lager:alert("hoge"),
    {content, "text/plain", "hello with lagger"}.
