package simuduck
{
	public class Duck
	{
		
		public var duckType:String;
		public var flyBehavior:FlyBehavior;
		public var quackBehavior:QuackBehavior;
		
		function Duck(){
			trace("new duck");
			trace("+++++++++++++++++++++++++");
			display();
		}
		public function display():void{
		}
		public function swim():void{
			trace("All ducks float");
		}
		public function performQuack():void{
			trace("quack: "+this.duckType);
			quackBehavior.quack();
		}
		public function performFly():void{
			trace("fly: "+this.duckType);
			flyBehavior.fly();
		}
		public function setDuckType(type:String):void{
			duckType = type;
		}
	}
}