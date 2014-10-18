package ng;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
//@:native("$cookies")
abstract NgCookies({}) from {} 
{

    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/bower_components/angular-cookies/angular-cookies.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-cookies/angular-cookies.min.js.map");
        #else
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-cookies/angular-cookies.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-cookies/angular-cookies.min.js.map");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-cookies/angular-cookies.js");
        #end
		//add "ngCookies" to global module dependencies
		if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
		window.hxdeps.push("ngCookies");
    }

    /**
    * Provides read access to browser's cookies.
    */
    public inline function get(key:String):String {
        return Reflect.field(this, key);
    }
    /**
    * Provides write access to browser's cookies.
    */
    public inline function put(key:String, value:String):Void {
        Reflect.setField(this, key, value);
    }

    public function remove(key:String):Void untyped{//can not use inline
    	var self = this;
    	__js__("delete self[key]");
    }	
}

//@:native("$cookieStore")
abstract NgCookieStore({}) from {} 
{
    /**
    * Provides a key-value (string-object) storage, that is backed by session cookies.
    * Objects put or retrieved from this storage are automatically serialized or
    * deserialized by angular's toJson/fromJson.
    */
    public inline function get(key:String):Dynamic {
        return Reflect.field(this, key);
    }
    /**
    * Provides a key-value (string-object) storage, that is backed by session cookies.
    * Objects put or retrieved from this storage are automatically serialized or
    * deserialized by angular's toJson/fromJson.
    */
    public inline function put(key:String, value:Dynamic):Void {
        Reflect.setField(this, key, value);
    }

    public function remove(key:String):Void untyped{ //can not use inline
    	var self = this;
    	__js__("delete self[key]");
    }	
}
