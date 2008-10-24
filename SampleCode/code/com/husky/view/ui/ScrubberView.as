package com.husky.view.ui
{
	import com.husky.model.PlayerData;
	
	import flash.display.Sprite;
	/**
	 *scrubber view 
	 * @author iksnae
	 * 
	 */
	public class ScrubberView extends Sprite
	{
		private var _model:PlayerData = PlayerData.getInstance()
		private var _loadedBar:Sprite;
		private var _progressBar:Sprite;
		private var _bg:Sprite;
		private var _dragger:ScrubBarDragger;
		
		
		private var _width:Number =265;
		private var _height:Number=5;
		private var _corner:Number=0;
        
	
		
		public function ScrubberView()
		{
			super();
			init();
		}
		
		
		private function init():void{
			// draw bars + dragger
			_loadedBar   = bar(_model.colorThird)
			_progressBar = bar(_model.colorPrimary)
			_bg          = bar(_model.colorPrimary,.4);
			_dragger     = new ScrubBarDragger()
			
			// add'em to the stage
			addChild(_bg);
			addChild(_loadedBar);
			addChild(_progressBar);
			addChild(_dragger);
		}
		/**
		 *bar maker 
		 * @param color
		 * @return bar:sprite
		 * 
		 */		
		private function bar(color:uint=0xffffff, alpha:Number=1):Sprite{
			var spr:Sprite = new Sprite()
			spr.graphics.beginFill(color);
			spr.graphics.drawRoundRect(0,0,_width,_height,_corner);
			spr.graphics.endFill()
			return spr;
		}
		
		public function get loadedBar():Sprite{
		  return _loadedBar;
		}
		
		public function get progressBar():Sprite{
			return _progressBar;
		}
		public function get dragger():ScrubBarDragger{
            return _dragger;
        }
		
		
	}
}