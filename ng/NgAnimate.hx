package ng;

import ng.Angular;
/**
 * ...
 * @author Richard Shi
 */
@:initPackage
//@:native("$animate")
extern class NgAnimate
{
    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/bower_components/angular-animate/angular-animate.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-animate/angular-animate.min.js.map");
        #else
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-animate/angular-animate.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-animate/angular-animate.min.js.map");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-animate/angular-animate.js");
        #end
		//add "ngAnimate" to global module dependencies
		if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
		window.hxdeps.push("ngAnimate");
    }

	public function enter(element:NgJQuery, parent:NgJQuery, after:NgJQuery, doneFn:Dynamic):Void;
	public function leave(element:NgJQuery, doneFn:Dynamic):Void;
	public function move(element:NgJQuery, parent:NgJQuery, after:NgJQuery, doneFn:Dynamic):Void;
	@:overload(function(element:NgJQuery,className:Array<String>, doneFn:Dynamic):Void{})
	public function addClass(element:NgJQuery, className:String, doneFn:Dynamic):Void;
	@:overload(function(element:NgJQuery,className:Array<String>, doneFn:Dynamic):Void{})
	public function removeClass(element:NgJQuery, className:String, doneFn:Dynamic):Void;
	public function enabled(value:Bool, element:NgJQuery):Bool;
}
