package com.husky.model
{
	import com.husky.utils.TimeTool;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	public class VideoPlayerState
	{
		
		private var _model:PlayerData = PlayerData.getInstance()
		public function VideoPlayerState()
		{
		}
		
		public var player:Boolean;
		
		public var currentFeed:String;
		public var fullScreen:Boolean;
		
		public var controllerMode:int;
		public var playing:Boolean;
		public var paused:Boolean=false;
		public var muted:Boolean=false;
		public var autoHide:Boolean;
		
		public function update(e:Event):void{
			try{
		       var perc:Number = Math.floor((_model.ns.time/_model.metaData.duration)*100)/100;
			   var loaded:Number = Math.floor((_model.ns.bytesLoaded/_model.ns.bytesTotal)*100)/100;
               _model.videoControllerView.progressBar.scaleX = perc;
               _model.videoControllerView.loadedBar.scaleX = loaded;
               _model.videoControllerView.timeDisplay.text = TimeTool.generateTime(_model.ns.time);
        	}catch(e:ErrorEvent){
			   	
			}
		}
	}
}