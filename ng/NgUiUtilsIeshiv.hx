package ng;

/**
 * ...
 * @author Richard Shi
 */

// READ: http://docs-next.angularjs.org/guide/ie
// element tags are statically defined in order to accommodate lazy-loading whereby directives are also unknown

// The ieshiv takes care of our ui.directives and AngularJS's ng-view, ng-include, ng-pluralize, ng-switch.
// However, IF you have custom directives that can be used as html tags (yours or someone else's) then
// add list of directives into <code>window.myCustomTags</code>

// <!--[if lte IE 8]>
//    <script>
//    window.myCustomTags = [ 'yourCustomDirective', 'somebodyElsesDirective' ]; // optional
//    </script>
//    <script src="build/angular-ui-ieshiv.js"></script>
// <![endif]-->

@:initPackage
extern class NgUiUtilsIeshiv
{

    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/bower_components/angular-ui-utils/ui-utils-ieshiv.min.js");
        #else
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-ui-utils/ui-utils-ieshiv.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-ui-utils/ui-utils-ieshiv.js");
        #end
    }
}
