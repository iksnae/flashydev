package  com.husky.view.ui
{
	import com.carlcalderon.Debug;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import gs.TweenLite;
	
	public class ButtonView extends Sprite
	{
		private var _overState:Sprite;
		private var _offState:Sprite;
		private var _disabledState:Sprite;
		private var _enabled:Boolean;
		
		
		public function ButtonView()
		{
			mouseChildren = false;
			buttonMode=true;
			_enabled 		= true;
			_overState 		= new Sprite();
			_offState 		= new Sprite();
			_disabledState 	= new Sprite();
			
			
			
			addChild(_disabledState);
			addChild(_offState);
			addChild(_overState);
			
			_overState.alpha=0;
			
			addEventListener(MouseEvent.MOUSE_OVER, over);
			addEventListener(MouseEvent.MOUSE_OUT, out);
			addEventListener(MouseEvent.CLICK, click);
			
			
		}
		
		
		private function click(e:MouseEvent):void{
	//		Debug.log("CLICK: "+this.name);
		}
		private function over(e:MouseEvent):void{
			TweenLite.to(_overState,.2,{alpha:1})
			TweenLite.to(_offState,.2,{alpha:0})
		}
		private function out(e:MouseEvent):void{
			TweenLite.to(_overState,.2,{alpha:0})
			TweenLite.to(_offState,.2,{alpha:1})
		}
		public function set enabled(bool:Boolean):void{
			_enabled = bool;
			if(!_enabled){
				buttonMode = _offState.visible=_overState.visible=false
				_disabledState.visible=true			
			}else{
				buttonMode = _offState.visible=_overState.visible=true
				_disabledState.visible=false
			}
		}
		
		public function get overState():Sprite{
			return _overState;
		}
		public function get offState():Sprite{
			return _offState;
		}
		public function get disabledState():Sprite{
			return _disabledState;
		}
		

	}
}