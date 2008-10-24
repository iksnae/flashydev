package com.husky.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.husky.control.command.FullScreenVideoCommand;
	import com.husky.control.command.InitVideoPlayerCommand;
	import com.husky.control.command.PlayFLVCommand;
	import com.husky.control.command.PlayPauseCommand;
	import com.husky.control.command.ScreenModeChangeCommand;
	import com.husky.control.command.SetupStageCommand;
	import com.husky.event.FLVStreamReadyEvent;
	import com.husky.event.FullScreenVideoEvent;
	import com.husky.event.PlayPauseEvent;
	import com.husky.event.ScreenModeChangeEvent;
	import com.husky.event.SetupStageEvent;
	import com.husky.event.VideoPlayerReadyEvent;

	public class VideoCommander extends FrontController
	{
		public function VideoCommander()
		{
			addCommand(VideoPlayerReadyEvent.EVENT_ID,InitVideoPlayerCommand)
			addCommand(SetupStageEvent.EVENT_ID,SetupStageCommand)
			addCommand(ScreenModeChangeEvent.EVENT_ID,ScreenModeChangeCommand)
			addCommand(PlayPauseEvent.EVENT_ID, PlayPauseCommand)
			addCommand(FLVStreamReadyEvent.EVENT_ID, PlayFLVCommand);
			addCommand(FullScreenVideoEvent.EVENT_ID,FullScreenVideoCommand)
		}
		
		
	}
}