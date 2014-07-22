package bat;

import ng.Angular;
import ng.IServices;

class LocServ{
	public var data(default,default):String = "Hello world!";
	public function new() {		
	}
}

class Services implements IServices{
	@:inject()
	public static var locServ:Dynamic = LocServ;

    public static function main(){
    }	

}