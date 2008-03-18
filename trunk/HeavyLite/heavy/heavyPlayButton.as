package heavy
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	
	
	public class heavyPlayButton extends Sprite
	{
		public var btn:Sprite = new Sprite();
		public var btnOver:Sprite = new Sprite();
		public var btnOff:Sprite = new Sprite();
		
		function heavyPlayButton(){
			
			btn.graphics.beginFill(0xffffff,0);
			btn.graphics.drawRect(7.5,7.5,20,20);
			btn.graphics.endFill();
			
			btnOver.name = 'playButtonOff';
			btnOver.name = 'playButtonOver';
			btnOver.graphics.beginFill(0xffffff);
			btnOver.graphics.lineTo(0,0);
			btnOver.graphics.lineTo(15,7.5);
			btnOver.graphics.lineTo(0,15);
			btnOver.graphics.endFill();
			btnOver.x = 10;
			btnOver.y = 10;
			btnOver.alpha=0;
			
			btnOff.name = 'playButtonOff';
			btnOff.name = 'playButtonOver';
			btnOff.graphics.beginFill(0xffffff,.5);
			btnOff.graphics.lineTo(0,0);
			btnOff.graphics.lineTo(15,7.5);
			btnOff.graphics.lineTo(0,15);
			btnOff.graphics.endFill();
			btnOff.x = 10;
			btnOff.y = 10;
			
			btn.addEventListener(MouseEvent.MOUSE_OVER, pOver);
			btn.addEventListener(MouseEvent.MOUSE_OUT, pOff);
			
			btn.addChild(btnOver);
			btn.addChild(btnOff);
			function pOver(e:MouseEvent):void{
				btnOver.alpha=1;
			}
			function pOff(e:MouseEvent):void{
				btnOver.alpha=0;
			}
			
			addChild(btn);
		}
		
	}
}