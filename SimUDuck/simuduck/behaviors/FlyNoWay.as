package simuduck.behaviors
{
	import simuduck.FlyBehavior;
	
	public class FlyNoWay implements FlyBehavior
	{
		public function fly():void
		{
			trace("I can't Fly!")
		}
		
	}
}