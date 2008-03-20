import mx.utils.Delegate;


class com.continuityny.timing.PauseMe {
	
	 
	private static var ALL_INTERVALS:Array = new Array();
	
	private var INTERVAL:Number;
	private var SCOPE:Object; 
	private var FUNC : Function ; 
	private var PAUSE_TIME : Number ; 
	
	public function PauseMe ( f:Function , t:Number ) {
		//if(scope == undefined){ SCOPE = this; }else{SCOPE = scope;}
		FUNC = f; 
		PAUSE_TIME = t;
		doPause( );
	}
	
	private function doPause ( ) : Void {
		
		var scope = this; 
		INTERVAL = setInterval(this, 
		function(){
			clearInterval(scope.INTERVAL);
			scope.FUNC();
		}, PAUSE_TIME);
		
		//PauseThis.ALL_INTERVALS[INTERVAL] = INTERVAL;
		
	}
	
	public function clear(){
		
		clearInterval(INTERVAL);
		
	}
	
	
	/*public static function purge () {
		
		trace("purge called: "+PauseMe.ALL_INTERVALS.length);
		
		for(var i:Number = 0; i<PauseThis.ALL_INTERVALS.length; i++){
			
			//trace("purge Interval: "+PauseThis.ALL_INTERVALS[i]);
			
			clearInterval(PauseThis.ALL_INTERVALS[i]);
		}
		
	}*/
}