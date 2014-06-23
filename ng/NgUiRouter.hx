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
    }
	//add "ui.router" to global module dependencies
	if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
	window.hxdeps.push("ui.router");	
}

//@:native("$stateProvider")
extern class NgStateProvider {
	@:overload(function(){definition:StateDef})
	public function state(name:String, definition:StateDef):NgStateProvider;
}

//@:native("$urlRouterProvider")
extern class NgUrlRouterProvider {
	
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
	public function new() {//TODO: rework?
	}
	public var name(default, default):String = null;
	public var url(default, default):String = null;
	public var views(default, default):Dynamic = null;
	public var abstract(default, default):Bool = false;//work?
	public var template(default, default):String = null;
	public var templateUrl(default, default):String = null;
	public var resolve(default, default):Dynamic = null;
	public var templateProvider(default, default):Dynamic = null;
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