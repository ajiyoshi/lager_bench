lager force the writing "sync" in the log level prior to error
=====

https://github.com/basho/lager/issues/133

prerequire
----
* erlc
* ab (apache bench)
* make

how to prepare
----
    $ make setup
	./rebar get-deps
    ...
    $ make run
    ./rebar compile
    ==> lager (compile)
    ==> ibrowse (compile)
    ==> rel (compile)
    ==> yaws (compile)
    ==> mochiweb (compile)
    ==> log4erl (compile)
    ==> lager_bench (compile)
    erl  -pa ebin/ deps/*/ebin -s ey_app
    Erlang R15B01 (erts-5.9.1) [source] [64-bit] [smp:4:4] [async-threads:0] [kernel-poll:false]

    Eshell V5.9.1  (abort with ^G)
    1> 
    =INFO REPORT==== 18-Apr-2013::13:36:03 ===
    Yaws: Listening to 127.0.0.1:8000 for <1> virtual servers:
     - http://localhost:8000 under /tmp

how to benchmark
----
    $ make bench

    ab -t 5 -c 10 http://127.0.0.1:8000/lager_alert
    Requests per second:    45.12 [#/sec] (mean)
    ....
    ab -t 5 -c 10 http://127.0.0.1:8000/lager_warn
    Requests per second:    7248.91 [#/sec] (mean)
    ....
    ab -t 5 -c 10 http://127.0.0.1:8000/log4erl
    Requests per second:    9129.36 [#/sec] (mean)
    ....

