package ng;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
//@:native("$animate")
class Animate
{
    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/js/bower_components/angular-animate/angular-animate.min.js");
        #end
		//add "ngAnimate" to global module dependencies
    }
	
}