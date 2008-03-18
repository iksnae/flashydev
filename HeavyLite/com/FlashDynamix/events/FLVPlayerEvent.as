package com.FlashDynamix.events {
	
	import flash.events.Event;
	
	public class FLVPlayerEvent extends Event {
		
		public static var UPDATE:String = "update";
		public static var COMPLETE:String = Event.COMPLETE;
		
		public function FLVPlayerEvent(type:String, bubbles:Boolean, cancelable:Boolean){
			super(type, bubbles, cancelable);
		}
	}
	
}