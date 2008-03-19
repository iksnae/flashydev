package heavy
{
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	
	
	public class heavyStopButton extends Sprite
	{
		public var stopBtn:Sprite = new Sprite();
		private var btnOver:Sprite = new Sprite();
		private var btnOff:Sprite = new Sprite();
		
		
		function heavyStopButton(){
			//stop
			stopBtn.graphics.beginFill(0x33eeff,0);
			stopBtn.graphics.drawRect(7.5,7.5,20,20);
			stopBtn.graphics.endFill();
			
			
			
			//stopBtn elements
			btnOver.graphics.beginFill(0xffffff);
			btnOver.graphics.drawRect(0,0,15,15);
			btnOver.graphics.endFill();
			btnOver.x = 10;
			btnOver.y = 10;
			btnOver.alpha=0;


			btnOff.graphics.beginFill(0xffffff,.5);
			btnOff.graphics.drawRect(0,0,15,15);
			btnOff.graphics.endFill();
			btnOff.x = 10;
			btnOff.y = 10;
			
			
			
			// add the kids...
			stopBtn.addChild(btnOver);
			stopBtn.addChild(btnOff);
			addChild(stopBtn);
			
			
			// listeners...
			this.addEventListener(MouseEvent.MOUSE_OVER, pOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, pOff);
			
			
			
			
			
			// adjustments
			stopBtn.x=20;
			stopBtn.x=20;
			
			
			// handlers
			function pOver(e:MouseEvent):void{
				trace('over')
				btnOver.alpha=1;
			}
			
			function pOff(e:MouseEvent):void{
				btnOver.alpha=0;
			
			}
		
			
			
			
		}	
	}
}