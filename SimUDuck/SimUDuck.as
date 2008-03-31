package {
	import flash.display.Sprite;
	import simuduck.*;

	public class SimUDuck extends Sprite
	{
		
		public var mallard:MallardDuck = new MallardDuck();
		public var decoy:DecoyDuck = new DecoyDuck();
		
		public function SimUDuck()
		{
			mallard.performFly();
			mallard.performQuack();
			
			decoy.performFly();
		}
	}
}
