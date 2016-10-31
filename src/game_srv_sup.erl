-module(game_srv_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    Procs = [],
    {ok, {{one_for_one, 10, 10}, Procs}}.

% web_specs(Mod, Port) ->
%     WebConfig = [{ip, {0,0,0,0}}, {port, Port}, {docroot, wsServer_deps:local_path(["priv", "www"])}],
%     {Mod, {Mod, start, [WebConfig]}, permanent, 5000, worker, dynamic}.
