package com.husky.control.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.carlcalderon.Debug;
	import com.husky.control.VideoTimer;
	import com.husky.event.VideoPlayerReadyEvent;
	import com.husky.model.PlayerData;
	
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	public class InitVideoPlayerCommand implements ICommand
	{
		
		// data
		private var _model:PlayerData = PlayerData.getInstance();
		
		public function InitVideoPlayerCommand()
		{
		}

		public function execute(event:CairngormEvent):void
		{
			Debug.log('InitVideoPlayerCommand',Debug.GREEN)
			_model.nc = new NetConnection()
            _model.nc.connect(null)
            _model.ns = new NetStream(_model.nc);
            _model.ns.addEventListener(NetStatusEvent.NET_STATUS, _model.app.onNetStreamStatus)
            _model.ns.addEventListener(IOErrorEvent.IO_ERROR, _model.app.onIOErrorStatus)
         
            _model.client = new Object();
            _model.client.onPlayStatus =_model.app.onPlayStatus;
            _model.ns.client = _model.client;
            
            _model.client.onMetaData =  _model.app.onMetaData;

            /// remove event
            _model.app.commander.removeCommand(VideoPlayerReadyEvent.EVENT_ID)
            // 
            _model.videoTimer = new VideoTimer();
            _model.videoView.proxy = _model.videoSource;
            
            _model.videoView.video.attachNetStream(_model.ns)
           
            
           
		}
		
	}
}