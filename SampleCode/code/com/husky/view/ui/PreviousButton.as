package com.husky.view.ui
{
	import com.husky.model.PlayerData;
	import com.husky.view.ui.icons.SkipIcon;
	
	import flash.display.Sprite;
	
	public class PreviousButton extends ButtonView
	{
		private var _model:PlayerData = PlayerData.getInstance()
		private var _bg:Sprite=new Sprite();
		private var _overIcon:SkipIcon;
		private var _offIcon:SkipIcon;
		
		public function PreviousButton()
		{
			addChild(_bg);
			_bg.graphics.beginFill(_model.colorPrimary,.2);
			_bg.graphics.drawRoundRect(0,0,40,40,5);
			_bg.graphics.endFill();
			super();
			
			_overIcon = new SkipIcon(_model.colorThird);
			_offIcon = new SkipIcon(_model.colorPrimary);
			_offIcon.scaleX=_offIcon.scaleX=-1;
			_offIcon.x+= _offIcon.width*2;
			_overIcon.scaleX=_overIcon.scaleX=-1;
			_overIcon.x+= _overIcon.width*2;
			
			offState.addChild(_offIcon)
			overState.addChild(_overIcon)
			
		}
		private function init():void{
			
		}
		
	}
}