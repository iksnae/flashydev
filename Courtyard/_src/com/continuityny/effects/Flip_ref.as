

import com.continuityny.effects.DistortImage;
// import com.pymm.effects.ReflectH;
import mx.utils.Delegate;
import com.continuityny.mc.ImageLoader;
import mx.transitions.easing.*;
import flash.display.BitmapData;

/**
 * @author Greg
 * @author MGallay
 */
class com.continuityny.effects.Flip {
	


	var startX:Number = 150;
	var startY:Number = 165;
	var mcWIDTH:Number;
	var mcHEIGHT:Number;
	
	var x0_goal:Number;
	var y0_goal:Number;
	var x1_goal:Number;
	var y1_goal:Number ;
	var x2_goal:Number ;
	var y2_goal:Number;
	var x3_goal:Number;
	var y3_goal:Number;
	
	var x0_pt:Number;
	var y0_pt:Number;
	var x1_pt:Number;
	var y1_pt:Number;
	var x2_pt:Number;
	var y2_pt:Number;
	var x3_pt:Number;
	var y3_pt:Number;
	
	var easing:Number;
	var easingResolve:Number = .3;
	
	var persp:Number = 2;
	
	var turns:Number;
	
	var shadowAlpha:Number = 0;
	var shadowValue:Number;

	var REFLECT;
	
	var mainClip:MovieClip;


	var TARGET_MC:MovieClip;

	var CONTAINER_MC:MovieClip; 
	var IMG_MC:MovieClip; 
	var BACK_MC:MovieClip; 
	var FRONT_MC:MovieClip; 
	var SHADOW_MC:MovieClip; 
	
	
	var d:DistortImage;
	private var FRONT_SRC:String; 
	private var BACK_SRC:String; 
	
	static var SPINNER_ARRAY:Array; 
	static var COUNT:Number = 0; 
	
	private var FRONT_BMP:BitmapData; 
	private var BACK_BMP : BitmapData;
	
	var tx=0;

	
	public function Flip(	
								_mc:MovieClip, 
								source_mc:MovieClip, 
								//front_src, 
								//back_src, 
								x:Number, 
								y:Number, 
								w:Number, 
								h:Number){
		
	
		trace("Flip: Target"+_mc+"source_mc:"+source_mc+" x:"+x+" y:"+y); 
		
		TARGET_MC = _mc; 
		
		//FRONT_SRC = front_src; 
		//BACK_SRC = back_src; 
		
		
		FRONT_BMP = new BitmapData(w, h, true, 0x00); 
		//BACK_BMP = new BitmapData(w, h, false, 0xFFFFFF); 
		
		FRONT_BMP.draw(source_mc);
		
		if(x!=undefined) startX = x; 
		if(y!=undefined) startY = y; 
		
		
		//if(SPINNER_ARRAY==undefined)SPINNER_ARRAY = new Array(); 
		
		var DEPTH = TARGET_MC.getNextHighestDepth();
		
		// visible spinner movieclip 
		CONTAINER_MC = TARGET_MC.createEmptyMovieClip("container_"+COUNT+"_mc", DEPTH);
		SPINNER_ARRAY.push(CONTAINER_MC); 
		
		// invisible image data 
		IMG_MC = TARGET_MC.createEmptyMovieClip("img_"+COUNT+"_mc", DEPTH+1); 
		BACK_MC = IMG_MC.createEmptyMovieClip("back_mc",IMG_MC.getNextHighestDepth());
		FRONT_MC = IMG_MC.createEmptyMovieClip("front_mc",IMG_MC.getNextHighestDepth());
				
		BACK_MC.attachBitmap(BACK_BMP, 100, "auto", true); 
		FRONT_MC.attachBitmap(FRONT_BMP, 100, "auto", true); 
		
		//SHADOW_MC = IMG_MC.attachMovie("shadow_mc", "shadow_mc", IMG_MC.getNextHighestDepth());
		//SHADOW_MC.shadow._alpha=0;
		
		IMG_MC._visible = false;
		
		
		
		if (persp<0) SHADOW_MC.shadow._rotation+=180;
		
		
		//var FRONT_LOADER = new ImageLoader(FRONT_MC, FRONT_SRC);
		//var BACK_LOADER = new ImageLoader(BACK_MC, BACK_SRC);
		
		/*var checkLoaded = function():Boolean{
			trace("cheack loaded:"+INT+"FRONT_LOADER:"+FRONT_LOADER.loaded+" BACK_LOADER:"+BACK_LOADER.loaded);
			if(FRONT_LOADER.loaded && BACK_LOADER.loaded) return true; 	
		};
		
		var INT = setInterval(Delegate.create(this, function(){
			if(checkLoaded()){
				clearInterval(INT); 
				initDistort();
			}
		}), 10); */
		
	
		initDistort();
		
		/*CONTAINER_MC.onRelease = Delegate.create(this, function() {
			
			//_MC.enabled = false; 
			
			if (FRONT_MC._visible == true) {
				flipScript(1,1);
			} else {
				flipScript(0,1);
			}
		});*/
		
		
		//COUNT++; 
		
	}
	
	
	private function initDistort(){
			
			trace("initDistort");
			
			mcWIDTH = SHADOW_MC._width = IMG_MC._width;
			mcHEIGHT = SHADOW_MC._height = IMG_MC._height;
			
			
			x0_pt = startX; 
			y0_pt = y0_goal = startY;
			x1_pt = startX+mcWIDTH;
			y1_pt = y1_goal = startY;
			x2_pt = startX+mcWIDTH; 
			y2_pt = y2_goal = startY+mcHEIGHT;
			x3_pt = startX; 
			y3_pt = y3_goal = startY+mcHEIGHT;
			
			
			doDistort();
			
			trace("_MC._width:"+CONTAINER_MC._width);
		
	}
		
	
	
