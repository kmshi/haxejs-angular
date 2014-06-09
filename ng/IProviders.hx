package ng;

/**
 * provider should be public static variable field = ?
 * @author Richard Shi
 */

@:autoBuild(ng.macro.InjectionBuilder.build("provider"))
interface IProviders
{
}

@:autoBuild(ng.macro.InjectionBuilder.buildProviderType())
class BaseProvider {
    //public function new() {}

    //@:inject("$location", "$anchorScroll")
	// public function get():Int{
	// 	return 200;
	// }
}
