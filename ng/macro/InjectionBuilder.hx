package ng.macro;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
#end
using Lambda;

/**
 * 
 * @author Richard Shi
 */
class InjectionBuilder
{
#if macro
    private static var currentClsName:String;
    private static var currentPackName:String;
    private static var allFields:Array<Field>;

    private static var mainField:Field;
    private static var mainFn:Function;

    private static var ctorField:Field;
    private static var ctor:Function;

    private static var blockMain:Array<Expr>;
    private static var blockCtor:Array<Expr>;

    private static function getClsName() {
        switch(Context.getLocalType()) {
            case TInst(ins, _): currentClsName = ins.toString();
            default:
        }
        currentPackName = Context.getLocalClass().get().pack.join(".");
    }

	private static function getMainFn() {
        for (f in allFields) {
            switch(f.kind) {
                case FFun(func) :
                    if (f.access.has(AStatic) && f.name == 'main') {
                        mainFn = func;
                        mainField = f;
                    }
                default:
            }
        }
        if (mainFn == null) throw new Error("No main entry point found", Context.currentPos());
    }

    private static function getMainFnBlock() {
        switch(mainFn.expr.expr) {
            case EBlock(b): blockMain = b;
            default: blockMain = [mainFn.expr];
        }
    }

    private static function getCtorAndBlock() {
        for (f in allFields) {
            switch(f.kind) {
                case FFun(func) :
                    if (!f.access.has(AStatic) && f.name == 'new') {
                        ctor = func;
                        ctorField = f;
                    }
                default:
            }
        }

        if (ctor == null) {
            //the "expr: macro $b{blockCtor}" seems work now, do not need throw exception here
            //throw new Error("No constractor new function found", Context.currentPos());
            
        	blockCtor = new Array<Expr>();
        	ctor = {
                args: [],
                ret: null,
                expr: macro $b{blockCtor},
                params: []
            };
            ctorField = {
	            name: "new",
	            doc: null,
	            access: [APublic],
	            kind: FFun(ctor),
	            pos: Context.currentPos(),
	            meta : null
	        };
	        allFields.push(ctorField);
        }else{
        	switch(ctor.expr.expr) {
	            case EBlock(b): blockCtor = b;
	            default: blockCtor = [ctor.expr];
	        }
        }
    }

    private static function addExpr2CtorBlock(){
    	var hasMeta:Bool = false;
    	for (f in allFields) {
            if (f.access.has(AStatic)) continue;
            if (f.access.has(APrivate)) continue;
            if (f.name == 'new') continue;
            switch(f.kind) {
                case FFun(_) :{
                    var injects = f.meta.filter(metaExists(":inject"));
                    var inject = null;
					if (injects != null && injects.length > 0 && (inject = injects[0]) != null)
					{
						//var str =  "untyped this.$get = [" + metaToString(inject.params).join(",") + ","+currentClsName+"."+f.name+"]";
						var str =  "untyped this.$get = [" + metaToString(inject.params).join(",") + ","+f.name+"]";
						var ett = Context.parse(str,Context.currentPos());
						blockCtor.push(macro {$ett;});
						hasMeta = true;
					}
                }
                default:
            }
        }
        if(!hasMeta){
			trace(currentClsName+":Please add public member function with @:inject('$xx','$yy') alike to macro setup this.$get");
		}
    }

    private static function addExpr2MainFnBlock(type:String) {
    	var hasMeta:Bool = false;
        for (f in allFields) {
            if (!f.access.has(AStatic)) continue;
            if (f.access.has(APrivate)) continue;
            switch(f.kind) {
                case FVar(_,_):{
                    var injects = f.meta.filter(metaExists(":inject"));
                    var inject = null;
					if (injects != null && injects.length > 0 && (inject = injects[0]) != null)
					{
						var ett = register(f.name,f.name,type);
						if (ett != null) blockMain.push(macro { $ett; } );
						
						var et = getInjectionExpr(f.name, metaToString(inject.params));
						if (type!="constant" && type!="value")//it is not value or constant
							blockMain.unshift(macro { $et; }); //block.insert(0, macro { $et; } );

						hasMeta = true;
					}
                }
                default:
            }
        }
        if(!hasMeta){
			trace(currentClsName + ":Please add public static variable with @:inject('$xx','$yy') alike to macro setup $inject");
        }
		
        blockMain.unshift(macro {
	        try {
	    		Angular.module('$currentPackName');
	  		} catch (e:Dynamic) {
	  			var deps:Array<String> = untyped window.hxdeps?window.hxdeps:[];
	  			//trace("deps:"+deps);
	    		Angular.module('$currentPackName',deps);
	  		}
        });//use package as module name
    	//blockMain.unshift(macro {Angular.module('$currentClsName',[]);});
    }

