package com.husky.event
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ScreenModeChangeEvent extends CairngormEvent
	{
		static public const EVENT_ID:String = 'screenModeChangeEvent'
		public function ScreenModeChangeEvent()
		{
			super(EVENT_ID);
		}
		
	}
}