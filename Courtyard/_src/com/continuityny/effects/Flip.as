

import com.continuityny.effects.DistortImage;

import mx.utils.Delegate;
import com.continuityny.mc.ImageLoader;
import mx.transitions.easing.*;
import mx.transitions.*;
import flash.geom.Point;
//import com.continuityny.shapes.RectangleGradient;
import flash.display.BitmapData;
import com.continuityny.timing.PauseThis;

/**
 * @author Greg
 * @author MGallay
 */
class com.continuityny.effects.Flip {
	


	private var startX:Number = 150;
	private var startY:Number = 165;
	private var mcWIDTH:Number;
	private var mcHEIGHT:Number;
	
	private var POINT_ARRAY:Array; 


	private var TARGET_MC:MovieClip;

	private var CONTAINER_MC:MovieClip; 
	private var IMG_MC:MovieClip; 
	private var BACK_MC:MovieClip; 
	private var FRONT_MC:MovieClip; 
	private var SHADOW_MC:MovieClip; 
	
	private var DISTORTION:DistortImage;
	
	private var FRONT_SRC:String; 
	private var BACK_SRC:String; 
	
	static var SPINNER_ARRAY:Array; 
	static var COUNT:Number = 0; 
	
	private var X_START_ARRAY:Array;
	private var Y_START_ARRAY:Array;
	
	private var X_CURRENT_ARRAY:Array;
	private var Y_CURRENT_ARRAY:Array;
	
	private var X_GOAL_ARRAY:Array;
	private var Y_GOAL_ARRAY:Array;
	
	private var X_GOAL2_ARRAY:Array;
	private var Y_GOAL2_ARRAY:Array;
	
	private var TWEEN:Tween; 
	private var PERSPECTIVE:Number; 
	private var SEGMENT:Number; 
	
	private var onQuarterFlipDone:Function; 
	private var onHalfFlipDone:Function; 
	
	//private var SHADOW:RectangleGradient;
	
	private var FRONT_BMP : BitmapData; 
	private var BACK_BMP : BitmapData;
	
	public var whenFlipForwardDone:Function; 
	
	public function Flip(	_mc:MovieClip, 
								source_bmp, 
								//front_src, 
								//back_src, 
								x:Number, 
								y:Number, 
								w:Number, 
								h:Number){
	
		trace("Flip: Target"+_mc+" x:"+x+" y:"+y); 
		
		TARGET_MC = _mc; 
		
		//FRONT_SRC = front_src; 
		//BACK_SRC = back_src; 
		//FRONT_BMP = new BitmapData(w, h, true, 0x00); 
		
		//BACK_BMP = new BitmapData(w, h, false, 0xFFFFFF); 
		
		//FRONT_BMP.draw(source_mc);
		
		FRONT_BMP = source_bmp;
		
		
		if(x!=undefined) startX = x; 
		if(y!=undefined) startY = y; 
		
		//if(SPINNER_ARRAY==undefined)SPINNER_ARRAY = new Array(); 
		//SPINNER_ARRAY.push(this);
		
		var DEPTH = TARGET_MC.getNextHighestDepth();
		 
		 
		// visible spinner movieclip 
		CONTAINER_MC = TARGET_MC.createEmptyMovieClip("container_"+COUNT+"_mc", DEPTH);
		
		// invisible image data 
		IMG_MC = TARGET_MC.createEmptyMovieClip("img_"+COUNT+"_mc", DEPTH+1); 
		BACK_MC = IMG_MC.createEmptyMovieClip("back_mc",IMG_MC.getNextHighestDepth());
		FRONT_MC = IMG_MC.createEmptyMovieClip("front_mc",IMG_MC.getNextHighestDepth());
		
		//SHADOW_MC = IMG_MC.attachMovie("shadow_mc", "shadow_mc", IMG_MC.getNextHighestDepth());
		SHADOW_MC = IMG_MC.createEmptyMovieClip("shadow_mc", IMG_MC.getNextHighestDepth());
		
		//BACK_MC.attachBitmap(BACK_BMP, 100, "auto", true); 
		FRONT_MC.attachBitmap(FRONT_BMP, 100, "auto", true); 
		
		//FRONT_MC._x += (200-(source_mc.getInnerDimensions()._width/2));
		//SHADOW_MC._alpha=0;
		
		IMG_MC._visible = false;
		
		
		
		/*var FRONT_LOADER = new ImageLoader(FRONT_MC, FRONT_SRC);
		var BACK_LOADER = new ImageLoader(BACK_MC, BACK_SRC);
		
		var checkLoaded = function():Boolean{
			trace("cheack loaded:"+INT+"FRONT_LOADER:"+FRONT_LOADER.loaded+" BACK_LOADER:"+BACK_LOADER.loaded);
			if(FRONT_LOADER.loaded && BACK_LOADER.loaded) return true; 	
		};
		
		var INT = setInterval(Delegate.create(this, function(){
			if(checkLoaded()){
				clearInterval(INT); 
				initDistort();
			}
		}), 10); 
		
		*/
		X_START_ARRAY = new Array(); 
		Y_START_ARRAY = new Array(); 
		
		X_GOAL_ARRAY = new Array(); 
		Y_GOAL_ARRAY = new Array(); 
		
		X_CURRENT_ARRAY = new Array(); 
		Y_CURRENT_ARRAY = new Array();
		
		
		X_GOAL2_ARRAY = new Array();
		Y_GOAL2_ARRAY = new Array();
		
		POINT_ARRAY = new Array(); 

		
		initDistort();
		
		COUNT++; 
	
		
	}
	
	
	private function initDistort(){
			
			trace("initDistort");
			
			mcWIDTH =  SHADOW_MC._width = IMG_MC._width;
			mcHEIGHT = SHADOW_MC._height = IMG_MC._height;
			
			POINT_ARRAY[0] = new Point(startX, startY); 
			POINT_ARRAY[1] = new Point(startX+mcWIDTH, startY); 
			POINT_ARRAY[2] = new Point(startX+mcWIDTH,startY+mcHEIGHT); 
			POINT_ARRAY[3] = new Point(startX, startY+mcHEIGHT); 
			
	
			X_START_ARRAY[0] = startX; 
			Y_START_ARRAY[0] = Y_GOAL_ARRAY[0] = startY;
			
			X_START_ARRAY[1] = startX+mcWIDTH;
			Y_START_ARRAY[1] = Y_GOAL_ARRAY[1] = startY;
			
			X_START_ARRAY[2] = startX+mcWIDTH; 
			Y_START_ARRAY[2] = Y_GOAL_ARRAY[2] = startY+mcHEIGHT;
			
			X_START_ARRAY[3] = startX; 
			Y_START_ARRAY[3] = Y_GOAL_ARRAY[3] = startY+mcHEIGHT;
			
			//SHADOW = new RectangleGradient(SHADOW_MC, startX, startY, mcWIDTH, mcHEIGHT);
			
			doDistort();
			
			trace("startY:"+startY+" mcHEIGHT:"+mcHEIGHT);
		
	}
		
	
	
