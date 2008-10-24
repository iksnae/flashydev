package com.husky.view.ui
{
	import com.husky.model.PlayerData;
	import com.husky.view.ui.icons.PlayIcon;
	
	import flash.display.Sprite;
	
	public class PlayButton extends ButtonView
	{
		private var _model:PlayerData = PlayerData.getInstance();
		private var _bg:Sprite=new Sprite();
		private var _overIcon:PlayIcon;
		private var _offIcon:PlayIcon;
		
		public function PlayButton()
		{
			addChild(_bg);
			_bg.graphics.beginFill(_model.colorPrimary,.2);
			_bg.graphics.drawRoundRect(0,0,40,40,5);
			_bg.graphics.endFill();
			super();
			_overIcon = new PlayIcon(_model.colorThird);
			_offIcon  = new PlayIcon(_model.colorPrimary);
			overState.addChild(_overIcon)
			offState.addChild(_offIcon)
		}
		
	}
}