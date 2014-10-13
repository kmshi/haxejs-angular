package av;

@:initPackage
@:native("AV")
extern class AV{
	private static function __init__() : Void untyped {
        #if embed_js
          ng.macro.InjectionBuilder.embedAlert("Can not embed av-mini.js,please reference by script tag before other scripts: www/bower_components/avos/av-mini.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/avos/av-mini.js");
        #else
          ng.macro.InjectionBuilder.copyFile("www/bower_components/avos/av-mini.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/avos/av.js");
        #end
    }

	public static function initialize(applicationId:String,applicationKey:String,?masterKey:String):Void;
	public static function useAVCloudCN():Void;
	public static function useAVCloudUS():Void;
	public static var _installationId:String;//hacked to be used in AVInstallation
	public static function _getInstallationId():String;//hacked here
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
	@:overload(function(point:{latitude:Float,longitude: Float}) : Void {})
	@:overload(function(lat:Float,lon:Float) : Void {})
	@:overload(function(arr:Array<Float>) : Void {})
	@:overload(function(other:AVGeoPoint) : Void {})
	public function new();
	public function toJSON():{};
	public function radiansTo(point:AVGeoPoint):Float;
	public function kilometersTo(point:AVGeoPoint):Float;
	public function milesTo(point:AVGeoPoint):Float;

	public static function current():AVPromise;
}

@:native("AV.Events")
extern class AVEvents {
	public function on(events:String, callback:Dynamic, context:{}):AVObject;
	public function bind(events:String, callback:Dynamic, context:{}):AVObject;
	public function off(events:String, callback:Dynamic, context:{}):AVObject;
	public function unbind(events:String, callback:Dynamic, context:{}):AVObject;
	public function trigger(events:String):AVObject;
}

@:native("AV.Object")
extern class AVObject extends AVEvents{
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

	public function add(attr:String,item:AVObject):AVObject;

	public function addUnique(attr:String,item:AVObject):AVObject;

	public function remove(attr:String,item:AVObject):AVObject;

	//public function op(attr:String):AVOp;

	public function clear():AVObject;

	public function fetch():AVPromise;

	public function save():AVPromise;

	public function destroy():AVPromise;

	public function clone():AVObject;

	public function change():AVObject;

	public function isNew():Bool;

	public function existed():Bool;

	public function hasChanged(attr:String):Bool;

	public function previous(attr:String):Dynamic;

	public function previousAttributes():Dynamic;

	public function isValid():Bool;

	public function getACL():AVACL;

	public function setACL(acl:AVACL):AVObject;

    public static function destroyAll(objs:Array<AVObject>):AVPromise;
    public static function saveAll(objs:Array<AVObject>):AVPromise;
}

@:native("AV.Collection")
extern class AVCollection extends AVEvents{
	public function new(models:Array<AVObject>);
	public function toJSON():Array<{}>;
	@:overload(function(model:AVObject) : AVCollection {})
	public function add(models:Array<AVObject>):AVCollection;
	@:overload(function(model:AVObject) : AVCollection {})
	public function remove(models:Array<AVObject>):AVCollection;
	public function at(index:Int):AVObject;
	public function pluck(attr:String):Array<Dynamic>;
	public function reset(models:Array<AVObject>):AVCollection;
	public var model:AVObject;
	public function fetch():AVPromise;
	//Underscore methods that we want to implement on the Collection.Like:'forEach', 'each'
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
	@:overload(function(user:AVUser) : Void {})
	@:overload(function(json:{}) : Void {})
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
	public function then(resolvedCallback:Dynamic, ?rejectedCallback:Dynamic):AVPromise;
}

