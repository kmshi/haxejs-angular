package ;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
class Cookies
{
    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/js/bower_components/angular-cookies/angular-cookies.min.js");
        #end
		//add "ngCookies" to global module dependencies
		if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
		window.hxdeps.push("ngCookies");
    }
	
}