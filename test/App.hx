package test;

import js.Browser;
import js.html.Document;
import ng.Angular;
import ng.IConfigs;
import ng.IProviders;
import js.JQuery;
import ng.NgResource;
import ng.NgRoute;
import ng.NgSanitize;
import ng.NgCookies;
import ng.NgBindOnce;

class XX extends BaseProvider{
	@:inject("$location", "$anchorScroll")
	public function get():Int{
		return 2000;
	}

	//public function new() untyped{this.$get = ["$location","$anchorScroll",get];}
	public function new(){trace("hello XX");}
}

class App implements IConfigs
{
	public static function main(){
		Controllers.main();
		Services.main();
		Directives.main();
		var a = {weight:3 };
		var b = {"weight":4 };
		trace(Angular.fromJson(Angular.toJson(b)));
		var argNames = Angular.injector(["ng"]).annotate(test.Controllers.scrollCtrl);
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
		inj.invoke(["locServ",function(locServ:test.Services.LocServ){trace(locServ.getA());}]);
		inj.invoke(["locServ", function(locServ:test.Services.LocServ) { trace(locServ.getA()); } ]);
		inj.invoke(["$http", function(http:NgHttp) { trace(http.defaults().xsrfHeaderName); } ]);
		trace(Angular.element(Browser.window.document.body.firstElementChild).html());
		inj.invoke(["$timeout", "$http", function(timeout:NgTimeout, http:NgHttp) {
			var p = timeout.run(function() { trace("after 1 second:" + http.defaults().xsrfHeaderName); }, 1000, true);
			//timeout.cancel(p);
			} ]);
		inj.invoke(["$compile","$rootScope","$interpolate",function(compile:NgCompile,rootScope:NgRootScope,interpolate:NgInterpolate){
			var scope = rootScope.newScope();
			scope["name"] = "kill game";
			var elem = Angular.element("<div>hi {{name}}</div>");
			trace(compile.runJ(elem)(scope));
			//trace(compile.run("<div>hi {{name}}</div>")(scope)[0]);
			trace(interpolate.endSymbol());
			var exp = interpolate.run('Hello {{name | uppercase}}!');
			trace(exp( { name:'Angular'} ));
			}]);
		var xx = new XX();
		var ret = untyped {xx["$get"];};
		trace(ret[2]());
		inj.invoke(["$cacheFactory", function(cacheFactory:NgCacheFactory) {
			var cache:NgCache = cacheFactory.newCache("haha");
			cache.put("hcc", 2014);
			trace("hcc=" + cache.get("hcc"));
			trace("hcc=" + cacheFactory.get("haha").get("hcc"));
			trace(cache.info());
			trace(cacheFactory.info());
			}]);
		inj.invoke(["$log", function(log:NgLog) {
			log.debug("debug:---");
			log.log("log:---");
			log.info("info:---");
			log.warn("warn:---");
			log.error("error:---");
			}]);
		inj.invoke(["$parse", function(parse:NgParse) {
			var getter = parse.run('user.name');
			var setter = getter.assign();
			var context = { user: { name:'angular' }};
			var locals = { user: { name:'local' }};
			trace("parse:" + getter.run(context));
			trace("parse:" + getter.run(context, locals));
			setter(context, "parse changed");
			trace("parse:" + getter.run(context));
			trace("parse:" + getter.constant());
			trace("parse:" + getter.literal());
			}]);
		inj.invoke(["$resource", function(resource:NgResource) {
			resource.run("http://www.zaobao.com");
			}]);
		inj.invoke(["$filter", function(filter:NgFilter) {
			trace(filter.run("uppercase")("http://www.zaobao.com"));
			}]);
		inj.invoke(["$sce", function(sce:NgSce) {
			trace("sce:"+ sce.trustAsHtml("<alert />"));//trust it, do not sanitize it
			}]);
		inj.invoke(["$sanitize", function(sanitize:NgSanitize) {
			trace("sanitize:"+ sanitize.run("<alert />"));
			}]);
		inj.invoke(["$cookies","$cookieStore", function(cookies:NgCookies,cookieStore:NgCookieStore) {
			trace("cookies old:"+ cookies.get("bei"));
			cookies.put("bei","long long ago");
			trace("cookies new:"+ cookies.get("bei"));
			cookies.remove("bei");

			trace("cookieStore old:"+ cookieStore.get("ben"));
			cookieStore.put("ben","long long ago");
			trace("cookieStore new:"+ cookieStore.get("ben"));
			}]);
	}
	
	@:inject("$httpProvider","$logProvider")
	public static var runConfig:Dynamic = function(httpProvider:NgHttpProvider,logProvider:NgLogProvider) {
		httpProvider.defaults.xsrfHeaderName = "haha";
		trace("debugEnabled:" + logProvider.debugEnabled());
		logProvider.debugEnabled(false);
		trace("debugEnabled:" + logProvider.debugEnabled());
	}
}