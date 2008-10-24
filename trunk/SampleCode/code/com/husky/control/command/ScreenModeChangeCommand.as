package com.husky.control.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.husky.model.PlayerData;
	
	import flash.display.StageDisplayState;

	/**
	 * This Command adjusts the video player and thumbnail sprites according to the 
     * the screen's display state.. fullscreen or normal...
     * Triggered when displayState change
	 * @author iksnae
	 */
	public class ScreenModeChangeCommand implements ICommand
	{
		private var _model:PlayerData = PlayerData.getInstance()
		public function ScreenModeChangeCommand()
		{
		}
/*
		public function execute(event:CairngormEvent):void
		{
			Debug.log('COMMAND: ScreenModeChangeCommand');
			if(_model.app.stage.displayState == StageDisplayState.FULL_SCREEN){
				
                // full screen mode				
               Debug.log('W:'+ _model.ScreenWidth+'  > '+_model.videoView.video)
               _model.videoView.width=_model.ScreenWidth;
               _model.videoView.height=_model.ScreenHeight;
               _model.app.thumb.width = _model.ScreenWidth;
               _model.app.thumb.height = _model.ScreenHeight;
               _model.app.thumb.x = 0
               _model.app.thumb.y = 0;
               _model.videoView.x = 0;
               _model.videoView.y = 0;
               
               if(_model.lowerThird!=''){
                   _model.videoView.y = ((_model.ScreenHeight)-(_model.videoControllerView.height-30))
          //         _model.toolTipManager.y=((_model.ScreenHeight)-(_model.videoControllerView.height-30)+100);
               }else{
                   _model.videoControllerView.y = ((_model.ScreenHeight)-(_model.videoControllerView.height))
            //       _model.toolTipManager.y=((_model.ScreenHeight)-(_model.videoControllerView.height))+100;
               }
               _model.videoControllerView.x = ((_model.ScreenWidth/2)-(_model.videoControllerView.width/2))
               _model.videoState.fullScreen = true;
               
               
 
               //add smoothing
               _model.videoView.video.smoothing=true
      //       _model.videoVolumeSliderView.update()
               var evt0:EnableControlAutoHideEvent = new EnableControlAutoHideEvent()
               evt0.dispatch()
               
			}else
			if(_model.app.stage.displayState == StageDisplayState.NORMAL){
			
				// normal mode
			   _model.videoView.width = _model.AppWidth;
               _model.app.thumb.width = _model.AppWidth;
               _model.app.thumb.height = _model.videoView.height;
               _model.videoControllerView.x = 0
               _model.app.thumb.x = 0;
               _model.app.thumb.y = 0;
               _model.videoView.x = 0;
               _model.videoView.y = 0;
               _model.videoState.fullScreen = false;
               
           //    _model.toolTipManager.y=450;

               // remove smoothing
               _model.videoView.video.smoothing=false
               
               if(_model.lowerThird!=''){
                	_model.videoControllerView.y = _model.AppHeight - (_model.videoControllerView.height-30);
               	    _model.videoView.height = _model.AppHeight - (_model.videoControllerView.height-30);
               }else{
               	    _model.videoControllerView.y = _model.AppHeight - _model.videoControllerView.height;
               	    _model.videoView.height = _model.AppHeight - (_model.videoControllerView.height);
               }
//               _model.videoVolumeSliderView.update()
               var evt1:DisableControlAutoHideEvent = new DisableControlAutoHideEvent()
               evt1.dispatch()
               
			}
		}*/
		public function execute(event:CairngormEvent):void{
			if(_model.app.stage.displayState == StageDisplayState.FULL_SCREEN){
			    _model.videoView.fullscreen = true;
			    _model.app.controllerView.fullscreen = true;
			}else{
				 _model.videoView.fullscreen = false;
				 _model.app.controllerView.fullscreen = false;
			}
		}
	}
}