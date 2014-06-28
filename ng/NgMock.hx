package ng;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
class NgMock 
{

    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/bower_components/angular-mocks/angular-mocks.js");
        #else
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-mocks/angular-mocks.js");
        #end
		//add "ngMock" to global module dependencies
		//if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
		//window.hxdeps.push("ngMock");
    }

    public static function module(name: String) : Void {
		untyped __js__("angular.mock.module(name)");
	}
	/**
	* If an object literal{key:value} is passed they will be registered as values in the module
	*/
	public static function config(obj:Dynamic) : Void {
		untyped __js__("angular.mock.module(obj)");
	}

	public static function inject(fn:Array<Dynamic>) : Void {
		untyped __js__("angular.mock.inject(fn)");
	}
}

