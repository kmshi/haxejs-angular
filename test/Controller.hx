package test;

import ng.IController;
import ng.Angular;

/**
 * ...
 * @author Richard Shi
 */

//use class/type as controller model
class Home{
	public var name(default, default):String;
	public var location(default, default):String;
	public function new(scope:NgScope) {
		name = "Blue sky";
		location = "Guangzhou";
		trace("use Model class as controller");
		scope.on("bb", function(event, args) { trace(args); } );
		scope.emit("bb", ["Hello event!", name, location]);
		scope.setModel("home", this);
		scope["arrayaccess"] = 1;
	}
}

class Scroll {
	private var location:NgLocation;
	private var anchorScroll:NgAnchorScroll;
	public function gotoBottom():Void {
		// set the location.hash to the id of
        // the element you wish to scroll to.
        location.hash('bottom'); 
		trace(location.protocol());
        // call $anchorScroll()
        anchorScroll();
	}
	
	public function new(scope:NgScope, location:NgLocation, anchorScroll:NgAnchorScroll) {
		this.location = location;
		this.anchorScroll = anchorScroll;
		scope.setModel("scroll", this);
	}
}

class Controller implements IController
{
    public static function main(){
    	trace("--main--");
    }

	@:inject("$scope")
	public static var homeController:Dynamic = Home;

	@:inject("$scope", "$location", "$anchorScroll")
	public static var scrollController:Dynamic = Scroll;
}
