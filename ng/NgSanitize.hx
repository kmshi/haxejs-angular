package ng;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
//@:native("$sanitize")
abstract NgSanitize({}) from {} 
{

    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/js/bower_components/angular-sanitize/angular-sanitize.min.js");
        #else
          ng.macro.InjectionBuilder.copyFile("www/js/bower_components/angular-sanitize/angular-sanitize.min.js");
          ng.macro.InjectionBuilder.copyFile("www/js/bower_components/angular-sanitize/angular-sanitize.js");
        #end
		//add "ngSanitize" to global module dependencies
		if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
		window.hxdeps.push("ngSanitize");
    }
	/**
	 * The input is sanitized by parsing the html into tokens. All safe tokens (from a whitelist) are
	 * then serialized back to properly escaped html string.
	 */
	public inline function run(html:String):String untyped {
		return this(html);
	}
}

//directives need this dependency
/**
 * ngBind
 * ngBindHtml
 */

//filters
/**
 * linky(text, target) -- Finds links in text input and turns them into html links. Supports http/https/ftp/mailto and plain email address links.
*/