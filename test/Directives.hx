package test;

import ng.Angular;
import ng.IDirectives;
import test.Services;
/**
 * ...
 * @author Richard Shi
 */
class Directives implements IDirectives
{

	@:inject("locServ")
	public static var appVersion:Dynamic = function(locServ:LocServ) {
		var obj =  new NgDirectiveDefinition();
		obj.restrict = "EA";
		obj.link = function(scope:NgScope, elm:NgJQuery,attr) {
          elm.text("1.0.0alpha");
		  trace("app-version uses other services:"+locServ.getA());
		};
		return obj;
	}

    public static function main(){
    }
	
}