import mx.events.EventDispatcher;

class com.myStuff.Broadcaster
{

    // registered objects to receive events
    private var __listeners:Array;

    static private var instance:Broadcaster;

    static public function getInstance() : Broadcaster
    {
	if ( instance == undefined )
	    instance = new Broadcaster();
	return instance;
    }

    private function Broadcaster() {
	init();
    }

    // PRIVATE
    // ________________________________________________

    private function init():Void {
	__listeners = [];
    }

    // PUBLIC
    // ________________________________________________

    // adds object to receive notification of events
    // 	evnt: name of event
    //	lstnr: object subscribing
    // 	mappedTo: name of function to call for notification
    public function addEventListener(evnt:String, lstnr:Object, mappedTo:String):Boolean {
	var ev:String;
	var li:Object;
	for (var i in __listeners) {
	    ev = __listeners[i].event;
	    li = __listeners[i].listener;
	    // add listener only if not currently subscribed
	    if (ev == evnt && li == lstnr) return false;
	}
	__listeners.push({event:evnt, listener:lstnr, mappedTo:mappedTo});
	return true;
    }

    // sends event notification to subscribed listeners
    // 	evnt: name of event
    //	params: any amount of properties to be passed to subscribers
    public function dispatchEvent(evnt:String, params:Object):Void {
	trace("Broadcaster1: dispatchEvent("+evnt+")");
	var evtObj = {type:evnt, parameters:params};
	for (var i:String in __listeners) {
	    // send notification if listener is subscribed to this event
	    if (__listeners[i].event == evnt) {
		// ** TBD: change so that only one of these functions is called
		// call method sharing event name
		__listeners[i].listener[evnt](evtObj);
		// call mappedTo function (if assigned)
		__listeners[i].listener[__listeners[i].mappedTo](evtObj);
	    }
	}
	trace ("Broadcaster2: "+ [evnt + "Handler"](evtObj));
	this[evnt + "Handler"](evtObj);
    }

    // removes object from listeners array
    // 	evnt: name of event
    //	lstnr: object subscribing
    public function removeEventListener(evnt:String, lstnr:Object):Boolean {
	var ev:String;
	var li:Object;
	for (var i = 0; i < __listeners.length; i++) {
	    ev = __listeners[i].event;
	    li = __listeners[i].listener;
	    // if listener is found, remove
	    if (ev == evnt && li == lstnr) {
		__listeners.splice(i, 1);
		return true;
	    }
	}
	return false;
    }

}
