package ReflectionGalleryAPI.Events {	import flash.events.Event;import flash.display.*;		/** * @author andrehines */public class ViewEvent extends Event{		public var targetSection:MovieClip;		public static var SECTION_CHANGED:String = "sectionChanged";	public static var NEXT_SECTION:String = "nextSection";	public static var PREV_SECTION:String = "prevSection";	public static var ZOOM_SECTION:String = "zoomSection";	public static var LINKS_READY:String = "linksReady";		function ViewEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, theTargetSection:MovieClip = null){		trace("ViewEvent class instantiated");				super(type, bubbles, cancelable);				//set the variables		this.targetSection = theTargetSection;	}		//Every custom Event class must override clone methods of the superclass	public override function clone():Event{		return	new ViewEvent(type, bubbles, cancelable, this.targetSection);	}	//Every custom Event class must override toString methods of the superclass	public override function toString():String{		return	formatToString("ViewEvent", "type", "bubbles", "cancelable", "eventPhase",								"targetSection");	}}}