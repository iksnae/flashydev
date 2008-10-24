package com.husky.view
{
	import com.husky.event.FullScreenVideoEvent;
	import com.husky.event.PlayPauseEvent;
	import com.husky.model.PlayerData;
	import com.husky.view.ui.FullScreenButton;
	import com.husky.view.ui.NextButton;
	import com.husky.view.ui.PauseButton;
	import com.husky.view.ui.PlayButton;
	import com.husky.view.ui.PreviousButton;
	import com.husky.view.ui.ScrubberView;
	import com.husky.view.ui.VolumeButton;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class ControllerView extends Sprite
	{
		//data
		private var _model:PlayerData = PlayerData.getInstance()
		
		// background
		private var _bg               :Sprite = new Sprite();
		
		// interface elements
		private var _pauseBtn         :PauseButton;
		private var _playBtn          :PlayButton;
		private var _prevBtn          :PreviousButton;
		private var _nextBtn          :NextButton;
		private var _volumeBtn        :VolumeButton;
		private var _fullScreenButton :FullScreenButton;
		private var _scrubber         :ScrubberView;

		// states
		private var _paused:Boolean;
		private var _fullScreen:Boolean;
		
		public function ControllerView()
		{
			super();
			// initialize the views
			_pauseBtn            = new PauseButton();
			_playBtn             = new PlayButton();
			_prevBtn             = new PreviousButton();
			_nextBtn             = new NextButton()
			_volumeBtn           = new VolumeButton();
			_scrubber            = new ScrubberView();
			_fullScreenButton    = new FullScreenButton();
			
			
			_bg.graphics.beginFill(_model.colorSecondary,.8);
			_bg.graphics.drawRoundRect(0,0,520,50,5)
			_bg.graphics.endFill()
			
			_fullScreenButton.y=
			_volumeBtn.y=
			_nextBtn.y= 
			_prevBtn.y=
			_playBtn.y=
			_pauseBtn.y              = 5;
			
			_playBtn.x=
			_pauseBtn.x              = 50;
			
			_prevBtn.x               = 5
			_nextBtn.x               = 95
			_volumeBtn.x             = 430
			_fullScreenButton.x      = 475
			_scrubber.y              = 23;
			_scrubber.x              = 150;
			
			// initialize
			init()
		}
		/**
		 *initializer: called by constructor 
		 * 
		 */		
		private function init():void{
			// add views to stage.
			addChild(_bg)
			addChild(_pauseBtn)
			addChild(_playBtn)
			addChild(_prevBtn)
			addChild(_nextBtn)
			addChild(_volumeBtn)
			addChild(_scrubber)
			addChild(_fullScreenButton)
			
			// add mouse listeners/handlers
			_pauseBtn.addEventListener(MouseEvent.CLICK,pauseClickHandler)
			_playBtn.addEventListener(MouseEvent.CLICK,playClickHandler)
			_fullScreenButton.addEventListener(MouseEvent.CLICK,fsClickHandler)
			
			
			// set defaults...
			togglePlayPause()
			_scrubber.progressBar.scaleX=0;
			_scrubber.loadedBar.scaleX=0;
            
			
		}
        /**
        * click handlers:
        * - playClickHandler
        * - pauseClickHandler
        *
        * */
        		
		private function pauseClickHandler(e:MouseEvent):void{
			var evt:PlayPauseEvent =new PlayPauseEvent()
            evt.dispatch();
			togglePlayPause()
		}
		private function playClickHandler(e:MouseEvent):void{
			var evt:PlayPauseEvent =new PlayPauseEvent()
            evt.dispatch();
			togglePlayPause()	
		}
		private function fsClickHandler(e:MouseEvent):void{
			var evt:FullScreenVideoEvent = new FullScreenVideoEvent();
			evt.dispatch();
		}
		
		
		
		/**
		 *toggles play/pause button and sets paused to true 
		 * 
		 */		
		public function togglePlayPause():void{
			
			if(_paused){
				_paused=false;
				_pauseBtn.visible   = true;
				_playBtn.visible    = false;
			}else{
				_paused=true;
				_pauseBtn.visible   = false;
				_playBtn.visible    = true;
			}	
		}
		public function get progressBar():Sprite{
			return _scrubber.progressBar;
		}
		public function get loadedBar():Sprite{
            return _scrubber.loadedBar;
        }
        public function get timeDisplay():TextField{
        	return _scrubber.dragger.timeDisplay;
        }
        public function set fullscreen(bool:Boolean):void{
            _fullScreen = bool;
            if(_fullScreen){
              
                this.x =_model.ScreenWidth/2-(this.width/2);
                this.y = _model.ScreenHeight-this.height;
        }else{
               this.x = 0;
               this.y = (_model.AppHeight+18)-this.height;
            }
        }
	}
}