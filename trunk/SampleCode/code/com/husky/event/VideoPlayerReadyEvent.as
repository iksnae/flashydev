package com.husky.event
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class VideoPlayerReadyEvent extends CairngormEvent
	{
		static public const EVENT_ID:String = 'videoPlayerReadyEvent'
		public function VideoPlayerReadyEvent()
		{
			super(EVENT_ID);
		}
		
	}
}