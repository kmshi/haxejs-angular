package ng;
/**
 * @author Richard Shi
 */ 
import js.html.Document;
import js.html.DOMWindow;
//import js.Browser;
import js.JQuery;

@:initPackage
//@:native("angular")
extern class Angular
{
    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/js/bower_components/angular/angular.min.js");
        #end

        ng.Angular = window.angular;

        //add "ng" to global module dependencies,default already
        //if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
        //window.hxdeps.push("ng");

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
    public static function bootstrap(element:js.html.Element, modules:Array<String>) : NgInjector;
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
	@:overload(function( element : String ) : NgJQuery {})
    public static function element(element:js.html.Element):NgJQuery;
	
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
	 * @param {Array.<string|Function>} modules A list of module functions or their aliases. See
	 *        {@link angular.module}. The `ng` module must be explicitly added.
	 * @returns {function()} Injector function. See {@link auto.$injector $injector}.
	 */
	public static function injector(modules:Array<String>):NgInjector;
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

extern class NgJQuery extends JQuery {
	/**
	 * retrieves the controller of the current element or its parent. By default
	 * retrieves controller associated with the `ngController` directive. If `name` is provided as
	 * camelCase directive name, then the controller for this directive will be retrieved (e.g.`'ngModel'`).
	 */
	public function controller(?name:String):NgController;
	/**
	 * retrieves the injector of the current element or its parent.
	 */
	public function injector():NgInjector;
	/**
	 * retrieves the {@link ng.$rootScope.Scope scope} of the current element or its parent.
	 */
	public function scope():NgScope;
	/**
	 * retrieves an isolate {@link ng.$rootScope.Scope scope} if one is attached directly to the current element. 
	 * This getter should be used only on elements that contain a directive which starts a new isolate scope. 
	 * Calling `scope()` on this element always returns the original non-isolate scope.
	 */
	public function isolateScope():NgScope;
	/**
	 * same as `data()`, but walks up the DOM until a value is found or the top parent element is reached.
	 */
	@:overload(function() : Dynamic {})
	@:overload(function( key : String ) : Dynamic {})
	public function inheritedData(key : String, value : Dynamic):NgJQuery;
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
   * registers a value/object that can be accessed by providers and services.
   * @param {string} name constant name
   * @param {*} object Constant value.
   * Because the constant are fixed, they get applied before other provide methods.
   */
	public function constant(name: String, object: Dynamic): Module;
  /**
   * registers a value/object that can only be accessed by services, not providers.
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
   * Register a **service constructor**, which will be invoked with `new` to create the service(type/class) instance.
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
	 * Register a **service factory**, which will be called to return the service instance.
	 * This is short for registering a service where its provider consists of only a `$get` property,
	 * which is the given service factory function.
	 * You should use {@link auto.$provide#factory $provide.factory(getFn)} if you do not need to
	 * configure your service in a provider.
   * @param {string} name service name
   * @param {Function} providerFunction Function for creating new instance of the service.
   */
	public function factory(name: String, providerFunction: Dynamic): Module;
  /**
   * registers a **service provider**
   * @param {string} name service name
   * @param {(Object|function())} provider If the provider is:
	 *
	 *   - `Object`: then it should have a `$get` method. The `$get` method will be invoked using
	 *     {@link auto.$injector#invoke $injector.invoke()} when an instance needs to be created.
	 *   - `Constructor`: a new instance of the provider will be created using
	 *     {@link auto.$injector#instantiate $injector.instantiate()}, then treated as `object`.
   */
	public function provider(name: String, provider: Dynamic): Module;

}

//@:native("$anchorScroll")
/**
 * A function service, when called, it checks current value of `$location.hash()` and scroll to related element
 */
//typedef NgAnchorScroll = Void->Void;
abstract NgAnchorScroll({}) from {} {
    public inline function run():Void untyped{
        this();
    }
}

//@:native("$anchorScrollProvider")
extern class NgAnchorScrollProvider {
	public function disableAutoScrolling():Void;
}

//@:native("$rootScope")
typedef NgRootScope = NgScope;

//@:native("$rootScopeProvider")
extern class NgRootScopeProvider {
	/**
	 * Sets the number of `$digest` iterations the scope should attempt to execute before giving up and
	 * assuming that the model is unstable.
	 *
	 * The current default is 10 iterations.
	 *
	 * In complex applications it's possible that the dependencies between `$watch`s will result in
	 * several digest iterations. However if an application needs more than the default 10 digest
	 * iterations for its model to stabilize then you should investigate what is causing the model to
	 * continuously change during the digest.
	 *
	 * Increasing the TTL could have performance implications, so you should not change it without
	 * proper justification.
	 *
	 * @param {number} limit The number of digest iterations.
	 */	
	public function digestTtl(limit:Int):Void;
}


//@:native("$scope")
abstract NgScope({}) from {} {
    @:arrayAccess public inline function arrayAccess(key:String):Dynamic {
        return Reflect.field(this, key);
    }
    
    @:arrayAccess public inline function arrayWrite<T>(key:String, value:T):Void {
        Reflect.setField(this, key, value);
    }
	
	public inline function setViewModel(name:String, value:Dynamic):Void untyped {
		this[name] = value;
	}
	
	public inline function getViewModel(name:String):Dynamic untyped {
		return this[name];
	}
	
	/**
	 * Creates a new child, $new(isolate)
	 */
	public inline function newScope(isolate:Bool=false):NgScope untyped{
		return this["$new"](isolate);
	}
	/**
	 * Registers a `listener` callback to be executed whenever the `watchExpression` changes
	 * @param {(function()|string)} watchExpression Expression that is evaluated on each
     *    {@link ng.$rootScope.Scope#$digest $digest} cycle. A change in the return value triggers
     *    a call to the `listener`.
     *
     *    - `string`: Evaluated as {@link guide/expression expression}
     *    - `function(scope)`: called with current `scope` as a parameter.
     * @param {(function()|string)=} listener Callback called whenever the return value of
     *   the `watchExpression` changes.
     *    - `function(newValue, oldValue, scope)`: called with current and previous values as
     *      parameters.
     * @returns {function()} Returns a deregistration function for this listener.
	 */
	 public inline function watch(watchExpression:Dynamic, listener:Dynamic):Dynamic untyped{
		return this["$watch"](watchExpression,listener);
	}
	/**
	 * Shallow watches the properties of an object and fires whenever any of the properties change
     * (for arrays, this implies watching the array items; for object maps, this implies watching
     * the properties). If a change is detected, the `listener` callback is fired.
     * @param {string|function(scope)} obj Evaluated as {@link guide/expression expression}. The
     *    expression value should evaluate to an object or an array which is observed on each
     *    {@link ng.$rootScope.Scope#$digest $digest} cycle. Any shallow change within the
     *    collection will trigger a call to the `listener`.
     *
     * @param {function(newCollection, oldCollection, scope)} listener a callback function called
     *    when a change is detected.
     *    - The `newCollection` object is the newly modified data obtained from the `obj` expression
     *    - The `oldCollection` object is a copy of the former collection data.
     *      Due to performance considerations, the`oldCollection` value is computed only if the
     *      `listener` function declares two or more arguments.
     *    - The `scope` argument refers to the current scope.
     *
     * @returns {function()} Returns a de-registration function for this listener. When the
     *    de-registration function is executed, the internal watch operation is terminated.
	 */
	public inline function watchCollection(obj:Dynamic, listener:Dynamic):Dynamic untyped{
		return this["$watchCollection"](obj,listener);
	}
	/**
	 * Processes all of the {@link ng.$rootScope.Scope#$watch watchers} of the current scope and
     * its children. Because a {@link ng.$rootScope.Scope#$watch watcher}'s listener can change
     * the model, the `$digest()` keeps calling the {@link ng.$rootScope.Scope#$watch watchers}
     * until no more listeners are firing. This means that it is possible to get into an infinite
     * loop. This function will throw `'Maximum iteration limit exceeded.'` if the number of
     * iterations exceeds 10.
     *
     * Usually, you don't call `$digest()` directly in
     * {@link ng.directive:ngController controllers} or in
     * {@link ng.$compileProvider#directive directives}.
     * Instead, you should call {@link ng.$rootScope.Scope#$apply $apply()} (typically from within
     * a {@link ng.$compileProvider#directive directives}), which will force a `$digest()`.
     *
     * If you want to be notified whenever `$digest()` is called,
     * you can register a `watchExpression` function with
     * {@link ng.$rootScope.Scope#$watch $watch()} with no `listener`.
     *
     * In unit tests, you may need to call `$digest()` to simulate the scope life cycle.
	 */
	 public inline function digest():Void untyped{
		this["$digest"]();
	}
      /**
       * Removes the current scope (and all of its children) from the parent scope. Removal implies
       * that calls to {@link ng.$rootScope.Scope#$digest $digest()} will no longer
       * propagate to the current scope and its children. Removal also implies that the current
       * scope is eligible for garbage collection.
       *
       * The `$destroy()` is usually used by directives such as
       * {@link ng.directive:ngRepeat ngRepeat} for managing the
       * unrolling of the loop.
       *
       * Just before a scope is destroyed, a `$destroy` event is broadcasted on this scope.
       * Application code can register a `$destroy` event handler that will give it a chance to
       * perform any necessary cleanup.
       *
       * Note that, in AngularJS, there is also a `$destroy` jQuery event, which can be used to
       * clean up DOM bindings before an element is removed from the DOM.
       */
	public inline function destroy():Void untyped {
		this["$destroy"]();
	}
      /**
       * Executes the `expression` on the current scope and returns the result. Any exceptions in
       * the expression are propagated (uncaught). This is useful when evaluating Angular
       * expressions.
       * @param {(string|function())=} expression An angular expression to be executed.
       *
       *    - `string`: execute using the rules as defined in  {@link guide/expression expression}.
       *    - `function(scope)`: execute the function with the current `scope` parameter.
       *
       * @param {(object)=} locals Local variables object, useful for overriding values in scope.
       * @returns {*} The result of evaluating the expression.
	   */
	public inline function eval(expr:Dynamic, ?locals:Dynamic):Dynamic untyped {
		return this["$eval"](expr,locals);
	}
      /**
       * Executes the expression on the current scope at a later point in time.
       *
       * The `$evalAsync` makes no guarantees as to when the `expression` will be executed, only
       * that:
       *
       *   - it will execute after the function that scheduled the evaluation (preferably before DOM
       *     rendering).
       *   - at least one {@link ng.$rootScope.Scope#$digest $digest cycle} will be performed after
       *     `expression` execution.
       *
       * Any exceptions from the execution of the expression are forwarded to the
       * {@link ng.$exceptionHandler $exceptionHandler} service.
       *
       * __Note:__ if this function is called outside of a `$digest` cycle, a new `$digest` cycle
       * will be scheduled. However, it is encouraged to always call code that changes the model
       * from within an `$apply` call. That includes code evaluated via `$evalAsync`.
       *
       * @param {(string|function())=} expr An angular expression to be executed.
       *
       *    - `string`: execute using the rules as defined in {@link guide/expression expression}.
       *    - `function(scope)`: execute the function with the current `scope` parameter.
       *
       */	
	public inline function evalAsync(expr:Dynamic):Void untyped {
		this["$evalAsync"](expr);
	}
      /**
       * `$apply()` is used to execute an expression in angular from outside of the angular
       * framework. (For example from browser DOM events, setTimeout, XHR or third party libraries).
       * Because we are calling into the angular framework we need to perform proper scope life
       * cycle of {@link ng.$exceptionHandler exception handling},
       * {@link ng.$rootScope.Scope#$digest executing watches}.
	   * 
       * Scope's `$apply()` method transitions through the following stages:
       *
       * 1. The {@link guide/expression expression} is executed using the
       *    {@link ng.$rootScope.Scope#$eval $eval()} method.
       * 2. Any exceptions from the execution of the expression are forwarded to the
       *    {@link ng.$exceptionHandler $exceptionHandler} service.
       * 3. The {@link ng.$rootScope.Scope#$watch watch} listeners are fired immediately after the
       *    expression was executed using the {@link ng.$rootScope.Scope#$digest $digest()} method.
       *
       * @param {(string|function())=} exp An angular expression to be executed.
       *
       *    - `string`: execute using the rules as defined in {@link guide/expression expression}.
       *    - `function(scope)`: execute the function with current `scope` parameter.
       *
       * @returns {*} The result of evaluating the expression.
       */
	public inline function apply(expr:Dynamic):Dynamic untyped {
		return this["$apply"](expr);
	}
      /**
       * Listens on events of a given type. See {@link ng.$rootScope.Scope#$emit $emit} for
       * discussion of event life cycle.
       *
       * The event listener function format is: `function(event, args...)`. The `event` object
       * passed into the listener has the following attributes:
       *
       *   - `targetScope` - `{Scope}`: the scope on which the event was `$emit`-ed or
       *     `$broadcast`-ed.
       *   - `currentScope` - `{Scope}`: the current scope which is handling the event.
       *   - `name` - `{string}`: name of the event.
       *   - `stopPropagation` - `{function=}`: calling `stopPropagation` function will cancel
       *     further event propagation (available only for events that were `$emit`-ed).
       *   - `preventDefault` - `{function}`: calling `preventDefault` sets `defaultPrevented` flag
       *     to true.
       *   - `defaultPrevented` - `{boolean}`: true if `preventDefault` was called.
       *
       * @param {string} name Event name to listen on.
       * @param {function(event, ...args)} listener Function to call when the event is emitted.
       * @returns {function()} Returns a deregistration function for this listener.
       */
	public inline function on(name:String,listener:Dynamic):Dynamic untyped {
		return this["$on"](name,listener);
	}
      /**
       * Dispatches an event `name` upwards through the scope hierarchy notifying the
       * registered {@link ng.$rootScope.Scope#$on} listeners.
       *
       * The event life cycle starts at the scope on which `$emit` was called. All
       * {@link ng.$rootScope.Scope#$on listeners} listening for `name` event on this scope get
       * notified. Afterwards, the event traverses upwards toward the root scope and calls all
       * registered listeners along the way. The event will stop propagating if one of the listeners
       * cancels it.
       *
       * Any exception emitted from the {@link ng.$rootScope.Scope#$on listeners} will be passed
       * onto the {@link ng.$exceptionHandler $exceptionHandler} service.
       *
       * @param {string} name Event name to emit.
       * @param {...*} args Optional one or more arguments which will be passed onto the event listeners.
       * @return {Object} Event object (see {@link ng.$rootScope.Scope#$on}).
       */
	public inline function emit(name:String,?args:Array<Dynamic>):Dynamic untyped {
		return this["$emit"](name,args);
	}
      /**
       * Dispatches an event `name` downwards to all child scopes (and their children) notifying the
       * registered {@link ng.$rootScope.Scope#$on} listeners.
       *
       * The event life cycle starts at the scope on which `$broadcast` was called. All
       * {@link ng.$rootScope.Scope#$on listeners} listening for `name` event on this scope get
       * notified. Afterwards, the event propagates to all direct and indirect scopes of the current
       * scope and calls all registered listeners along the way. The event cannot be canceled.
       *
       * Any exception emitted from the {@link ng.$rootScope.Scope#$on listeners} will be passed
       * onto the {@link ng.$exceptionHandler $exceptionHandler} service.
       *
       * @param {string} name Event name to broadcast.
       * @param {...*} args Optional one or more arguments which will be passed onto the event listeners.
       * @return {Object} Event object, see {@link ng.$rootScope.Scope#$on}
       */	
	public inline function broadcast(name:String,?args:Array<Dynamic>):Dynamic untyped {
		return this["$broadcast"](name,args);
	}	
}

//@:native("$brower")//! This is a private undocumented service !
//extern class NgBrowser{
//}

//@:native("$location")
extern class NgLocation {
   /**
   * Return full url representation with all segments encoded according to rules specified in
   * [RFC 3986](http://www.ietf.org/rfc/rfc3986.txt).
   *
   * @return {string} full url
   */
	public function absUrl():String;
  /**
   * Return url (e.g. `/path?a=b#hash`) when called without any parameter.
   * Change path, search and hash, when called with parameter and return `$location`.
   *
   * @param {string=} url New url without base prefix (e.g. `/path?a=b#hash`)
   * @param {string=} replace The path that will be changed
   * @return {string} url
   */	
	@:overload(function(url:String, replace:String):NgLocation{})
	public function url():String;
	
	public function protocol():String;
	public function host():String;
	public function port():Int;

	//property(setter) in extern class seems not work, use @:overload instead
	//public var path(default, default):String;
	
	@:overload(function(val:String):String{})
	public function path():String;
	@:overload(function(val:String):String{})
	public function search():String;	
	@:overload(function(val:String):String{})
	public function hash():String;
  /**
   * If called, all changes to $location during current `$digest` will be replacing current history
   * record, instead of adding new one.
   */	
	public function replace():NgLocation;
}

//@:native("$q")
extern class NgQ {
  /**
   * Creates a `Deferred` object which represents a task which will finish in the future.
   *
   * @returns {Deferred} Returns a new instance of deferred.
   */	
	public function defer():NgDeferred;
  /**
   * @ngdoc method
   * @name $q#reject
   * @function
   *
   * @description
   * Creates a promise that is resolved as rejected with the specified `reason`. This api should be
   * used to forward rejection in a chain of promises. If you are dealing with the last promise in
   * a promise chain, you don't need to worry about it.
   *
   * When comparing deferreds/promises to the familiar behavior of try/catch/throw, think of
   * `reject` as the `throw` keyword in JavaScript. This also means that if you "catch" an error via
   * a promise error callback and you want to forward the error to the promise derived from the
   * current promise, you have to "rethrow" the error by returning a rejection constructed via
   * `reject`.
   * @param {*} reason Constant, message, exception or an object representing the rejection reason.
   * @returns {Promise} Returns a promise that was already resolved as rejected with the `reason`.
   */
	public function reject(reason:Dynamic):NgPromise;
  /**
   * Wraps an object that might be a value or a (3rd party) then-able promise into a $q promise.
   * This is useful when you are dealing with an object that might or might not be a promise, or if
   * the promise comes from a source that can't be trusted.
   *
   * @param {*} value Value or a promise
   * @returns {Promise} Returns a promise of the passed value or promise
   */
	public function when(value:Dynamic):NgPromise;
  /**
   * Combines multiple promises into a single promise that is resolved when all of the input
   * promises are resolved.
   *
   * @param {Array.<Promise>|Object.<Promise>} promises An array or hash of promises.
   * @returns {Promise} Returns a single promise that will be resolved with an array/hash of values,
   *   each value corresponding to the promise at the same index/key in the `promises` array/hash.
   *   If any of the promises is resolved with a rejection, this resulting promise will be rejected
   *   with the same rejection value.
   */
	public function all(promises:Array<NgPromise>):NgPromise;  
}

extern class NgDeferred {
	/**
	 * promise object associated with this deferred.
	 */
	public var promise(default, null):NgPromise;
	/**
	 * resolves the derived promise with the `value`. If the value is a rejection
	 * constructed via `$q.reject`, the promise will be rejected instead.
	 */
	public function resolve(value:Dynamic):Void;
	/**
	 * rejects the derived promise with the `reason`. This is equivalent to
	 * resolving it with a rejection constructed via `$q.reject`.
	 */
	public function reject(reason:Dynamic):Void;
	/**
	 * provides updates on the status of the promise's execution. This may be called
	 * multiple times before the promise is either resolved or rejected.
	 */
	public function notify(value:Dynamic):Void;
}

extern class NgPromise {
	/**
	 *   regardless of when the promise was or will be resolved or rejected, `then` calls one of the success 
	 *   or error callbacks asynchronously as soon as the result is available. 
	 *   The callbacks are called with a single argument: the result or rejection reason. 
	 *   Additionally, the notify callback may be called zero or more times to provide a progress indication, 
	 *   before the promise is resolved or rejected.
	 *   This method *returns a new promise* which is resolved or rejected via the return value of the
	 *   `successCallback`, `errorCallback`. It also notifies via the return value of the
	 *   `notifyCallback` method. The promise can not be resolved or rejected from the notifyCallback  method.
	 */
	public function then(successCallback:Dynamic, ?errorCallback:Dynamic, ?notifyCallback:Dynamic):NgPromise;
	//catch is keyward in haxe	
	//public function catch (errorCallback:Dynamic):NgPromise;
	
	/**
	 *   allows you to observe either the fulfillment or rejection of a promise,
	 *   but to do so without modifying the final value. This is useful to release resources or do some
	 *   clean-up that needs to be done whether the promise was rejected or resolved. See the [full
	 *   specification](https://github.com/kriskowal/q/wiki/API-Reference#promisefinallycallback) for
	 *   more information.
	 *
	 *   Because `finally` is a reserved word in JavaScript and reserved keywords are not supported as
	 *   property names by ES3, you'll need to invoke the method like `promise['finally'](callback)` to
	 *   make your code IE8 and Android 2.x compatible. 
	 *   Hero Haxe, it already called like `promise['finally'](callback)`
	 */
	public function finally(callbackFn:Dynamic):NgPromise;
}

extern class NgHttpPromise extends NgPromise {
	/**
	 * successCallback: function(data, status, headers, config)
	 * The arguments passed into these functions are destructured representation of the response object passed into the
     *   `then` method. The response object has these properties:
     *
     *   - **data** – `{string|Object}` – The response body transformed with the transform
     *     functions.
     *   - **status** – `{number}` – HTTP status code of the response.
     *   - **headers** – `{function([headerName])}` – Header getter function.
     *   - **config** – `{Object}` – The configuration object that was used to generate the request.
	 * A response status code between 200 and 299 is considered a success status and
     * will result in the success callback being called. Note that if the response is a redirect,
     * XMLHttpRequest will transparently follow it, meaning that the error callback will not be
     * called for such responses.
	 */
	public function success(successCallback:Dynamic):NgHttpPromise;
	/**
	 * errorCallback: function(data, status, headers, config)
	 */
	public function error(errorCallback:Dynamic):NgHttpPromise;
}

//@:native("$http")
abstract NgHttp( { } ) from { } {
	/**
	 * send out http request
	 * @param {object} requestConfig Object describing the request to be made and how it should be
     *    processed. The object has following properties:
     *
     *    - **method** – `{string}` – HTTP method (e.g. 'GET', 'POST', etc)
     *    - **url** – `{string}` – Absolute or relative URL of the resource that is being requested.
     *    - **params** – `{Object.<string|Object>}` – Map of strings or objects which will be turned
     *      to `?key1=value1&key2=value2` after the url. If the value is not a string, it will be
     *      JSONified.
     *    - **data** – `{string|Object}` – Data to be sent as the request message data.
     *    - **headers** – `{Object}` – Map of strings or functions which return strings representing
     *      HTTP headers to send to the server. If the return value of a function is null, the
     *      header will not be sent.
     *    - **xsrfHeaderName** – `{string}` – Name of HTTP header to populate with the XSRF token.
     *    - **xsrfCookieName** – `{string}` – Name of cookie containing the XSRF token.
     *    - **transformRequest** –
     *      `{function(data, headersGetter)|Array.<function(data, headersGetter)>}` –
     *      transform function or an array of such functions. The transform function takes the http
     *      request body and headers and returns its transformed (typically serialized) version.
     *    - **transformResponse** –
     *      `{function(data, headersGetter)|Array.<function(data, headersGetter)>}` –
     *      transform function or an array of such functions. The transform function takes the http
     *      response body and headers and returns its transformed (typically deserialized) version.
     *    - **cache** – `{boolean|Cache}` – If true, a default $http cache will be used to cache the
     *      GET request, otherwise if a cache instance built with
     *      {@link ng.$cacheFactory $cacheFactory}, this cache will be used for
     *      caching.
     *    - **timeout** – `{number|Promise}` – timeout in milliseconds, or {@link ng.$q promise}
     *      that should abort the request when resolved.
     *    - **withCredentials** - `{boolean}` - whether to to set the `withCredentials` flag on the
     *      XHR object. See {@link https://developer.mozilla.org/en/http_access_control#section_5
     *      requests with credentials} for more information.
     *    - **responseType** - `{string}` - see {@link
     *      https://developer.mozilla.org/en-US/docs/DOM/XMLHttpRequest#responseType requestType}.
	 */
	 public inline function run(requestConfig:Dynamic):NgHttpPromise untyped {
		return this(requestConfig);
	}
    /**
     * Shortcut method to perform `GET` request.
     *
     * @param {string} url Relative or absolute URL specifying the destination of the request
     * @param {Object=} config Optional configuration object
     * @returns {HttpPromise} Future object
     */
	public inline function get(url:String, ?config:Dynamic):NgHttpPromise untyped {
		return this.get(url,config);
	}
	public inline function delete(url:String, ?config:Dynamic):NgHttpPromise untyped {
		return this.delete(url,config);
	}
	public inline function head(url:String, ?config:Dynamic):NgHttpPromise untyped {
		return this.head(url,config);
	}
    /**
     * Shortcut method to perform `JSONP` request.
     *
     * @param {string} url Relative or absolute URL specifying the destination of the request.
     *                     Should contain `JSON_CALLBACK` string.
     * @param {Object=} config Optional configuration object
     * @returns {HttpPromise} Future object
     */	
	public inline function jsonp(url:String, ?config:Dynamic):NgHttpPromise untyped {
		return this.jsonp(url,config);
	}
	public inline function put(url:String, data:Dynamic, ?config:Dynamic):NgHttpPromise untyped {
		return this.put(url,config);
	}
	public inline function post(url:String, data:Dynamic, ?config:Dynamic):NgHttpPromise untyped {
		return this.post(url,config);
	}
    /**
     * Runtime equivalent of the `$httpProvider.defaults` property. Allows configuration of
     * default headers, withCredentials as well as request and response transformations.
     */	
	public inline function defaults():HttpDefaults untyped {
		return this.defaults;
	}
}

//@:native("$httpProvider")
extern class NgHttpProvider {
	public var defaults(default, null):HttpDefaults;
	public var interceptors(default, null):Array<Dynamic>;
}

//@:native("$injector")
extern class NgInjector {
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
	@:overload(function(fn:Dynamic, ?self:Dynamic, ?locals:Dynamic):Dynamic{})
	public function invoke(fn:Array<Dynamic>, ?self:Dynamic, ?locals:Dynamic):Dynamic;
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

typedef HttpDefaults = {
	transformResponse:Array<Dynamic>,// transform incoming response data
	transformRequest:Array<Dynamic>, // transform outgoing request data
	headers: {
		common:Dynamic,
		post:Dynamic,
		put:Dynamic,
		patch:Dynamic
	},
	xsrfCookieName:String,
	xsrfHeaderName:String
}

//@:native("$compile")
abstract NgCompile({}) from {} {
    public inline function runJ(element:NgJQuery):NgScope->Array<js.html.Element> untyped{
        return this(element);
    }
    public inline function run(element:String):NgScope->Array<js.html.Element> untyped{
        return this(element);
    }
}


//@:native("$cacheFactory")
abstract NgCacheFactory( { } ) from { } {
	/**
	 * Factory that constructs cache objects and gives access to them.
	 * @param {string} cacheId Name or id of the newly created cache.
	 * @param {object=} options Options object that specifies the cache behavior. Properties:
	 *
	 *   - `{number=}` `capacity` — turns the cache into LRU cache.
	 */
	public inline function newCache(cacheId:String, ?options:Dynamic):NgCache untyped {
		return this(cacheId,options);
	}
	/**
     * Get information about all the of the caches that have been created
     *
     * @returns {Object} - key-value map of `cacheId` to the result of calling `cache#info`
    */
	public inline function info():Dynamic untyped {
		return this.info();
	}
	/**
	 * Get access to a cache object by the `cacheId` used when it was created.
	 * @param {string} cacheId Name or id of a cache to access.
	 * @returns {object} Cache object identified by the cacheId or undefined if no such cache.
	 */
	public inline function get(cacheId:String):NgCache untyped {
		return this.get(cacheId);
	}
}

extern class NgCache {
	/**
	 * Returns id, size, and options of cache.
	 */
	public function info():Dynamic;
	/**
	 * Puts a new key-value pair into the cache and returns the value
	 */
	public function put(key:String, value:Dynamic):Dynamic;
	/**
	 * Returns cached value for `key` or undefined for cache miss.
	 */
	public function get(key:String):Dynamic;
	/**
	 * Removes a key-value pair from the cache.
	 */
	public function remove(key:String):Void;
	/**
	 * Removes all cached values.
	 */
	public function removeAll():Void;
	/**
	 * Removes references to this cache from $cacheFactory.
	 */
	public function destroy():Void;
}

//@:native("$document")
extern class NgDocument extends NgJQuery{
	
}

//@:native("$exceptionHandler")
abstract NgExceptionHandler({}) from {} {
	public inline function run(exception:js.Error, ?cause:String):Void untyped {
		this(exception, cause);
	}
}

//@:native("$interpolate")
abstract NgInterpolate({}) from {} {
	public inline function run(text:String, ?mustHaveExpression:Bool, ?trustedContext:String):Dynamic->String untyped {
		return this(text,mustHaveExpression,trustedContext);
	}
	public inline function startSymbol():String untyped {
		return this.startSymbol();
	}
	public inline function endSymbol():String untyped {
		return this.endSymbol();
	}
}

//@:native("$interpolateProvider")
extern class NgInterpolateProvider {
	public var startSymbol(default, default):String;
	public var endSymbol(default,default):String;
}

//@:native("$interval")
//typedef NgInterval = Dynamic->Int->Int->Bool->NgPromise;
abstract NgInterval({}) from {} {
    public inline function run(fn:Dynamic, delay:Int, count:Int=0, invokeApply:Bool=true):NgPromise untyped{
      return this(fn,delay,count,invokeApply);
    }

    public inline function cancel(promise:NgPromise):Bool untyped{
        return this.cancel(promise);
    }

    /**
    * In tests you can use flush(millis) to move forward by `millis` milliseconds and trigger any functions 
    * scheduled to run in that time.
    */
    public inline function flush(millis:Int):Void untyped{
        this.flush(millis);
    }
}

//@:native("$httpBackend")
/*extern class NgHttpBackend {
}*/

//@:native("$log")
extern class NgLog {
	public function debug(message:Dynamic):Void;
	public function log(message:Dynamic):Void;
	public function warn(message:Dynamic):Void;
	public function info(message:Dynamic):Void;
	public function error(message:Dynamic):Void;
}

//@:native("$logProvider")
extern class NgLogProvider {
	@:overload(function():Bool{})
	public function debugEnabled(flag:Bool):NgLogProvider;
}

//@:native("$parse")
extern class NgParse {
	
}

//@:native("$sce")
extern class NgSce {
	
}

//@:native("$sceDelegate")
extern class NgSceDelegate {
	
}

//@:native("$sniffer")
extern class NgSniffer {
	
}

//@:native("$templateCache")
extern class NgTemplateCache {
	
}

//@:native("$timeout")
//typedef NgTimeout = Dynamic->Int->Bool->NgPromise;
abstract NgTimeout({}) from {} {
    public inline function run(fn:Dynamic, delay:Int,invokeApply:Bool=true):NgPromise untyped{
        return this(fn,delay,invokeApply);
    }
    public inline function cancel(promise:NgPromise):Bool untyped{
        return this.cancel(promise);
    }
}

//@:native("$window")
extern class NgWindow extends DOMWindow{
	
}

//@:native("$controller")
extern class NgController {
	
}

class NgDirectiveDefinition {
  public function new(){}
	/**
	 * When there are multiple directives defined on a single DOM element, sometimes it
	 * is necessary to specify the order in which the directives are applied. The `priority` is used
	 * to sort the directives before their `compile` functions get called. Priority is defined as a
	 * number. Directives with greater numerical `priority` are compiled first. Pre-link functions
	 * are also run in priority order, but post-link functions are run in reverse order. The order
	 * of directives with the same priority is undefined. The default priority is `0`.
	 */
	public var priority(default, default):Int = 0;
	/**
	 * string '<div></div>' or  function(tElement, tAttrs) { ... }
	 * replace the current element with the contents of the HTML. The replacement process
	 * migrates all of the attributes / classes from the old element to the new one. See the
	 * {@link guide/directive#creating-custom-directives_creating-directives_template-expanding-directive
	 * Directives Guide} for an example.
	 *
	 * You can specify `template` as a string representing the template or as a function which takes
	 * two arguments `tElement` and `tAttrs` (described in the `compile` function api below) and
	 * returns a string value representing the template.
	 */
	public var template(default, default):Dynamic = null;
	/**
	 * string 'directive.html' or  function(tElement, tAttrs) { ... }
	 * Same as `template` but the template is loaded from the specified URL. Because
	 * the template loading is asynchronous the compilation/linking is suspended until the template
	 * is loaded.
	 *
	 * You can specify `templateUrl` as a string representing the URL or as a function which takes two
	 * arguments `tElement` and `tAttrs` (described in the `compile` function api below) and returns
	 * a string value representing the url.  In either case, the template URL is passed through {@link
	 * api/ng.$sce#getTrustedResourceUrl $sce.getTrustedResourceUrl}.
	 */
	public var templateUrl(default, default):Dynamic = null;
	/**
	 * specify where the template should be inserted. Defaults to `false`.
	 *
	 * * `true` - the template will replace the current element.
	 * * `false` - the template will replace the contents of the current element.
	 */
	public var replace(default, default):Bool = false;
	/**
	 * compile the content of the element and make it available to the directive.
	 * Typically used with {@link ng.directive:ngTransclude
	 * ngTransclude}. The advantage of transclusion is that the linking function receives a
	 * transclusion function which is pre-bound to the correct scope. In a typical setup the widget
	 * creates an `isolate` scope, but the transclusion is not a child, but a sibling of the `isolate`
	 * scope. This makes it possible for the widget to have private state, and the transclusion to
	 * be bound to the parent (pre-`isolate`) scope.
	 *
	 * * `true` - transclude the content of the directive.
	 * * `'element'` - transclude the whole element including any directives defined at lower priority.
	 */
	public var transclude(default, default):Dynamic = null;
	/**
	 * String of subset of `EACM` which restricts the directive to a specific directive
	 * declaration style. If omitted, the default (attributes only) is used.
	 *
	 * * `E` - Element name: `<my-directive></my-directive>`
	 * * `A` - Attribute (default): `<div my-directive="exp"></div>`
	 * * `C` - Class: `<div class="my-directive: exp;"></div>`
	 * * `M` - Comment: `<!-- directive: my-directive exp -->`
	 */
	public var restrict(default, default):String = 'A';
	/**
	 * **If set to `true`,** then a new scope will be created for this directive. If multiple directives on the
	 * same element request a new scope, only one new scope is created. The new scope rule does not
	 * apply for the root of the template since the root of the template always gets a new scope.
	 *
	 * **If set to `{}` (object hash),** then a new "isolate" scope is created. The 'isolate' scope differs from
	 * normal scope in that it does not prototypically inherit from the parent scope. This is useful
	 * when creating reusable components, which should not accidentally read or modify data in the
	 * parent scope.
	 *
	 * The 'isolate' scope takes an object hash which defines a set of local scope properties
	 * derived from the parent scope. These local properties are useful for aliasing values for
	 * templates. Locals definition is a hash of local scope property to its source:
	 *
	 * * `@` or `@attr` - bind a local scope property to the value of DOM attribute. The result is
	 *   always a string since DOM attributes are strings. If no `attr` name is specified  then the
	 *   attribute name is assumed to be the same as the local name.
	 *   Given `<widget my-attr="hello {{name}}">` and widget definition
	 *   of `scope: { localName:'@myAttr' }`, then widget scope property `localName` will reflect
	 *   the interpolated value of `hello {{name}}`. As the `name` attribute changes so will the
	 *   `localName` property on the widget scope. The `name` is read from the parent scope (not
	 *   component scope).
	 *
	 * * `=` or `=attr` - set up bi-directional binding between a local scope property and the
	 *   parent scope property of name defined via the value of the `attr` attribute. If no `attr`
	 *   name is specified then the attribute name is assumed to be the same as the local name.
	 *   Given `<widget my-attr="parentModel">` and widget definition of
	 *   `scope: { localModel:'=myAttr' }`, then widget scope property `localModel` will reflect the
	 *   value of `parentModel` on the parent scope. Any changes to `parentModel` will be reflected
	 *   in `localModel` and any changes in `localModel` will reflect in `parentModel`. If the parent
	 *   scope property doesn't exist, it will throw a NON_ASSIGNABLE_MODEL_EXPRESSION exception. You
	 *   can avoid this behavior using `=?` or `=?attr` in order to flag the property as optional.
	 *
	 * * `&` or `&attr` - provides a way to execute an expression in the context of the parent scope.
	 *   If no `attr` name is specified then the attribute name is assumed to be the same as the
	 *   local name. Given `<widget my-attr="count = count + value">` and widget definition of
	 *   `scope: { localFn:'&myAttr' }`, then isolate scope property `localFn` will point to
	 *   a function wrapper for the `count = count + value` expression. Often it's desirable to
	 *   pass data from the isolated scope via an expression and to the parent scope, this can be
	 *   done by passing a map of local variable names and values into the expression wrapper fn.
	 *   For example, if the expression is `increment(amount)` then we can specify the amount value
	 *   by calling the `localFn` as `localFn({amount: 22})`.
	 */
	public var scope(default, default):Dynamic = true;
	/**
	 * Controller constructor function. The controller is instantiated before the
	 * pre-linking phase and it is shared with other directives (see
	 * `require` attribute). This allows the directives to communicate with each other and augment
	 * each other's behavior. The controller is injectable (and supports bracket notation) with the following locals:
	 *
	 * * `$scope` - Current scope associated with the element
	 * * `$element` - Current element
	 * * `$attrs` - Current attributes object for the element
	 * * `$transclude` - A transclude linking function pre-bound to the correct transclusion scope.
	 *    The scope can be overridden by an optional first argument.
	 *   `function([scope], cloneLinkingFn)`.
	 */
	public var controller(default, default):Dynamic = null;
	/**
	 * Controller alias at the directive scope. An alias for the controller so it
	 * can be referenced at the directive template. The directive needs to define a scope for this
	 * configuration to be used. Useful in the case when directive is used as component.
	 */
	public var controllerAs(default, default):String = null;
	/**
	 * Require another directive and inject its controller as the fourth argument to the linking function. The
	 * `require` takes a string name (or array of strings) of the directive(s) to pass in. If an array is used, the
	 * injected argument will be an array in corresponding order. If no such directive can be
	 * found, or if the directive does not have a controller, then an error is raised. The name can be prefixed with:
	 *
	 * * (no prefix) - Locate the required controller on the current element. Throw an error if not found.
	 * * `?` - Attempt to locate the required controller or pass `null` to the `link` fn if not found.
	 * * `^` - Locate the required controller by searching the element's parents. Throw an error if not found.
	 * * `?^` - Attempt to locate the required controller by searching the element's parents or pass `null` to the
	 *   `link` fn if not found.
	 */
	public var require(default, default):Array<String> = null;
	/**
	 * The compile function deals with transforming the template DOM. Since most directives do not do
	 * template transformation, it is not used often. Examples that require compile functions are
	 * directives that transform template DOM, such as {@link
	 * api/ng.directive:ngRepeat ngRepeat}, or load the contents
	 * asynchronously, such as {@link ngRoute.directive:ngView ngView}. The
	 * compile function takes the following arguments.
	 *
	 *   * `tElement` - template element - The element where the directive has been declared. It is
	 *     safe to do template transformation on the element and child elements only.
	 *
	 *   * `tAttrs` - template attributes - Normalized list of attributes declared on this element shared
	 *     between all directive compile functions.
	 *
	 *   * `transclude` -  [*DEPRECATED*!] A transclude linking function: `function(scope, cloneLinkingFn)`
	 * 
	 * A compile function can have a return value which can be either a function or an object.
	 *
	 * * returning a (post-link) function - is equivalent to registering the linking function via the
	 *   `link` property of the config object when the compile function is empty.
	 *    **function postLink(scope, iElement, iAttrs, controller) { ... }**
	 * 
	 * * returning an object with function(s) registered via `pre` and `post` properties - allows you to
	 *   control when a linking function should be called during the linking phase. See info about
	 *   pre-linking and post-linking functions below.
	 * 	{
	 *    pre: function preLink(scope, iElement, iAttrs, controller) { ... },
	 *    post: function postLink(scope, iElement, iAttrs, controller) { ... }
	 *  }
	 */
	public var compile(default, default):Dynamic = null;
	/**
	 * This property is used only if the `compile` property is not defined.
	 * The link function is responsible for registering DOM listeners as well as updating the DOM. It is
	 * executed after the template has been cloned. This is where most of the directive logic will be
	 * put.
	 *
	 *   * `scope` - {@link ng.$rootScope.Scope Scope} - The scope to be used by the
	 *     directive for registering {@link ng.$rootScope.Scope#$watch watches}.
	 *
	 *   * `iElement` - instance element - The element where the directive is to be used. It is safe to
	 *     manipulate the children of the element only in `postLink` function since the children have
	 *     already been linked.
	 *
	 *   * `iAttrs` - instance attributes - Normalized list of attributes declared on this element shared
	 *     between all directive linking functions.
	 *
	 *   * `controller` - a controller instance - A controller instance if at least one directive on the
	 *     element defines a controller. The controller is shared among all the directives, which allows
	 *     the directives to use the controllers as a communication channel.
	 *
	 *   * `transcludeFn` - A transclude linking function pre-bound to the correct transclusion scope.
	 *     The scope can be overridden by an optional first argument. This is the same as the `$transclude`
	 *     parameter of directive controllers.
	 *     `function([scope], cloneLinkingFn)`.
	 *
	 *
	 * #### Pre-linking function
	 *
	 * Executed before the child elements are linked. Not safe to do DOM transformation since the
	 * compiler linking function will fail to locate the correct elements for linking.
	 *
	 * #### Post-linking function
	 *
	 * Executed after the child elements are linked. It is safe to do DOM transformation in the post-linking function.
	 * 
	 * return	{
	 *    pre: function preLink(scope, iElement, iAttrs, controller) { ... },
	 *    post: function postLink(scope, iElement, iAttrs, controller) { ... }
	 *  }
	 * or return function postLink(scope, iElement, iAttrs, controller) { ... }
	 */
	public var link(default, default):Dynamic = null;
}