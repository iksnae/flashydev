package {
	import com.carlcalderon.Debug;
	import com.husky.control.VideoCommander;
	import com.husky.event.SetupStageEvent;
	import com.husky.event.VideoPlayerReadyEvent;
	import com.husky.model.PlayerData;
	import com.husky.view.ControllerView;
	import com.husky.view.ui.VideoView;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;

	/**
	 *this is a video player that's drawn and created completely from code.
	 * it's designed to be configures on runtime, with flashvars passed in
	 * on EMBED code.
	 * an example of final product ca be seen here: http://iksnae.com/new_controller/
	 * @author iksnae
	 * 
	 */
	public class HeavyVPlayer extends Sprite
	{
		public var videoView:VideoView;
		public var overlayView:Sprite=new Sprite();
		public var controllerView:ControllerView;
		public var commander:VideoCommander;
		public var thumb:Sprite;
		private var _model:PlayerData = PlayerData.getInstance()
		
		
		public function HeavyVPlayer()
		{
			Debug.clear()
			Debug.log('HeavyVPlayer '+ _model.VERSION)
			// setup stage
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align 	= StageAlign.TOP_LEFT;
			
			commander = new VideoCommander();
			_model.flashVars = LoaderInfo(this.root.loaderInfo).parameters;
			
		
			
			
			parseFlasVars()
			
		}
		private function parseFlasVars():void{
			// check  hostURL
			if(_model.flashVars['hostURL'])  _model.hostURL = _model.flashVars['hostURL'];
			// check colors
			if(_model.flashVars['color0'] ) _model.colorPrimary =_model.flashVars['color0'];
			if(_model.flashVars['color1'] ) _model.colorSecondary =_model.flashVars['color1'];
			if(_model.flashVars['color2'] ) _model.colorThird =_model.flashVars['color2'];
			// check content id
			if(_model.flashVars['cid']) _model.videoID = _model.flashVars['cid'];
			//
			if(_model.flashVars['source']) _model.videoSource = _model.flashVars['source'];
            
			for(var i in _model.flashVars){
				Debug.log('FLASHVAR: '+i+' = '+_model.flashVars[i])
			}
			init();
		}
		private function init():void{
			/// init controller
            controllerView  = new ControllerView();
            videoView       = new VideoView();
            thumb = videoView.thumb;
            
            controllerView.y= videoView.height+5;
            
            addChild(videoView);
            addChild(controllerView);
            addChild(overlayView);
            
            _model.app      = this;
            _model.videoView= videoView;
            _model.videoControllerView = controllerView;
            _model.videoState = videoView.videoState;
            // stage setup event
            var stageEvt:SetupStageEvent = new SetupStageEvent()
            stageEvt.data = this.stage;
            stageEvt.dispatch()
            
            Debug.log('Ready!!!',Debug.GREEN);
            var evt:VideoPlayerReadyEvent = new VideoPlayerReadyEvent();
            evt.dispatch()
            
		}
		public function showThumb(thmb:Loader):void{
            thumb.addChild(thmb)
        }
		public function onNetStreamStatus(e:NetStatusEvent):void{
			
		}
		public function onIOErrorStatus(e:IOErrorEvent):void{
			
            
        }
        public function onMetaData(e:Object):void{
            
        }
        public function onPlayStatus(e:Object):void{
            
        }
	}
}
