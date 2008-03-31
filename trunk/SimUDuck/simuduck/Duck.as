package simuduck
{
	public class Duck
	{
		
		public var duckType:String;
		public var flyBehavior:FlyBehavior;
		public var quackBehavior:QuackBehavior;
		
		function Duck(){
		}
		public function display():void{
		}
		public function swim():void{
			trace("All ducks float");
		}
		public function performQuack():void{
			quackBehavior.quack();
		}
		public function performFly():void{
			flyBehavior.fly();
		}
		public function setDuckType(type:String):void{
			duckType = type;
		}
	}
}