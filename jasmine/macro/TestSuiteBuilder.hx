package jasmine.macro;

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
class TestSuiteBuilder
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
            //the "expr: macro $a{blockCtor}" seems not work, so throw exception here
            throw new Error("No constractor new function found", Context.currentPos());

        	blockCtor = new Array<Expr>();
        	ctor = {
                args: [],
                ret: null,
                expr: macro $a{blockCtor},
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
            if (!f.access.has(AStatic)) continue;
            //if (f.access.has(APrivate)) continue;
            if (f.name == 'main') continue;
            switch(f.kind) {
                case FFun(_) :{
                    var str =  null;
                    if (f.name.toLowerCase() == 'setup') str =  "untyped beforeEach(" + f.name +")";
                    if (f.name.toLowerCase() == 'teardown') str =  "untyped afterEach(" + f.name +")";
                    if (f.name.indexOf('test')==0) str =  "untyped it('" + f.name+"',"+ f.name +")";
                    if (f.name.indexOf('_test')==0) str =  "untyped xit('" + f.name+"',"+ f.name +")";
                    if (str==null) continue;
					var ett = Context.parse(str,Context.currentPos());
					blockCtor.push(macro {$ett;});
					hasMeta = true;
                }
                default:
            }
        }
        if(!hasMeta){
			trace(currentClsName+":Please add public static function started with testXXX");
		}
    }

    private static function addExpr2MainFnBlock() {	
        var str =  "untyped describe('" + currentClsName+"',"+ currentClsName +")";
        var ett = Context.parse(str,Context.currentPos());
        blockMain.unshift(macro {$ett;});
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
	
    macro public static function buildSuite():Array<haxe.macro.Field>{
    	allFields = Context.getBuildFields();
    	getClsName();

        getMainFn();
        getMainFnBlock();
        addExpr2MainFnBlock();

    	getCtorAndBlock();
    	addExpr2CtorBlock();
    	return allFields;
    }

}