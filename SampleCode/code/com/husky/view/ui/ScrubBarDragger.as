package com.husky.view.ui
{
	import com.husky.model.PlayerData;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class ScrubBarDragger extends Sprite
	{
		private var _model:PlayerData = PlayerData.getInstance()
		private var _carrot:Sprite;
		private var _timeDisplay:TextField;
		private var _hit:Sprite;
		private var _style:TextFormat= new TextFormat()
		
		public function ScrubBarDragger()
		{
			super();
			_carrot      = drawCarrot(_model.colorThird);
			_timeDisplay = new TextField()
			_hit         = new Sprite();
			
			
			
			_style.color= _model.colorPrimary;
			_style.font = 'Arial'
			_style.size = 12;
			_style.align = TextFormatAlign.CENTER;
			
			_timeDisplay.defaultTextFormat = _style;
			_timeDisplay.width=30;
			_timeDisplay.selectable=false;
			
			addChild(_timeDisplay);
			addChild(_carrot)
			addChild(_hit)
			
			
			
			_hit.graphics.beginFill(0x666,0);
			_hit.graphics.drawRect(0,-15,width,height)
			_hit.graphics.endFill();
			
			
			_timeDisplay.text = '0:00'
			_timeDisplay.y=5;
			_timeDisplay.x=-12;
			
			
			mouseChildren=false;
			buttonMode=true
		}
		private function drawCarrot(color:uint):Sprite{
			var spr:Sprite=new Sprite()
			spr.graphics.beginFill(color)
			spr.graphics.lineTo(20,0)
			spr.graphics.lineTo(10,15)
			spr.graphics.lineTo(0,0);
			spr.y=-15;
			spr.x=-10;
			return spr;
		}
		public function get timeDisplay():TextField{
			return _timeDisplay
		}
		
	}
}