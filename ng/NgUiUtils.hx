package ng;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
extern class NgUiUtils
{

    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/bower_components/angular-ui-utils/ui-utils.min.js");
        #else
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-ui-utils/ui-utils.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/angular-ui-utils/ui-utils.js");
        #end
		//add "ui.utils" to global module dependencies
		if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
		window.hxdeps.push("ui.utils");
    }
}

//directives need this dependency
/**
 * uiEvent
 * General-purpose Event binding. Bind any event not natively supported by Angular
 * Pass an object with keynames for events to ui-event
 * Allows $event object and $params object to be passed
 *
 * @example <input ui-event="{ focus : 'counter++', blur : 'someCallback()' }">
 * @example <input ui-event="{ myCustomEvent : 'myEventHandler($event, $params)'}">
 *
 * @param ui-event {string|object literal} The event to bind to as a string or a hash of events with their callbacks
 * 
 * uiInclude???
 * 
 * uiIndeterminate
 * Provides an easy way to toggle a checkboxes indeterminate property
 *
 * @example <input type="checkbox" ui-indeterminate="isUnkown">
 * 
 * uiJq
 * General-purpose jQuery wrapper. Simply pass the plugin name as the expression.
 * It is possible to specify a default set of parameters for each jQuery plugin.
 * Under the jq key, namespace each plugin by that which will be passed to ui-jq.
 * Unfortunately, at this time you can only pre-define the first parameter.
 * @example { jq : { datepicker : { showOn:'click' } } }
 * @param ui-jq {string} The $elm.[pluginName]() to call.
 * @param [ui-options] {mixed} Expression to be evaluated and passed as options to the function
 *     Multiple parameters can be separated by commas
 * @param [ui-refresh] {expression} Watch expression and refire plugin on changes
 * @example <input ui-jq="datepicker" ui-options="{showOn:'click'},secondParameter,thirdParameter" ui-refresh="iChange">
 * 
 * uiKeydown,uiKeypress,uiKeyup
 * Bind one or more handlers to particular keys or their combination
 * @param hash {mixed} keyBindings Can be an object or string where keybinding expression of keys or keys combinations and AngularJS Exspressions are set. 
 * Object syntax: "{ keys1: expression1 [, keys2: expression2 [ , ... ]]}". String syntax: ""expression1 on keys1 [ and expression2 on keys2 [ and ... ]]"". 
 * Expression is an AngularJS Expression, and key(s) are dash-separated combinations of keys and modifiers (one or many, if any. Order does not matter). 
 * Supported modifiers are 'ctrl', 'shift', 'alt' and key can be used either via its keyCode (13 for Return) or name. 
 * Named keys are 'backspace', 'tab', 'enter', 'esc', 'space', 'pageup', 'pagedown', 'end', 'home', 'left', 'up', 'right', 'down', 'insert', 'delete'.
 * @example <input ui-keypress="{enter:'x = 1', 'ctrl-shift-space':'foo()', 'shift-13':'bar()'}" /> <input ui-keypress="foo = 2 on ctrl-13 and bar('hello') on shift-esc" />
 * 
 * uiMask???
 * Attaches input mask onto input element
 * 
 * uiReset???
 * Add a clear button to form inputs to reset their value
 * 
 * uiRoute???
 * 
 * ngScrollViewport???
 * 
 * ngScroll???
 * 
 * uiScrollfix
 * Adds a 'ui-scrollfix' class to the element when the page scrolls past it's position.
 * @param [offset] {int} optional Y-offset to override the detected offset.
 *   Takes 300 (absolute) or -300 or +300 (relative to detected)
 * 
 * uiShow,uiHide,uiToggle
 * Adds a 'ui-show/ui-hide' class to the element instead of display:block
 * Created to allow tighter control  of CSS without bulkier directives
 *
 * @param expression {boolean} evaluated expression to determine if the class should be added
 * 
 * uiValidate
 * General-purpose validator for ngModel.
 * angular.js comes with several built-in validation mechanism for input fields (ngRequired, ngPattern etc.) but using
 * an arbitrary validation function requires creation of a custom formatters and / or parsers.
 * The ui-validate directive makes it easy to use any function(s) defined in scope as a validator function(s).
 * A validator function will trigger validation on both model and input changes.
 *
 * @example <input ui-validate=" 'myValidatorFunction($value)' ">
 * @example <input ui-validate="{ foo : '$value > anotherModel', bar : 'validateFoo($value)' }">
 * @example <input ui-validate="{ foo : '$value > anotherModel' }" ui-validate-watch=" 'anotherModel' ">
 * @example <input ui-validate="{ foo : '$value > anotherModel', bar : 'validateFoo($value)' }" ui-validate-watch=" { foo : 'anotherModel' } ">
 *
 * @param ui-validate {string|object literal} If strings is passed it should be a scope's function to be used as a validator.
 * If an object literal is passed a key denotes a validation error key while a value should be a validator function.
 * In both cases validator function should take a value to validate as its argument and should return true/false indicating a validation result.
 */

//filters
/**
 * format(value, replace)
 * A replacement utility for internationalization very similar to sprintf.
 *
 * @param replace {mixed} The tokens to replace depends on type
 *  string: all instances of $0 will be replaced
 *  array: each instance of $0, $1, $2 etc. will be placed with each array item in corresponding order
 *  object: all attributes will be iterated through, with :key being replaced with its corresponding value
 * @return string
 *
 * @example: 'Hello :name, how are you :day'.format({ name:'John', day:'Today' })
 * @example: 'Records $0 to $1 out of $2 total'.format(['10', '20', '3000'])
 * @example: '$0 agrees to all mentions $0 makes in the event that $0 hits a tree while $0 is driving drunk'.format('Bob')
 * 
 * highlight(text, search, caseSensitive)
 * Wraps the results by 'ui-match' class
 * @param text {string} haystack to search through
 * @param search {string} needle to search for
 * @param [caseSensitive] {boolean} optional boolean to use case-sensitive searching
 * 
 * inflector(text, inflector)
 * Converts variable-esque naming conventions to something presentational, capitalized words separated by space.
 * @param {String} value The value to be parsed and prettified.
 * @param {String} [inflector] The inflector to use. Default: humanize.
 * @return {String}
 * @example {{ 'Here Is my_phoneNumber' | inflector:'humanize' }} => Here Is My Phone Number
 *          {{ 'Here Is my_phoneNumber' | inflector:'underscore' }} => here_is_my_phone_number
 *          {{ 'Here Is my_phoneNumber' | inflector:'variable' }} => hereIsMyPhoneNumber
 * 
 * unique(items, filterOn)
 * Filters out all duplicate items from an array by checking the specified key
 * @param [key] {string} the name of the attribute of each object to compare for uniqueness
 * *if the key is empty, the entire object will be compared
 * *if the key === false then no filtering will be performed
 * @return {array}
*/