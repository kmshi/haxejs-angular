package av;

@:native("AV")
extern class AV{
	public function initialize(applicationId:String,applicationKey:String,?masterKey:String):Void;
	public function useAVCloudCN():Void;
	public function useAVCloudUS():Void;
}

@:native("AV.Error")
extern class AVError{
	public function new(code:Int, message:String);
	public static var OTHER_CAUSE:Int;
	public static var INTERNAL_SERVER_ERROR:Int;
	public static var CONNECTION_FAILED:Int;
	public static var OBJECT_NOT_FOUND:Int;
	public static var INVALID_QUERY:Int;
	public static var INVALID_CLASS_NAME:Int;
	public static var MISSING_OBJECT_ID:Int;
	public static var INVALID_KEY_NAME:Int;
	public static var INVALID_POINTER:Int;
	public static var INVALID_JSON:Int;
	public static var COMMAND_UNAVAILABLE:Int;
	public static var NOT_INITIALIZED:Int;
	public static var INCORRECT_TYPE:Int;
	public static var INVALID_CHANNEL_NAME:Int;
	public static var PUSH_MISCONFIGURED:Int;
	public static var OBJECT_TOO_LARGE:Int;
	public static var OPERATION_FORBIDDEN:Int;
	public static var CACHE_MISS:Int;
	public static var INVALID_NESTED_KEY:Int;
	public static var INVALID_FILE_NAME:Int;
	public static var INVALID_ACL:Int;
	public static var TIMEOUT:Int;
	public static var INVALID_EMAIL_ADDRESS:Int;
	public static var MISSING_CONTENT_TYPE:Int;
	public static var MISSING_CONTENT_LENGTH:Int;
	public static var INVALID_CONTENT_LENGTH:Int;
	public static var FILE_TOO_LARGE:Int;
	public static var FILE_SAVE_ERROR:Int;
	public static var FILE_DELETE_ERROR:Int;
	public static var DUPLICATE_VALUE:Int;
	public static var INVALID_ROLE_NAME:Int;
	public static var EXCEEDED_QUOTA:Int;
	public static var SCRIPT_FAILED:Int;
	public static var VALIDATION_ERROR:Int;
	public static var INVALID_IMAGE_DATA:Int;
	public static var UNSAVED_FILE_ERROR:Int;
	public static var INVALID_PUSH_TIME_ERROR:Int;
	public static var USERNAME_MISSING:Int;
	public static var PASSWORD_MISSING:Int;
	public static var USERNAME_TAKEN:Int;
	public static var EMAIL_TAKEN:Int;
	public static var EMAIL_MISSING:Int;
	public static var EMAIL_NOT_FOUND:Int;
	public static var SESSION_MISSING:Int;
	public static var MUST_CREATE_USER_THROUGH_SIGNUP:Int;
	public static var ACCOUNT_ALREADY_LINKED:Int;
	public static var LINKED_ID_MISSING:Int;
	public static var INVALID_LINKED_SESSION:Int;
	public static var UNSUPPORTED_SERVICE:Int;
}

@:native("AV.GeoPoint")
extern class AVGeoPoint{
	@:overload(function(point:{latitude:Float,longitude: Float}) : AVGeoPoint {})
	@:overload(function(lat:Float,lon:Float) : AVGeoPoint {})
	@:overload(function(arr:Array<Float>) : AVGeoPoint {})
	@:overload(function(other:AVGeoPoint) : AVGeoPoint {})
	public function new();
	public function toJSON():{};
	public function radiansTo(point:AVGeoPoint):Float;
	public function kilometersTo(point:AVGeoPoint):Float;
	public function milesTo(point:AVGeoPoint):Float;

	public static function current():AVPromise;
}

