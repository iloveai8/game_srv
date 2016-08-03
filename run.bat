erl -pa ebin deps/mochiweb/ebin deps/cowlib/ebin deps/ranch/ebin deps/cowboy/ebin -boot start_sasl -config elog -name wsServer_dev@127.0.0.1 +K true +P 102400 -s wsServer -s reloader
