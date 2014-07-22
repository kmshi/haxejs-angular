package bat;

import ng.Angular;
import ng.IFilters;
using StringTools;


class Filters implements IFilters{
	public static function main(){}

	@:inject("version")
	public static var interpolate:Dynamic = function(version:String){
		return function(text:String){
			return text.replace("%VERSION%",version);
		};
	};
}