@:native("AV.Object")
extern class AVObject {
	public function new(classname:String);

	public function get(attr:String):Dynamic;

	public function fetchWhenSave(enable:Bool):Void;

	public function toJSON():{};

	public function dirty(attr:String):Bool;

	public function relation(attr:String):AVRelation;

	public function escape(attr:String):String;

	public function has(attr:String):Bool;

	@:overload(function(pairs:{}) : AVObject {})
	public function set(attr:String,val:Dynamic):AVObject;

	public function unset(attr:String):AVObject;

	public function increment(attr:String,amount:Int):AVObject;

	public function add(attr:String,item:Object):AVObject;

	public function addUnique(attr:String,item:Object):AVObject;

	public function remove(attr:String,item:Object):AVObject;

	//public function op(attr:String):AVOp;

	public function clear():AVObject;

	public function fetch():AVPromise;

	public function save():AVPromise;

	public function destroy():AVPromise;

	public function isNew():Bool;

	public function existed():Bool;

	public function hasChanged(attr:String):Bool;

	public function previous(attr:String):Dynamic;

	public function previousAttributes():Dynamic;

	public function isValid():Bool;

	public function getACL():AVACL;

	public function setACL(acl:AVACL):AVObject;

	//inherit from AV.Events
	public function on(events:String, callback:Dynamic, context:{}):AVObject;
	public function bind(events:String, callback:Dynamic, context:{}):AVObject;
	public function off(events:String, callback:Dynamic, context:{}):AVObject;
	public function unbind(events:String, callback:Dynamic, context:{}):AVObject;
	public function trigger(events:String):AVObject;

    public static function destroyAll(objs:Array<AVObject>):AVPromise;
    public static function saveAll(objs:Array<AVObject>):AVPromise;
}

@:native("AV.Relation")
extern class AVRelation{
	@:overload(function(object:AVObject) : Void {})
	public function add(objects:Array<AVObject>):Void;
	@:overload(function(object:AVObject) : Void {})
	public function remove(objects:Array<AVObject>):Void;
	public function toJSON():{};
	public function query():AVQuery;

	public static function reverseQuery(parentClass:String, relationKey:String, child:AVObject):AVQuery;
}

@:native("AV.Role")
extern class AVRole extends AVObject{
	public function new(name:String, acl:AVACL);
	public function getName():String;
	public function setName(name:String):AVRole;
	public function getUsers():AVRelation;
	public function getRoles():AVRelation;
}

@:native("AV.ACL")
extern class AVACL{
	@:overload(function(user:AVUser) : AVACL {})
	@:overload(function(json:{}) : AVACL {})
	public function new();

	public function toJSON():{};

	@:overload(function(userId:AVUser, allowed:Bool) : Void {})
	public function setReadAccess(userId:String, allowed:Bool):Void;	
	@:overload(function(userId:AVUser) : Bool {})
	public function getReadAccess(userId:String):Bool;
	@:overload(function(userId:AVUser, allowed:Bool) : Void {})
	public function setWriteAccess(userId:String, allowed:Bool):Void;	
	@:overload(function(userId:AVUser) : Bool {})
	public function getWriteAccess(userId:String):Bool;

	public function setPublicReadAccess(allowed:Bool):Void;	
	public function getPublicReadAccess():Bool;
	public function setPublicWriteAccess(allowed:Bool):Void;	
	public function getPublicWriteAccess():Bool;

	@:overload(function(role:AVRole, allowed:Bool) : Void {})
	public function setRoleReadAccess(role:String, allowed:Bool):Void;	
	@:overload(function(role:AVRole) : Bool {})
	public function getRoleReadAccess(role:String):Bool;
	@:overload(function(role:AVRole, allowed:Bool) : Void {})
	public function setRoleWriteAccess(role:String, allowed:Bool):Void;	
	@:overload(function(role:AVRole) : Bool {})
	public function getRoleWriteAccess(role:String):Bool;	
}

// @:native("AV.Op")
// extern class AVOp{
// }

@:native("AV.Promise")
extern class AVPromise{
	public static function is(promise:Dynamic):Bool;
	public static function as(val:Dynamic):AVPromise;
	public static function error(err:Dynamic):AVPromise;
	public static function when(promises:Array<AVPromise>):AVPromise;

	public function resolve(result:Dynamic):Void;
	public function reject(err:Dynamic):Void;
	public function then(resolvedCallback:Dynamic, rejectedCallback:Dynamic):AVPromise;
}

@:native("AV.Query")
extern class AVQuery{

}

@:native("AV.File")
extern class AVFile{

}

@:native("AV.User")
extern class AVUser extends AVObject{

}

class Object{
	private var obj:AVObject = null;

	public function new(?_obj:AVObject){
		if (_obj!=null) {
			obj = _obj;
			return;
		}
		var subCls = Type.getClass(this);
		var clsName = Type.getClassName(subCls);
		var lastIdx = clsName.lastIndexOf('.');
		obj = new AVObject(clsName.substring(lastIdx+1));	
	}
}