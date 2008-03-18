package com.FlashDynamix.controls.ui{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.media.Video;
	import flash.utils.Timer;

	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.FlashDynamix.controls.ui.VideoPlayback;
	import com.FlashDynamix.events.VideoPlaybackEvent;
	import com.FlashDynamix.events.FLVPlayerEvent;
	import com.FlashDynamix.media.FLVPlayer;

	public class VideoController extends Sprite {

		private var fvp:FLVPlayer;
		private var timer:Timer;

		public function VideoController() {

			fvp = new FLVPlayer(myVid);
			timer = new Timer(50);
			
			timer.addEventListener(TimerEvent.TIMER, onRefresh);
			playback.addEventListener(VideoPlaybackEvent.CLICK, onClick);
			fvp.addEventListener(FLVPlayerEvent.UPDATE, onUpdate);
			fvp.addEventListener(FLVPlayerEvent.COMPLETE, onComplete);
			playAgainPB.addEventListener(MouseEvent.CLICK, function(){
				playAgainPB.visible = false;
				fvp.rewind();
			});
			poller.addEventListener(Event.ENTER_FRAME, function(){;
				poller.arrow.rotation -= 15;
			});

			timer.start();
			playAgainPB.visible = false;
			poller.visible = false;
		}
		public function play(url:String) {
			fvp.play(url);
		}
		private function onRefresh(e:TimerEvent){
			playback.loaded = fvp.loaded;
			playback.progress = fvp.progress;
			var secs:String = uint(fvp.time%60).toString();
			secs = (secs.length == 1)?"0"+secs:secs;
			var mins:String = uint(fvp.time/60).toString();
			mins = (mins.length == 1)?"0"+mins:mins;
			playback.info = mins+":"+secs;
		}
		private function onUpdate(e:FLVPlayerEvent) {
			poller.visible = fvp.buffering;
		}
		private function onComplete(e:FLVPlayerEvent) {
			poller.visible = false;
			playAgainPB.visible = true;
		}
		private function onClick(e:VideoPlaybackEvent) {
			switch (e.method) {
				case VideoPlayback.REWIND :
					fvp.rewind();
					break;
				case VideoPlayback.PAUSE :
					fvp.pause();
					break;
				case VideoPlayback.PLAY :
					fvp.pause();
					break;
				case VideoPlayback.SOUND :
					fvp.soundOn(playback.soundOn);
					break;
				case VideoPlayback.SEEK :
					fvp.seek(e.value);
					break;
			}
		}
	}
}