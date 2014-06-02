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

    private static var block:Array<Expr>;

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
            case EBlock(b): block = b;
            default: block = [mainFn.expr];
        }
    }

    //type: 1--controller, 2--service,3--config, 4--directive, 5--filter,6--animation,7--factory,
    //8--provider, 100-- value, 101--constant
    private static function addExpr2MainFnBlock(type:Int) {
        block.push(macro {
	        try {
	    		Angular.module('$currentPackName');
	  		} catch (e:Dynamic) {
	    		Angular.module('$currentPackName',[]);
	  		}
        });//use package as module name
    	//block.push(macro {Angular.module('$currentClsName',[]);});
        for (f in allFields) {
            if (!f.access.has(AStatic)) continue;
            if (f.access.has(APrivate)) continue;
            switch(f.kind) {
                case FVar(_,_):{
                    var injects = f.meta.filter(metaExists(":inject"));
                    var inject = null;
					if (injects != null && injects.length > 0 && (inject = injects[0]) != null)
					{
						var et = getInjectionExpr(f.name, metaToString(inject.params));
						if (type<100)//it is not value or constant
							block.insert(0,macro { $et;});

						var ett = null;
						if (type==1) ett = registerController(f.name,f.name);
						if (type==2) ett = registerService(f.name,f.name);
						
						if (type==3) ett = registerConfig(f.name);

						if (type==4) ett = registerDirective(f.name,f.name);
						if (type==5) ett = registerFilter(f.name,f.name);
						if (type==6) ett = registerAnimation(f.name,f.name);
						if (type==7) ett = registerFactory(f.name,f.name);
						if (type==8) ett = registerProvider(f.name,f.name);

						if (type==100) ett = registerValue(f.name,f.name);
						if (type==101) ett = registerConstant(f.name,f.name);
						//trace(ett);
						if (ett!=null) block.push(macro {$ett;});
					}
                }
                default:
            }
        }

    }

    private static function registerController(name:String,fvar:String):Expr
    {
    	var str =  "Angular.module(\""+currentPackName+"\").controller(\""+name+"\","+fvar+")";
    	//var str =  "Angular.module(\""+currentClsName+"\").controller(\""+name+"\","+fvar+")";
    	return Context.parse(str,Context.currentPos());
    }

    private static function registerService(name:String,fvar:String):Expr
    {
    	var str =  "Angular.module(\""+currentPackName+"\").service(\""+name+"\","+fvar+")";
    	//var str =  "Angular.module(\""+currentClsName+"\").service(\""+name+"\","+fvar+")";
    	return Context.parse(str,Context.currentPos());
    }

    private static function registerConfig(fvar:String):Expr
    {
    	var str =  "Angular.module(\""+currentPackName+"\").config("+fvar+")";
    	//var str =  "Angular.module(\""+currentClsName+"\").config("+fvar+")";
    	return Context.parse(str,Context.currentPos());
    }

    private static function registerDirective(name:String,fvar:String):Expr
    {
    	var str =  "Angular.module(\""+currentPackName+"\").directive(\""+name+"\","+fvar+")";
    	//var str =  "Angular.module(\""+currentClsName+"\").directive(\""+name+"\","+fvar+")";
    	return Context.parse(str,Context.currentPos());
    }

    private static function registerFilter(name:String,fvar:String):Expr
    {
    	var str =  "Angular.module(\""+currentPackName+"\").filter(\""+name+"\","+fvar+")";
    	//var str =  "Angular.module(\""+currentClsName+"\").filter(\""+name+"\","+fvar+")";
    	return Context.parse(str,Context.currentPos());
    }

    private static function registerAnimation(name:String,fvar:String):Expr
    {
    	var str =  "Angular.module(\""+currentPackName+"\").animation(\""+name+"\","+fvar+")";
    	//var str =  "Angular.module(\""+currentClsName+"\").animation(\""+name+"\","+fvar+")";
    	return Context.parse(str,Context.currentPos());
    }

    private static function registerFactory(name:String,fvar:String):Expr
    {
    	var str =  "Angular.module(\""+currentPackName+"\").factory(\""+name+"\","+fvar+")";
    	//var str =  "Angular.module(\""+currentClsName+"\").factory(\""+name+"\","+fvar+")";
    	return Context.parse(str,Context.currentPos());
    }

    private static function registerProvider(name:String,fvar:String):Expr
    {
    	var str =  "Angular.module(\""+currentPackName+"\").provider(\""+name+"\","+fvar+")";
    	//var str =  "Angular.module(\""+currentClsName+"\").provider(\""+name+"\","+fvar+")";
    	return Context.parse(str,Context.currentPos());
    } 

    private static function registerValue(name:String,fvar:String):Expr
    {
    	var str =  "Angular.module(\""+currentPackName+"\").value(\""+name+"\","+fvar+")";
    	//var str =  "Angular.module(\""+currentClsName+"\").value(\""+name+"\","+fvar+")";
    	return Context.parse(str,Context.currentPos());
    } 

    private static function registerConstant(name:String,fvar:String):Expr
    {
    	var str =  "Angular.module(\""+currentPackName+"\").constant(\""+name+"\","+fvar+")";
    	//var str =  "Angular.module(\""+currentClsName+"\").constant(\""+name+"\","+fvar+")";
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
	
	//type: 1--controller, 2--service,3--config, 4--directive, 5--filter,6--animation,7--factory,
    //8--provider, 100-- value, 101--constant
	macro public static function build(type:Int):Array<haxe.macro.Field> {
        allFields = Context.getBuildFields();
        getClsName();
        getMainFn();
        getMainFnBlock();
        addExpr2MainFnBlock(type);
        return allFields;
    }

	macro public static function inject(module:Expr, name: Expr,fn:Expr):haxe.macro.Expr
  	{
	    var field;
	    var cls;
	    //trace(fn);
	    switch(fn.expr){
	    	case EField(expr, m):{
	    		cls = switch(expr.expr){
	    			case EConst(CIdent(clsName)):clsName;
	    			case _:null;
	    		}
	    		field = m;
	    	}
	    	case _:null;
	    }

	    //trace(cls);
	    //trace(field);
	    //trace(haxe.macro.Context.getType(cls);
	    var injects:Array<String> = new Array<String>();
	    switch (haxe.macro.Context.getType(cls))
	    {
	      case TInst(cl,_):{
	      	for (st in cl.get().statics.get())
	      		if (st.name==field){
	      			//var meta: Metadata = st.meta;
	      			for (meta in st.meta.get())
	      			   if (meta.name == ":inject"){
	      			   		for(param in meta.params)
	      			   			switch(param.expr){
	      			   				case EConst(CString(injectName)): injects.push('"$injectName"');
	      			   				case _:null;
	      			   			}
	      			   }
	      		}
	      		//trace(st.name);
	      }
	        
	      case _:
	    }
	    //trace(injects);
	    var untypedJs = Context.parse(cls+"."+field+ ".$inject = [" + injects.join(",") + "]",Context.currentPos());
	    return macro {
	    	$untypedJs;
	    	$module.controller($name, $fn);
	    }

	  }

}