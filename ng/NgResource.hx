package ng;

import ng.Angular;
/**
 * ...
 * @author Richard Shi
 */
@:initPackage
//@:native("$resource")
abstract NgResource({}) from {}
{
    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/js/bower_components/angular-resource/angular-resource.min.js");
        #end
		//add "ngResource" to global module dependencies
		if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
		window.hxdeps.push("ngResource");
    }
	
	public inline function run(url:String, ?paramDefaults:Dynamic, ?actions:Dynamic):ResourceClass untyped {
		return this(url,paramDefaults,actions);
	}
}

abstract ResourceClass ({}) from {}{
	public inline function get(?parameters:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):ResourceObj untyped {
		
	}
	public inline function save(parameters:Dynamic,postData:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):ResourceObj untyped {
		
	}
	public inline function query(?parameters:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):ResourceObj untyped {
		
	}
	public inline function remove(?parameters:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):ResourceObj untyped {
		
	}
	public inline function delete(?parameters:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):ResourceObj untyped {
		
	}
	public inline function action(action:String,?parameters:Dynamic,?postData:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):ResourceObj untyped {
		
	}
}

abstract ResourceObj({}) from {} {
	public inline function save(?parameters:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):ResourceObj untyped {
		
	}
	public inline function remove(?parameters:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):ResourceObj untyped {
		
	}
	public inline function delete(?parameters:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):ResourceObj untyped {
		
	}
	public inline function promise():NgPromise untyped {
		
	}
	public inline function resolved():Bool untyped {
		
	}
}