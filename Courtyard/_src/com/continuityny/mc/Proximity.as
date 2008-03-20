

import com.bourre.commands.Delegate;
import mx.transitions.easing.*;
import mx.transitions.Tween;

/**
 * @author Greg
 */
class com.continuityny.mc.Proximity {
	
	
	private var TARGET_MC:MovieClip; 
	private var DISTANCE:Number; 
	private var OFFSET:Number; 
	private var _MouseListener:Object; 
	private var TWEEN:Tween;
	private var onUpdate:Function;
	
	public function Proximity(	_mc:MovieClip, 
								distance:Number, 
								offset:Number, 
								updFunc:Function
								) {
		
		TARGET_MC = _mc; 
		DISTANCE = distance; 
		OFFSET = offset; 
		
		TARGET_MC._x = -offset; 
		
		onUpdate = updFunc;
		
		
	}
	
	
	public function start(){
		
		_MouseListener = new Object();
		_MouseListener.onMouseMove = Delegate.create(this, adjustProximity);
		Mouse.addListener(_MouseListener);
		
	}
	
	public function stop(){
		trace("Prox:Stop:"+TARGET_MC);
		Mouse.removeListener(_MouseListener);
		delete _MouseListener.onMouseMove;
		delete _MouseListener;
	}
		
	
	
	private function adjustProximity(){
		
		var mouse_x:Number = TARGET_MC._parent._xmouse;
		
		var perc_distance:Number = (DISTANCE - Math.abs(mouse_x)) / DISTANCE;
		
		//if(mouse_x <= DISTANCE && (mouse_x > 0) ){
		if(mouse_x <= DISTANCE ){
			
			TARGET_MC._x = Math.floor(-OFFSET + (OFFSET * perc_distance)); 
			
			
		
		}else{
		
	
			if( ( TARGET_MC._x <= -OFFSET ) || ( TARGET_MC._x >= DISTANCE ) ){
				
				TARGET_MC._x = -OFFSET; 
				
			}else{
				TARGET_MC._x -= 4;
			}
		}
		
			_root.output_mc.output_1_txt.text = "mouse: "+ mouse_x;
			_root.output_mc.output_2_txt.text = "d: "+ perc_distance;
			_root.output_mc.output_3_txt.text = "x: "+ TARGET_MC._x;
			 
			 
			/*trace("TARGET_MC:"+TARGET_MC);
			trace("TARGET_MC._xmouse:"+TARGET_MC._xmouse);
			trace("perc_distance:"+perc_distance);
			trace("NEW X:"+TARGET_MC._x); */
			
			onUpdate();
			
			updateAfterEvent();
			
			// TWEEN.stop();
			// delete TWEEN; 
			//var _mc = TARGET_MC;
			//TWEEN = new Tween(_mc, "_x", Strong.easeOut, _mc._x, -OFFSET, .5, true);
			
	}
	
	
}