	private function doDistort(){
				
				d = new DistortImage(CONTAINER_MC, IMG_MC, 2, 2, true);			
				d.setTransform(x0_pt,y0_pt,x1_pt,y1_pt,x2_pt,y2_pt,x3_pt,y3_pt);
		}
			
				
	public function flipForward (){
		persp = -1; 
		flipScript(.5,2); 
	}
	
	public function halfFlipForward (){
		persp = 1; 
		flipScript(.5,1); 
	}
	
	public function flipBackward(){
		persp = .75; 
		flipScript(.5,2); 
	}
	
	public function quarterFlipBackward(){
		persp = .75; 
		flipScript(.25,1); 
	}
	
	public function halfFlipBackward(){
		persp = -1; 
		flipScript(.5,1); 
	}
	
	public function halfFlipBackward2(){
		persp = -1; 
		flipScript(.5,1); 
	}
	
	
	public function getMC():MovieClip{
		return CONTAINER_MC;
	}
	
	
	
	private function flipScript(SEGMENT, turnsVar) {
		
			
			SHADOW_MC.shadow._rotation += 180;
			SHADOW_MC.line_mc._visible = true; 
			
		
			turns = (turnsVar != undefined) ? turnsVar : 1;
			
			//easing = (turns>1) ? .1+(turns/100) : easingResolve;
			
			easing = .2 ;
			
			shadowValue = (10-(easing*10));
			
			
			if (SEGMENT == .5) {
				
				SHADOW_MC.line_mc._x = (persp==-1) ? 0 : 250;
				
				x0_goal = startX+mcWIDTH;
				x1_goal = startX;
				x2_goal = startX;
				x3_goal = startX+mcWIDTH;
		
				x0_pt = startX;
				x1_pt = startX+mcWIDTH;
				x2_pt = startX+mcWIDTH;
				x3_pt = startX;
				
			}else if (SEGMENT == .25) {
				
				SHADOW_MC.line_mc._x = (persp==-1) ? 0 : 250;
				
				x0_goal = startX+(mcWIDTH*.5);
				x1_goal = startX+mcWIDTH-(mcWIDTH*.5);
				x2_goal = startX+mcWIDTH-(mcWIDTH*.5);
				x3_goal = startX+(mcWIDTH*.5);
		
				x0_pt = startX;
				x1_pt = startX+mcWIDTH;
				x2_pt = startX+mcWIDTH;
				x3_pt = startX;
			
			} else {
				
				SHADOW_MC.line_mc._x = (persp==-1) ? 250 : 0;
				
				x0_goal = startX;
				x1_goal = startX+mcWIDTH;
				x2_goal = startX+mcWIDTH;
				x3_goal = startX;
		
				x0_pt = startX+mcWIDTH;
				x1_pt = startX;
				x2_pt = startX;
				x3_pt = startX+mcWIDTH;
			}
			
			
			
			
			CONTAINER_MC.onEnterFrame = Delegate.create(this, function(){doTransform(SEGMENT);}); 
			
	}
	
