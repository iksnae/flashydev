package com.husky.view.ui
{
	import com.husky.model.PlayerData;
	import com.husky.view.ui.icons.VolumeIcon;
	
	import flash.display.Sprite;

	public class VolumeButton extends Sprite
	{
		private var _model:PlayerData = PlayerData.getInstance()
		private var _bg:Sprite=new Sprite();
		
		private var icon0:VolumeIcon;
		
		public function VolumeButton()
		{
			addChild(_bg);
			_bg.graphics.beginFill(_model.colorPrimary,.2);
			_bg.graphics.drawRoundRect(0,0,40,40,5);
			_bg.graphics.endFill();
			super();
			
			icon0 = new VolumeIcon(_model.colorPrimary)
			addChild(icon0)
		}
		
	}
}