@:native("AV.Query")
extern class AVQuery{
	public function new(objectClass:String);
	public function get(objectId:String):AVPromise;
	public function toJSON():{};
	public function find():AVPromise;
	public function destroyAll():AVPromise;
	public function count():AVPromise;
	public function first():AVPromise;
	public function each(callback:Dynamic):AVPromise;

	public function skip(n:Int):AVQuery;
	public function limit(n:Int):AVQuery;
	public function equalTo(key:String, value:Dynamic):AVQuery;
	public function notEqualTo(key:String, value:Dynamic):AVQuery;
	public function lessThan(key:String, value:Dynamic):AVQuery;
	public function greaterThan(key:String, value:Dynamic):AVQuery;
	public function lessThanOrEqualTo(key:String, value:Dynamic):AVQuery;
	public function greaterThanOrEqualTo(key:String, value:Dynamic):AVQuery;
	public function containedIn(key:String, values:Array<Dynamic>):AVQuery;
	public function notContainedIn(key:String, values:Array<Dynamic>):AVQuery;
	public function containsAll(key:String, values:Array<Dynamic>):AVQuery;
	public function exists(key:String):AVQuery;
	public function doesNotExist(key:String):AVQuery;
	public function matches(key:String,regex:Dynamic, modifiers:String):AVQuery;
	public function matchesQuery(key:String,query:AVQuery):AVQuery;
	public function doesNotMatchQuery(key:String,query:AVQuery):AVQuery;
	public function matchesKeyInQuery(key:String,queryKey:String,query:AVQuery):AVQuery;
	public function doesNotMatchKeyInQuery(key:String,queryKey:String,query:AVQuery):AVQuery;
	public function contains(key:String, value:Dynamic):AVQuery;
	public function startsWith(key:String, value:Dynamic):AVQuery;
	public function endsWith(key:String, value:Dynamic):AVQuery;
	public function ascending(key:String):AVQuery;
	public function addAscending(key:String):AVQuery;
	public function descending(key:String):AVQuery;
	public function addDescending(key:String):AVQuery;
	public function near(key:String, point:AVGeoPoint):AVQuery;
	public function withinRadians(key:String, point:AVGeoPoint, distance:Float):AVQuery;
	public function withinMiles(key:String, point:AVGeoPoint, distance:Float):AVQuery;
	public function withinKilometers(key:String, point:AVGeoPoint, distance:Float):AVQuery;
	public function withinGeoBox(key:String, southwest:AVGeoPoint, northeast:AVGeoPoint):AVQuery;
	public function include(key1:String,?key2:String,?key3:String):AVQuery;
	public function select(key1:String,?key2:String,?key3:String):AVQuery;

	public static function or(query1:AVQuery, query2:AVQuery):AVQuery;
	/**
	resolved result will be {results:Array,count:Int,className:String}
	*/
	public static function doCloudQuery(cql:String):AVPromise;
}

@:native("AV.File")
extern class AVFile{
	@:overload(function(name:String, data:{base64:String}, ?type:String) : Void {})
	@:overload(function(name:String, data:Array<Int>, ?type:String) : Void {})
	public function new(name:String, data:js.html.File, ?type:String);
	public function name():String;
	public function url():String;
	public function metaData():{};
	public function thumbnailURL(width:Int, height:Int, ?quality:Int, ?scaleToFit:Bool, ?fmt:String):String;
	public function size():Int;
	public function ownerId():String;
	public function destroy():AVPromise;
	public function save():AVPromise;

	public static function withURL(name:String, url:String, ?metaData:{}, ?type:String):AVFile;
}

