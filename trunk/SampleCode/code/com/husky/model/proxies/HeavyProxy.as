package com.husky.model.proxies
{
	import com.carlcalderon.Debug;
	import com.husky.model.PlayerData;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	/**
	 *HeavyProxy Class 
	 * @author iksnae
	 */	
	
	public class HeavyProxy implements VideoProxy
	{
		private var _model:PlayerData = PlayerData.getInstance()
		private var thumbLoader:Loader;
		public function HeavyProxy()
		{
		}

		public function init():void
		{
			getData()
		}
		
		
		
		public function getData():void{
			Debug.log('HeavyProxy.playVideo: '+_model.videoID)
            var query:String='http://www.heavy.com/gateway/video_detail/v3/'+_model.locale+'/'+_model.videoID
        
            var loader:URLLoader = new URLLoader()
            var request:URLRequest = new URLRequest(query)
            request.method = URLRequestMethod.GET;
            loader.addEventListener(Event.COMPLETE, dataLoaded)
            loader.load(request)
		}
		
		public function playVideo():void
		{
			_model.ns.play(_model.videoURL)
		}
		private function dataLoaded(e:Event):void{
			var dataXML:XML = new XML(URLLoader(e.target).data);
			
			
			
			var thumbURL:String = dataXML.thumb;
			var videoURL:String = dataXML..source.@src;
			trace(e.target.data)
			trace("video: "+videoURL)
			trace("thumb: "+thumbURL);
			/*
			var incre:int=0
			for(var i in dataString){
			    trace(incre+': '+i)
			    incre++
			}
			*/
			_model.videoURL = videoURL;
			Debug.log("Heavy FLV: "+_model.videoURL)
			thumbLoader = new Loader()

            thumbLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, thumbReady)
            thumbLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError)
            thumbLoader.load(new URLRequest(thumbURL))
		}
		private function thumbReady(e:Event):void{
            Debug.log('Thumbnail Loaded')
            thumbLoader.width = _model.AppWidth
            thumbLoader.height = _model.videoView.height
            
            _model.app.showThumb(thumbLoader)
            
            if(_model.autoplay){
                _model.videoControllerView['playpause_btn'].toggle()
                _model.app.overlayView.alpha=0;
                _model.videoState.playing=true;
                _model.videoTimer.videoTimer.start();
               playVideo()
            }
            
        }
        private function onIOError(e:IOErrorEvent):void{
        	Debug.log('onIOError: '+e.text)
        }
		
	}
}