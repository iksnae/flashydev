package com.husky.event
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class PlayPauseEvent extends CairngormEvent
	{
		static public const EVENT_ID:String = 'playPauseTriggeredEvent'
		public function PlayPauseEvent()
		{
			super(EVENT_ID);
		}
		
	}
}