	private function doTransform(SEGMENT) {
		
				var base_mc = this; 
				base_mc.tx += .1;
				var d = 3;
				//set point position
				for (var i:Number=0; i<4; i++) {
					
					
					var this_x_goal 	= base_mc["x"+i+"_goal"];
					var this_x_pt 		= base_mc["x"+i+"_pt"];
					var this_y_goal 	= base_mc["y"+i+"_goal"];
					var this_y_pt 		= base_mc["y"+i+"_pt"]; 
						
					
					// set X values 
				// base_mc["x"+i+"_pt"] += (this_x_goal-this_x_pt)*easing;
				
				trace("base_mc.tx:"+base_mc.tx+" |  ease:"+Strong.easeOut(base_mc.tx, this_x_pt, this_x_goal-this_x_pt, 1000));
					
					var c = (this_x_goal-this_x_pt);
				base_mc["x"+i+"_pt"] = Strong.easeIn(base_mc.tx, this_x_pt, c, d);
				
				//(t, this.begin, this.change, this._duration)
					
					// set Y values 
				if (i<2) {
						
					var c = (this_y_goal-this_y_pt) * persp; 
				// base_mc["y"+i+"_pt"] += (((this_x_goal- this_x_pt )*easing*persp)+(this_y_goal-this_y_pt))*easing;
			base_mc["y"+i+"_pt"] = Strong.easeIn(base_mc.tx, this_y_pt, c, d);
			
			//base_mc["y"+i+"_pt"] = (((this_x_goal- this_x_pt )*easing*persp)+(this_y_goal-this_y_pt))*easing;
			
					
					} else {
						
				//base_mc["y"+i+"_pt"] += (((this_x_goal-this_x_pt)*easing*-persp)+(this_y_goal-this_y_pt))*easing;
					}
				}
				
				// set Shadow
				shadowAlpha=Number((Math.abs(base_mc.y0_pt-base_mc.y0_goal)-shadowValue)*shadowValue);
			
				if (shadowAlpha<100){
						SHADOW_MC.shadow._alpha = shadowAlpha;
					} else {
						SHADOW_MC.shadow._alpha=100;
					}
				if (SHADOW_MC.shadow._alpha<3) SHADOW_MC.shadow._alpha=0;
				
				
				
				// set Face
				if (base_mc.x1_pt<startX+(IMG_MC._width/2)) {
					FRONT_MC._visible = false;
				} else {
					FRONT_MC._visible = true;
				}
				
				
				
				
				
				
				// detect end
				if ( Math.abs(x1_pt-x1_goal)<.4+((turns-1)*5) ) {
						
						turns--;
					
					if (turns == 0) {
						
						d.setTransform(x0_goal,y0_goal,x1_goal,y1_goal,x2_goal,y2_goal,x3_goal,y3_goal);
						SHADOW_MC.line_mc._visible = false; 
						delete CONTAINER_MC.onEnterFrame;
					
					} else {
							
						if (SEGMENT == .5) {
							
							delete CONTAINER_MC.onEnterFrame;
							flipScript(0,turns);
						
						} else {
							
							delete CONTAINER_MC.onEnterFrame;
							flipScript(1,turns);
						}
					}

				}
				
				// do distort
				doDistort();
				
				
			}
		} 
		
		