    private static function register(name:String,fvar:String,type:String):Expr
    {
	   	var str =  "";
    	if(type=="config" || type=="run") 
    		str =  "Angular.module(\""+currentPackName+"\")."+type+"("+fvar+")";
    	else
    		str =  "Angular.module(\""+currentPackName+"\")."+type+"(\""+name+"\","+fvar+")";
    	return Context.parse(str,Context.currentPos());
    }

    private static function getInjectionExpr(destination: String, injections: Array<String>): Expr
	{
		var str =  destination + ".$inject = [" + injections.join(",") + "]";
		return Context.parse(str,Context.currentPos());
	}

    private static function metaToString(meta: Array<Expr>)
	{
		return meta.map(function (p: Expr): String {
			return switch(p.expr)
			{
				case EConst(CString(str)): '"$str"';
				case _: "";
			}
		});
	}

    private static function metaExists(name: String): MetadataEntry -> Bool
	{
		return function (entry: MetadataEntry) {
			return entry.name == name;
		}
	}
#end
	
	macro public static function build(type:String):Array<haxe.macro.Field> {
        allFields = Context.getBuildFields();
        getClsName();
        getMainFn();
        getMainFnBlock();
        addExpr2MainFnBlock(type);
        return allFields;
    }

    macro public static function buildProviderType():Array<haxe.macro.Field>{
    	allFields = Context.getBuildFields();
    	getClsName();
    	getCtorAndBlock();
    	addExpr2CtorBlock();
    	return allFields;
    }

    macro public static function embedAlert( msg : Expr ) {
        var str = switch( msg.expr ) {
            case EConst(c):
                switch( c ) {
                case CString(str): str;
                default: null;
                }
            default: null;
        }
        if( str == null ) Context.error("Should be a constant string", msg.pos);
        trace(str);
        return macro null;
    }

    macro public static function copyFile( fileName : Expr ) {
        var str = switch( fileName.expr ) {
            case EConst(c):
                switch( c ) {
                case CString(str): str;
                default: null;
                }
            default: null;
        }
        if( str == null ) Context.error("Should be a constant string", fileName.pos);

        //trace(Context.resolvePath(str));

        if (!sys.FileSystem.exists( str )){
            var lastIndex = str.lastIndexOf("/");
            sys.FileSystem.createDirectory(str.substr(0,lastIndex));
            sys.io.File.copy( Context.resolvePath(str) , str);
        }
        return macro null;
    }

    macro public static function moduleDependency(moduleName:Expr,path:Expr,deps:Expr) {
        var strModuleName = switch( moduleName.expr ) {
            case EConst(c):
                switch( c ) {
                    case CString(str): str;
                    default: null;
                }
            default: null;
        }
        if( strModuleName == null ) Context.error("Should be a constant string", moduleName.pos);

        var strPath = switch( path.expr ) {
            case EConst(c):
                switch( c ) {
                    case CString(str): str;
                    default: null;
                }
            default: null;
        }
        if( strPath == null ) strPath = '';

        var arrDeps = ['angular'];
        //TODO:get it from deps Expr

        var json = {paths:{},shim:{}};
        if (sys.FileSystem.exists("require.json")){
            json = haxe.Json.parse(sys.io.File.getContent("require.json"));
            if (json.paths==null) json.paths = {};
            if (json.shim==null) json.shim = {};
        }
        Reflect.setProperty( json.paths , strModuleName , strPath );
        var shimVal = {};
        shimVal.deps = arrDeps;
        if (strModuleName == "angular") shimVal.exports = 'angular';
        if (strModuleName == "jquery") shimVal.exports = 'jquery';
        Reflect.setProperty( json.shim , strModuleName , shimVal );
        sys.io.File.saveContent( "require.json" , haxe.Json.stringify(json));

        return macro null;
    }
}