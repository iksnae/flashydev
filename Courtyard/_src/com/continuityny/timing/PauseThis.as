﻿import mx.utils.Delegate;class com.continuityny.timing.PauseThis {		 	private static var ALL_INTERVALS:Array = new Array();		private var INTERVAL:Number;	private var SCOPE:Object; 		public function PauseThis ( f:Function , t:Number, b:Boolean, scope:Object ) {				 				if(scope == undefined){ SCOPE = this; }else{SCOPE = scope;}				pauseMe(f,t, b);	}		private function pauseMe ( f, t, b ) : Void {				// var this_scope = this; 		INTERVAL = setInterval(		Delegate.create(SCOPE, 				   		function(){			 //var s = SCOPE;			if (!b) {				//trace("Cleared Internal Interval:"+INTERVAL);				clearInterval(INTERVAL);				//delete PauseThis.ALL_INTERVALS[INTERVAL];			}			//trace("PauseThis CALLED:"+INTERVAL);			f();				}) , t);				//PauseThis.ALL_INTERVALS[INTERVAL] = INTERVAL;			}		public function clear(){				clearInterval(INTERVAL);			}			public static function purge () {				trace("purge called: "+PauseThis.ALL_INTERVALS.length);				for(var i:Number = 0; i<PauseThis.ALL_INTERVALS.length; i++){						//trace("purge Interval: "+PauseThis.ALL_INTERVALS[i]);						clearInterval(PauseThis.ALL_INTERVALS[i]);		}			}}