package ng;


/**
 * @author Richard Shi
 */


import js.JQuery;

@:initPackage
//@:native("angular")
extern class Angular
{
    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/js/bower_components/angular/angular.min.js");
        #end
        ng.Angular = angular;
        //if not include jquery, use jqLite embedded in angular.js
        if (js.JQuery==null) js.JQuery = jqLite;
    }

    public static function module(name: String, ?requires: Array<String>, ?configFn: Dynamic): Module;
    public static function bind(self:Dynamic, fn:Dynamic, ?args:Array<Dynamic>):Dynamic;
    public static function bootstrap(element:js.html.Element, modules:Array<String>) : Injector;
    public static function copy(source:Dynamic, destination:Dynamic):Void;
    public static function element(element:js.html.Element):JQuery;//JQLite to be better
}

extern class Module
{
  /**
   * @name angular.Module#constant
   * @param {string} name constant name
   * @param {*} object Constant value.
   * Because the constant are fixed, they get applied before other provide methods.
   */
	public function constant(name: String, object: Dynamic): Module;
  /**
   * @name angular.Module#value
   * @param {string} name service name
   * @param {*} object Service instance object.
   */
	public function value(name: String, object: Dynamic): Module;		
   /**
   * @name angular.Module#controller
   * @param {string|Object} name Controller name, or an object map of controllers where the
   *    keys are the names and the values are the constructors.
   * @param {Function} constructor Controller constructor function.
   */
	public function controller(name: String, constructor: Dynamic): Module;
  /**
   * @name angular.Module#service
   * @param {string} name service name
   * @param {Function} constructor A constructor function that will be instantiated to return an object only once.
   */
	public function service(name: String, constructor: Dynamic): Module;
  /**
   * @name angular.Module#config
   * @param {Function} configFn Execute this function on module load. Useful for service
   *    configuration.
   */
	public function config(configFn: Dynamic): Module;
  /**
   * @name angular.Module#directive
   * @param {string|Object} name Directive name, or an object map of directives where the
   *    keys are the names and the values are the factories.
   * @param {Function} directiveFactory Factory function for creating new instance of
   * directives.
   */
	public function directive(name: String, directiveFactory: Dynamic): Module;
  /**
   * @name angular.Module#filter
   * @param {string} name Filter name.
   * @param {Function} filterFactory Factory function for creating new instance of filter.
   */
	public function filter(name: String, filterFactory: Dynamic): Module;
  /**
   * @name angular.Module#animation
   * @param {string} name animation name
   * @param {Function} animationFactory Factory function for creating new instance of an
   *                                    animation.
   */
	public function animation(name: String, animationFactory: Dynamic): Module;
  /**
   * @name angular.Module#factory
   * @param {string} name service name
   * @param {Function} providerFunction Function for creating new instance of the service.
   */
	public function factory(name: String, providerFunction: Dynamic): Module;
  /**
   * @name angular.Module#provider
   * @param {string} name service name
   * @param {Function} providerType Construction function for creating new instance of the
   *                                service.
   */
	public function provider(name: String, providerType: Dynamic): Module;

}

//@:native("$rootScope")
extern class RootScope{
    public function digest():Void;
    public function broadcast():Void;
}

//@:native("$http")
extern class Http{

}

//@:native("$injector")
extern class Injector{

}
