package com.FlashDynamix.events {
	
	import flash.events.Event;
	import flash.net.URLRequest
	
	public class YouTubeEvent extends Event {
		
		public static var COMPLETE:String = Event.COMPLETE;
		public static var ERROR:String = "error";
		public var data:Object;
		public var method:String;
		public var request:*;
		
		public function YouTubeEvent(type:String, bubbles:Boolean, cancelable:Boolean, m:String){
			super(type, bubbles, cancelable);
			method = m;
		}
		public override function toString():String { 
		   	return formatToString("YouTubeEvent", "method", "data"); 
		}
	}
}