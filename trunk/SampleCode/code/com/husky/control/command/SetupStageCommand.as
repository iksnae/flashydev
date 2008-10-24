package com.husky.control.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.carlcalderon.Debug;
	import com.husky.event.ScreenModeChangeEvent;
	import com.husky.event.SetupStageEvent;
	import com.husky.model.PlayerData;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.system.Capabilities;
	/**
	 *sets up the stage's scalings and alignment, then adds listeners for Resize event 
	 * @author iksnae
	 * 
	 */
	public class SetupStageCommand implements ICommand
	{
		private var _model:PlayerData= PlayerData.getInstance()
		public function SetupStageCommand()
		{
		}

		public function execute(event:CairngormEvent):void
		{
			Debug.log('COMMAND: SetupStageCommand ',Debug.YELLOW);
			_model.app.commander.removeCommand(SetupStageEvent.EVENT_ID)
			handler(SetupStageEvent(event))
		}
		private function handler(obj:SetupStageEvent):void{
			
			_model.AppWidth = obj.data.stageWidth
			_model.AppHeight = obj.data.stageHeight
			Debug.log('Dimensions: '+ _model.AppWidth+' x '+ _model.AppHeight,Debug.LIGHT_BLUE);
			_model.ScreenHeight = Capabilities.screenResolutionY;
			_model.ScreenWidth = Capabilities.screenResolutionX;
            
			obj.data.scaleMode = StageScaleMode.NO_SCALE;
			obj.data.align = StageAlign.TOP_LEFT
			obj.data.addEventListener(FullScreenEvent.FULL_SCREEN, fullScreenHandler)
			obj.data.addEventListener(Event.RESIZE, resizeHandler)
			
		}
		private function fullScreenHandler(e:FullScreenEvent):void{
			var evt:ScreenModeChangeEvent = new ScreenModeChangeEvent();
			evt.dispatch()
		}
		private function resizeHandler(e:Event):void{
			Debug.log('RESIZE!')
		}
	}
}