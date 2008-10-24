package com.husky.control.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.carlcalderon.Debug;
	import com.husky.model.PlayerData;

	/**
	 * plays the FLV url stored in PlayerData via NetStream
	 * @author iksnae
	 * @see PlayerData
	 */
	public class PlayFLVCommand implements ICommand
	{
		private var _model:PlayerData = PlayerData.getInstance()
		public function PlayFLVCommand()
		{
		
		}

		public function execute(event:CairngormEvent):void
		{
			Debug.log('COMMAND: PlayFLVCommand. play: '+_model.videoURL,Debug.YELLOW)
			_model.ns.play(_model.videoURL)	
		}
	}
}