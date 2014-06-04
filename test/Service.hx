package test;

import ng.Angular;
import ng.IService;

class LocServ{
	public var a:Int = 10;
	public function getA(){return ++a;}
	public function new(http:Http){}
}

class Service implements IService{
	@:inject("$http")
	public static var locServ:Dynamic = LocServ;

    public static function main(){
    }	

}