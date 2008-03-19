package heavy
{
	import flash.display.Sprite;

	public class HeavyCloseButton extends Sprite
	{
		public var CloseButton:Sprite= new Sprite();
		
		public function HeavyCloseButton()
		{
			//TODO: implement function
			init();
		}
		private function init():void{
			
			CloseButton.graphics.beginFill(0xD40000,.5);
			CloseButton.graphics.drawCircle(0,0,10);
			CloseButton.graphics.endFill();
			
			var x0:Sprite=new Sprite();
			var x1:Sprite=new Sprite();
			
			x0.graphics.beginFill(0xffffff);
			x1.graphics.beginFill(0xffffff);

			x0.graphics.drawRect(-7.5,-7.5,3,15);
			x1.graphics.drawRect(-7.5,-7.5,3,15);
			
			x0.graphics.endFill();
			x1.graphics.endFill();
			
			x0.rotation=-45;
			x1.rotation=45;
			x0.x=4;
			x0.y=-4;
			
			x1.x=4;
			x1.y=4;
			
			CloseButton.addChild(x0);
			CloseButton.addChild(x1);
			CloseButton.x=310;
			CloseButton.y=10;
			CloseButton.scaleX=.7;
			CloseButton.scaleY=.7;
			
			addChild(CloseButton);
			trace(CloseButton)
		}
	}
}