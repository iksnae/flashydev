import mx.transitions.easing.Strong;
import mx.transitions.Tween;

/**
 * @author Greg
 */
class com.continuityny.mc.Rise {
	
	private var TARGET_MC:MovieClip;
	private var H:Number;
	
	public function Rise(	_mc:MovieClip, 
							h:Number
							){
		
			//trace("Rise:"+_mc);
			H = h;
			
			TARGET_MC = _mc;
			
			_mc.top_mc._y += h; 
			_mc.bottom_mc._y -= h; 
			
		
	}
	
	public function init(){
		//trace("Rise init:"+TARGET_MC); 
		new Tween(TARGET_MC.top_mc, "_y", Strong.easeOut, TARGET_MC.top_mc._y, 0, 1, true);
		new Tween(TARGET_MC.bottom_mc, "_y", Strong.easeOut, TARGET_MC.bottom_mc._y, 0, 1, true);
	}
	
	public function up(){
		//trace("Rise init:"+TARGET_MC); 
		TARGET_MC.top_mc._y = 0;
		TARGET_MC.bottom_mc._y = 0;
	
	}
	
	public function out(){
		//trace("Rise: out - "+H);
		new Tween(TARGET_MC.top_mc, "_y", Strong.easeOut, TARGET_MC.top_mc._y, H, 1, true);
		new Tween(TARGET_MC.bottom_mc, "_y", Strong.easeOut, TARGET_MC.bottom_mc._y, -H, 1, true);
	
	}
	
	public function reset(){
		//trace("Rise: reset - "+H);
		TARGET_MC.top_mc._y =  H;
		TARGET_MC.bottom_mc._y =  -H;
	}
	
}
