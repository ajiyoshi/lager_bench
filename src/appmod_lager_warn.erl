-module(appmod_lager_warn).
-export([out/1]).

out(_) ->
    lager:warn("hoge"),
    {content, "text/plain", "hello with lagger"}.
