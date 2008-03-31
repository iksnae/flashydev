package simuduck.ducks
{
	import simuduck.Duck
	import simuduck.behaviors.*;

	public class DuckWhistle extends Duck
	{
		function DuckWhistle():void{
			this.duckType = "Duck Whistle";
			this.flyBehavior = new FlyWithWings();
			this.quackBehavior = new Quack();
		}
	}
}