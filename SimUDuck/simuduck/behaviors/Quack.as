package simuduck.behaviors
{
	import simuduck.Duck
	import simuduck.behaviors.*;
	import simuduck.QuackBehavior;
	
	public class Quack implements QuackBehavior
	{

		public function quack():void{
			trace(' -> Quack!');
		}
	}
}