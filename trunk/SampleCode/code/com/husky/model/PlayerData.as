package com.husky.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import com.husky.control.VideoTimer;
	import com.husky.view.ControllerView;
	import com.husky.view.ui.VideoView;
	
	import flash.net.NetConnection;
	import flash.net.NetStream;

	public class PlayerData implements IModelLocator
	{
		
		// instantiation related objects
		public function PlayerData(enf:SingletonEnforcer){};
		static private var instance:PlayerData=null;
		static public function getInstance():PlayerData{
			if(instance == null) instance = new PlayerData(new SingletonEnforcer());
			return instance;
		}
		
		
		
		// url passed in by flash vars...
		public var hostURL:String;
	
		public const VERSION:String = '1.3';
		
        public var app:HeavyVPlayer;
        public var flashVars:Object;
        
        public var colorPrimary:uint    = 0xffffff;
        public var colorSecondary:uint  = 0x000000;
        public var colorThird:uint      = 0x6cbedc;
		
		
		public var locale:String='US'
		
		public var videoURL:String;
		public var videoState:VideoPlayerState;
		public var videoView:VideoView;
		public var videoControllerView:ControllerView;
		public var videoID:String;
		public var videoSource:String;
		public var videoTimer:VideoTimer;
		
		
		public var metaData:*
		public var ns:NetStream;
		public var nc:NetConnection;
		public var client:Object;
		
		
		public var AppWidth:Number;
		public var AppHeight:Number;
		public var ScreenHeight:Number;
		public var ScreenWidth:Number;
        
		public var autoplay:Boolean;
		public var lowerThird:String;
		public var paused:Boolean;
        
		
		
		
	}
}
class SingletonEnforcer{}