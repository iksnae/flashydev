package events{

import flash.events.Event;

public class DistanceNotchEvent extends Event{

	public var numNotches:int;
	public var directionNegativeX:Boolean;
	public var directionNegativeY:Boolean;
	public var pixelDistance:int;
	public var startingX:Number;
	public var startingY:Number;
	public var directionChangedX:Boolean = false;
	public var directionChangedY:Boolean = false;

	public static var NOTCH_CHANGED:String = "notchChanged";
	public static var NOTCH_CHANGED_X:String = "notchChangedX";
	public static var NOTCH_CHANGED_Y:String = "notchChangedY";


	public function DistanceNotchEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,
										theNumNotches:int = 0, directionNegativeX:Boolean = false,
										directionNegativeY:Boolean = false, thePixelDistance:int = 0,
										theStartingX:Number = 0, theStartingY:Number = 0, theDirectionChangedX:Boolean = false,
										theDirectionChangedY:Boolean = false){
		super(type, bubbles, cancelable);

		//trace("DistanceNotchEvent class instantiated");

		//set the variables
		this.numNotches = theNumNotches;
		this.directionNegativeX = directionNegativeX;
		this.directionNegativeY = directionNegativeY;
		this.pixelDistance = thePixelDistance;
		this.startingX = theStartingX;
		this.startingY = theStartingY;
		this.directionChangedX = theDirectionChangedX;
		this.directionChangedY = theDirectionChangedY;
		}


	//Every custom Event class must override clone methods of the superclass
	public override function clone():Event{
		return	new DistanceNotchEvent(type, bubbles, cancelable, this.numNotches,
										this.directionNegativeX, this.directionNegativeY,
										this.pixelDistance, this.startingX, this.startingY,
										this.directionChangedX, this.directionChangedY);
		}


	//Every custom Event class must override toString methods of the superclass
	public override function toString():String{
		return	formatToString("DistanceNotchEvent", "type", "bubbles", "cancelable", "eventPhase",
								"numNotches", "directionNegativeX", "directionNegativeY", "pixelDistance",
								"startingX", "startingY", "directionChangedX", "directionChangedY");
	}


}
}