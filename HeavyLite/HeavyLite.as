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
	import heavy.heavyPlayButton;
	import heavy.heavyStopButton;
	import heavy.AdViewController;
	import heavy.HeavyCloseButton;
	

	public class HeavyLite extends Sprite
	{
		public var yt:YouTube;
		
		private var __youtubeDevID:String 	= 'fqvXEj7gYlo';
		private var __videoPlayer:Video 	= new Video();
		private var __youTubePlayer:FLVPlayer = new FLVPlayer(__videoPlayer);
		private var __videoHolder:Sprite	= new Sprite();
		
		private var __playButton:heavyPlayButton = new heavyPlayButton();
		private var __stopButton:heavyStopButton = new heavyStopButton();
		private var __closeButton:HeavyCloseButton = new HeavyCloseButton();
		
		private var __adViewer:AdViewController = new AdViewController();
		
		
		
		public function HeavyLite()
		{
			//draw video bg
			__videoHolder.graphics.beginFill(0x000000);
			__videoHolder.graphics.drawRect(0,0,320,240);
			__videoHolder.graphics.endFill();
			
			// add videoplayer to holder
			//__videoHolder.scaleX=1.5;
			//__videoHolder.scaleY=1.5;
			__videoHolder.addChild(__videoPlayer);
			__videoHolder.addChild(__closeButton);
			trace('heavy light')
		
			// add holder to stage...
			addChild(__videoHolder);
		
			//call init method
			init();
		}
		
		public function playVideo(id:String):void{
			getVideo(id);
		}
		
		private function init():void{
			//init youtube instance
			yt = new YouTube();
			//addlisteners
			yt.addEventListener(YouTubeEvent.COMPLETE,	ytLoaded);
			yt.addEventListener(YouTubeEvent.ERROR,		ytError);
			
			createControls();
		}
		
		private function showVideoPlayer():void{
			
		}
		
		private function createControls():void{
			var spr:Sprite = new Sprite();
			spr.graphics.beginFill(0x666666,.5);
			spr.graphics.drawRoundRect(5,5,630,25,5);
			spr.graphics.endFill();
			spr.y=220;
			spr.scaleX=.5;
			spr.scaleY=.5;
			
			// add the kids
			spr.addChild(__playButton);
			spr.addChild(__stopButton);
		
			
			__videoHolder.addChild(spr);
			//
			__playButton.addEventListener(MouseEvent.CLICK,playButtonClicked);
		}
		
		private function playButtonClicked(e:MouseEvent):void{
			playVideo('84zv1odQwjo');
		}
		
		private function ytLoaded(e:YouTubeEvent):void{
			trace('loaded: '+e.method);
			switch(e.method){
				case YouTube.VIDEOID:
					try{
						__youTubePlayer.play(YouTube.FLVUrl+e.data.id+"&t="+e.data.t);
					}catch(e:ArgumentError){
						trace('video could not play');
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
		private function getVideo(id:String):void{
			yt.getVideoId(id);
			yt.videoIdDetails(id);
		}
	}
}