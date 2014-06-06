package test;

import js.Browser;
import js.html.Document;
import ng.Angular;
import ng.IConfig;
//import ng.Animate;
using ng.Angular.NgTimeoutHelper;

class App implements IConfig
{
	public static function main(){
		test.Controller.main();
		test.Service.main();
		var a = {weight:3 };
		var b = {"weight":4 };
		trace(Angular.fromJson(Angular.toJson(b)));
		var argNames = Angular.injector(["ng"]).annotate(test.Controller.scrollController);
		trace(argNames);
		trace(Angular.injector(["ng", "test"]).has("loginController"));	
		var d = new Date(2014,6,3,3,52,50);
		var arr = [1, 2, 3];
		var und = null;
		trace(Angular.isDate(d));		
		trace(Angular.isDate(arr));
		trace(Angular.isArray(d));		
		trace(Angular.isArray(arr));
		trace(Angular.isDefined(und));
		trace(Angular.isUndefined(und));
		trace(Angular.version.full);
		var inj = Angular.injector( ["ng", "test"] );
		trace(inj.get("locServ").getA());
		inj.invoke(["locServ",function(locServ:test.Service.LocServ){trace(locServ.getA());}]);
		inj.invoke(["locServ", function(locServ:test.Service.LocServ) { trace(locServ.getA()); } ]);
		inj.invoke(["$http", function(http:NgHttp) { trace(http.defaults.xsrfHeaderName); } ]);
		trace(Angular.element(Browser.window.document.body.firstElementChild).html());
		inj.invoke(["$timeout", "$http", function(timeout:NgTimeout, http:NgHttp) {
			var p = timeout(function() { trace("after 1 second:" + http.defaults.xsrfHeaderName); }, 1000, true);
			//timeout.cancel(p);
			} ]);
	}
	
	@:inject("$httpProvider")
	public static var runConfig:Dynamic = function(httpProvider:NgHttpProvider) {
		httpProvider.defaults.xsrfHeaderName = "haha";
	}
}