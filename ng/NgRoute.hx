package ;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
class NgRoute
{
    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/js/bower_components/angular-route/angular-route.min.js");
        #end
		//add "ngRoute" to global module dependencies
		if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
		window.hxdeps.push("ngRoute");
    }
	
}