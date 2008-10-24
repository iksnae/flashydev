package com.husky.view.ui
{
	import com.husky.model.PlayerData;
	import com.husky.view.ui.icons.FullScreenIcon;
	
	import flash.display.Sprite;
	
	public class FullScreenButton extends ButtonView
	{
		private var _model:PlayerData = PlayerData.getInstance()
		private var _bg:Sprite=new Sprite();
		private var _overIcon:FullScreenIcon;
		private var _offIcon:FullScreenIcon;
		
		public function FullScreenButton()
		{
			addChild(_bg);
			_bg.graphics.beginFill(_model.colorPrimary,.2);
			_bg.graphics.drawRoundRect(0,0,40,40,5);
			_bg.graphics.endFill();
			super();
			_overIcon = new FullScreenIcon(_model.colorThird);
			_offIcon  = new FullScreenIcon(_model.colorPrimary);
			overState.addChild(_overIcon)
			offState.addChild(_offIcon)
		}
		
	}
}