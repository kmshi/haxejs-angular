package test;

import ng.IController;
import ng.Angular;

/**
 * ...
 * @author Richard Shi
 */

typedef HomeScope = {
	>Scope,
	home: {
		name:String,
		location:String
		}
}

typedef ScrollScope = {
	>Scope,
	gotoBottom:Void->Void
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

	@:inject("$scope", "$location", "$anchorScroll")
	public static var scrollController:Dynamic = function(scope:ScrollScope, location:Location, anchorScroll:AnchorScroll) {
        scope.gotoBottom = function (){
           // set the location.hash to the id of
           // the element you wish to scroll to.
           location.hash('bottom');

           // call $anchorScroll()
           anchorScroll();
         };
        trace("scrollController");
    }


}
