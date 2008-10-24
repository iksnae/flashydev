package com.husky.view.ui
{
	import com.carlcalderon.Debug;
	import com.husky.model.PlayerData;
	import com.husky.model.VideoPlayerState;
	import com.husky.model.proxies.FVLVideoProxy;
	import com.husky.model.proxies.HeavyProxy;
	import com.husky.model.proxies.VideoProxy;
	import com.husky.model.proxies.YouTubeProxy;
	
	import flash.display.Sprite;
	import flash.media.Video;

	public class VideoView extends Sprite
	{
		private var _model:PlayerData = PlayerData.getInstance()
		private var _bg:Sprite = new Sprite()
        private var _width:Number = 520;
		private var _height:Number = 340;
		
        private var _video:Video = new Video(_width,_height)
        
		private var _videoProxy:VideoProxy;
		private var _thumb:Sprite = new Sprite();
		private var _fullScreen:Boolean;
		public var videoState:VideoPlayerState=new VideoPlayerState();
		
		public function VideoView()
		{
			super();
			
			_bg.graphics.beginFill(0x000000);
			_bg.graphics.drawRect(0,0,_width,_height);
			_bg.graphics.endFill();
			
			addChild(_bg);
			addChild(_thumb);
			addChild(_video);
			
		}
		
		public function get video():Video{
			return _video;
		}
		public function get videoProxy():VideoProxy{
            return _videoProxy;
        }
        public function get thumb():Sprite{
            return _thumb;
        }
		
		public function set proxy(type:String):void{
			Debug.log('VideoView.proxy: '+type)
			switch(type){
				case 'heavy':
				    _videoProxy = new HeavyProxy();
				    _videoProxy.init();
				break;
				case 'youtube':
                    _videoProxy = new YouTubeProxy();
                    _videoProxy.init()
                break;
                case 'flv':
                    _videoProxy = new FVLVideoProxy();
                break;
			}
		}
		public function set fullscreen(bool:Boolean):void{
			_fullScreen = bool;
			if(_fullScreen){
				Debug.log('W: '+_model.ScreenWidth);
				this.width =_model.ScreenWidth;
				this.height = _model.ScreenHeight;
  		}else{
				this.width  = _width;
	            this.height = _height;
    		}
		}
		
	}
}