@:native("AV.User")
extern class AVUser extends AVObject{
	//public function signUp(attrs:{username:String,password:String}):AVPromise;
	//public function logIn():AVPromise;
	public function follow(target:AVUser):AVPromise;
	public function unfollow(target:AVUser):AVPromise;
	public function followerQuery():AVQuery;
	public function followeeQuery():AVQuery;
	public function isCurrent():Bool;
	public function getUsername():String;
	public function setUsername(username:String):AVUser;
	public function getMobilePhoneNumber():String;
	public function setMobilePhoneNumber(phone:String):AVUser;
	public function setPassword(password:String):AVUser;
	public function authenticated():Bool;
	public function getEmail():String;
	public function setEmail(email:String):AVUser;

	public static function signUp(username:String,password:String):AVPromise;
	public static function logIn(username:String,password:String):AVPromise;
	public static function logInWithMobilePhoneSmsCode(mobilePhone:String,smsCode:String):AVPromise;
	public static function logInWithMobilePhone(mobilePhone:String,password:String):AVPromise;
	public static function logOut():AVPromise;
	public static function requestPasswordReset(email:String):AVPromise;
	public static function requestEmailVerify(email:String):AVPromise;
	public static function requestMobilePhoneVerify(mobilePhone:String):AVPromise;
	public static function requestPasswordResetBySmsCode(mobilePhone:String):AVPromise;
	public static function resetPasswordBySmsCode(code:String, password:String):AVPromise;
	public static function verifyMobilePhone(code:String):AVPromise;
	public static function requestLoginSmsCode(mobilePhone:String):AVPromise;
	public static function current():AVUser;
}

@:native("AV.Cloud")
extern class AVCloud{
	public static function run(name:String, data:{}):AVPromise;
	public static function requestSmsCode(mobilePhone:String):AVPromise;
	public static function verifySmsCode(code:String):AVPromise;
}


@:native("AV.Push")
extern class AVPush{
	/**
	{channels:Array<String>,push_time:Date,expiration_time:Date,expiration_interval:Int,where:AVQuery,data:{alert:String}}
	*/
	public static function send(data:{data:{alert:String}}):AVPromise;
}

@:native("AV.Status")
extern class AVStatus{

}

class HxAVObject extends AVObject{
	private var className:String;//hacked?

	public function new(){
		var subCls = Type.getClass(this);
		var clsName = Type.getClassName(subCls);
		var lastIdx = clsName.lastIndexOf('.');

		className = clsName.substring(lastIdx+1);
		super(className);
		var temp = new AVObject(className);
		for (field in Reflect.fields(temp)){
			Reflect.setField(this,field,Reflect.field(temp,field));
		}

		/** try to call Object.defineProperty for every fields    
			Object.defineProperty(Todo.prototype, "title", {
		      get: function() {
		        return this.get("text");
		      },
		      set: function(aValue) {
		        this.set("text", aValue);
		      }
		    });
		*/
		//trace(Type.getInstanceFields(subCls));
	}
}

class HxAVInstallation extends AVObject{
	private var className:String;//hacked?

	public var deviceType(get,null):String;
	public var installationId(get,set):String;
	public var deviceToken(get,set):String;
	public var badge(get,set):Int;
	public var timeZone(get,set):String;
	public var channels(get,set):Array<String>;

	public function new(deviceType:String){
		//it should use "installations" route? it looks like this way works:) 
		//https://cn.avoscloud.com/1.1/installations
		className = "_Installation";
		super(className);
		var temp = new AVObject(className);
		for (field in Reflect.fields(temp)){
			Reflect.setField(this,field,Reflect.field(temp,field));
		}

		set("deviceType",deviceType);
	}

	//override to make sure deviceType and others are set correctly
	//public function validate(attrs, options):Bool{
	//	return true;
	//}

	public function get_deviceType():String{
		return get("deviceType");
	}

	public function set_installationId(installationId:String):String{
		set("installationId",installationId);
		AV._installationId = installationId;
		return installationId;
	}

	public function get_installationId():String{
		return get("installationId");
	}

	public function get_deviceToken():String{
		return get("deviceToken");
	}

	public function set_deviceToken(deviceToken:String):String{
		set("deviceToken",deviceToken);
		return deviceToken;
	}

	public function get_badge():Int{
		return get("badge");
	}

	public function set_badge(badge:Int):Int{
		set("badge",badge);
		return badge;
	}

	public function get_timeZone():String{
		return get("timeZone");
	}

	public function set_timeZone(timeZone:String):String{
		set("timeZone",timeZone);
		return timeZone;
	}

	public function get_channels():Array<String>{
		return get("channels");
	}

	public function set_channels(channels:Array<String>):Array<String>{
		set("channels",channels);
		return channels;
	}
}
