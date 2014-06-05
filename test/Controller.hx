package test;

import ng.IController;
import ng.Angular;

/**
 * ...
 * @author Richard Shi
 */

typedef HomeScope = {
	>NgScope,
	home: {
		name:String,
		location:String
		}
}

typedef ScrollScope = {
	>NgScope,
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
	public static var scrollController:Dynamic = function(scope:ScrollScope, location:NgLocation, anchorScroll:NgAnchorScroll) {
        scope.gotoBottom = function (){
           // set the location.hash to the id of
           // the element you wish to scroll to.
           location.hash('bottom'); 
		   trace(location.protocol());
           // call $anchorScroll()
           anchorScroll();
         };
        trace("scrollController");
    }


}
