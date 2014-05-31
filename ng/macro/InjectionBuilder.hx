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
    private static var allFields:Array<Field>;

    private static var mainField:Field;
    private static var mainFn:Function;

    private static var block:Array<Expr>;

    private static function getClsName() {
        switch(Context.getLocalType()) {
            case TInst(ins, _): currentClsName = ins.toString();
            default:
        }
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

    private static function addExpr2MainFnBlock() {
    	block.push(macro {Angular.module('$currentClsName',[]);});
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
						block.insert(0,macro { $et;});
						var ett = registerCtrl(f.name,f.name);
						//trace(ett);
						block.push(macro {$ett;});
					}
                }
                default:
            }
        }

    }

    private static function registerCtrl(name:String,ctrl:String):Expr
    {
    	var str =  "Angular.module(\""+currentClsName+"\").controller(\""+name+"\","+ctrl+")";
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

	macro public static function build():Array<haxe.macro.Field> {
        allFields = Context.getBuildFields();
        getClsName();
        getMainFn();
        getMainFnBlock();
        addExpr2MainFnBlock();
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