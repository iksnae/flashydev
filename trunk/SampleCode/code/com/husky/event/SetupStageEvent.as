package com.husky.event
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class SetupStageEvent extends CairngormEvent
	{
		static public const EVENT_ID:String = 'setupStageEvent'
		public function SetupStageEvent()
		{
			super(EVENT_ID);
		}
		
	}
}