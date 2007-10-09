package events {import flash.events.Event;import flash.display.InteractiveObject;	
	/** * @author andrehines */ public class LoadeeEvent extends Event{		public var targetLoadee:InteractiveObject;		public static var LOADEE_CLOSED:String = "loadeeClosed";		function LoadeeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, theLoadee:InteractiveObject = null){		trace("LoadeeEvent class instantiated");				super(type, bubbles, cancelable);				//set the variables		this.targetLoadee = theLoadee;	}		//Every custom Event class must override clone methods of the superclass	public override function clone():Event{		return	new LoadeeEvent(type, bubbles, cancelable, this.targetLoadee);	}	//Every custom Event class must override toString methods of the superclass	public override function toString():String{		return	formatToString("LoadeeEvent", "type", "bubbles", "cancelable", "eventPhase",								"targetLoadee");	}}}