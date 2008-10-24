package com.husky.view.ui.icons
{
	import flash.display.Sprite;

	public class VolumeIcon extends Sprite
	{
		private var _color:uint;
		private var _bars:int=5;
		private var _lo:Number=5;
		private var _hi:Number=15;
		private var _barsize:Number=5;
		private var _spacing:Number=1.5;
		public function VolumeIcon(color:uint=0xffffff)
		{
			super();
			x = 5
			y = _hi;
			_color= color;
			init();
			
		}
		private function init():void{
			var dist:Number = _hi- _lo;
			var diff:Number = dist/ _bars;
			graphics.beginFill(_color)
		//	graphics.lineStyle(1,0xfff)
			graphics.moveTo(0,_hi)
			for( var i:int=0;i<_bars;i++){
				graphics.lineTo(i*(_barsize+_spacing),_lo-(diff*i))
				graphics.lineTo( (i*(_barsize+_spacing))+_barsize, (_lo-(diff*i))-(diff))
				graphics.lineTo( (i*(_barsize+_spacing))+_barsize,_hi)
				graphics.lineTo( (i*(_barsize+_spacing))+(_barsize+_spacing), _hi)
			}
		}
	}
}