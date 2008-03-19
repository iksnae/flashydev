package heavy
{
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class AdViewController extends Sprite
	{
		private var adImageURL:String;
		private var adMask:Sprite;
		
		private var hit:Sprite;
		
		private var rightPanel:Sprite	=new Sprite();
		private var leftPanel:Sprite	=new Sprite();
	
		private var adTimer:Timer;
		private var adURLS:Array		=new Array();
		
		
		
		public function showAd(secs:Number):void{
			hit.visible=true;
			closePanels();
			adTimer = new Timer(secs);
			adTimer.addEventListener(TimerEvent.TIMER_COMPLETE,closeAd);
		}
		public function adFinished():void{
			
		}
		
		public function AdViewController()
		{
			//TODO: implement function
			init();
		}
		
		private function init():void{
			
		}		
		
		private function closeAd():void{
			hit.visible=fasle;
			openPanels();
		}
		private function closePanels():void{
			
		}
		private function openPanels():void{
			
		}
		private function loadAds():void{
			
		}
		
	}
}