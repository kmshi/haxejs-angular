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
          haxe.macro.Compiler.includeFile("www/bower_components/angular-resource/angular-resource.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-resource/angular-resource.min.js.map");
        #else
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-resource/angular-resource.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-resource/angular-resource.min.js.map");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-resource/angular-resource.js");
          ng.macro.InjectionBuilder.moduleDependency("angular-resource","bower_components/angular-resource/angular-resource",["angular"]);
        #end
		//add "ngResource" to global module dependencies
		if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
		window.hxdeps.push("ngResource");
    }
	/**
	 * A factory which creates a resource class object that lets you interact with
	 * [RESTful](http://en.wikipedia.org/wiki/Representational_State_Transfer) server-side data sources.
	 * @param {string} url A parametrized URL template with parameters prefixed by `:` as in
	 *   `/user/:username`. If you are using a URL with a port number (e.g.
	 *   `http://example.com:8080/api`), it will be respected.
	 *
	 *   If you are using a url with a suffix, just add the suffix, like this:
	 *   `$resource('http://example.com/resource.json')` or `$resource('http://example.com/:id.json')`
	 *   or even `$resource('http://example.com/resource/:resource_id.:format')`
	 *   If the parameter before the suffix is empty, :resource_id in this case, then the `/.` will be
	 *   collapsed down to a single `.`.  If you need this sequence to appear and not collapse then you
	 *   can escape it with `/\.`.
	 *
	 * @param {Object=} paramDefaults Default values for `url` parameters. These can be overridden in
	 *   `actions` methods. If any of the parameter value is a function, it will be executed every time
	 *   when a param value needs to be obtained for a request (unless the param was overridden).
	 *
	 *   Each key value in the parameter object is first bound to url template if present and then any
	 *   excess keys are appended to the url search query after the `?`.
	 *
	 *   Given a template `/path/:verb` and parameter `{verb:'greet', salutation:'Hello'}` results in
	 *   URL `/path/greet?salutation=Hello`.
	 *
	 *   If the parameter value is prefixed with `@` then the value of that parameter is extracted from
	 *   the data object (useful for non-GET operations).
	 *
	 * @param {Object.<Object>=} actions Hash with declaration of custom action that should extend
	 *   the default set of resource actions. The declaration should be created in the format of {@link
	 *   ng.$http#usage_parameters $http.config}:
	 *
	 *       {action1: {method:?, params:?, isArray:?, headers:?, ...},
	 *        action2: {method:?, params:?, isArray:?, headers:?, ...},
	 *        ...}
	 *
	 *   Where:
	 *
	 *   - **`action`** – {string} – The name of action. This name becomes the name of the method on
	 *     your resource object.
	 *   - **`method`** – {string} – HTTP request method. Valid methods are: `GET`, `POST`, `PUT`,
	 *     `DELETE`, and `JSONP`.
	 *   - **`params`** – {Object=} – Optional set of pre-bound parameters for this action. If any of
	 *     the parameter value is a function, it will be executed every time when a param value needs to
	 *     be obtained for a request (unless the param was overridden).
	 *   - **`url`** – {string} – action specific `url` override. The url templating is supported just
	 *     like for the resource-level urls.
	 *   - **`isArray`** – {boolean=} – If true then the returned object for this action is an array,
	 *     see `returns` section.
	 *   - **`transformRequest`** –
	 *     `{function(data, headersGetter)|Array.<function(data, headersGetter)>}` –
	 *     transform function or an array of such functions. The transform function takes the http
	 *     request body and headers and returns its transformed (typically serialized) version.
	 *   - **`transformResponse`** –
	 *     `{function(data, headersGetter)|Array.<function(data, headersGetter)>}` –
	 *     transform function or an array of such functions. The transform function takes the http
	 *     response body and headers and returns its transformed (typically deserialized) version.
	 *   - **`cache`** – `{boolean|Cache}` – If true, a default $http cache will be used to cache the
	 *     GET request, otherwise if a cache instance built with
	 *     {@link ng.$cacheFactory $cacheFactory}, this cache will be used for
	 *     caching.
	 *   - **`timeout`** – `{number|Promise}` – timeout in milliseconds, or {@link ng.$q promise} that
	 *     should abort the request when resolved.
	 *   - **`withCredentials`** - `{boolean}` - whether to set the `withCredentials` flag on the
	 *     XHR object. See
	 *     [requests with credentials](https://developer.mozilla.org/en/http_access_control#section_5)
	 *     for more information.
	 *   - **`responseType`** - `{string}` - see
	 *     [requestType](https://developer.mozilla.org/en-US/docs/DOM/XMLHttpRequest#responseType).
	 *   - **`interceptor`** - `{Object=}` - The interceptor object has two optional methods -
	 *     `response` and `responseError`. Both `response` and `responseError` interceptors get called
	 *     with `http response` object. See {@link ng.$http $http interceptors}.
	 *
	 * @returns {Object} A resource "class" object with methods for the default set of resource actions
	 *   optionally extended with custom `actions`. The default set contains these actions:	
	*/
	public inline function run(url:String, ?paramDefaults:Dynamic, ?actions:Dynamic):ResourceClass untyped {
		return this(url,paramDefaults,actions);
	}
}

abstract ResourceClass ({}) from {}{
	/**
	 *	Success callback is called with (value, responseHeaders) arguments. Error callback is called
	 *   with (httpResponse) argument.
	 *
	 *   Class actions return empty instance (with additional properties below).
	*/
	public inline function get(?parameters:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):ResourceObj untyped {
		return this.get(parameters,successCallback,errorCallback);
	}
	public inline function save(parameters:Dynamic,postData:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):ResourceObj untyped {
		return this.save(parameters,postData,successCallback,errorCallback);
	}
	public inline function query(?parameters:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):ResourceObj untyped {
		return this.query(parameters,successCallback,errorCallback);
	}
	public inline function remove(?parameters:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):ResourceObj untyped {
		return this.remove(parameters,successCallback,errorCallback);
	}
	public inline function delete(?parameters:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):ResourceObj untyped {
		return this.delete(parameters,successCallback,errorCallback);
	}
	public inline function action(action:String,?parameters:Dynamic,?postData:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):ResourceObj untyped {
		return this[action](parameters,postData,successCallback,errorCallback);
	}
}

abstract ResourceObj({}) from {} {
	/**
	 *Instance actions return promise of the action.
	*/
	public inline function save(?parameters:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):NgPromise untyped {
		return this["$save"](parameters,successCallback,errorCallback);
	}
	public inline function remove(?parameters:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):NgPromise untyped {
		return this["$remove"](parameters,successCallback,errorCallback);
	}
	public inline function delete(?parameters:Dynamic,?successCallback:Dynamic,?errorCallback:Dynamic):NgPromise untyped {
		return this["$delete"](parameters,successCallback,errorCallback);
	}
	public inline function promise():NgPromise untyped {
		return this["$promise"];
	}
	public inline function resolved():Bool untyped {
		return this["$resolved"];
	}
}