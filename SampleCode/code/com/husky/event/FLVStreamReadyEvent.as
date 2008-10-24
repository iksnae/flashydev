package com.husky.event
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class FLVStreamReadyEvent extends CairngormEvent
	{
		static public const EVENT_ID:String = 'flvStreamReadyEvent'
		public function FLVStreamReadyEvent()
		{
			super(EVENT_ID);
		}
		
	}
}