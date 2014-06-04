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
        //add "ng" to global module dependencies,default already
        //if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
        //window.hxdeps.push("ng");

        ng.Angular = window.angular;
        //if not include jquery, use jqLite embedded in angular.js, however, it is not public yet
        //if (js.JQuery==null) js.JQuery = jqLite;
    }

	 /** 
     * The `angular.module` is a global place for creating, registering and retrieving Angular
     * modules.
     * All modules (angular core or 3rd party) that should be available to an application must be
     * registered using this mechanism.
     *
     * When passed two or more arguments, a new module is created.  If passed only one argument, an
     * existing module (the name passed as the first argument to `module`) is retrieved.
	 */
    public static function module(name: String, ?requires: Array<String>, ?configFn: Dynamic): Module;
	 /**
	 * Returns a function which calls function `fn` bound to `self` (`self` becomes the `this` for
	 * `fn`). You can supply optional `args` that are prebound to the function. This feature is also
	 * known as [partial application](http://en.wikipedia.org/wiki/Partial_application), as
	 * distinguished from [function currying](http://en.wikipedia.org/wiki/Currying#Contrast_with_partial_function_application).
	 *
	 * @param {Object} self Context which `fn` should be evaluated in.
	 * @param {function()} fn Function to be bound.
	 * @param {...*} args Optional arguments to be prebound to the `fn` function call.
	 * @returns {function()} Function that wraps the `fn` with all the specified bindings.
	 */
    public static function bind(self:Dynamic, fn:Dynamic, ?args:Array<Dynamic>):Dynamic;
	 /**
	 * Use this function to manually start up angular application.
	 * @param {DOMElement} element DOM element which is the root of angular application.
	 * @param {Array<String|Function|Array>=} modules an array of modules to load into the application.
	 *     Each item in the array should be the name of a predefined module or a (DI annotated)
	 *     function that will be invoked by the injector as a run block.
	 *     See: {@link angular.module modules}
	 * @returns {auto.$injector} Returns the newly created injector for this app.
	 */
    public static function bootstrap(element:js.html.Element, modules:Array<String>) : Injector;
	 /**
	 * Creates a deep copy of `source`, which should be an object or an array.
	 * @param {*} source The source that will be used to make a copy.
	 *                   Can be any type, including primitives, `null`, and `undefined`.
	 * @param {(Object|Array)=} destination Destination into which the source is copied. If
	 *     provided, must be of the same type as `source`.
	 * @returns {*} The copy or updated `destination`, if `destination` was specified.
	 */
    public static function copy(source:Dynamic, destination:Dynamic):Dynamic;
	/**
	 * Wraps a raw DOM element or HTML string as a [jQuery](http://jquery.com) element.
	 * @param {string|DOMElement} element HTML string or DOMElement to be wrapped into jQuery.
	 * @returns {Object} jQuery object.
	 */
    public static function element(element:js.html.Element):JQuery;//JQLite to be better
	
	public static function equals(o1:Dynamic, o2:Dynamic):Bool;
	/**
	 * Extends the destination object `dst` by copying all of the properties from the `src` object(s)
	 * to `dst`. You can specify multiple `src` objects.
	 *
	 * @param {Object} dst Destination object.
	 * @param {...Object} src Source object(s).
	 * @returns {Object} Reference to `dst`.
	 */
	public static function extend(dst:Dynamic, src:Array<Dynamic>):Dynamic;
	 /**
	 * Invokes the `iterator` function once for each item in `obj` collection, which can be either an
	 * object or an array. The `iterator` function is invoked with `iterator(value, key)`, where `value`
	 * is the value of an object property or an array element and `key` is the object property key or
	 * array element index. Specifying a `context` for the function is optional.
	 * @param {Object|Array} obj Object to iterate over.
	 * @param {Function} iterator Iterator function.
	 * @param {Object=} context Object to become context (`this`) for the iterator function.
	 * @returns {Object|Array} Reference to `obj`.
	 */
	public static function forEach(obj:Dynamic, iterator:Dynamic, ?context:Dynamic):Dynamic;
	/**
	 * Deserializes a JSON string.
	 *
	 * @param {string} json JSON string to deserialize.
	 * @returns {Object|Array|string|number} Deserialized thingy.
	 */
	public static function fromJson(json:String):Dynamic;
	
	/**
	 * Serializes input into a JSON-formatted string. Properties with leading $ characters will be
	 * stripped since angular uses this notation internally.
	 * @param {Object|Array|Date|string|number} obj Input to be serialized into JSON.
	 * @param {boolean=} pretty If set to true, the JSON output will contain newlines and whitespace.
	 * @returns {string|undefined} JSON-ified string representing `obj`.
	 */
	public static function toJson(obj:Dynamic, pretty:Bool = false):Dynamic;
	/**
	 * Creates an injector function that can be used for retrieving services as well as for
	 * dependency injection (see {@link guide/di dependency injection}).
	 *

	 * @param {Array.<string|Function>} modules A list of module functions or their aliases. See
	 *        {@link angular.module}. The `ng` module must be explicitly added.
	 * @returns {function()} Injector function. See {@link auto.$injector $injector}.
	 */
	public static function injector(modules:Array<String>):Injector;
	/**
	 * Determines if a reference is an `Array`.
	 *
	 * @param {*} value Reference to check.
	 * @returns {boolean} True if `value` is an `Array`.
	 */
	public static function isArray(value:Dynamic):Bool;
	/**
	 * Determines if a value is a date.
	 *
	 * @param {*} value Reference to check.
	 * @returns {boolean} True if `value` is a `Date`.
	 */
	public static function isDate(value:Dynamic):Bool;
	/**
	 * Determines if a reference is defined.
	 *
	 * @param {*} value Reference to check.
	 * @returns {boolean} True if `value` is defined.
	 */
	public static function isDefined(value:Dynamic):Bool;
	/**
	 * Determines if a reference is undefined.
	 *
	 * @param {*} value Reference to check.
	 * @returns {boolean} True if `value` is undefined.
	 */
	public static function isUndefined(value:Dynamic):Bool;
	/**
	 * Determines if a reference is a DOM element (or wrapped jQuery element).
	 *
	 * @param {*} value Reference to check.
	 * @returns {boolean} True if `value` is a DOM element (or wrapped jQuery element).
	 */
	public static function isElement(node:Dynamic):Bool;
	/**
	 * Determines if a reference is a `Function`.
	 *
	 * @param {*} value Reference to check.
	 * @returns {boolean} True if `value` is a `Function`.
	 */
	public static function isFunction(value:Dynamic):Bool;
	/**
	 * Determines if a reference is a `Number`.
	 *
	 * @param {*} value Reference to check.
	 * @returns {boolean} True if `value` is a `Number`.
	 */
	public static function isNumber(value:Dynamic):Bool;
	/**
	 * Determines if a reference is an `Object`. Unlike `typeof` in JavaScript, `null`s are not
	 * considered to be objects. Note that JavaScript arrays are objects.
	 *
	 * @param {*} value Reference to check.
	 * @returns {boolean} True if `value` is an `Object` but not `null`.
	 */
	public static function isObject(value:Dynamic):Bool;
	/**
	 * Determines if a reference is a `String`.
	 *
	 * @param {*} value Reference to check.
	 * @returns {boolean} True if `value` is a `String`.
	 */
	public static function isString(value:Dynamic):Bool;
	/**
	 * Converts the specified string to lowercase.
	 * @param {string} string String to be converted to lowercase.
	 * @returns {string} Lowercased string.
	 */
	public static function lowercase(string:String):String;
	/**
	 * Converts the specified string to uppercase.
	 * @param {string} string String to be converted to uppercase.
	 * @returns {string} Uppercased string.
	 */
	public static function uppercase(string:String):String;	
	/**
	 * A function that performs no operations. This function can be useful when writing code in the
	 * functional style.
	   ```js
		 function foo(callback) {
		   var result = calculateResult();
		   (callback || angular.noop)(result);
		 }
	   ```
	 */
	public static function noop():Void;
	/**
	 * An object that contains information about the current AngularJS version. 
	 */	
	public static var version:Version;
}

