package test;

import ng.IController;
import ng.Angular;

/**
 * ...
 * @author Richard Shi
 */

typedef HomeScope = {
	>RootScope,
	name:String
}

class Controller implements IController
{
    public static function main(){
    	trace("--main--");
    }

	@:inject("$scope")
	public static var homeController:Dynamic = function(scope:HomeScope){
		scope.name = "good";
		trace("homeController");
	}

	@:inject("$rootScope","$http")
	public static var loginController:Dynamic = function(scope:RootScope,http:Http){
        //scope.digest();
        //scope.broadcast();
        trace("loginController");
    }


}
