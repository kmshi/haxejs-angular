package ng.angular;


/**
 * @author Richard Shi
 */


@:native("angular")
extern class Angular
{
	public static function module(name: String, ?requires: Array<String>, ?configFn: Dynamic): Module;
}

extern class Module
{
	public function config(configFn: Dynamic): Module;
	public function constant(name: String, object: Dynamic): Module;
	public function controller(name: String, ctrlFn: Dynamic): Module;
	public function service(name: String, constructor: Dynamic): Module;
}

@:native("$rootScope")
extern class RootScope{
    public function digest():Void;
    public function broadcast():Void;
}

@:native("$http")
extern class Http{

}
