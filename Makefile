.PHONY:test

all: compile

setup:
	./rebar get-deps
	cp priv/rebar.config.yaws deps/yaws/rebar.config
	touch deps/yaws/priv/charset.def
	mkdir -p log

compile:
	./rebar compile

test:
	./rebar eunit

clean:
	./rebar clean

OPT=

run: compile
	erl $(OPT) -pa ebin/ deps/*/ebin -s ey_app

bench:
	ab -t 5 -c 10 http://127.0.0.1:8000/lager_alert
	#ab -t 5 -c 10 http://127.0.0.1:8000/without_lager
	ab -t 5 -c 10 http://127.0.0.1:8000/lager_warn
	ab -t 5 -c 10 http://127.0.0.1:8000/log4erl
