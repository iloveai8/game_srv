%% @author Mochi Media <dev@mochimedia.com>
%% @copyright 2010 Mochi Media <dev@mochimedia.com>

%% @doc wsServer.

-module(wsServer).
-author("Mochi Media <dev@mochimedia.com>").
-export([start/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.


%% @spec start() -> ok
%% @doc Start the wsServer server.
start() ->
    ensure_started(crypto),
    ensure_started(cowlib),
    ensure_started(ranch),
    ensure_started(cowboy),
    ensure_started(wsServer).


%% @spec stop() -> ok
%% @doc Stop the wsServer server.
stop() ->
    application:stop(wsServer).
