package com.husky.control.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.carlcalderon.Debug;
	import com.husky.model.PlayerData;
	/**
	 *toggles play/pause of video 
	 * @author iksnae
	 * 
	 */
	public class PlayPauseCommand implements ICommand
	{
		private var _model:PlayerData = PlayerData.getInstance()
		public function PlayPauseCommand()
		{
		}

		public function execute(event:CairngormEvent):void
		{
			Debug.log('COMMAND: PlayPauseCommand! ')
	//	    Debug.log(' --> paused: '+_model.videoState.paused)
	//		Debug.log(' --> playing: '+_model.videoState.playing)
            
			if(!_model.videoState.playing && _model.videoState.paused){
		         Debug.log('resume video')
				_model.ns.resume()
				_model.videoTimer.videoTimer.start();
				_model.videoState.playing=true;
				_model.videoState.paused=false;
				_model.app.overlayView.alpha=0;
			}else
			if(_model.videoState.playing && !_model.videoState.paused){
				 Debug.log('pause video')
				 _model.videoTimer.videoTimer.stop();
				 _model.app.overlayView.alpha=1;
				 _model.ns.pause()
				 _model.videoState.playing=false;
				 _model.videoState.paused=true;
			}else
			if(!_model.videoState.playing && !_model.videoState.paused){
				 Debug.log('play video')
				 _model.videoTimer.videoTimer.start();
				 _model.app.overlayView.alpha=0;
				 _model.videoView.videoProxy.playVideo()
				 _model.videoState.playing=true;
				
			}
		}	
	}
}