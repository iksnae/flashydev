

import com.continuityny.effects.DistortImage;
// import com.pymm.effects.ReflectH;
import mx.utils.Delegate;
import com.continuityny.mc.ImageLoader;
import mx.transitions.easing.*;
import mx.transitions.*;
import flash.geom.Point;
import flash.display.BitmapData;
// import com.continuityny.shapes.RectangleGradient;



/**
 * @author Greg

 */
 
class com.continuityny.effects.PanelOpenDistort {
	


	private var startX:Number = 0;
	private var startY:Number = 25;
	private var mcWIDTH:Number;
	private var mcHEIGHT:Number;
	
	private var OPEN_ARRAY:Array; 


	private var TARGET_MC:MovieClip;

	private var BMP_MC:MovieClip; 
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

	private var CLOSED_ARRAY : Array;

	private var POINT_ARRAY : Array; 
	
	private var _BMP:BitmapData;
	
	public var onOpen:Function;
	public var onClose:Function;
	
	//private var SHADOW:RectangleGradient;
	
	
	public function PanelOpenDistort(_mc:MovieClip, orientation:String, x:Number, y:Number){
		
	
		trace("PanelOpenDistort: Target"+_mc+" x:"+x+" y:"+y); 
		
		TARGET_MC = _mc;
		

		
		_BMP = new BitmapData(_mc._width, _mc._height, true, 0x00); 
		_BMP.draw(_mc); 
		
		if(x!=undefined) startX = x; 
		if(y!=undefined) startY = y; 
		

	BMP_MC = TARGET_MC._parent.createEmptyMovieClip("bmp_mc", 2035);
		


		
		POINT_ARRAY = new Array(); 
		X_START_ARRAY = new Array(); 
		Y_START_ARRAY = new Array(); 
		
		X_GOAL_ARRAY = new Array(); 
		Y_GOAL_ARRAY = new Array(); 
		
		X_CURRENT_ARRAY = new Array(); 
		Y_CURRENT_ARRAY = new Array();
		
		
		X_GOAL2_ARRAY 	= new Array();
		Y_GOAL2_ARRAY 	= new Array();
		
		OPEN_ARRAY 		= new Array(); 
		CLOSED_ARRAY 	= new Array(); 


		initDistort();
		
	}
	
	
	
	
	private function initDistort(){
			
			
			mcWIDTH =  TARGET_MC._width;
			mcHEIGHT = TARGET_MC._height;
			
			trace("initDistort:mcWIDTH - "+mcWIDTH+" mcHEIGHT:"+mcHEIGHT);
			
			//OPEN_ARRAY[0] = new Point(startX, startY); 
			OPEN_ARRAY[1] = new Array();
			OPEN_ARRAY[1]["x"] = startX + mcWIDTH ;
			OPEN_ARRAY[1]["y"] = startY;
			
			OPEN_ARRAY[2] = new Array();
			OPEN_ARRAY[2]["x"] = startX + mcWIDTH; 
			OPEN_ARRAY[2]["y"] = startY + mcHEIGHT;
			
			var q_height = (mcHEIGHT*.15); 
			POINT_ARRAY[1] = new Array();
			CLOSED_ARRAY[1] = new Array();
			POINT_ARRAY[1]["x"] = CLOSED_ARRAY[1]["x"] = startX; 
			POINT_ARRAY[1]["y"] = CLOSED_ARRAY[1]["y"] = startY + q_height ; 
			
			POINT_ARRAY[2] = new Array();
			CLOSED_ARRAY[2] = new Array();
			POINT_ARRAY[2]["x"] = CLOSED_ARRAY[2]["x"]  = startX; 
			POINT_ARRAY[2]["y"] = CLOSED_ARRAY[2]["y"] = startY + mcHEIGHT - q_height; 
			
	
			doDistort();
			
		//	trace("startY:"+startY+" mcHEIGHT:"+mcHEIGHT);
		
	}
		
	
	
	private function doDistort(){
		
				//trace("Do distort:"+OPEN_ARRAY[1].x+" BMP_MC:"+BMP_MC);
				
				DISTORTION = new DistortImage(BMP_MC, _BMP, 2, 2);			
				
				DISTORTION.setTransform(	0, startY,
											POINT_ARRAY[1].x, POINT_ARRAY[1].y, 
											POINT_ARRAY[2].x, POINT_ARRAY[2].y, 
											//OPEN_ARRAY[1].x*.7, OPEN_ARRAY[1].y+4,
											//OPEN_ARRAY[2].x*.7, OPEN_ARRAY[2].y-4,
											//20, mcHEIGHT
											0, mcHEIGHT+startY
								);
	}
			
				
	
	
	
	
	
	
	
	public function close() {
		
			// trace("PanelOpenDistort: Closed"); 
			var d = .25;
			
			var func = Regular.easeIn;
			
			// set X values 
			new Tween(POINT_ARRAY[1], "x", func, POINT_ARRAY[1].x, CLOSED_ARRAY[1].x, d, true);
			
			// set Y values 
			TWEEN = new Tween(POINT_ARRAY[1], "y", func, POINT_ARRAY[1].y, CLOSED_ARRAY[1].y, d, true);
			
			// set other points based on first point
			TWEEN.onMotionChanged = Delegate.create(this, function(){
				
				//trace("onMotionChanged POINT_ARRAY[1].x:"+ POINT_ARRAY[1].x ); 

				POINT_ARRAY[2].x = POINT_ARRAY[1].x;
				POINT_ARRAY[2].y = (startY + mcHEIGHT) - (POINT_ARRAY[1].y - startY);
					
						
				doDistort();
			});

			TWEEN.onMotionFinished = Delegate.create(this, function(){

					onClose();

			});

	}
	
	
	
	
	private function run(){
		
		//doTransform();
		
	}
	
	
	public  function open() {
		
		
			//trace("PanelOpenDistort:Open"); 
			var d = .25;
			
			var func = Regular.easeIn;
			
			// set X values 
			new Tween(POINT_ARRAY[1], "x", func, POINT_ARRAY[1].x, OPEN_ARRAY[1].x, d, true);
			
			// set Y values 
			TWEEN = new Tween(POINT_ARRAY[1], "y", func, POINT_ARRAY[1].y, OPEN_ARRAY[1].y, d, true);
			
			// set other points based on first point
			TWEEN.onMotionChanged = Delegate.create(this, function(){
				
				//trace("onMotionChanged POINT_ARRAY[1].x:"+ POINT_ARRAY[1].x ); 

				POINT_ARRAY[2].x = POINT_ARRAY[1].x;
				POINT_ARRAY[2].y = (startY + mcHEIGHT) - (POINT_ARRAY[1].y - startY);
					
						
				doDistort();
			});

			TWEEN.onMotionFinished = Delegate.create(this, function(){

					onOpen();

			});

	}
		
	
	
	
	

	
	
	public function getMC():MovieClip{
		return BMP_MC;
	}
		 
}
		
		
