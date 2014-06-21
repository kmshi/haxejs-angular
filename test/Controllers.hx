package test;

import ng.IControllers;
import ng.Angular;
import ng.NgRoute;
import ng.NgTouch;
/**
 * ...
 * @author Richard Shi
 */

//use class/type as controller model
class HomeCtrl extends BaseCtrl{
	public var name(default, default):String;
	public var location(default, default):String;
	public function new(scope:NgScope,route:NgRoute) {
		super(scope);
		name = "Blue sky";
		location = "Guangzhou";
		trace("use Model class as controller");
		scope.on("bb", function(event, args) { trace(args); } );
		scope.emit("bb", ["Hello event!", name, location]);
		scope["arrayaccess"] = 1;
		trace(route);
		trace(route.routes);
	}
}

class ScrollCtrl  extends BaseCtrl{
	private var location:NgLocation;
	private var anchorScroll:NgAnchorScroll;
	private var swipe:NgSwipe;
	private var target:String;
	public function gotoBottom():Void {
		// set the location.hash to the id of
        // the element you wish to scroll to.
        location.hash(target); 
		trace(location.protocol());
        // call $anchorScroll()
        anchorScroll.run();
        //seems swipe.bind not work as expected
        //swipe.bind(untyped __js__("window.document"),new EventHandlers(null,function(point:js.html.Point){trace(point);}));
	}
	
	public function new(scope:NgScope, location:NgLocation, anchorScroll:NgAnchorScroll,swipe:NgSwipe) {
		this.location = location;
		this.anchorScroll = anchorScroll;
		this.swipe = swipe;
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
		//exceptionHandler.run(new js.Error("SA"), "HCC");
		super(scope);
	}
	public function stopClock() {
		interval.cancel(handle);
	}
	public function swipeLeft(){
		trace("swipe left");
		interval.cancel(handle);
	}
}

class Controllers implements IControllers
{
    public static function main(){
    	trace("--main--");
    }

	@:inject("$scope","$route")
	public static var homeCtrl:Dynamic = HomeCtrl;

	@:inject("$scope", "$location", "$anchorScroll","$swipe")
	public static var scrollCtrl:Dynamic = ScrollCtrl;

	@:inject("$scope","$interval","$exceptionHandler")
	public static var clockCtrl:Dynamic = ClockCtrl;
}
