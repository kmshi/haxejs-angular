package bat;

import ng.Angular;
import ng.IControllers;
import bat.Services;

//use class/type as controller model
class MyCtrl1 extends BaseCtrl{
	private var locServ:LocServ;
	public var name(default,default):String = "Hello world! MyCtrl1";
	public function save(){
		locServ.data = name;
	}
	public function new(scope:NgScope,locServ:LocServ){
		super(scope);
		name = locServ.data;
		this.locServ = locServ;
	}
}

class MyCtrl2 extends BaseCtrl{
	public var name(default,default):String = "Hello world! MyCtrl2";
	public function new(scope:NgScope){
		super(scope);
	}
}

class Controllers implements IControllers
{
    public static function main(){
    }

	@:inject("$scope","locServ")
	public static var myCtrl1:Dynamic = MyCtrl1;

	@:inject("$scope")
	public static var myCtrl2:Dynamic = MyCtrl2;
}