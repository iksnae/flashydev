/**
 * @author andrehines
 */
package utils.Mouse{

import flash.events.*;
import events.*;


public class DistanceNotch extends EventDispatcher{

	//identify the symbol name that this class is bound to
	static var symbolName : String = "DistanceNotch";
	//identify the fully qualified package name of the symbol owner
	static var symbolOwner : Object = DistanceNotch;
	//provide the className variable
	var className : String = "DistanceNotch";

	private var __measuring:Boolean = false;
	private var __startingX:int;
	private var __startingY:int;
	private var __pixelIncrements:uint = 18;
	private var __numNotches:int = 0;
	private var __numNotchesX:int = 0;
	private var __numNotchesY:int = 0;
	private var __directionNegativeX:Boolean = false;
	private var __directionNegativeY:Boolean = false;

	public static var CONTINUE_MEASURING:String = "continueMeasuring";


	function DistanceNotch(pixelIncrements:uint):void{
		trace("DistanceNotch class instantiated");

		this.__pixelIncrements = pixelIncrements;
	}


	//begins the process of measuring from the passed in coordinate integers
	public function startMeasuring(theMouseX:int, theMouseY:int):void{
		//trace("startMeasuring function called on: " + this.className);



		//if we are already measuring, we do not allow this function to continue.
		//instead we call the continueMeasuring function
		if(this.__measuring){
			continueMeasuring(theMouseX, theMouseY);
			return;
		}

		//next we set the measuring boolean to true, so that we know not to allow
		//any new calls to startMeasuring
		this.__measuring = true;

		//set the coordinates for other functions to be able to acces
		this.__startingX = theMouseX;
		this.__startingY = theMouseY;
		
		continueMeasuring(theMouseX, theMouseY);
	}


	//stops the process of measuring and resets all values
	public function stopMeasuring():void{
		trace("stopMeasuring function called on: " + this.className);

		//set the measuring boolean to reflect that we are not measuring anymore
		this.__measuring = false;

		//reset the coordinates
		this.__startingX = undefined;
		this.__startingY = undefined;

		//reset number of notches
		this.__numNotches = 0;
		this.__numNotchesX = 0;
		this.__numNotchesY = 0;
	}


	//continues measuring and dispatches an event everytime a pixel imcrement has been reached
	public function continueMeasuring(theMouseX:int, theMouseY:int):void{
		//trace("continueMeasuring function called on: " + this.className);

		//determine the coordinates, along with if they are negative or positive
		var xDistance:int = theMouseX - this.__startingX;
		var yDistance:int = theMouseY - this.__startingY;

		//lets figure out the distance, in pixels, from the two points
		var pixelDistance:int = Math.round(Math.sqrt(xDistance * xDistance + yDistance * yDistance));
		trace("pixelDistance: " + pixelDistance);

		//lets figure out the number of notches to move based on the pixel increments
		var numNotchesX:int = Math.round(xDistance / this.__pixelIncrements);
		var numNotchesY:int = Math.round(yDistance / this.__pixelIncrements);
		var numNotches:int = Math.round(pixelDistance / this.__pixelIncrements);

		//trace("numNotchesY: " + numNotchesY);
		//trace("this.__numNotchesY: " + this.__numNotchesY);

		//call function to broadcast all the info that we need to, if the notch count has changed
		var directionNegative:Boolean = false;
		var directionChanged:Boolean = false;

		if(this.__numNotches != numNotches){
			//now update the __numNotches to the new count
			this.__numNotches = numNotches;
			onNotchChanged(numNotches, false, false, pixelDistance, false, false);
		}

		//call function to broadcast all the info that we need to, if the x notch count has changed
		if(this.__numNotchesX != numNotchesX){
			if(this.__numNotchesX < numNotchesX){
				directionNegative = true;
			}else{
				directionNegative = false;
			}

			//now update the __numNotches to the new count
			this.__numNotchesX = numNotchesX;
			
			//also check to see is we have a direction change in the X
			if(directionNegative != this.__directionNegativeX){
				directionChanged = true;
				this.__directionNegativeX = !this.__directionNegativeX;
			}else{
				directionChanged = false;
			}

			onNotchChangedX(numNotchesX, directionNegative, directionNegative, pixelDistance, directionChanged, false);
			}

		//call function to broadcast all the info that we need to, if the y notch count has changed
		if(this.__numNotchesY != numNotchesY){
			if(this.__numNotchesY < numNotchesY){
				directionNegative = true;
			}else{
				directionNegative = false;
			}

			//now update the __numNotches to the new count
			this.__numNotchesY = numNotchesY;
			
			//also check to see is we have a direction change in the Y
			if(directionNegative != this.__directionNegativeY){
				directionChanged = true;
				this.__directionNegativeY = !this.__directionNegativeY;
			}else{
				directionChanged = false;
			}

			onNotchChangedY(numNotchesY, directionNegative, directionNegative, pixelDistance, false, directionChanged);
		}
	}


	//EVENT broadcasts that a notch has changed
	public function onNotchChanged(theNumNotches:int, directionNegativeX:Boolean, directionNegativeY:Boolean, thePixelDistance:int, theDirectionChangedX:Boolean, theDirectionChangedY:Boolean):void{
		//trace("broadcasting onContinueMeasuring event on: " + this.className);

		dispatchEvent(new DistanceNotchEvent(DistanceNotchEvent.NOTCH_CHANGED, true, false, theNumNotches, directionNegativeX, directionNegativeY, thePixelDistance, this.__startingX, this.__startingY, theDirectionChangedX, theDirectionChangedY));
	}

	//EVENT broadcasts that a notch has changed
	public function onNotchChangedX(theNumNotches:int, directionNegativeX:Boolean, directionNegativeY:Boolean, thePixelDistance:int, theDirectionChangedX:Boolean, theDirectionChangedY:Boolean):void{
		//trace("broadcasting onContinueMeasuring event on: " + this.className);

		dispatchEvent(new DistanceNotchEvent(DistanceNotchEvent.NOTCH_CHANGED_X, true, false, theNumNotches, directionNegativeX, directionNegativeY, thePixelDistance, this.__startingX, this.__startingY, theDirectionChangedX, theDirectionChangedY));
	}

	//EVENT broadcasts that a notch has changed
	public function onNotchChangedY(theNumNotches:int, directionNegativeX:Boolean, directionNegativeY:Boolean, thePixelDistance:int, theDirectionChangedX:Boolean, theDirectionChangedY:Boolean):void{
		//trace("broadcasting onContinueMeasuring event on: " + this.className);

		dispatchEvent(new DistanceNotchEvent(DistanceNotchEvent.NOTCH_CHANGED_Y, true, false, theNumNotches, directionNegativeX, directionNegativeY, thePixelDistance, this.__startingX, this.__startingY, theDirectionChangedX, theDirectionChangedY));
	}



//////////////////////////////////////////getters and setters ////////////////////////////////

	public function get measuring():Boolean{
		return this.__measuring;
	}

}//end class
}/////////end package