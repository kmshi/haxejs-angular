package ng;

//import js.html.Node;
//import js.html.Text;
import js.html.Element;
//import js.html.Document;

@:initPackage
@:native("Strophe")
extern class Strophe{
    private static function __init__() : Void untyped {
        #if embed_js
          haxe.macro.Compiler.includeFile("www/bower_components/strophe/strophe.min.js");
        #else
          ng.macro.InjectionBuilder.copyFile("www/bower_components/strophe/strophe.min.js");
          ng.macro.InjectionBuilder.copyFile("www/bower_components/strophe/strophe.js");
          ng.macro.InjectionBuilder.moduleDependency("strophe","bower_components/strophe/strophe");
        #end
    }

    public static var VERSION:String;
    public static var NS:{
    	HTTPBIND: String,
        BOSH: String,
        CLIENT: String,
        AUTH: String,
        ROSTER: String,
        PROFILE: String,
        DISCO_INFO: String,
        DISCO_ITEMS: String,
        MUC: String,
        SASL: String,
        STREAM: String,
        BIND: String,
        SESSION: String,
        VERSION: String,
        STANZAS: String,
        XHTML_IM: String,
        XHTML: String
    };
    public static var Status: {
        ERROR: Int,
        CONNECTING: Int,
        CONNFAIL: Int,
        AUTHENTICATING: Int,
        AUTHFAIL: Int,
        CONNECTED: Int,
        DISCONNECTED: Int,
        DISCONNECTING: Int,
        ATTACHED: Int
    };

    public static function addNamespace(name:String, value:String):Void;
    public static function forEachChild(elem:Element, elemName:String, func:Dynamic):Void;
    public static function isTagEqual(el:Element, name:String):Bool;
    public static function xmlElement(name:String):Element;
    public static function xmlescape(text:String):String;
    public static function xmlTextNode(text:String):Element;//or Text?
    public static function xmlHtmlNode(html:String):Element;
    public static function getText(elem:Element):String;
    public static function copyElement(elem:Element):Element;
    public static function createHtml(elem:Element):Element;
    public static function escapeNode(node:String):String;
    public static function unescapeNode(node:String):String;
    public static function getNodeFromJid(jid:String):String;
    public static function getDomainFromJid(jid:String):String;
    public static function getResourceFromJid(jid:String):String;
    public static function getBareJidFromJid(jid:String):String;
    public static function serialize(elem:Element):String;
    public static function addConnectionPlugin(name:String, ptype:Dynamic):Void;
}

class StropheHelper{
    public static function build(name:String, attrs:{}):StropheBuilder{
    	return untyped __js__("$build(name,attrs)");
    }

    public static function msg(attrs:{}):StropheBuilder{
    	return untyped __js__("$msg(attrs)");
    }

    public static function iq(attrs:{}):StropheBuilder{
    	return untyped __js__("$iq(attrs)");
    }

    public static function pres(?attrs:{}):StropheBuilder{
    	return untyped __js__("$pres(attrs)");
    }
	/** 
	 *  Create and initialize a Strophe.Connection object.
	 *
	 *  The transport-protocol for this connection will be chosen automatically
	 *  based on the given service parameter. URLs starting with "ws://" or
	 *  "wss://" will use WebSockets, URLs starting with "http://", "https://"
	 *  or without a protocol will use BOSH.
	 *
	 *  To make Strophe connect to the current host you can leave out the protocol
	 *  and host part and just pass the path, e.g.
	 *
	 *  > var conn = new Strophe.Connection("/http-bind/");
	 *
	 *  WebSocket options:
	 *
	 *  If you want to connect to the current host with a WebSocket connection you
	 *  can tell Strophe to use WebSockets through a "protocol" attribute in the
	 *  optional options parameter. Valid values are "ws" for WebSocket and "wss"
	 *  for Secure WebSocket.
	 *  So to connect to "wss://CURRENT_HOSTNAME/xmpp-websocket" you would call
	 *
	 *  > var conn = new Strophe.Connection("/xmpp-websocket/", {protocol: "wss"});
	 *
	 *  Note that relative URLs _NOT_ starting with a "/" will also include the path
	 *  of the current site.
	 *
	 *  Also because downgrading security is not permitted by browsers, when using
	 *  relative URLs both BOSH and WebSocket connections will use their secure
	 *  variants if the current connection to the site is also secure (https).
	 *
	 *  BOSH options:
	 *
	 *  by adding "sync" to the options, you can control if requests will
	 *  be made synchronously or not. The default behaviour is asynchronous.
	 *  If you want to make requests synchronous, make "sync" evaluate to true:
	 *  > var conn = new Strophe.Connection("/http-bind/", {sync: true});
	 *  You can also toggle this on an already established connection:
	 *  > conn.options.sync = true;
	 *
	 *
	 *  Parameters:
	 *    (String) service - The BOSH or WebSocket service URL.
	 *    (Object) options - A hash of configuration options
	 *
	 *  Returns:
	 *    A new Strophe.Connection object.
	 */
    public static function connection(service:String, ?options:{}):StropheConnection{
    	return untyped __js__("new Strophe.Connection(service, options)");
    }
} 

