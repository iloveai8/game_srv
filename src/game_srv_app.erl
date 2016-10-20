-module(game_srv_app).
-behaviour(application).
-compile(export_all).
%% API.
start(_Type, _Args) ->
    log:start(),
    {ok, _} = start_http(),
    {ok, _} = start_https(),
    game_srv_sup:start_link().

stop(_State) ->
    ok.

start_http() ->
    StaticDir = get_path("priv"),
    Dispatch = cowboy_router:compile([
        {"[...]test.:_", [
                {"/", cowboy_static, {file, StaticDir ++ "/index.html"}},  
                {"/static/[...]", cowboy_static, {dir, StaticDir}},
                {"/websocket", ws_handler, []},
                {"/:name", toppage_handler, []}]},
        {"[www.]test.:_", [
                {"/", cowboy_static, {file, StaticDir ++ "/index.html"}},  
                {"/static/[...]", cowboy_static, {dir, StaticDir}},
                {"/websocket", ws_handler, []},
                {"/:name", toppage_handler, []}]},
        {"www.wsserver.com", [
                {"/", cowboy_static, {file, StaticDir ++ "/index.html"}},  
                {"/static/[...]", cowboy_static, {dir, StaticDir}},
                {"/websocket", ws_handler, []},
                {"/:name", toppage_handler, []}]}
    ]),
    cowboy:start_http(http, 100, [{port, 8081}], [{env, [{dispatch, Dispatch}]}]).

start_https() ->
    StaticDir = get_path("priv"),
    CertDir = get_path("priv/ssl"),
    Dispatch = cowboy_router:compile([
        {'_', [
                {"/", cowboy_static, {file, StaticDir ++ "/index_ssl.html"}},  
                {"/static/[...]", cowboy_static, {dir, StaticDir}},
                {"/websocket", ws_handler, []},
                {"/toppage_handler", toppage_handler, []}
        ]}
    ]),
    cowboy:start_https(https, 100, [{port, 8082},
                                    {cacertfile, CertDir ++ "/ca.crt"},
                                    {certfile, CertDir ++ "/server.crt"},
                                    {keyfile, CertDir ++ "/server.key"}], [{env, [{dispatch, Dispatch}]}]).    

get_path(ExtraPath)->
    {ok, CurrentPath} = file:get_cwd(),
    Path = string:concat(CurrentPath, "/"),
    string:concat(Path, ExtraPath).  

priv_dir(ExtraPath) ->
    case code:priv_dir(ExtraPath) of
        {error, bad_name} ->
            "./priv";
        Priv ->
            Priv
    end.