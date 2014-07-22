package bat;

import ng.Angular;
import ng.IConfigs;
import ng.NgRoute;
import ng.NgTouch;

class App implements IConfigs
{
	public static function main(){
		Controllers.main();
		Directives.main();
		Values.main();
		Filters.main();
		Services.main();
		//In IE, console.log is only available after you have opened the Developer Tools (F12 to toggle it open and closed). 
		//Funny thing is that after you've opened it, you can close it, then still post to it via console.log calls, and those will be seen when you reopen it.
		//trace("Hello world!"); 
	}

	@:inject("$routeProvider")
	public static var runConfig:Dynamic = function(routeProvider:NgRouteProvider) {
		routeProvider.when("/view1",new RouteMapping().set_templateUrl('partials/partial1.html').set_controller('myCtrl1'));
		routeProvider.when("/view2",new RouteMapping().set_templateUrl('partials/partial2.html'));
		routeProvider.otherwise(new RouteMapping().set_redirectTo('/view1'));
	}

	//IE is the only major browser that caches XHR requests. An efficient way to avoid this poor behavior is to set an HTTP response header of Cache-Control to be no-cache for every request.
	//This behavior is the default behavior for modern browsers and helps to provide a better experience for IE users.
	@:inject("$httpProvider")
	public static var ieAjaxConfig:Dynamic = function(httpProvider:NgHttpProvider){
		untyped httpProvider.defaults.headers.common["Cache-Control"] = 'no-cache';
	}
}