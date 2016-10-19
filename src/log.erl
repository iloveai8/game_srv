%===============================================
% This file is part of the "Gem Engine"
% Copyright(C), 2011
% History:
% Created by JiZhe
%===============================================
%% Log

-module(log).
-export([start/0,error/2,error/1,info/1,info/2,warning/1,warning/2]).

%% -compile( export_all ).
-define( LOG_DIR, "./log/" ).

start() ->
	% {{Year, Month, Day}, {Hour, Minute, Second}} = erlang:localtime(),
	% {ok, App} = application:get_application(),
 	% Filename = lists:flatten(io_lib:format("~p_~4..0w_~2..0w_~2..0w ~2..0w_~2..0w_~2..0w", 
 	% 		[App, Year, Month, Day, Hour, Minute, Second])) ++ ".log",
	filelib:ensure_dir( ?LOG_DIR ),
	% FilePath = filename:join( ?LOG_DIR, Filename ),
	% error_logger:logfile({open, FilePath}),
	info( "Log Started!~n" ).

-ifdef(debug).
	info( Msg ) -> 
		error_logger:info_msg( Msg ).
	info( Msg, ArgvList ) -> 
		error_logger:info_msg( Msg, ArgvList ).
	warning( Msg ) -> 
		error_logger:warning_msg( Msg ).
	warning( Msg, ArgvList ) -> 
		error_logger:warning_msg( Msg, ArgvList ).
	error( Msg) -> 
		error_logger:error_msg( Msg ).
	error( Msg, ArgvList ) -> 
		error_logger:error_msg( Msg, ArgvList ).
-else.
	info( _Msg ) -> 
		ok.
	info( _Msg, _ArgvList ) -> 
		ok.
	warning( _Msg ) -> 
		ok.
	warning( _Msg, _ArgvList ) -> 
		ok.
	error( _Msg ) -> 
		ok.
	error( _Msg, _ArgvList ) -> 
		ok.
-endif.