package
{
	public class MuteQuack implements QuackBehavior
	{
		public function quack():void{
			trace('<<silence>>');
		}
	}
}