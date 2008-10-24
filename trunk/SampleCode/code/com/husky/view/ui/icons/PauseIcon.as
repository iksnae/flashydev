package com.husky.view.ui.icons
{
	import flash.display.Sprite;
	
	public class PauseIcon extends Sprite
	{
		
		private var _color:uint;
		
		public function PauseIcon(color:uint=0xffffff)
		{
			_color=color;
			x = 9
			y = 7.5
			init();	
		}
		private function init():void{
			graphics.beginFill(_color);
			graphics.drawRect(0,0,7.5,25)
			graphics.drawRect(15,0,7.5,25)
			graphics.endFill();
		}
	}
}