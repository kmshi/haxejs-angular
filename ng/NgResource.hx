package ;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
class NgResource
{
    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/js/bower_components/angular-resource/angular-resource.min.js");
        #end
		//add "ngResource" to global module dependencies
		if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
		window.hxdeps.push("ngResource");
    }
	
}