typedef Version = {
  full: String, // all of these placeholder strings will be replaced by grunt's package task
  major: Int,  
  minor: Int,
  dot: Int,
  codeName: String	
}

extern class Module
{
	/**
	 * Name of the module
	 */	
	public static var name:String;
	/**
	 *Holds the list of modules which the injector will load before the current module is loaded.
	 */	
	public static var requires:Array<String>;	
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
extern class Injector {
	/**
	 * Return an instance of the service.
	 *
	 * @param {string} name The name of the instance to retrieve.
	 * @return {*} The instance.
	 */
	public function get(name:String):Dynamic;
	/**
	 * Invoke the method and supply the method arguments from the `$injector`.
	 *
	 * @param {!Function} fn The function to invoke. Function parameters are injected according to the
	 *   {@link guide/di $inject Annotation} rules.
	 * @param {Object=} self The `this` for the invoked method.
	 * @param {Object=} locals Optional object. If preset then any argument names are read from this
	 *                         object first, before the `$injector` is consulted.
	 * @returns {*} the value returned by the invoked `fn` function.
	 */	
	public function invoke(fn:Dynamic, ?self:Dynamic, ?locals:Dynamic):Dynamic;
	/**
	 * Allows the user to query if the particular service exist.
	 *
	 * @param {string} Name of the service to query.
	 * @returns {boolean} returns true if injector has given service.
	 */	
	public function has(name:String):Bool;
	/**
	 * Create a new instance of JS type. The method takes a constructor function invokes the new
	 * operator and supplies all of the arguments to the constructor function as specified by the
	 * constructor annotation.
	 *
	 * @param {Function} Type Annotated constructor function.
	 * @param {Object=} locals Optional object. If preset then any argument names are read from this
	 * object first, before the `$injector` is consulted.
	 * @returns {Object} new instance of `Type`.
	 */	
	public function instantiate(type:Dynamic, ?locals:Dynamic):Dynamic;
	/**
	 * Returns an array of service names which the function is requesting for injection. This API is
	 * used by the injector to determine which services need to be injected into the function when the
	 * function is invoked. There are three ways in which the function can be annotated with the needed
	 * dependencies.	
	 * @param {Function|Array.<string|Function>} fn Function for which dependent service names need to
	 * be retrieved as described above.
	 *
	 * @returns {Array.<string>} The names of the services which the function requires.
	 */ 
	public function annotate(fn:Dynamic):Array<String>;
}
