package com.husky.control
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class VideoTimer
	{
		public function VideoTimer()
		{
			resetVideoTimer()
		}
		
		public var videoPlayTime:Number;
		
		public var videoTimer:Timer = new Timer(1000);
		
		public function resetVideoTimer():void{
			videoPlayTime=0;
		}
		private function incrementVideoTimer(e:TimerEvent):void{
			videoPlayTime++;
		}
	}
}