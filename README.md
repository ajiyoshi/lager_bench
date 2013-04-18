is lager slow?
=====

I use yaws as web server for sub system of our advertising system.
I try to use lager to log our application log.
but it was to slow for me.
did i do any miss configuration or insane use of lager?

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
    ab -t 5 -c 10 http://127.0.0.1:8000/with_lager
    This is ApacheBench, Version 2.3 <$Revision: 655654 $>
    Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
    Licensed to The Apache Software Foundation, http://www.apache.org/

    Benchmarking 127.0.0.1 (be patient)


    Server Software:        Yaws
    Server Hostname:        127.0.0.1
    Server Port:            8000

    Document Path:          /with_lager
    Document Length:        17 bytes

    Concurrency Level:      10
    Time taken for tests:   5.002 seconds
    Complete requests:      239
    Failed requests:        0
    Write errors:           0
    Total transferred:      37523 bytes
    HTML transferred:       4063 bytes
    Requests per second:    47.78 [#/sec] (mean)
    Time per request:       209.304 [ms] (mean)
    Time per request:       20.930 [ms] (mean, across all concurrent requests)
    Transfer rate:          7.33 [Kbytes/sec] received

    Connection Times (ms)
                  min  mean[+/-sd] median   max
    Connect:        0    0   0.0      0       0
    Processing:    27  206  43.6    193     320
    Waiting:       27  206  43.6    193     320
    Total:         27  206  43.6    193     320

    Percentage of the requests served within a certain time (ms)
      50%    193
      66%    212
      75%    223
      80%    229
      90%    277
      95%    301
      98%    301
      99%    301
     100%    320 (longest request)
    ab -t 5 -c 10 http://127.0.0.1:8000/without_lager
    This is ApacheBench, Version 2.3 <$Revision: 655654 $>
    Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
    Licensed to The Apache Software Foundation, http://www.apache.org/

    Benchmarking 127.0.0.1 (be patient)


    Server Software:        Yaws
    Server Hostname:        127.0.0.1
    Server Port:            8000

    Document Path:          /without_lager
    Document Length:        20 bytes

    Concurrency Level:      10
    Time taken for tests:   5.000 seconds
    Complete requests:      40691
    Failed requests:        0
    Write errors:           0
    Total transferred:      6510560 bytes
    HTML transferred:       813820 bytes
    Requests per second:    8138.14 [#/sec] (mean)
    Time per request:       1.229 [ms] (mean)
    Time per request:       0.123 [ms] (mean, across all concurrent requests)
    Transfer rate:          1271.58 [Kbytes/sec] received

    Connection Times (ms)
                  min  mean[+/-sd] median   max
    Connect:        0    0   0.1      0       3
    Processing:     0    1   2.4      1     144
    Waiting:        0    1   2.4      1     144
    Total:          0    1   2.4      1     144

    Percentage of the requests served within a certain time (ms)
      50%      1
      66%      1
      75%      1
      80%      1
      90%      2
      95%      2
      98%      4
      99%      6
     100%    144 (longest request)
    ab -t 5 -c 10 http://127.0.0.1:8000/log4erl
    This is ApacheBench, Version 2.3 <$Revision: 655654 $>
    Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
    Licensed to The Apache Software Foundation, http://www.apache.org/

    Benchmarking 127.0.0.1 (be patient)


    Server Software:        Yaws
    Server Hostname:        127.0.0.1
    Server Port:            8000

    Document Path:          /log4erl
    Document Length:        18 bytes

    Concurrency Level:      10
    Time taken for tests:   5.000 seconds
    Complete requests:      36460
    Failed requests:        0
    Write errors:           0
    Total transferred:      5760680 bytes
    HTML transferred:       656280 bytes
    Requests per second:    7291.94 [#/sec] (mean)
    Time per request:       1.371 [ms] (mean)
    Time per request:       0.137 [ms] (mean, across all concurrent requests)
    Transfer rate:          1125.12 [Kbytes/sec] received

    Connection Times (ms)
                  min  mean[+/-sd] median   max
    Connect:        0    0   0.1      0       1
    Processing:     0    1   0.8      1      17
    Waiting:        0    1   0.8      1      17
    Total:          0    1   0.8      1      17

    Percentage of the requests served within a certain time (ms)
      50%      1
      66%      1
      75%      1
      80%      2
      90%      2
      95%      2
      98%      4
      99%      5
     100%     17 (longest request)
