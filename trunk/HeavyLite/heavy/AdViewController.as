package heavy
{
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import lt.uza.utils.Global;
	import flash.events.Event;
	import gs.TweenLite;
	import flash.display.Loader;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.net.URLRequest;

	public class AdViewController extends Sprite
	{
		private var global:Global = Global.getInstance();
		private var adImageURL:String;
		private var adMask:Sprite= new Sprite();
		private var adMask1:Sprite= new Sprite();
		
		private var hit:Sprite=new Sprite();
		
		private var rightPanel:Sprite = new Sprite();
		private var leftPanel:Sprite = new Sprite();
	
		public var adTimer:Timer;
		private var adURLS:Array = new Array();
		private var myShell:Sprite;
		
		private var imageLoader:Loader= new Loader();
		
		
		public function showAd(secs:Number):void{
			hit.visible=true;
			closePanels();
			adTimer = new Timer(secs*1000);
			
			trace('timer set for '+secs+' seconds.')
			adTimer.addEventListener(TimerEvent.TIMER,adFinished);
			
			adTimer.start();
		}
		
		public function adFinished(e:Event=null):void{
			openPanels();
			trace('timer finished.')
			global.playVideo();
			closeAd();
		}
		
		public function AdViewController(shell:Sprite)
		{
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,adLoaded);
			imageLoader.load(new URLRequest('ad1.png'));
			//TODO: implement function
			hit.graphics.beginFill(0xccff33,0);
			hit.graphics.drawRect(0,0,320,240);
			hit.graphics.endFill();
			adMask.graphics.beginFill(0xccff33);
			adMask.graphics.drawRect(0,0,320,240);
			adMask.graphics.endFill();
			adMask1.graphics.beginFill(0xccff33);
			adMask1.graphics.drawRect(0,0,320,240);
			adMask1.graphics.endFill();
			hit.visible=false;
			hit.buttonMode=true;
			hit.useHandCursor=true;
			
			
			
			addChild(adMask);
			addChild(adMask1);
			
			rightPanel.mask=adMask;
			leftPanel.mask=adMask1;
			
		//	rightPanel.x=600;
			
			rightPanel.mouseEnabled=false;
			leftPanel.mouseEnabled=false;
			
			addChild(rightPanel);
			addChild(leftPanel);
			addChild(hit)
			init(shell);
		}
		
		private function init(shell:Sprite):void{
			myShell = shell;
		}		
		
		public function closeAd():void{
			adTimer.stop();
			hit.visible=false;
			
		}
		private function closePanels():void{
			TweenLite.to(rightPanel,.3,{x:0});
			TweenLite.to(leftPanel,.3,{x:0});
		}
		private function openPanels():void{
			TweenLite.to(rightPanel,.3,{x:160});
			TweenLite.to(leftPanel,.3,{x:-160});
		}
		private function loadAds():void{
			
		}
		private function adLoaded(e:Event):void{
			trace(' ad image loaded');
			
			var myBitmap:BitmapData=new BitmapData(imageLoader.width,imageLoader.height);			
			var mtx:Matrix = new Matrix();
			myBitmap.draw(imageLoader,mtx);
			
			rightPanel.graphics.beginBitmapFill(myBitmap,mtx,false,true);
			rightPanel.graphics.drawRect(160,0,160,240);
			rightPanel.graphics.endFill();
			
			leftPanel.graphics.beginBitmapFill(myBitmap,mtx,false,true);
			leftPanel.graphics.drawRect(0,0,160,240);
			leftPanel.graphics.endFill();
			
		}
		
	}
}