#!/bin/sh
exec erl \
    -pa ebin deps/*/ebin \
    -boot start_sasl \
    -config elog \
    -sname wsServer_dev \
    -s wsServer \
    -s reloader
