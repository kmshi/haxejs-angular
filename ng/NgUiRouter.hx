package ng;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
extern class NgUiRouter
{
    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/js/bower_components/angular-ui-router/release/angular-ui-router.min.js");
        #end

        //add "ui.router" to global module dependencies
		if (Angular.isUndefined(window.hxdeps)) window.hxdeps = [];
		window.hxdeps.push("ui.router");
    }
}

//@:native("$stateProvider")
extern class NgStateProvider {
	@:overload(function(definition:StateDef):NgStateProvider{})
	public function state(name:String, definition:StateDef):NgStateProvider;
}

//@:native("$urlRouterProvider")
extern class NgUrlRouterProvider {
	public function when(what:String, handler:String):NgUrlRouterProvider;
	public function otherwise(rule:String):NgUrlRouterProvider;
}

//@:native("$state")
extern class NgState {
	public var current(default, null):StateDef;	
	public var params(default, null):Dynamic;
	
	public function reload():Void;
	public function go(to:String, ?params:Dynamic, ?options:Dynamic):Void;
	public function transitionTo(to:String, ?toParams:Dynamic, ?options:Dynamic):Void;
	public function is(stateOrName:Dynamic, ?params:Dynamic):Bool;
	public function includes(stateOrName:Dynamic, ?params:Dynamic):Bool;
	public function href(stateOrName:Dynamic, ?params:Dynamic, ?options:Dynamic):String;	
}

class StateDef {
	public function new(?url:String,?template:String,?views:Dynamic) {
		this.url = url;
		this.template = template;
		this.views = views;
	}

	public var name(default, default):String = null;
	public var url(default, default):String = null;
	public var views(default, default):Dynamic = null;
	public inline function set_abstract(val:Bool):Void untyped{
		this["abstract"] = val;
	}
	public inline function get_abstract():Bool untyped{
		return this["abstract"];
	}
	public var template(default, default):String = null;
	public var templateUrl(default, default):String = null;
	public var resolve(default, default):Dynamic = null;
	public var templateProvider(default, default):Dynamic = null;
	public var controller(default, default):Dynamic = null;
}

//@:native("$stateParams")
typedef NgStateParams = Dynamic;

//directives need this dependency
/**
 * uiView
 * uiSref
 * uiSrefActive
 */

//filters
/**
 * isState
 * includedByState
*/

//events
/**
 * $stateChangeStart
 * $stateChangeSuccess
 * $stateChangeError
*/