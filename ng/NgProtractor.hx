package ng;

/**
 * ...
 * @author Richard Shi
 */
//@:initPackage
@:native("browser")
extern class NgProtractor 
{
    public static var baseUrl(default,null):String;
    public static var rootEl(default,null):String;
    public static var params(default,null):Dynamic;
    public static function waitForAngular():Void;
    public static function findElement(locator:LocatorDef):WebElement;
    public static function findElements(locator:LocatorDef):Array<WebElement>;
    public static function isElementPresent(locatorOrElement:Dynamic):Bool
    public static function get(destination:String, ?opt_timeout:Int):Void;
    public static function refresh(?opt_timeout:Int):Void;
    public static function navigate():Void;
    public static function setLocation(url:String):Void;
    public static function getLocationAbsUrl():String;
    public static function debugger():Void;
    public static function element(locator:LocatorDef):ElementFinder;
}

extern class ElementArrayFinder{
    public function getWebElements():Array<WebElement>;
    public function get(index:Int):ElementFinder;
    public function first():ElementFinder;
    public function last():ElementFinder;
    public function count():Int;
    public function asElementFinders_():Array<ElementFinder>;
    public function then(fn:Array<ElementFinder>->Void):Void;
    public function each(fn:ElementFinder->Int->Void):Void;
    public function map(mapFn:ElementFinder->Int->Dynamic):Array;
    public function filter(mapFn:ElementFinder->Int->Dynamic):Array;
    public function reduce(mapFn:ElementFinder->Int->Dynamic):Dynamic;
}
}

@:native("element")
extern class ElementFinder extends WebElement{
    public static function all(locator:LocatorDef):ElementArrayFinder;
    public function element(subLocator:LocatorDef):ElementFinder;
    public function isPresent():Bool;
    public function isElementPresent(subLocator:LocatorDef):Bool;
    public function getWebElement():WebElement;
    public function then(fn:Dynamic, ?errorFn:Dynamic):Void;
}

extern class WebElement{
    public function click():Void;
    public function sendKeys(val:String):Void;
    public function getTagName():String;
    public function getCssValue(key:String):String;
    public function getAttribute(key:String):String;
    public function getText():String;
    public function getSize():Dynamic;//{width: number, height: number}
    public function getLocation():Dynamic;//{x: number, y: number}
    public function isEnabled():Bool;
    public function isSelected():Bool;
    public function submit():Void;
    public function clear():Void;
    public function isDisplayed():Bool;
    public function getOuterHtml():String;
    public function getInnerHtml():String;
    public function toWireValue():String;
}

@:native("by")
extern class By{
    public static function addLocator(name:String, script:Dynamic):Array<WebElement>;
    public static function binding(bindingDescriptor:String):LocatorDef;
    public static function exactBinding(bindingDescriptor:String):LocatorDef;
    public static function model(model:String):LocatorDef;
    public static function buttonText(searchText:String):LocatorDef;
    public static function partialButtonText(searchText:String):LocatorDef;
    public static function repeater(repeatDescriptor:String):LocatorDef;
    public static function cssContainingText(cssSelector:String, searchText:String):LocatorDef;
    public static function options(optionsDescriptor:String):LocatorDef;
    public static function className(className:String):LocatorDef;
    public static function css(selector:String):LocatorDef;
    public static function id(id:String):LocatorDef;
    public static function linkText(linkText:String):LocatorDef;
    public static function js(script:Dynamic, ?args1:Dynamic, ?args2:Dynamic, ?args3:Dynamic):LocatorDef;
    public static function name(name:String):LocatorDef;
    public static function partialLinkText(partialLinkText:String):LocatorDef;
    public static function tagName(tagName:String):LocatorDef;
    public static function xpath(xpath:String):LocatorDef;
}


typedef LocatorDef = {
    function findElementsOverride(driver, usingObj):Dynamic;
    function toString():String;
    function row(index:Int):LocatorDef;
    function column(binding:String):LocatorDef;
}