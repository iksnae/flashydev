package com.bootlegcomedy.views
{
	import flash.display.Sprite;
	/*
	import youtube api classes... thanks to FlashDynamix
	*/
	
	import com.FlashDynamix.services.YouTube;
	import com.FlashDynamix.events.YouTubeEvent;
	//import com.FlashDynamix.controls.ui.VideoController;
	import com.FlashDynamix.media.FLVPlayer;
	import com.FlashDynamix.events.FLVPlayerEvent;
	import flash.text.TextField;
	import flash.display.Loader;
	import flash.net.URLRequest;

	public class VideoMediaView extends Sprite
	{
		private var yt:YouTube;
		private var vplayer:VideoPlayer= new VideoPlayer();
		private var vlister:VideoLister= new VideoLister();
		private var __youTubePlayer:FLVPlayer = new FLVPlayer(vplayer.videoplayer);
		
		
		private var __allVideos:Array= new Array();
		private var __allThumbs:Array= new Array();
		private var __allTitles:Array = new Array();
		private var __kontrol:Sprite = new Sprite();
		private var __titleText:TextField = new TextField();
		private var __viewsText:TextField = new TextField();
		private var __lengthText:TextField = new TextField();
		private var __playingVideo:Boolean=false;
		
		
		public function VideoMediaView()
		{
			visible=false;
			alpha=0;
			init();
		}
		private function init():void{
			vlister.x=620;
			vplayer.x=10;
			yt = new YouTube();
			//addlisteners
			yt.addEventListener(YouTubeEvent.COMPLETE,	ytLoaded);
			yt.addEventListener(YouTubeEvent.ERROR,		ytError);

			__youTubePlayer.addEventListener(FLVPlayerEvent.UPDATE,flvUpdate);
			
			
			addChild(vplayer);
			addChild(vlister);
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
							var title = e
							__allVideos.push(e.data[i].id);
							__allTitles.push(e.data[i].title);
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
				case YouTube.VIDEOSPLAYLIST :
					try {
			//			addToVideoList(e.data);
		
						trace("Videos By Playlist: " + e.request.tag + " : " + e.data.length());
						for(var i in e.data){
						//	trace(e.data[i].id);
							var title = e
							__allVideos.push(e.data[i].id);
							__allTitles.push(e.data[i].title);
							getThumbnail(e.data[i].id)
							
						}
					} catch (evt:ArgumentError) {
						trace("ERROR : No Videos For Tag");
					}
				break;
				case YouTube.VIDEOIDDETAILS :
				//	writeLine("VIDEO ID DETAILS");
				trace('============================================')
					for each (var detail:XML in e.data.elements()) {
						trace(detail.name()+": "+detail);
					//	writeLine(detail.name()+": "+detail);
					}
					trace('============================================')
					var theDetails:XML = new XML(e.data);
					__titleText.text = theDetails..title;
					__viewsText.text = theDetails..view_count+' views';
					__lengthText.text = theDetails..length_seconds+' seconds';
				
					trace(e.data.elements())
					break;
			}
		}
		private function flvUpdate(e:FLVPlayerEvent):void {
			
			trace('phase: '+e)
		}
		private function ytError(e:YouTubeEvent):void{
			trace('error loading youtube video');
		}
		private function getThumbnail(str:String):String{
			var thumbURL:String = 'http://i.ytimg.com/vi/'+str+'/default.jpg';
			return thumbURL;
		}
		private function getVideos():void{
			yt.videosbyTag('bitch slap');
		//	yt.videosbyTag('ashy larry');
		//	yt.videosbyTag('bootlegcomedy');
			
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