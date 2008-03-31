package {
	import flash.display.Sprite;
	import simuduck.*;
	import simuduck.ducks.*;
	import simuduck.behaviors.*;

	public class SimUDuck extends Sprite
	{
		
		public var mallard:MallardDuck = new MallardDuck();
		public var decoy:DecoyDuck = new DecoyDuck();
		public var whistle:DuckWhistle = new DuckWhistle();
		
		public function SimUDuck()
		{
			// call methods in mallard 
			mallard.performQuack();
			mallard.performFly();
			
			// call methods in decoy
			decoy.performQuack();
			decoy.performFly();
			
			// call methods in whistle
			whistle.performQuack();
			whistle.performFly();
		}
	}
}
