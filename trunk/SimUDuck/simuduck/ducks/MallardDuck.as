package simuduck.ducks
{
	import simuduck.Duck
	import simuduck.behaviors.*;

	
	public class MallardDuck extends Duck
	{
		
		public function MallardDuck()
		{
			
			this.duckType ="Mallard";
			this.flyBehavior = new FlyWithWings();
			this.quackBehavior = new Quack()
	
		}
	}
}