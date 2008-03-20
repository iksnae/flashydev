

class com.continuityny.nav.ClickTracker {
	
	
	private var TRACEME = false; 
	
	private var FOLLOW_ID:Number;
	private var FOLLOW_INTERVAL:Number = 10;
	
	private var CLICK_ARRAY:Array;
	private var CLICK_ACTION_ARRAY:Array = [];
	
	private var OVER_ACTION_ARRAY:Array = [];
	private var OVER_SWITCH_ARRAY:Array = [];
	
	private var OUT_ACTION_ARRAY:Array = [];
	
	private var onMouseUp:Function;

	private var HIT:Array = [];
	// private static var HIT:Boolean;
	
	private var MOUSE_SWITCH_ARRAY:Array;
	
	private var i:Number;

	private var ENABLED_ARRAY : Array;

	private var _root : MovieClip;
	
	
	
	
	public function ClickTracker () {
		
	
		init();
	}
	
	
	private function init() : Void {
		
		CLICK_ARRAY = new Array();
		ENABLED_ARRAY = new Array();
		
		if(TRACEME) trace("INIT: "+typeof CLICK_ARRAY);
		
		Mouse.addListener(this);
		this.onMouseUp = checkHit;
		trackMouse();
		
		
	}
	
	private function trackMouse(){
		
		// localize scope :: "There must be an easier way"
		var this_scope = this;
		var this_checkOver:Function = function(){	
			var s = this_scope;
			s.checkOver();
		};
		
		FOLLOW_ID = setInterval( this_checkOver, FOLLOW_INTERVAL);

	}
	
	public function pause(s:Boolean):Void{
		if(TRACEME) trace("PAUSE CLICKS");
		if(s){
			if(TRACEME) trace("PAUSE CLICKS CLEARED");
			clearInterval(this.FOLLOW_ID); 
		}
	}
	
	private function checkHit(){
		
		for(i = 0; i<CLICK_ARRAY.length; i++){
			HIT[i] = CLICK_ARRAY[i].hitTest(_root._xmouse, _root._ymouse, true);
			if(HIT[i] && ENABLED_ARRAY[i]) { 
				if(TRACEME) trace("CLICK"); 
				CLICK_ACTION_ARRAY[i]( CLICK_ARRAY[i] ); } // call rel action
		} 
	}
	
	
	private function checkOver(){
		
		// trace("CHECK OVER: "+typeof CLICK_ARRAY);
		
		for(i = 0; i<CLICK_ARRAY.length; i++){

			// CLICK_ARRAY[i].onRelease = null;

			HIT[i] = CLICK_ARRAY[i].hitTest(_root._xmouse, _root._ymouse, true);
			
			if(HIT[i]){
				if(!OVER_SWITCH_ARRAY[i]){
					OVER_ACTION_ARRAY[i]( CLICK_ARRAY[i] ); // call over action
					OVER_SWITCH_ARRAY[i] = true;
					if(TRACEME) trace("OVER ACTION");
				}
			}else if(!HIT[i] && OVER_SWITCH_ARRAY[i]){
				OUT_ACTION_ARRAY[i]( CLICK_ARRAY[i] ); // call out action
				OVER_SWITCH_ARRAY[i] = false;
				if(TRACEME) trace("OUT ACTION");
			}
		} 

	}

	
	
	public function addClickTarget (added_mc:MovieClip, 
									clickFun:Function, 
									overFun:Function, 
									outFun:Function, 
									mouseSwitch:Boolean
									):Void {
		
		if(TRACEME) trace("addClickTarget: "+added_mc);
		
		var duplicate:Boolean;
		
		for(i = 0; i<CLICK_ARRAY.length; i++){
			if(CLICK_ARRAY[i] == added_mc){
				duplicate = true;
				break;
			}else{
				duplicate = false;
			}
		}
		
		if(!duplicate) {
			ENABLED_ARRAY.push(true);
			CLICK_ARRAY.push(added_mc);
			CLICK_ACTION_ARRAY.push(clickFun);
			OVER_ACTION_ARRAY.push(overFun);
			OUT_ACTION_ARRAY.push(outFun);
			MOUSE_SWITCH_ARRAY.push(mouseSwitch);
			added_mc.onRelease = null;
		}
	}
	
	
	public function removeClickTarget (removed_mc:MovieClip):Void {
		
		delete removed_mc.onRelease;
		
		for(i = 0; i<CLICK_ARRAY.length; i++){
			if(CLICK_ARRAY[i] == removed_mc){
				
				CLICK_ARRAY.splice(i,1);
				CLICK_ACTION_ARRAY.splice(i,1);
				OVER_ACTION_ARRAY.splice(i,1);
				OUT_ACTION_ARRAY.splice(i,1);
				OVER_SWITCH_ARRAY.splice(i,1);
				// delete CLICK_ARRAY[i].onRollOver;
				break;
			}
		}
		
		//delete removed_mc.onRollOver;
	}
	
	public function enableMC(mc:MovieClip, bool:Boolean){
		
		trace("Clicks - enable mc:"+mc+"CLICK_ARRAY:"+CLICK_ARRAY.length); 
		
		for(var each in CLICK_ARRAY){
			
			var this_mc = CLICK_ARRAY[each]; 
			
			trace("enable mc:"+mc._name+" = "+bool);
			
			if(mc._name == this_mc._name){
				
				var key = each; 
				ENABLED_ARRAY[key] = bool;
				break;
			}
			
			
		}
		
		
	}
	
	
}