package ;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
class Route
{
    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/js/bower_components/angular-route/angular-route.min.js");
        #end
		//add "ngRoute" to global module dependencies
    }
	
}