extern class StropheBuilder{
	public function tree():Element;
	public function toString():String;
	public function up():StropheBuilder;
	public function attrs(moreattrs:Dynamic):StropheBuilder;
	public function c(name:String, ?attrs:Dynamic, ?text:String):StropheBuilder;
	public function cnode(elem:Element):StropheBuilder;//XMLElement type?
	public function t(text:String):StropheBuilder;
	public function h(html:String):StropheBuilder;
}

extern class StropheConnection{
	public var xmlInput(default,default):Dynamic;
	public var xmlOutput(default,default):Dynamic;
	public var rawInput(default,default):Dynamic;
	public var rawOutput(default,default):Dynamic;

	public function reset():Void;
	public function pause():Void;
	public function resume():Void;
	public function getUniqueId(?suffix:String):String;
    /** 
     *  Starts the connection process.
     *
     *  As the connection process proceeds, the user supplied callback will
     *  be triggered multiple times with status updates.  The callback
     *  should take two arguments - the status code and the error condition.
     *
     *  The status code will be one of the values in the Strophe.Status
     *  constants.  The error condition will be one of the conditions
     *  defined in RFC 3920 or the condition 'strophe-parsererror'.
     *
     *  The Parameters _wait_, _hold_ and _route_ are optional and only relevant
     *  for BOSH connections. Please see XEP 124 for a more detailed explanation
     *  of the optional parameters.
     *
     *  Parameters:
     *    (String) jid - The user's JID.  This may be a bare JID,
     *      or a full JID.  If a node is not supplied, SASL ANONYMOUS
     *      authentication will be attempted.
     *    (String) pass - The user's password.
     *    (Function) callback - The connect callback function.
     *    (Integer) wait - The optional HTTPBIND wait value.  This is the
     *      time the server will wait before returning an empty result for
     *      a request.  The default setting of 60 seconds is recommended.
     *    (Integer) hold - The optional HTTPBIND hold value.  This is the
     *      number of connections the server will hold at one time.  This
     *      should almost always be set to 1 (the default).
     *    (String) route - The optional route value.
     */	
	public function connect(jid:String, pass:String, callback:Dynamic, ?wait:Int, ?hold:Int, ?route:String):Void;
    /**
     *  Attach to an already created and authenticated BOSH session.
     *
     *  This function is provided to allow Strophe to attach to BOSH
     *  sessions which have been created externally, perhaps by a Web
     *  application.  This is often used to support auto-login type features
     *  without putting user credentials into the page.
     *
     *  Parameters:
     *    (String) jid - The full JID that is bound by the session.
     *    (String) sid - The SID of the BOSH session.
     *    (String) rid - The current RID of the BOSH session.  This RID
     *      will be used by the next request.
     *    (Function) callback The connect callback function.
     *    (Integer) wait - The optional HTTPBIND wait value.  This is the
     *      time the server will wait before returning an empty result for
     *      a request.  The default setting of 60 seconds is recommended.
     *      Other settings will require tweaks to the Strophe.TIMEOUT value.
     *    (Integer) hold - The optional HTTPBIND hold value.  This is the
     *      number of connections the server will hold at one time.  This
     *      should almost always be set to 1 (the default).
     *    (Integer) wind - The optional HTTBIND window value.  This is the
     *      allowed range of request ids that are valid.  The default is 5.
     */	
	public function attach(jid:String, sid:String, rid:String, callback:Dynamic, ?wait:Int, ?hold:Int, ?wind:Int):Void;
    /**
     *  Send a stanza.
     *
     *  This function is called to push data onto the send queue to
     *  go out over the wire.  Whenever a request is sent to the BOSH
     *  server, all pending data is sent and the queue is flushed.
     *
     *  Parameters:
     *    (XMLElement |
     *     [XMLElement] |
     *     Strophe.Builder) elem - The stanza to send.
     */	
    @:overload(function(elem:StropheBuilder):Void{})
	public function send(elem:Element):Void;
	public function flush():Void;
    /** 
     *  Helper function to send IQ stanzas.
     *
     *  Parameters:
     *    (XMLElement) elem - The stanza to send.
     *    (Function) callback - The callback function for a successful request.
     *    (Function) errback - The callback function for a failed or timed
     *      out request.  On timeout, the stanza will be null.
     *    (Integer) timeout - The time specified in milliseconds for a
     *      timeout to occur.
     *
     *  Returns:
     *    The id used to send the IQ.
    */
    @:overload(function(elem:StropheBuilder, callback:Dynamic, errback:Dynamic, ?timeout:Int):String{})	
	public function sendIQ(elem:Element, callback:Dynamic, errback:Dynamic, ?timeout:Int):String;
    /** 
     *  Add a timed handler to the connection.
     *
     *  This function adds a timed handler.  The provided handler will
     *  be called every period milliseconds until it returns false,
     *  the connection is terminated, or the handler is removed.  Handlers
     *  that wish to continue being invoked should return true.
     *
     *  Because of method binding it is necessary to save the result of
     *  this function if you wish to remove a handler with
     *  deleteTimedHandler().
     *
     *  Note that user handlers are not active until authentication is
     *  successful.
     *
     *  Parameters:
     *    (Integer) period - The period of the handler.
     *    (Function) handler - The callback function.
     *
     *  Returns:
     *    A reference to the handler that can be used to remove it.
     */	
	public function addTimedHandler(period:Int, handler:Dynamic):Dynamic;
	public function deleteTimedHandler(handRef:Dynamic):Void;
    /** 
     *  Add a stanza handler for the connection.
     *
     *  This function adds a stanza handler to the connection.  The
     *  handler callback will be called for any stanza that matches
     *  the parameters.  Note that if multiple parameters are supplied,
     *  they must all match for the handler to be invoked.
     *
     *  The handler will receive the stanza that triggered it as its argument.
     *  The handler should return true if it is to be invoked again;
     *  returning false will remove the handler after it returns.
     *
     *  As a convenience, the ns parameters applies to the top level element
     *  and also any of its immediate children.  This is primarily to make
     *  matching /iq/query elements easy.
     *
     *  The options argument contains handler matching flags that affect how
     *  matches are determined. Currently the only flag is matchBare (a
     *  boolean). When matchBare is true, the from parameter and the from
     *  attribute on the stanza will be matched as bare JIDs instead of
     *  full JIDs. To use this, pass {matchBare: true} as the value of
     *  options. The default value for matchBare is false.
     *
     *  The return value should be saved if you wish to remove the handler
     *  with deleteHandler().
     *
     *  Parameters:
     *    (Function) handler - The user callback.
     *    (String) ns - The namespace to match.
     *    (String) name - The stanza name to match.
     *    (String) type - The stanza type attribute to match.
     *    (String) id - The stanza id attribute to match.
     *    (String) from - The stanza from attribute to match.
     *    (String) options - The handler options
     *
     *  Returns:
     *    A reference to the handler that can be used to remove it.
     */	
	public function addHandler(handler:Dynamic, ns:String, name:String, type:String, ?id:String, ?from:String, ?options:{}):Dynamic;
	public function deleteHandler(handRef:Dynamic):Void;
    /** 
     *  Start the graceful disconnection process.
     *
     *  This function starts the disconnection process.  This process starts
     *  by sending unavailable presence and sending BOSH body of type
     *  terminate.  A timeout handler makes sure that disconnection happens
     *  even if the BOSH server does not respond.
     *
     *  The user supplied connection callback will be notified of the
     *  progress as this process happens.
     *
     *  Parameters:
     *    (String) reason - The reason the disconnect is occuring.
     */	
	public function disconnect(?reason:String):Void;
    /** 
     * Set up authentication
     *
     *  Contiunues the initial connection request by setting up authentication
     *  handlers and start the authentication process.
     *
     *  SASL authentication will be attempted if available, otherwise
     *  the code will fall back to legacy authentication.
     *
     */	
	//public function authenticate(matched):Void;
}