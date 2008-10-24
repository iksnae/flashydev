package com.husky.view.ui.icons
{
	import flash.display.Sprite;
	
	public class PlayIcon extends Sprite
	{
		private var _color:uint;
		public function PlayIcon(color:uint=0xffffff)
		{
			_color = color;
			x=10;
			y=5.5
			init();
		}
		private function init():void{
			graphics.beginFill(_color);
			graphics.moveTo(0,0)
			graphics.lineTo(24,14.5)
			graphics.lineTo(0,29)
			graphics.lineTo(0,0)
			graphics.endFill()
		}
	}
}