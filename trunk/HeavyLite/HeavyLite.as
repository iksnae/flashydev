package {
	/*
	import framework classes
	*/
	import flash.display.*;
	import flash.net.*;
	import flash.events.*;
	import flash.text.*;
	import flash.media.*;
	
	import fl.controls.*;
	import fl.data.*;
	import fl.events.*;
	
	import fl.managers.StyleManager;
	
	/*
	import youtube api classes... thanks to FlashDynamix
	*/
	
	import com.FlashDynamix.services.YouTube;
	import com.FlashDynamix.events.YouTubeEvent;
	import com.FlashDynamix.controls.ui.VideoController;
	import com.FlashDynamix.media.FLVPlayer;
	

	public class HeavyLite extends Sprite
	{
		public var yt:YouTube;
		
		
		private var __videoList:List;
		private var __youtubeDevID:String 	= 'fqvXEj7gYlo';
		private var __videoPlayer:Video 	= new Video();
		private var __youTubePlayer:FLVPlayer = new FLVPlayer(__videoPlayer);
		private var __videoHolder:Sprite	= new Sprite();
		
		
		
		
		public function HeavyLite()
		{
			//draw video bg
			__videoHolder.graphics.beginFill(0x000000);
			__videoHolder.graphics.drawRect(0,0,320,240);
			__videoHolder.graphics.endFill();
			// add videoplayer to holder
			__videoHolder.addChild(__videoPlayer);
			// add holder to stage...
			addChild(__videoHolder);
			//call init method
			init();
		}
		private function init():void{
			//init youtube instance
			yt = new YouTube();
			//addlisteners
			yt.addEventListener(YouTubeEvent.COMPLETE,	ytLoaded);
			yt.addEventListener(YouTubeEvent.ERROR,		ytError);
			
			createControls();
		}
		private function createControls():void{
			var spr:Sprite = new Sprite();
			spr.graphics.beginFill(0x666666);
			spr.graphics.drawRoundRect(5,5,310,25,5);
			spr.graphics.endFill();
			spr.y=205;
			__videoHolder.addChild(spr);
		}
		private function ytLoaded(e:YouTubeEvent):void{
			trace('loaded: '+e.method);
			switch(e.method){
				case YouTube.VIDEOID:
					try{
						__youTubePlayer.play(YouTube.FLVUrl+e.data.id+"&t="+e.data.t);
					}catch(e:ArgumentError){
						trace('video could not play')
					}
				break;
			}
		}
		private function ytError(e:YouTubeEvent):void{
			trace('error loading youtube video');
		}
		private function getThumbnail(str:String):String{
			var thumbURL:String = 'http://i.ytimg.com/vi/'+str+'/default.jpg';
			return thumbURL;
		}
	}
}