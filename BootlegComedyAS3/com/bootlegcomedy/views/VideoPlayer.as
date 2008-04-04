package com.bootlegcomedy.views
{
	import flash.display.Sprite;
	import flash.media.Video;


	public class VideoPlayer extends Sprite
	{
		public var videoplayer:Video=new Video();
		private var bg:Sprite=new Sprite();
		private var PlayPauseButton;
		private var FullscreenButton;
		private var Seekbar;
		
		
		
		
		function VideoPlayer():void{
			init();
		}
		private function init():void{
			
			
			
			bg.graphics.beginFill(0x666666,.5);
			bg.graphics.drawRect(0,0,600,450);
			bg.graphics.endFill();
			
			addChild(bg);
			addChild(videoplayer);
		}
		
	}
}