package com.FlashDynamix.events {
	
	import flash.events.MouseEvent;
	
	public class VideoPlaybackEvent extends MouseEvent {
		
		public static var CLICK:String = MouseEvent.CLICK;
		public var method:String;
		public var value:*;
		
		public function VideoPlaybackEvent(type:String, bubbles:Boolean, cancelable:Boolean, m:String){
			super(type, bubbles, cancelable);
			method = m;
		}
		public override function toString():String { 
		   	return formatToString("VideoPlaybackEvent", "method", "data"); 
		}
	}
	
}