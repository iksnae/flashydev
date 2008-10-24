package com.husky.view.ui
{
	import com.husky.model.PlayerData;
	import com.husky.view.ui.icons.PauseIcon;
	
	import flash.display.Sprite;
	
	public class PauseButton extends ButtonView
	{
		private var _model:PlayerData = PlayerData.getInstance()
		private var _bg:Sprite=new Sprite();
		private var _overIcon:PauseIcon;
		private var _offIcon:PauseIcon;
		
		
		public function PauseButton()
		{
			addChild(_bg);
			_bg.graphics.beginFill(_model.colorPrimary,.2);
			_bg.graphics.drawRoundRect(0,0,40,40,5);
			_bg.graphics.endFill();
			super();
			_overIcon = new PauseIcon(_model.colorThird);
			_offIcon  = new PauseIcon(_model.colorPrimary);
			overState.addChild(_overIcon)
			offState.addChild(_offIcon)
		}
		
	}
}