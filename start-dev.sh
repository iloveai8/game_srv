#!/bin/sh




exec erl  \
    -pa ebin deps/*/ebin \
    -boot start_sasl \
    -config elog \
    -sname game_srv_dev \
    -s game_srv \
    -s reloader



