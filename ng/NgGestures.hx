package ng;

/**
 * ...
 * @author Richard Shi
 */
@:initPackage
extern class NgGestures 
{

    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/js/bower_components/angular-gestures/gestures.min.js");
        #else
          ng.macro.InjectionBuilder.copyFile("www/js/bower_components/angular-gestures/gestures.min.js");
        #end
		//add "angular-gestures" to global module dependencies
		if (Angular.isUndefined(window.hxdeps))window.hxdeps = [];
		window.hxdeps.push("angular-gestures");
    }
}

//directives need this dependency
/**
* Use attributes on you containers in the same way you use `ng-click` e.g. `hm-tap="add_something()"`
* You can use angular interpolations like this : `hm-swipe="remove_something({{ id }})"`
* You can also use Hammer.js options by e.g. `hm-tap-opts="{hold: false}"`

## Supported events
* hmDoubleTap : 'doubletap',
* hmDragstart : 'dragstart',
* hmDrag : 'drag',
* hmDragUp : 'dragup',
* hmDragDown : 'dragdown',
* hmDragLeft : 'dragleft',
* hmDragRight : 'dragright',
* hmDragEnd : 'dragend',
* hmHold : 'hold',
* hmPinch : 'pinch',
* hmPinchIn : 'pinchin',
* hmPinchOut : 'pinchout',
* hmRelease : 'release',
* hmRotate : 'rotate',
* hmSwipe : 'swipe',
* hmSwipeUp : 'swipeup',
* hmSwipeDown : 'swipedown',
* hmSwipeLeft : 'swipeleft',
* hmSwipeRight : 'swiperight',
* hmTap : 'tap',
* hmTouch : 'touch',
* hmTransformstart : 'transformstart',
* hmTransform : 'transform',
* hmTransformend : 'transformend'
*/