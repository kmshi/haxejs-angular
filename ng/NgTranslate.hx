package ng;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
//@:native("$translate")
extern class NgTranslate
{
    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/bower_components/angular-translate/angular-translate.min.js");
          haxe.macro.Compiler.includeFile("www/bower_components/angular-translate-loader-url/angular-translate-loader-url.min.js");
          haxe.macro.Compiler.includeFile("www/bower_components/angular-translate-loader-static-files/angular-translate-loader-static-files.min.js");
        #else
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate/angular-translate.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate/angular-translate.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate-loader-url/angular-translate-loader-url.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate-loader-url/angular-translate-loader-url.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate-loader-static-files/angular-translate-loader-static-files.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate-loader-static-files/angular-translate-loader-static-files.js");
        #end
        //add "pascalprecht.translate" to global module dependencies
        if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
        window.hxdeps.push("pascalprecht.translate");
    } 

    @:overload(function(langKey:String):Void{})
    public function use():String;
    public function preferredLanguage():String;
    public function cloakClassName():String;
    @:overload(function(langKey:String):Void{})
    public function useFallbackLanguage():String;
    public function refresh(langKey:String):Void;
}

//@:native("$translateProvider")
extern class NgTranslateProvider
{
    public function translations(langKey:String, translationTable:{}):NgTranslateProvider;
    public function cloakClassName(name:String):NgTranslateProvider;
    public function addInterpolation(factory:Dynamic):NgTranslateProvider;
    @:overload(function(langKey:String):NgTranslateProvider{})
    public function preferredLanguage():String;
    public function fallbackLanguage(langKey:String):NgTranslateProvider;
    @:overload(function(langKey:String):NgTranslateProvider{})
    public function use():String;
    public function useUrlLoader(url:String):NgTranslateProvider;
    public function useStaticFilesLoader(options:{prefix:String,suffix:String}):NgTranslateProvider;
    public function useLocalStorage():NgTranslateProvider;
    public function useCookieStorage():NgTranslateProvider;
    public function registerAvailableLanguageKeys(languageKeys:Array<String>, ?aliases:{}):NgTranslateProvider;
    public function determinePreferredLanguage(?fn:Dynamic):NgTranslateProvider;
}

//directives need this dependency