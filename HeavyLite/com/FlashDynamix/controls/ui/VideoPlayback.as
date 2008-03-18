package com.FlashDynamix.controls.ui{

	import com.FlashDynamix.events.VideoPlaybackEvent;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.media.SoundMixer;
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;

	public class VideoPlayback extends Sprite {

		private var _soundOn:Boolean = true;
		private var dispatcher:EventDispatcher;
		private var progressBar:MovieClip;
		private var loadBar:MovieClip;
		
		public var allowSeek:Boolean = false;

		public static  var REWIND:String = "rewind";
		public static  var PLAY:String = "play";
		public static  var PAUSE:String = "pause";
		public static  var SOUND:String = "sound";
		public static  var FULLSCREEN:String = "fullscreen";
		public static  var SEEK:String = "seek";

		public function VideoPlayback() {
			dispatcher = new EventDispatcher();

			progressBar = barHolder.progress;
			loadBar = barHolder.loaded;

			if(allowSeek){
				loadBar.addEventListener(MouseEvent.MOUSE_UP, onClick);
			}
			
			addPBHandler(rewindPB);
			addPBHandler(pausePB);
			addPBHandler(playPB);
			addPBHandler(soundTogglePB);
			
			playPB.alpha = 1;
			playPB.visible = false;
		}
		private function addPBHandler(item:SimpleButton) {
			item.addEventListener(MouseEvent.MOUSE_UP, onClick);
		}
		private function onClick(e:MouseEvent) {
			var evt:VideoPlaybackEvent = new VideoPlaybackEvent(VideoPlaybackEvent.CLICK, true, true, null);
			switch (e.target) {
				case rewindPB :
					evt.method = REWIND;
					break;
				case pausePB :
					evt.method = PAUSE;
					pausePB.visible = false;
					playPB.visible = true;
					break;
				case playPB :
					evt.method = PAUSE;
					pausePB.visible = true;
					playPB.visible = false;
					break;
				case soundTogglePB :
					_soundOn = !soundOn;
					if (soundOn) {
						soundTogglePB.alpha = 1;
					} else {
						soundTogglePB.alpha = 0.5;
					}
					evt.method = SOUND;
					break;
				case loadBar :
					var x:Number = loadBar.mouseX*loadBar.scaleX;
					evt.value =  Math.min(1, (x/205));
					evt.method = SEEK;
					break;
			}
			dispatcher.dispatchEvent(evt);
		}
		public function get soundOn():Boolean {
			return _soundOn;
		}
		public function set loaded(num:Number) {
			loadBar.scaleX = num;
		}
		public function set progress(num:Number) {
			progressBar.scaleX = num;
		}
		public function set info(txt:String){
			infoTxtBx.text = txt;
		}
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0.0, useWeakReference:Boolean=false):void {
			dispatcher.addEventListener(type, listener);
		}
	}
}