package ng;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
class NgMock 
{

    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/bower_components/angular-mocks/angular-mocks.js");
        #else
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-mocks/angular-mocks.js");
        #end
		//add "ngMock" to global module dependencies
		//if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
		//window.hxdeps.push("ngMock");
    }

    public static function module(name: String) : Void {
		untyped __js__("angular.mock.module(name)");
	}
	/**
	* If an object literal{key:value} is passed they will be registered as values in the module
	*/
	public static function config(obj:Dynamic) : Void {
		untyped __js__("angular.mock.module(obj)");
	}
  /**
  * used to configure all kinds of providers which is injected into fn, like: configProvider(function(xxProvider){...})
  */
  public static function configProvider(fn:Dynamic->Void) : Void {
    untyped __js__("angular.mock.module(fn)");
  }

	public static function inject(fn:Array<Dynamic>) : Void {
		untyped __js__("angular.mock.inject(fn)");
	}
	/**
	 * Mock of the Date type which has its timezone specified via constructor arg.
	 *
	 * The main purpose is to create Date-like instances with timezone fixed to the specified timezone
	 * offset, so that we can test code that depends on local timezone settings without dependency on
	 * the time zone settings of the machine where the code is running.
	 *
	 * @param {number} offset Offset of the *desired* timezone in hours (fractions will be honored)
	 * @param {(number|string)} timestamp Timestamp representing the desired time in *UTC*
	*/
	@:overload(function(offset:Int, timestamp:Int):Date{})
	public static function tzDate(offset:Int, timestamp:String) : Date {
		return untyped __js__("angular.mock.TzDate(offset,timestamp)");
	}

	public static function dump(object:Dynamic) : String {
		return untyped __js__("angular.mock.dump(object)");
	}
}

//@:native("$httpBackend")
extern class NgHttpBackend{
   /**
   * Creates a new backend definition.
   *
   * @param {string} method HTTP method.
   * @param {string|RegExp} url HTTP url.
   * @param {(string|RegExp|function(string))=} data HTTP request body or function that receives
   *   data string and returns true if the data is as expected.
   * @param {(Object|function(Object))=} headers HTTP headers or function that receives http header
   *   object and returns true if the headers match the current definition.
   * @returns {requestHandler} Returns an object with `respond` method that controls how a matched
   *   request is handled.
   *
   *  - respond –
   *      `{function([status,] data[, headers])|function(function(method, url, data, headers)}`
   *    – The respond method takes a set of static data to be returned or a function that can return
   *    an array containing response status (number), response data (string) and response headers
   *    (Object).
   */
	public function when(method:String, ?url:Dynamic, ?data:Dynamic, ?headers:Dynamic):RequestHandler;
	public function whenGET(url:Dynamic, ?headers:Dynamic):RequestHandler;
	public function whenHEAD(url:Dynamic, ?headers:Dynamic):RequestHandler;
	public function whenDELETE(url:Dynamic, ?headers:Dynamic):RequestHandler;
	public function whenPOST(url:Dynamic, data:Dynamic, ?headers:Dynamic):RequestHandler;
	public function whenPUT(url:Dynamic, data:Dynamic, ?headers:Dynamic):RequestHandler;
	public function whenPATCH(url:Dynamic, data:Dynamic, ?headers:Dynamic):RequestHandler;
	public function whenJSONP(url:Dynamic):RequestHandler;
  /**
   * Creates a new request expectation.
   *
   * @param {string} method HTTP method.
   * @param {string|RegExp} url HTTP url.
   * @param {(string|RegExp|function(string)|Object)=} data HTTP request body or function that
   *  receives data string and returns true if the data is as expected, or Object if request body
   *  is in JSON format.
   * @param {(Object|function(Object))=} headers HTTP headers or function that receives http header
   *   object and returns true if the headers match the current expectation.
   * @returns {requestHandler} Returns an object with `respond` method that control how a matched
   *  request is handled.
   *
   *  - respond –
   *    `{function([status,] data[, headers])|function(function(method, url, data, headers)}`
   *    – The respond method takes a set of static data to be returned or a function that can return
   *    an array containing response status (number), response data (string) and response headers
   *    (Object).
   */
	public function expect(method:String, ?url:Dynamic, ?data:Dynamic, ?headers:Dynamic):RequestHandler;
	public function expectGET(url:Dynamic, ?headers:Dynamic):RequestHandler;
	public function expectHEAD(url:Dynamic, ?headers:Dynamic):RequestHandler;
	public function expectDELETE(url:Dynamic, ?headers:Dynamic):RequestHandler;
	public function expectPOST(url:Dynamic, data:Dynamic, ?headers:Dynamic):RequestHandler;
	public function expectPUT(url:Dynamic, data:Dynamic, ?headers:Dynamic):RequestHandler;
	public function expectPATCH(url:Dynamic, data:Dynamic, ?headers:Dynamic):RequestHandler;
	public function expectJSONP(url:Dynamic):RequestHandler;	
  /**
   * Flushes all pending requests using the trained responses.
   *
   * @param {number=} count Number of responses to flush (in the order they arrived). If undefined,
   *   all pending requests will be flushed. If there are no pending requests when the flush method
   *   is called an exception is thrown (as this typically a sign of programming error).
   */
	public function flush(count:Int):Void;
  /**
   * Verifies that all of the requests defined via the `expect` api were made. If any of the
   * requests were not made, verifyNoOutstandingExpectation throws an exception.
   *
   * Typically, you would call this method following each test case that asserts requests using an
   * "afterEach" clause.
   *
   * <pre>
   *   afterEach($httpBackend.verifyNoOutstandingExpectation);
   * </pre>
   */	
	public function verifyNoOutstandingExpectation():Void;
  /**
   * Verifies that there are no outstanding requests that need to be flushed.
   *
   * Typically, you would call this method following each test case that asserts requests using an
   * "afterEach" clause.
   *
   * <pre>
   *   afterEach($httpBackend.verifyNoOutstandingRequest);
   * </pre>
   */
	public function verifyNoOutstandingRequest():Void;
  /**
   * Resets all request expectations, but preserves all backend definitions. Typically, you would
   * call resetExpectations during a multiple-phase test when you want to reuse the same instance of
   * $httpBackend mock.
   */
	public function resetExpectations():Void;
}

typedef RequestHandler = {
	function respond(status:Int, data:Dynamic, ?headers:Dynamic) :Void;
}
