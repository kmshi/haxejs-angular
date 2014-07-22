package bat;

import ng.Angular;
import ng.IDirectives;

class Directives implements IDirectives{
	@:inject("version")
	public static var appVersion:Dynamic = function(version:String) {
		return  new NgDirectiveDefinition()
		.set_restrict("EA")
		.set_link(function(scope:NgScope, elm:NgJQuery,attr) {
          elm.text(version);
		});
	}

    public static function main(){
    }
}