	private function doDistort(){
				trace("Do distort");
				DISTORTION = new DistortImage(CONTAINER_MC, IMG_MC, 2, 2, true);			
				DISTORTION.setTransform(	POINT_ARRAY[0].x,POINT_ARRAY[0].y,
											POINT_ARRAY[1].x,POINT_ARRAY[1].y,
											POINT_ARRAY[2].x,POINT_ARRAY[2].y,
											POINT_ARRAY[3].x,POINT_ARRAY[3].y
								);
	}
			
				
	
	
	
	
	private function flipScript() {


			var FOCAL_LENGTH = mcHEIGHT*.125; 
			
			trace("PERSP:"+PERSPECTIVE+" FOCAL_LENGTH:"+FOCAL_LENGTH);
			
			SHADOW_MC.line_mc._visible = true; 
				
			X_GOAL_ARRAY[0] = startX+(mcWIDTH*.5);
			X_GOAL_ARRAY[1] = startX+mcWIDTH-(mcWIDTH*.5);
			X_GOAL_ARRAY[2] = startX+mcWIDTH-(mcWIDTH*.5);
			X_GOAL_ARRAY[3] = startX+(mcWIDTH*.5);
			
			X_GOAL2_ARRAY[0] = startX+mcWIDTH; 
			X_GOAL2_ARRAY[1] = startX;
			X_GOAL2_ARRAY[2] = startX;
			X_GOAL2_ARRAY[3] = startX+mcWIDTH;
			
			Y_GOAL_ARRAY[0] = startY+(FOCAL_LENGTH*PERSPECTIVE);
			Y_GOAL_ARRAY[1] = startY-(FOCAL_LENGTH*PERSPECTIVE);
			Y_GOAL_ARRAY[2] = startY+mcHEIGHT+(FOCAL_LENGTH*PERSPECTIVE);
			Y_GOAL_ARRAY[3] = startY+mcHEIGHT-(FOCAL_LENGTH*PERSPECTIVE); 
			
			doTransform();
	}
	
	
	private function run(){
		
		doTransform();
		
	}
	
	
	private function doTransform() {
		
			var d = .25;
			
			var rotation = ( PERSPECTIVE == 1 ) ? 180 : 0 ; 
			var line_x = ( PERSPECTIVE == 1 ) ? 250 : 0 ;
			
				//set point position
			//for (var i:Number=0; i<4; i++) {

			
				if(SEGMENT == 0){
					
					trace('SEGMENT 0 :'+SEGMENT);
					var this_x_goal 	= X_GOAL_ARRAY[0];
					var this_x_pt 		= POINT_ARRAY[0].x;
					var this_y_goal 	= Y_GOAL_ARRAY[0];
					var this_y_pt 		= POINT_ARRAY[0].y;
					
					var func = Regular.easeIn; 
					
					var mc = SHADOW_MC; 
					mc._rotation = rotation;
					SHADOW_MC.line_mc._visible = true; 
					SHADOW_MC.line_mc._x = line_x;
					new Tween(mc, "_alpha", func, mc._alpha, 100, d, true);
					
				}else if(SEGMENT == 1){
					
					trace('SEGMENT 1 :'+SEGMENT);
					
					var this_x_goal 	= ( PERSPECTIVE == 1 ) ? X_GOAL2_ARRAY[0] : X_START_ARRAY[0];
					var this_x_pt 		= X_GOAL_ARRAY[0];
					
					var this_y_goal 	= Y_START_ARRAY[0];
					var this_y_pt 		= POINT_ARRAY[0].y;
					
					var func = Regular.easeOut; 
					
					var mc = SHADOW_MC; 
					SHADOW_MC.line_mc._visible = true; 
					new Tween(mc, "_alpha", func, mc._alpha, 0, d, true);
				}
				
	
			
			// set X values 
			new Tween(POINT_ARRAY[0], "x", func, POINT_ARRAY[0].x, this_x_goal, d, true);
			// set Y values 
			TWEEN = new Tween(POINT_ARRAY[0], "y", func, POINT_ARRAY[0].y, this_y_goal, d, true);
			
			// set other points based on first point
			TWEEN.onMotionChanged = Delegate.create(this, function(){
				//trace("POINT_ARRAY[0].x:"+ POINT_ARRAY[0].x ); 
						
				
				POINT_ARRAY[1].x = (startX + mcWIDTH) - (POINT_ARRAY[0].x-startX);	
				POINT_ARRAY[1].y = startY - (POINT_ARRAY[0].y-startY);
				
				POINT_ARRAY[3].x = POINT_ARRAY[0].x;
				POINT_ARRAY[3].y = (startY + mcHEIGHT) - (POINT_ARRAY[0].y-startY);
				
				POINT_ARRAY[2].x = POINT_ARRAY[1].x;
				POINT_ARRAY[2].y = (startY+ mcHEIGHT) - (POINT_ARRAY[1].y-startY);
					
						
				doDistort();
			});
				
			TWEEN.onMotionFinished = Delegate.create(this, function(){
					trace("onMotionFinished"); 
					
					if(POINT_ARRAY[0].x == X_GOAL_ARRAY[0]){
						trace("onQuarterFlipDone");
						onQuarterFlipDone(); 
						delete onQuarterFlipDone;
					}
					
					if(POINT_ARRAY[0].x == X_GOAL2_ARRAY[0]){
						
						trace("onHalfFlipDone");
						onHalfFlipDone();
						delete onHalfFlipDone;
						
						
					}

			});
		
			
			
			// set Face
			/*	if (base_mc.x1_pt<startX+(IMG_MC._width/2)) {
					FRONT_MC._visible = false;
				} else {
					FRONT_MC._visible = true;
			}
				
				
			*/
	
	}
		
	
	
	
	public function flipForward (){
		trace("flipForward"); 
		SEGMENT = 0; 
		PERSPECTIVE = 1;
		flipScript(); 
		
		
		 
		SEGMENT = 1; 
		onQuarterFlipDone = function(){
			// FRONT_MC._visible = false;
			
			new Color(FRONT_MC).setRGB(0xFFFFFF); 
			
			doTransform();
			
			
		};
		
		onHalfFlipDone = function(){
			
			whenFlipForwardDone();
			
			new PauseThis(Delegate.create(this, function(){CONTAINER_MC.removeMovieClip();}), 1000);
			
		};
	}
	
	
	public function flipBackward (){
		trace("flipForward"); 
		SEGMENT = 0; 
		PERSPECTIVE = -1;
		flipScript(); 
		
		SEGMENT = 1; 
		PERSPECTIVE = 1;
		onQuarterFlipDone = function(){
			// FRONT_MC._visible = false;
			
			new Color(FRONT_MC).setRGB(0xFFFFFF); 
			doTransform();
		};
		
		onHalfFlipDone = function(){
			
			whenFlipForwardDone();
			new PauseThis(Delegate.create(this, function(){CONTAINER_MC.removeMovieClip();}), 1000);
			
		};
	}
	
	public function flipForward2 (){
		trace("flipForward2"); 
		
		SEGMENT = 0; 
		PERSPECTIVE = -1;

		flipScript(); 
		
		SEGMENT = 1; 
		PERSPECTIVE = -1;
		onQuarterFlipDone = doTransform;
		
	}
	
	public function flipBackward2 (){
		trace("flipbackward2"); 
		
		SEGMENT = 0; 
		PERSPECTIVE = 1;

		flipScript(); 
		
		SEGMENT = 1; 
		PERSPECTIVE = 1;
		onQuarterFlipDone = doTransform;
		
	}
	
	
	
	public function fullFlipForward () {
		
		flipForward();
		onHalfFlipDone = flipForward2;
	}
	
	public function fullFlipBackward () {
		
		flipBackward();
		onHalfFlipDone = flipBackward2;
	}
	
	

	
	
	public function getMC():MovieClip{
		return CONTAINER_MC;
	}
		 
}
		
		
