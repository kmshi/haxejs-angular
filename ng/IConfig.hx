package ng;

/**
 * config should be public static variable field = function with void return to configure module
 * @author Richard Shi
 */

@:autoBuild(ng.macro.InjectionBuilder.build("config"))
interface IConfig
{
}