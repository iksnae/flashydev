package  com.husky.control.command
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class EnableControlAutoHideEvent extends CairngormEvent
	{
		static public const EVENT_ID:String = 'enableControlAutoHideEvent'
		public function EnableControlAutoHideEvent()
		{
			super(EVENT_ID);
		}
		
	}
}