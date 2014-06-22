package ng;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
extern class NgBindOnce 
{

    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/js/bower_components/angular-bindonce/bindonce.min.js");
        #end
		//add "pasvaz.bindonce" to global module dependencies
		if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
		window.hxdeps.push("pasvaz.bindonce");
    }
}

//directives need this dependency
/**
 * AngularJs provides a great data binding system but if you abuse of it the page can run into some performance issues, 
 * it's known that more of 2000 watchers can lag the UI and that amount can be reached easily 
 * if you don't pay attention to the data-binding. Sometime you really need to bind your data using watchers, 
 * especially for SPA because the data are updated in real time, but often you can avoid it with some efforts, 
 * most of the data presented in your page, once rendered, are immutable so you shouldn't keep watching them for changes.
 * 
## Attribute Usage
| Directive  | 	Description | 	Example  |
|------------|----------------|-----|
| `bindonce="{somedata}"`| **bindonce** is the main directive. `{somedata}` is optional, and if present, forces bindonce to wait until `somedata` is defined before rendering its children  | `<div bindonce="Person">...<div>` |
| `bo-if = "condition"`     | equivalent to `ng-if` but doesn't use watchers |`<ANY bo-if="Person.isPublic"></ANY>`|
| `bo-switch = "expression"`     | equivalent to `ng-switch` but doesn't use watchers |`<div bo-switch="Person.isPublic">` `<span bo-switch-when="'yes">public</span>` `<span bo-switch-default>private</span>` `</div>`|
| `bo-show = "condition"`     | equivalent to `ng-show` but doesn't use watchers |`<ANY bo-show="Person.isPublic"></ANY>`|
| `bo-hide = "condition"`     | equivalent to `ng-hide` but doesn't use watchers |`<ANY bo-hide="Person.isPrivate"></ANY>`|
| `bo-text = "text"`      | evaluates "text" and print it as text inside the element | `<span bo-text="Person.name"></span>` |
| `bo-bind = "text"`      | alias for `bo-text`, equivalent to `ng-bind` but doesn't use watchers | `<span bo-bind="Person.name"></span>` |
| `bo-html = "markup"`      | evaluates "markup" and render it as html inside the element |`bo-html="Person.description"`|
| `bo-href-i = "url"`<br>*use `bo-href` instead* | **equivalent** to `ng-href`.<br>**Heads up!** Using interpolation `{{}}` it creates one watcher: <br>`bo-href-i="/p/{{Person.id}}"`. <br>Use `bo-href` to avoid the watcher:<br> `bo-href="'/p/' + Person.id"` |`<a bo-href-i="/profile{{Person.id}}"></a>`|
| `bo-href = "url"`      | **similar** to `ng-href` but doesn't allow interpolation using `{{}}` like `ng-href`. <br>**Heads up!** You can't use interpolation `{{}}` inside the url, use bo-href-i for that purpose |`<a bo-href="'/profile' + Person.id"></a>` <br />or<br /> `<a bo-href="link" bo-text="Link"></a>`|
| `bo-src-i = "url"`<br>*use `bo-src` instead* | **equivalent** to `ng-src`. <br>**Heads up!** It creates one watcher |`<img bo-src-i="{{picture}}" bo-alt="title">`|
| `bo-src = "url"`      | **similar** to `ng-src` but doesn't allow interpolation using `{{}}` like `ng-src`. <br>**Heads up!** You can't use interpolation `{{}}`, use bo-src-i for that purpose |`<img bo-src="picture" bo-alt="title">`|
| `bo-class = "object/string"`      | equivalent to `ng-class` but doesn't use watchers |`<span bo-class="{'fancy':Person.condition}">`|
| `bo-alt = "text"`      | evaluates "text" and render it as `alt` for the element |`<ANY bo-alt="title">`|
| `bo-title = "text"`      | evaluates "text" and render it as `title` for the element |`<ANY bo-title="title">`|
| `bo-id = "#id"`      | evaluates "#id" and render it as `id` for the element |`<ANY bo-id="id">`|
| `bo-style = "object"`      | equivalent to `ng-style` but doesn't use watchers |`<ANY bo-style="{'color':Person.color}">`|
| `bo-value = "expression"`      | evaluates "expression" and render it as `value` for the element |`<input type="radio" bo-value="value">`|
| `bo-attr bo-attr-foo = "text"`      | evaluates "text" and render it as a custom attribute for the element |`<div bo-attr bo-attr-foo="bar"></div>`|
*/
