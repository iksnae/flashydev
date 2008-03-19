package heavy
{
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import lt.uza.utils.Global;

	public class AdViewController extends Sprite
	{
		private var global:Global = Global.getInstance();
		private var adImageURL:String;
		private var adMask:Sprite;
		
		private var hit:Sprite=new Sprite();
		
		private var rightPanel:Sprite	=new Sprite();
		private var leftPanel:Sprite	=new Sprite();
	
		private var adTimer:Timer;
		private var adURLS:Array		=new Array();
		private var myShell:Sprite;
		
		
		
		public function showAd(secs:Number):void{
			hit.visible=true;
			//closePanels();
			adTimer = new Timer(secs*1000,0);
			
			trace('timer set for '+secs+' seconds.')
			adTimer.addEventListener(TimerEvent.TIMER_COMPLETE,adFinished);
			
			adTimer.start();
		}
		
		public function adFinished(e=null):void{
			//openPanels();
			trace('timer finised.')
			adTimer.stop();
			closeAd()
			
		}
		
		public function AdViewController(shell:Sprite)
		{
			//TODO: implement function
			hit.graphics.beginFill(0xccff33);
			hit.graphics.drawRect(0,0,320,240);
			hit.graphics.endFill();
			hit.visible=false;
			addChild(hit)
			init(shell);
		}
		
		private function init(shell:Sprite):void{
			myShell = shell;
		}		
		
		private function closeAd():void{
			global.playVideo();
			hit.visible=false;
			
		}
		private function closePanels():void{
			
		}
		private function openPanels():void{
			
		}
		private function loadAds():void{
			
		}
		
	}
}