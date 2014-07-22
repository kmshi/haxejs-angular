package test;

import jasmine.BaseSuite;
import ng.NgMock;
import ng.Angular;
/**
* the code in new and main function should be generated automatically
* setup/teardown and test methods should all to be static public.
* _testXXX method to be pending spec
*/
//@:pending
class Unit extends BaseSuite{
	public static function main():Void{
		bat.App.main();
	}

	public static function setup():Void {
		NgMock.module("bat");
	}

	public static function teardown():Void {
	}

	public static function testMyCtrl1Defined() {
		NgMock.inject(["locServ","$controller",function(locServ,controller:NgController){
				var myCtrl1 = controller.run('myCtrl1', {locServ: locServ});
    			BaseSuite.expect(myCtrl1).toBeDefined();
			}]);
	}

	//@:pending
	public static function testMyCtrl2Defined() {
		NgMock.inject(["$controller",function(controller:NgController){
				var myCtrl2 = controller.run('myCtrl2', {"scope": {}});
    			BaseSuite.expect(myCtrl2).toBeDefined();
			}]);
	}

	public static function testAppVersionDirective() {
      	NgMock.config({'version':'TEST_VER'});
      	NgMock.inject(["$compile","$rootScope",function(compile:NgCompile, rootScope:NgRootScope) {
	        var element = compile.run('<span app-version></span>')(rootScope);
	        BaseSuite.expect(element.text()).toEqual('TEST_VER');
	    }]);
	}

	public static function testInterpolateFilter() {
      	NgMock.config({'version':'TEST_VER'});
      	NgMock.inject(["interpolateFilter",function(interpolateFilter) {
	      BaseSuite.expect(interpolateFilter('before %VERSION% after')).toEqual('before TEST_VER after');
	    }]);
	}

	public static function testVersionValue() {
      	NgMock.inject(["version",function(version) {
	      BaseSuite.expect(version).toEqual('0.1');
	    }]);
	}

	public static function _testC() {
		//pending
	}
}