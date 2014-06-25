package ng;

import js.html.Element;
import js.html.Point;
/**
 * ...
 * @author Richard Shi
 */
@:initPackage
extern class NgTouch 
{

    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/js/bower_components/angular-touch/angular-touch.min.js");
        #else
          ng.macro.InjectionBuilder.copyFile("www/js/bower_components/angular-touch/angular-touch.min.js");
        #end
		//add "ngTouch" to global module dependencies
		if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
		window.hxdeps.push("ngTouch");
    }
}

//@:native("$swipe")
extern class NgSwipe{	
	public function bind(element:Element, eventHandlers:EventHandlers):Void;
}

typedef MotionHandler = Point->Void;

class EventHandlers{
	public function new(?start:MotionHandler,?move:MotionHandler,?end:MotionHandler,?cancel:MotionHandler){
		this.start = start;
		this.move = move;
		this.end = end;
		this.cancel = cancel;
	}
	public var start(default,default):MotionHandler = null;
	public var move(default,default):MotionHandler = null;
	public var end(default,default):MotionHandler = null;
	public var cancel(default,default):MotionHandler = null;
}

//directives need this dependency
/**
 * ngClick
 * ngSwipeLeft
 * ngSwipeRight
 */
