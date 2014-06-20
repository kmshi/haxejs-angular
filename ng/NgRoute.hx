package ng;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
//@:native("$route")
extern class NgRoute
{
    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/js/bower_components/angular-route/angular-route.min.js");
        #end
		//add "ngRoute" to global module dependencies
		if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
		window.hxdeps.push("ngRoute");
    }
	/**
	 * Reference to the current route definition.
     * The route definition contains:
     *
     *   - `controller`: The controller constructor as define in route definition.
     *   - `locals`: A map of locals which is used by {@link ng.$controller $controller} service for
     *     controller instantiation. The `locals` contain
     *     the resolved values of the `resolve` map. Additionally the `locals` also contain:
     *
     *     - `$scope` - The current route scope.
     *     - `$template` - The current route template HTML.
	*/
	public var current(default,null):Dynamic;
	/**
	* Object with all route configuration Objects as its properties.
	*/
	public var routes(default,null):Dynamic;
}

//@:native("$routeProvider")
extern class NgRouteProvider{
	/**
	   * @param {string} path Route path (matched against `$location.path`). If `$location.path`
	   *    contains redundant trailing slash or is missing one, the route will still match and the
	   *    `$location.path` will be updated to add or drop the trailing slash to exactly match the
	   *    route definition.
	   *
	   *    * `path` can contain named groups starting with a colon: e.g. `:name`. All characters up
	   *        to the next slash are matched and stored in `$routeParams` under the given `name`
	   *        when the route matches.
	   *    * `path` can contain named groups starting with a colon and ending with a star:
	   *        e.g.`:name*`. All characters are eagerly stored in `$routeParams` under the given `name`
	   *        when the route matches.
	   *    * `path` can contain optional named groups with a question mark: e.g.`:name?`.
	   *
	   *    For example, routes like `/color/:color/largecode/:largecode*\/edit` will match
	   *    `/color/brown/largecode/code/with/slashes/edit` and extract:
	   *
	   *    * `color: brown`
	   *    * `largecode: code/with/slashes`.	
	*/
	public function when(path:String, route:RouteMapping):NgRouteProvider;
	public function otherwise(route:RouteMapping):NgRouteProvider;
}

//@:native("$routeParams")
abstract NgRouteParams({}) from {} {
    @:arrayAccess public inline function arrayAccess(key:String):Dynamic {
        return Reflect.field(this, key);
    }
    
    @:arrayAccess public inline function arrayWrite<T>(key:String, value:T):Void {
        Reflect.setField(this, key, value);
    }	
}

class RouteMapping{
	public function new(?controller:Dynamic,?controllerAs:Dynamic,?template:Dynamic,?templateUrl:Dynamic,?resolve:Dynamic,?redirectTo:Dynamic){
		this.controller = controller;
		this.controllerAs = controllerAs;
		this.template = template;
		this.templateUrl = templateUrl;
		this.resolve = resolve;
		this.redirectTo = redirectTo;
	}
	/**
	*  Controller fn that should be associated with
   	*  newly created scope or the name of a {@link angular.Module#controller registered
   	*  controller} if passed as a string.
	*/
	public var controller(default, default):Dynamic = null;
	/**
	*  A controller alias name. If present the controller will be
   	*  published to scope under the `controllerAs` name.
	*/	
	public var controllerAs(default, default):String = null;
	/**
	*  html template as a string or a function that
   	*  returns an html template as a string which should be used by {@link
   	*  ngRoute.directive:ngView ngView} or {@link ng.directive:ngInclude ngInclude} directives.
   	*  This property takes precedence over `templateUrl`.
   	*  If `template` is a function, it will be called with the following parameters:
    *
    *      - `{Array.<Object>}` - route parameters extracted from the current
    *        `$location.path()` by applying the current route
	*/	
	public var template(default, default):Dynamic = null;
	/**
	*  path or function that returns a path to an html
    *  template that should be used by {@link ngRoute.directive:ngView ngView}.
	*/	
	public var templateUrl(default, default):Dynamic = null;
	/**
	*     An optional map of dependencies which should
   *      be injected into the controller. If any of these dependencies are promises, the router
   *      will wait for them all to be resolved or one to be rejected before the controller is
   *      instantiated.
   *      If all the promises are resolved successfully, the values of the resolved promises are
   *      injected and {@link ngRoute.$route#$routeChangeSuccess $routeChangeSuccess} event is
   *      fired. If any of the promises are rejected the
   *      {@link ngRoute.$route#$routeChangeError $routeChangeError} event is fired. The map object
   *      is:
   *
   *      - `key` – `{string}`: a name of a dependency to be injected into the controller.
   *      - `factory` - `{string|function}`: If `string` then it is an alias for a service.
   *        Otherwise if function, then it is {@link auto.$injector#invoke injected}
   *        and the return value is treated as the dependency. If the result is a promise, it is
   *        resolved before its value is injected into the controller. Be aware that
   *        `ngRoute.$routeParams` will still refer to the previous route within these resolve
   *        functions.  Use `$route.current.params` to access the new route parameters, instead.
	*/	
	public var resolve(default, default):Dynamic = null;
	/**
	*     value to update
   *      {@link ng.$location $location} path with and trigger route redirection.
   *
   *      If `redirectTo` is a function, it will be called with the following parameters:
   *
   *      - `{Object.<string>}` - route parameters extracted from the current
   *        `$location.path()` by applying the current route templateUrl.
   *      - `{string}` - current `$location.path()`
   *      - `{Object}` - current `$location.search()`
   *
   *      The custom `redirectTo` function is expected to return a string which will be used
   *      to update `$location.path()` and `$location.search()`.
	*/	
	public var redirectTo(default, default):Dynamic = null;
	/**
	*  reload route when only `$location.search()` or `$location.hash()` changes.
	*  If the option is set to `false` and url in the browser changes, then
    *  `$routeUpdate` event is broadcasted on the root scope.
	*/
	public var reloadOnSearch(default, default):Bool = true;
	/**
	*  match routes without being case sensitive
   *
   *      If the option is set to `true`, then the particular route can be matched without being
   *      case sensitive
	*/	
	public var caseInsensitiveMatch(default, default):Bool = false;
}

//directives
/**
 * ngView
*/