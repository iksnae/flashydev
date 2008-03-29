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
	//import com.FlashDynamix.controls.ui.VideoController;
	import com.FlashDynamix.media.FLVPlayer;
	import com.FlashDynamix.events.FLVPlayerEvent;
	import heavy.heavyPlayButton;
	import heavy.heavyStopButton;
	import heavy.AdViewController;
	import heavy.HeavyCloseButton;
	import lt.uza.utils.Global;
	import flash.system.Security;
	

	public class HeavyLite extends Sprite
	{
		public var yt:YouTube;
		Security.loadPolicyFile('http://gdata.youtube.com/crossdomain.xml');
		private var global:Global = Global.getInstance();
		
		private var __currentTrack:String;
		private var __videoPlayer:Video 	= new Video();
		private var __youTubePlayer:FLVPlayer = new FLVPlayer(__videoPlayer);
		private var __centeredHolder:Sprite = new Sprite();
		private var __videoHolder:Sprite	= new Sprite();
		private var __hider:Sprite= new Sprite();
		private var __dimmer:Sprite=new Sprite();
		private var __bg:Sprite=new Sprite();
		private var __thumbHolder:Sprite=new Sprite();
		
		private var __playButton:heavyPlayButton = new heavyPlayButton();
		private var __stopButton:heavyStopButton = new heavyStopButton();
		private var __closeButton:HeavyCloseButton = new HeavyCloseButton();
		
		private var __adViewer:AdViewController;
		private var __allVideos:Array= new Array();
		private var __allThumbs:Array= new Array();
		private var kontrol:Sprite = new Sprite();
		private var __playingVideo:Boolean=false;
		
		
		
		public function HeavyLite()
		{
			global.playVideo=playVideo;
			__adViewer = new AdViewController(this);
			//draw video bg
			__videoHolder.graphics.beginFill(0xffffff);
			__videoHolder.graphics.drawRect(-10,-10,340,260);
			__videoHolder.graphics.endFill();
			
			__hider.graphics.beginFill(0x000000);
			__hider.graphics.drawRect(0,0,320,240);
			__hider.graphics.endFill();
			
			
			// add videoplayer to holder
			__videoHolder.addChild(__videoPlayer);
			__videoHolder.addChild(__hider);
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
			__dimmer.graphics.beginFill(0x000000,.8);
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
		
		public function playVideo():void{
			trace('play video: '+__currentTrack);
			kontrol.visible=true;
			getVideo(__currentTrack);
		}
		
		public function closePlayer(e=null):void{
			trace('showVideoPlayer')
			__adViewer.closeAd();
			__hider.alpha=1;
			if(__playingVideo){
				__playingVideo=true;
				__youTubePlayer.stop();
			}
			hideVideoPlayer();
		}
		
		private function init():void{
			//init youtube instance
			yt = new YouTube();
			//addlisteners
			yt.addEventListener(YouTubeEvent.COMPLETE,	ytLoaded);
			yt.addEventListener(YouTubeEvent.ERROR,		ytError);
			__youTubePlayer.addEventListener(FLVPlayerEvent.COMPLETE,closePlayer);
			__youTubePlayer.addEventListener(FLVPlayerEvent.UPDATE,flvUpdate);
			

			createControls();
		}
		private function flvUpdate(e:FLVPlayerEvent):void {
			 __hider.alpha=0;
			trace('phase: '+e)
		}
		
		private function showVideoPlayer():void{
			trace('showVideoPlayer')
			__centeredHolder.alpha=0;
			__centeredHolder.visible=true;
			__dimmer.alpha=0;
			__dimmer.visible=true;
			TweenLite.to(__dimmer,.5,{alpha:1});
			TweenLite.to(__centeredHolder,.3,{alpha:1,scaleX:1.2,scaleY:1.2,delay:.5});
		}
		private function hideVideoPlayer():void{
			trace('hideVideoPlayer');
			TweenLite.to(__dimmer,1,{alpha:.5});
			
			TweenLite.to(__centeredHolder,.3,{alpha:0,scaleX:1,scaleY:1,onComplete:disableVPlayer});
		}
		private function disableVPlayer():void{
			__centeredHolder.visible=false;
			__dimmer.visible=false;
			
		}
		
	
		private function createControls():void{
		
			kontrol.graphics.beginFill(0x666666,.5);
			kontrol.graphics.drawRoundRect(5,5,630,25,5);
			kontrol.graphics.endFill();
			
			kontrol.y=220;
			kontrol.scaleX=.5;
			kontrol.scaleY=.5;
			
			// add the kids
			kontrol.addChild(__playButton);
			kontrol.addChild(__stopButton);
			__stopButton.visible=false;
			
			__videoHolder.addChild(kontrol);
			// add listeners
			__closeButton.addEventListener(MouseEvent.CLICK, closePlayer);
			__playButton.addEventListener(MouseEvent.CLICK,playButtonClicked);
			__stopButton.addEventListener(MouseEvent.CLICK,playButtonClicked);
			
			//load the video thumbs/IDs
			getVideos();
		}
		
		private function playButtonClicked(e:MouseEvent):void{
			__youTubePlayer.pause();
		}
		private function stopButtonClicked(e:MouseEvent):void{
			__youTubePlayer.stop();
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
					__currentTrack = __allVideos[i];
					__adViewer.showAd(4);
					kontrol.visible=false;
				}
			}
			
		}
		
		private function getVideos():void{
			yt.videosbyTag('heavy funny');
		}
		private function getVideo(id:String):void{
			try{
				__playingVideo=true;
				trace('video loaded')
				yt.getVideoId(id);
				yt.videoIdDetails(id);
				
			}catch(e:ArgumentError){
				trace('video failed to load')
			}
		}
	}
}