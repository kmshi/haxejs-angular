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
          haxe.macro.Compiler.includeFile("www/bower_components/angular-translate-storage-cookie/angular-translate-storage-cookie.min.js");
          haxe.macro.Compiler.includeFile("www/bower_components/angular-translate-storage-local/angular-translate-storage-local.min.js");
          haxe.macro.Compiler.includeFile("www/bower_components/angular-translate-handler-log/angular-translate-handler-log.min.js");
        #else
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate/angular-translate.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate/angular-translate.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate-loader-url/angular-translate-loader-url.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate-loader-url/angular-translate-loader-url.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate-loader-static-files/angular-translate-loader-static-files.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate-loader-static-files/angular-translate-loader-static-files.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate-storage-cookie/angular-translate-storage-cookie.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate-storage-cookie/angular-translate-storage-cookie.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate-storage-local/angular-translate-storage-local.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate-storage-local/angular-translate-storage-local.js");                    
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate-handler-log/angular-translate-handler-log.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-translate-handler-log/angular-translate-handler-log.js");

          ng.macro.InjectionBuilder.moduleDependency("angular-translate-handler-log","bower_components/angular-translate-handler-log/angular-translate-handler-log",["angular-translate"]);
          ng.macro.InjectionBuilder.moduleDependency("angular-translate-storage-local","bower_components/angular-translate-storage-local/angular-translate-storage-local",["angular-translate"]);
          ng.macro.InjectionBuilder.moduleDependency("angular-translate-storage-cookie","bower_components/angular-translate-storage-cookie/angular-translate-storage-cookie",["angular-translate"]);
          ng.macro.InjectionBuilder.moduleDependency("angular-translate-loader-static-files","bower_components/angular-translate-loader-static-files/angular-translate-loader-static-files",["angular-translate"]);
          ng.macro.InjectionBuilder.moduleDependency("angular-translate-loader-url","bower_components/angular-translate-loader-url/angular-translate-loader-url",["angular-translate"]);
          ng.macro.InjectionBuilder.moduleDependency("angular-translate","bower_components/angular-translate/angular-translate",["angular"]);
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

    @:overload(function(langKey:String):NgTranslateProvider{})
    public function preferredLanguage():String;

    @:overload(function(langKeys:Array<String>):NgTranslateProvider{})
    public function fallbackLanguage(langKey:String):NgTranslateProvider;

    //@:overload(function(langKey:String):NgTranslateProvider{})
    //public function use():String;

    /**
    * url which expects a `lang` parameter to return a JSON: url?lang=en
    */
    public function useUrlLoader(url:String):NgTranslateProvider;
    /**
    * angular-translate will concatenate the given information to `{{prefix}}{{langKey}}{{suffix}}`.
    */    
    public function useStaticFilesLoader(options:{prefix:String,suffix:String}):NgTranslateProvider;
    public function useLocalStorage():NgTranslateProvider;
    public function useCookieStorage():NgTranslateProvider;
    public function useMissingTranslationHandlerLog():NgTranslateProvider;
    public function registerAvailableLanguageKeys(languageKeys:Array<String>, ?aliases:{}):NgTranslateProvider;
    public function determinePreferredLanguage(?fn:Dynamic):NgTranslateProvider;
    public function useLoader(loaderFactoryName:String, ?options:{}):NgTranslateProvider;
    public function useStorage(storageFactoryName:String):NgTranslateProvider;
    public function useMissingTranslationHandler(factoryName:String):NgTranslateProvider;
    public function useInterpolation(factoryName:String):NgTranslateProvider;
    public function addInterpolation(factoryName:String):NgTranslateProvider;    
}

//directives need this dependency