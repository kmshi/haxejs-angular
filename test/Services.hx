package test;

import ng.Angular;
import ng.IServices;

class LocServ{
	public var a:Int = 10;
	public function getA(){return ++a;}
	public function new(http:NgHttp, q:NgQ) {
		var p = q.when(1);
		p.finally(function() { trace("Done"); });
	}
}

class Services implements IServices{
	@:inject("$http","$q")
	public static var locServ:Dynamic = LocServ;

    public static function main(){
    }	

}