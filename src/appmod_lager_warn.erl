-module(appmod_lager_warn).
-export([out/1]).

out(_) ->
    lager:warning("hoge"),
    {content, "text/plain", "hello with lagger"}.
