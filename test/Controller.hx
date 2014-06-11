package test;

import ng.IControllers;
import ng.Angular;

/**
 * ...
 * @author Richard Shi
 */

//use class/type as controller model
class HomeCtrl extends BaseCtrl{
	public var name(default, default):String;
	public var location(default, default):String;
	public function new(scope:NgScope) {
		super(scope);
		name = "Blue sky";
		location = "Guangzhou";
		trace("use Model class as controller");
		scope.on("bb", function(event, args) { trace(args); } );
		scope.emit("bb", ["Hello event!", name, location]);
		scope["arrayaccess"] = 1;
	}
}

class ScrollCtrl  extends BaseCtrl{
	private var location:NgLocation;
	private var anchorScroll:NgAnchorScroll;
	private var target:String;
	public function gotoBottom():Void {
		// set the location.hash to the id of
        // the element you wish to scroll to.
        location.hash(target); 
		trace(location.protocol());
        // call $anchorScroll()
        anchorScroll.run();
	}
	
	public function new(scope:NgScope, location:NgLocation, anchorScroll:NgAnchorScroll) {
		this.location = location;
		this.anchorScroll = anchorScroll;
		this.target = 'bottom';
		super(scope);
	}
}

class ClockCtrl  extends BaseCtrl{
	public var clock:Date = Date.now();
	private var handle:NgPromise;
	private var interval:NgInterval;
	public function updateClock(){
		clock = Date.now();
	}
	public function new(scope:NgScope,interval:NgInterval,exceptionHandler:NgExceptionHandler){
		handle = interval.run(this.updateClock, 1000, 0, false);
		this.interval = interval;
		exceptionHandler.run(new js.Error("SA"), "HCC");
		super(scope);
	}
	public function stopClock() {
		interval.cancel(handle);
	}
}

class Controller implements IControllers
{
    public static function main(){
    	trace("--main--");
    }

	@:inject("$scope")
	public static var homeCtrl:Dynamic = HomeCtrl;

	@:inject("$scope", "$location", "$anchorScroll")
	public static var scrollCtrl:Dynamic = ScrollCtrl;

	@:inject("$scope","$interval","$exceptionHandler")
	public static var clockCtrl:Dynamic = ClockCtrl;
}
