package events {	import flash.events.Event;/** * @author andrehines */public class XMLEvent extends Event{		public var packagedInfo:Array;		public static var PACKAGED_INFO:String = "packagedInfo";		function XMLEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, thePackagedInfo:Array = null){		trace("XMLEvent class instantiated");				super(type, bubbles, cancelable);				//set the variables		this.packagedInfo = thePackagedInfo;	}		//Every custom Event class must override clone methods of the superclass	public override function clone():Event{		return	new XMLEvent(type, bubbles, cancelable, this.packagedInfo);	}	//Every custom Event class must override toString methods of the superclass	public override function toString():String{		return	formatToString("XMLEvent", "type", "bubbles", "cancelable", "eventPhase",								"packagedInfo");	}}}