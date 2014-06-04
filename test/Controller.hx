package test;

import ng.IController;
import ng.Angular;

/**
 * ...
 * @author Richard Shi
 */

typedef HomeScope = {
	>RootScope,
	home: {
		name:String,
		location:String
		}
}

class Controller implements IController
{
    public static function main(){
    	trace("--main--");
    }

	@:inject("$scope")
	public static var homeController:Dynamic = function(scope:HomeScope){
		scope.home = { name:"Blue sky",location:"Guangzhou" };
		trace("homeController");
	}

	@:inject("$rootScope")
	public static var loginController:Dynamic = function(scope:RootScope){
        //scope.digest();
        //scope.broadcast();
        trace("loginController");
    }


}
