package com.husky.event
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class DisableControlAutoHideEvent extends CairngormEvent
	{
		static public const EVENT_ID:String = 'disableControlAutoHideEvent'
		public function DisableControlAutoHideEvent()
		{
			super(EVENT_ID);
		}
		
	}
}