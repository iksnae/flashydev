package  com.husky.control.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.husky.mbedder.model.HuskyData;

	public class DisableControlAutoHideCommand implements ICommand
	{
	    var _model:HuskyData = HuskyData.getInstance()
	    
		public function DisableControlAutoHideCommand()
		{
		}

		public function execute(event:CairngormEvent):void
		{
		      _model.videoState.autoHide = false;
		}
		
	}
}