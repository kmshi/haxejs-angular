package jasmine;

/**
 * @author Richard Shi
 */

/**
* the code in new and main function should be generated automatically
* setup/teardown and test methods should all to be static public.
* _testXXX method to be pending spec
*/
@:autoBuild(jasmine.macro.TestSuiteBuilder.buildSuite())
class BaseSuite
{
	public static function expect( actual : Dynamic ) : Matchers {
		return untyped __js__("expect(actual)");
	}
	
	public static function runs( func : Void -> Void ) : Void {
		untyped __js__("runs(func)");
	}
	
	public static function waits( timeoutMilliseconds : Int ) : Void {
		untyped __js__("waits(timeoutMilliseconds)");
	}
	
	public static function waitsFor( func : Void -> Bool, ?message : String, ?timeoutMilliseconds : Int ) : Void {
		untyped __js__("waitsFor(func, message, timeoutMilliseconds)");
	}
	
	public static function spyOn( x : Dynamic, method : String ) : Spy {
		return untyped __js__("spyOn(x, method)");
	}

	public static function createSpy( x : Dynamic) : Spy {
		return untyped __js__("jasmine.createSpy(x)");
	}
	/**
	* takes a constructor or “class” name as an expected value. It returns true if the constructor matches the constructor of the actual value.
	*/
	public static function jasmineAny( x : Dynamic) : Dynamic {
		return untyped __js__("jasmine.any(x)");
	}

	public static function setTimeout(callback:Dynamic, timeoutMilliseconds : Int ) : Void {
		untyped __js__("setTimeout(callback,timeoutMilliseconds)");
	}

	public static function setInterval(callback:Dynamic, timeoutMilliseconds : Int ) : Void {
		untyped __js__("setInterval(callback,timeoutMilliseconds)");
	}

	public static function useMockClock() : Void {
		untyped __js__("jasmine.Clock.useMock()");
	}

	public static function tickClock(timeoutMilliseconds:Int) : Void {
		untyped __js__("jasmine.Clock.tick(timeoutMilliseconds)");
	}
}

typedef Matchers = {
	var not(default, never) : Matchers;
	
	function toBe( expected : Dynamic ) : Void;
	function toBeDefined() : Void;
	function toBeFalsy() : Void;
	function toBeGreaterThan( expected : Dynamic ) : Void;
	function toBeLessThan( expected : Dynamic ) : Void;
	function toBeNull() : Void;
	function toBeTruthy() : Void;
	function toBeUndefined() : Void;
	function toContain( expected : Dynamic ) : Void;
	function toEqual( expected : Dynamic ) : Void;
	function toHaveBeenCalled() : Void;
	function toHaveBeenCalledWith( arguments : Dynamic ) : Void;
	function toMatch( expected : Dynamic ) : Void;
	function toThrow( expected : String ) : Void;
}

typedef Spy = {
	var callCount(default, never) : Int;
	var identity(default, never) : String;
	var calls(default, never) : Array<Dynamic>;
	var mostRecentCall(default, never) : Dynamic;

	function andCallFake( fakeFunc : Dynamic ) : Spy;
	function andCallThrough() : Spy;
	function andReturn( value : Dynamic ) : Spy;
	function andThrow( exceptionMsg : String ) : Spy;
}