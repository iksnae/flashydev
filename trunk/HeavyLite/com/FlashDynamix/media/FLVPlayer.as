package com.FlashDynamix.media{

	import flash.net.*;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.utils.Timer;
	
	import flash.events.TimerEvent;
	import flash.events.NetStatusEvent;
	
	import flash.events.EventDispatcher;
	
	import com.FlashDynamix.events.FLVPlayerEvent;

	public class FLVPlayer extends EventDispatcher {

		private var vid:Video;
		private var nc:NetConnection;
		private var ns:NetStream;

		private var _buffering:Boolean = false;
		private var _bufferTime:Number = 5;
		private var timer:Timer;
		private var _duration:Number = 0;

		public function FLVPlayer(v:Video) {
			vid = v;

			nc = new NetConnection();
			nc.connect(null);

			ns = new NetStream(nc);
			ns.bufferTime = _bufferTime;
			ns.client = {onMetaData:onMeta};
			vid.attachNetStream(ns);
			
		}
		private function onMeta(data:Object) {
			duration = Number(data.duration);
		}
		private function onUpdate(e:TimerEvent){
			if(loaded<1){
				if((_buffering && buffer>.95) || (!_buffering && buffer<.05)){
					_buffering = buffer<.05;
					dispatchEvent(new FLVPlayerEvent(FLVPlayerEvent.UPDATE, true, true));
				}
			} else if(Math.floor(time) == Math.floor(duration)) {
				timer.stop();
				_buffering = false;
				dispatchEvent(new FLVPlayerEvent(FLVPlayerEvent.COMPLETE, true, true));
			}
		}
		public function play(url:String) {
			ns.play(url);
			timer = new Timer(50);
			timer.addEventListener(TimerEvent.TIMER, onUpdate);
			timer.start();
		}
		public function stop() {
			ns.pause();
			ns.seek(0);
		}
		public function pause() {
			ns.togglePause();
		}
		public function rewind() {
			ns.seek(0);
		}
		public function seek(per:Number){
			ns.seek(Math.min(loaded, per)*duration);
		}
		public function soundOn(flag:Boolean) {
			ns.soundTransform = (flag)?new SoundTransform(1): new SoundTransform(0);
		}
		public function set duration(num:Number) {
			_duration = num
		}
		public function get duration():Number {
			return _duration;
		}
		public function get loaded():Number {
			if(ns.bytesLoaded<10) return 0;
			return Math.max(0, Math.min(1, ns.bytesLoaded / ns.bytesTotal));
		}
		public function get progress():Number {
			if(duration == 0) return 0;
			return Math.max(0, Math.min(1, time / duration));
		}
		public function get buffer():Number {
			return Math.max(0, Math.min(1, ns.bufferLength / ns.bufferTime));
		}
		public function get time():Number {
			return ns.time;
		}
		public function get timeLoaded():Number {
			return loaded*duration;
		}
		public function get buffering():Boolean {
			return _buffering;
		}
	}
}