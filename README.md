cowboy ssl config

一、cowboy 依赖 
	ensure_started(crypto)
    ensure_started(cowlib)
    ensure_started(ranch)
    ensure_started(cowboy)

二、CA证书制作
	指定目录 or 在priv目录
	利用openssl 生成 ca.crt、server.key、servev.crt、client.key、client.crt

	或者利用脚本 gencert.sh生成

	注意：证书生成规则中ca证书 CN==>访问域名一定要是服务器部署的域名否则无法访问例如：www.wsserver.com(本地测试可以输入IP：10.0.6.230)

三、ssl 配置
	A、获取证书文件目录, 参数配置里面会用到路径  CertDir
	CertDir = 
		fun get_path(CertPath)->
		    {ok, CurrentPath} = file:get_cwd(),
		    Path = string:concat(CurrentPath, "/"),
		    string:concat(Path, CertPath).  

    B、https 参数配置
    	cowboy:start_https(Ref, NbAcceptors, TransOpts, ProtoOpts)
    	Ref 		==> https (atom)
    	NbAcceptors ==> 100 (默认)
    	TransOpts 	==> [{port, 8080}, {cacertfile, CertDir ++ "/ca.crt"}, {certfile, CertDir ++ "/server.crt"}, {keyfile, CertDir ++ "/server.key"}]
			    	  	port ==> 8080
			    	  	cacertfile ==> CA根证书路径
			    	  	certfile ==> 服务器CA签名证书路径
			    	  	keyfile ==> 服务器秘钥Key
    	ProtoOpts 	==> 
			    		[{env, [{dispatch, Dispatch}]}]  	
			    		Dispatch = list()::HostsMatch

四、启动服务器，可通过浏览器访问测试 https://www.wsserver.com:Port/pathSource    		


    	 

	
    


