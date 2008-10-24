package com.husky.model.proxies
{
	import com.carlcalderon.Debug;
	import com.husky.event.FLVStreamReadyEvent;
	import com.husky.model.PlayerData;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class YouTubeProxy implements VideoProxy
	{
		private var _model:PlayerData = PlayerData.getInstance()
		private var loader:Loader;
		private var thumbLoader:Loader;
		private var abortID:uint;
		
		private var regularURL:String;
		private var streamURL:String;
		
		public function YouTubeProxy()
		{
			super();
			regularURL = 'http://youtube.com/v/'+_model.videoID;
			loader = new Loader()
			thumbLoader = new Loader()
			loader.contentLoaderInfo.addEventListener(Event.INIT,onInit)
			thumbLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, thumbReady)
		}
		public function init():void{
			Debug.log('initiating YouTubeProxy');
			if(!_model.autoplay){
			    getThumbnail()
			}else{
				_model.videoControllerView.togglePlayPause()
				_model.app.overlayView.alpha=0;
				_model.videoState.playing=true;
				_model.videoTimer.videoTimer.start();
				getVideo();
				
			}
		}
		private function getThumbnail():void{
			//regularURL = 'http://youtube.com/v/'+_model.contentID;
			thumbLoader.load(new URLRequest('http://i2.ytimg.com/vi/'+_model.videoID+'/0.jpg'))
            	
   			
		
		}
		public function getVideo():void{
            var req:URLRequest = new URLRequest(regularURL)
            req.method = URLRequestMethod.GET;
    
            loader.load(req)
            Debug.log('loading video...')
            
        }
		private function onInit(evt:Event):void{
			Debug.log ("Loaded, processing: " + loader.contentLoaderInfo.url);
            var urlVars:URLVariables = new URLVariables ();
            urlVars.decode (loader.contentLoaderInfo.url.split("?")[1]);
            Debug.log ("Processed:-");
            Debug.log ("-------> video_id:" + urlVars.video_id);
            Debug.log ("-------> t param:" + urlVars.t);
            Debug.log ("-------> thumbnail-url:" + urlVars.iurl);
            streamURL = constructFLVURL(urlVars.video_id,urlVars.t)
            _model.videoURL = streamURL;
            Debug.log ("YouTube FLV URL: " + streamURL);
       
            //Debug.log ("Started Playing Video...");
            loader.unload();
            
            var fire:FLVStreamReadyEvent = new FLVStreamReadyEvent()
            fire.dispatch()
           
            
		}
		private function thumbReady(e:Event):void{
			Debug.log('Thumbnail Loaded')
			thumbLoader.width = _model.AppWidth
			thumbLoader.height = _model.videoView.height
			
			_model.app.showThumb(thumbLoader)
			
		}
		private function constructFLVURL(video_id:String, t:String):String{
			var str:String = "http://www.youtube.com/get_video.php?";
                str += "video_id=" + video_id;
                str += "&t=" + t;
                return str;
		}
		public function playVideo():void{
			getVideo();
		}
	}
}