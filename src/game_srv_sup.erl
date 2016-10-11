-module(game_srv_sup).
-behaviour(supervisor).

-export([start_link/0, upgrade/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

upgrade() ->
    {ok, {_, Specs}} = init([]),
    Old = sets:from_list( [Name || {Name, _, _, _} <- supervisor:which_children(?MODULE)]),
    New = sets:from_list([Name || {Name, _, _, _, _, _} <- Specs]),
    Kill = sets:subtract(Old, New),

    sets:fold(fun (Id, ok) -> supervisor:terminate_child(?MODULE, Id), supervisor:delete_child(?MODULE, Id), ok end, ok, Kill),
    [supervisor:start_child(?MODULE, Spec) || Spec <- Specs],
    ok.

init([]) ->
    Procs = [],
    {ok, {{one_for_one, 10, 10}, Procs}}.

web_specs(Mod, Port) ->
    WebConfig = [{ip, {0,0,0,0}}, {port, Port}, {docroot, wsServer_deps:local_path(["priv", "www"])}],
    {Mod, {Mod, start, [WebConfig]}, permanent, 5000, worker, dynamic}.
