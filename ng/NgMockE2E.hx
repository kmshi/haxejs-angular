package ng;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
class NgMockE2E 
{

    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/bower_components/angular-mocks/angular-mocks.js");
        #else
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-mocks/angular-mocks.js");
          ng.macro.InjectionBuilder.moduleDependency("angular-mocks","bower_components/angular-mocks/angular-mocks",["angular"]);
        #end
    		//add "ngMockE2E" to global module dependencies
    		if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
    		window.hxdeps.push("ngMockE2E");
    }
}

/**
 * <pre>
 *   myAppDev = angular.module('myAppDev', ['myApp', 'ngMockE2E']);
 *   myAppDev.run(function($httpBackend) {
 *     phones = [{name: 'phone1'}, {name: 'phone2'}];
 *
 *     // returns the current list of phones
 *     $httpBackend.whenGET('/phones').respond(phones);
 *
 *     // adds a new phone to the phones array
 *     $httpBackend.whenPOST('/phones').respond(function(method, url, data) {
 *       phones.push(angular.fromJson(data));
 *     });
 *     $httpBackend.whenGET(/^\/templates\//).passThrough();
 *     //...
 *   });
 * </pre>
*/
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
}

typedef RequestHandler = {
	function respond(status:Int, data:Dynamic, ?headers:Dynamic) :Void;
  function passThrough():Void;
}
