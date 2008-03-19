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
	
	
	import gs.TweenLite;
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
		private var __centeredHolder:Sprite = new Sprite();
		private var __videoHolder:Sprite	= new Sprite();
		private var __dimmer:Sprite=new Sprite();
		private var __bg:Sprite=new Sprite();
		private var __thumbHolder:Sprite=new Sprite();
		
		private var __playButton:heavyPlayButton = new heavyPlayButton();
		private var __stopButton:heavyStopButton = new heavyStopButton();
		private var __closeButton:HeavyCloseButton = new HeavyCloseButton();
		
		private var __adViewer:AdViewController = new AdViewController();
		private var __allVideos:Array= new Array();
		private var __allThumbs:Array= new Array();
		
		
		
		public function HeavyLite()
		{
			//draw video bg
			__videoHolder.graphics.beginFill(0x000000);
			__videoHolder.graphics.drawRect(0,0,320,240);
			__videoHolder.graphics.endFill();
			
			
			// add videoplayer to holder
			__videoHolder.addChild(__videoPlayer);
			__videoHolder.addChild(__adViewer);
			__videoHolder.addChild(__closeButton);
			__videoHolder.x=-160;
			__videoHolder.y=-120;
			__centeredHolder.x=210;
			__centeredHolder.y=180;
			__centeredHolder.visible=false;
			
			// draw bg
			__bg.graphics.beginFill(0x000000);
			__bg.graphics.drawRect(-200,-200,3000,2000);
			__bg.graphics.endFill();
			
			//draw dimmer..
			__dimmer.graphics.beginFill(0x000000,.6);
			__dimmer.graphics.drawRect(-200,-200,3000,2000);
			__dimmer.graphics.endFill();
			__dimmer.visible=false;
			
			// add holder to stage...
			__centeredHolder.addChild(__videoHolder);
			addChild(__bg);
			addChild(__thumbHolder);
			addChild(__dimmer);
			addChild(__centeredHolder);
			
			
			//call init method
			init();
		}
		
		
		
		public function playVideo(id:String):void{
			getVideo(id);
		}
		
		public function closePlayer(e:MouseEvent=null):void{
			hideVideoPlayer();
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
			__centeredHolder.alpha=0;
			__centeredHolder.visible=true;
			__dimmer.alpha=0;
			__dimmer.visible=true;
			TweenLite.to(__dimmer,.5,{alpha:1});
			TweenLite.to(__centeredHolder,.7,{alpha:1,scaleX:1.2,scaleY:1.2,delay:1});
		}
		private function hideVideoPlayer():void{
			__youTubePlayer.stop();
			TweenLite.to(__dimmer,1,{alpha:.5,delay:1});
			TweenLite.to(__centeredHolder,.7,{alpha:0,scaleX:1,scaleY:1,onComplete:disableVPlayer});
		}
		private function disableVPlayer():void{
			__centeredHolder.visible=false;
			__dimmer.visible=false;
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
			// add listeners
			__closeButton.addEventListener(MouseEvent.CLICK, closePlayer);
			__playButton.addEventListener(MouseEvent.CLICK,playButtonClicked);
			getVideos();
		}
		
		private function playButtonClicked(e:MouseEvent):void{
			playVideo('84zv1odQwjo');
		}
		
		private function ytLoaded(e:YouTubeEvent):void{
			trace('loaded: '+e.method);
			switch(e.method){
				case YouTube.VIDEOSBYTAG :
					try {
			//			addToVideoList(e.data);
						trace("Videos For Tag : " + e.request.tag + " : " + e.data.length());
						for(var i in e.data){
						//	trace(e.data[i].id);
						
							__allVideos.push(e.data[i].id);
							getThumbnail(e.data[i].id)
							
						}
					} catch (evt:ArgumentError) {
						trace("ERROR : No Videos For Tag");
					}
					break;
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
		private var row:Number=0;
		private var col:Number=0;
		
		private function getThumbnail(str:String):String{
			var thumbURL:String = 'http://i.ytimg.com/vi/'+str+'/default.jpg';
			var thumbLoader:Loader=new Loader();
		
			thumbLoader.load(new URLRequest(thumbURL));
			
			thumbLoader.x = col*60;
			thumbLoader.y = row*30;
			col++;
			if( col>=7){
				col=0;
				row++;
			}
			
			thumbLoader.scaleX=.5;
			thumbLoader.scaleY=.5;
			
			thumbLoader.addEventListener(MouseEvent.CLICK,thumbClicked);
			__thumbHolder.addChild(thumbLoader);
			trace(thumbURL);
			
			__allThumbs.push([thumbLoader,__allThumbs.length]);
			return thumbURL;
		}
		private function thumbClicked(e:MouseEvent):void{
			for(var i in __allThumbs){
				if(__allThumbs[i][0]==e.target){
					showVideoPlayer();
					playVideo(__allVideos[i]);
				}
			}
			
		}
		private function getVideos():void{
			yt.videosbyTag('heavy weapon');
		}
		private function getVideo(id:String):void{
			yt.getVideoId(id);
			yt.videoIdDetails(id);
		}
	}
}