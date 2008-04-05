package simuduck.ducks
{
	import simuduck.Duck
	import simuduck.behaviors.*;
	
	
	public class DecoyDuck extends Duck
	{
		function DecoyDuck():void{
			this.duckType = "Decoy";
			this.flyBehavior = new FlyNoWay();
			this.quackBehavior = new Quack();
		}
	}
}