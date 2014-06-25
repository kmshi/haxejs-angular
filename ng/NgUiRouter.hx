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
        #else
          ng.macro.InjectionBuilder.copyFile("www/js/bower_components/angular-ui-router/release/angular-ui-router.min.js");
          ng.macro.InjectionBuilder.copyFile("www/js/bower_components/angular-ui-router/release/angular-ui-router.js");
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
	public function new() {		
	}

	public function set_name(val:String):StateDef  untyped{ this.name = val; return this;}
	public function get_name():String untyped{return this.name;}
	public function set_url(val:String):StateDef  untyped{ this.url = val; return this;}
	public function get_url():String untyped{return this.url;}
	public function set_views(val:Dynamic):StateDef  untyped{ this.views = val; return this;}
	public function get_views():Dynamic untyped{return this.views;}
	public function set_abstract(val:Bool):StateDef untyped{
		this["abstract"] = val;
		return this;
	}
	public function get_abstract():Bool untyped{return this["abstract"];}
	public function set_template(val:String):StateDef  untyped{ this.template = val; return this;}
	public function get_template():String untyped{return this.template;}
	public function set_templateUrl(val:String):StateDef  untyped{ this.templateUrl = val; return this;}
	public function get_templateUrl():String untyped{return this.templateUrl;}
	public function set_resolve(val:Dynamic):StateDef  untyped{ this.resolve = val; return this;}
	public function get_resolve():Dynamic untyped{return this.resolve;}
	public function set_templateProvider(val:Dynamic):StateDef  untyped{ this.templateProvider = val; return this;}
	public function get_templateProvider():Dynamic untyped{return this.templateProvider;}
	public function set_controller(val:Dynamic):StateDef  untyped{ this.controller = val; return this;}
	public function get_controller():Dynamic untyped{return this.controller;}
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