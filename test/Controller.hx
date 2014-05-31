package test;

import ng.Injectable;
import ng.Angular;

/**
 * ...
 * @author Richard Shi
 */

typedef HomeScope = {
	>RootScope,
	name:String
}

class Controller implements Injectable
{
    public static function main(){
    }

	@:inject("$scope")
	public static var homeController:Dynamic = function(scope:HomeScope){
		scope.name = "good";
	}

	@:inject("$rootScope","$http")
	public static var loginController:Dynamic = function(scope:RootScope,http:Http){
        scope.digest();
        scope.broadcast();
    }


}
