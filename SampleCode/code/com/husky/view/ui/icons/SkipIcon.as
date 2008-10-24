package com.husky.view.ui.icons
{
	import flash.display.Sprite;

	public class SkipIcon extends Sprite
	{
		private var _color:uint;
		public function SkipIcon(color:uint=0xffffff)
		{
			_color=color
			y=11;
			x=3;
			init();
		}
		private function init():void{
			graphics.beginFill(_color);
			graphics.moveTo(10,0)
			graphics.lineTo(22,9)
			graphics.lineTo(10,18)
			graphics.lineTo(10,0)
			
			graphics.drawRect(25,0,2,18)
			
			graphics.endFill()
		}
		
		
	}
}