package ng;

/**
 * controller should be public static variable field = function without return to setup model to scope
 * @author Richard Shi
 */

@:autoBuild(ng.macro.InjectionBuilder.build("controller"))
interface IControllers
{
}

class BaseCtrl{
	public function new(scope:ng.Angular.NgScope){
		var className:String = Type.getClassName(Type.getClass(this));
		var pos:Int = className.lastIndexOf('.');
		className = className.charAt(pos+1).toLowerCase()+className.substr(pos+2);//camel name
		scope.setViewModel(className,this);
	}
}