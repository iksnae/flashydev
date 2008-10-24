package com.husky.view.ui.icons
{
	import flash.display.Sprite;

	public class FullScreenIcon extends Sprite
	{
		
		private var _color:uint;
		public function FullScreenIcon(color:uint=0xffffff)
		{
			super();
			_color=color;
			x = 6;
			y=10
			var view:Sprite = bracketSet();
			addChild(view)
		}
		
		private function bracket():Sprite{
			var spr:Sprite=new Sprite();
			spr.graphics.beginFill(_color);
			spr.graphics.lineTo(5,0);
			spr.graphics.lineTo(5,2);
			spr.graphics.lineTo(2,2);
			spr.graphics.lineTo(2,5);
			spr.graphics.lineTo(0,5);
			spr.graphics.lineTo(0,0)
			spr.graphics.endFill();
			return spr;
		}
		private function bracketSet():Sprite{
			var spr:Sprite = new Sprite();
			var bracket0:Sprite = bracket();
			var bracket1:Sprite = bracket();
			var bracket2:Sprite = bracket();
			var bracket3:Sprite = bracket();
			var block:Sprite = new Sprite()
			
			block.graphics.beginFill(_color);
			block.graphics.drawRect(4,4,20,12);
			block.graphics.endFill()
			
			bracket1.x=28;
			bracket1.rotation=90
			
			bracket2.x=28;
			bracket2.y=20;
			bracket2.rotation=180
			
			bracket3.y=20;
			bracket3.rotation=-90
			
			
			spr.addChild(bracket0);
			spr.addChild(bracket1);
			spr.addChild(bracket2);
			spr.addChild(bracket3);
			spr.addChild(block);
			 
			return spr;
		}
	}
}