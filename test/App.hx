package test;

import ng.Angular;
import ng.IConfig;

class App implements IConfig
{
	public static function main(){
		Angular.module('test',["ngTouch","ngRouter"]);
		test.Controller.main();
	}

	@:inject("$http")
	public static var initConfig:Dynamic = function(http:Http){
        trace("initConfig");
    }
}