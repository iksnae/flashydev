package com.bootlegcomedy.control
{
	import flash.display.Sprite;
	import lt.uza.utils.Global;
	import gs.TweenLite;
	
	public class ViewController extends Sprite
	{
		private var global:Global=Global.getInstance();
		private var id:String   = "viewController";
		private var type:String = "default";
		private var xpos:Number = 0;
		private var ypos:Number = 0;
		private var views:Array=new Array();
	
		
		
		public function ViewController():void{
			global.changeViews=changeViews;
			global.views=views;
			trace(this.id);
		}
		public function changeViews(num:Number):void{
			trace("changeView: "+num)
			for(var i=0;i<views.length;i++){
				trace(views[i][0]+" | "+num);
				if(views[i][0]==num){
					views[i][1].alpha=0;
					views[i][1].visible=true;
					TweenLite.to(views[i][1],1,{alpha:1});
				}else{
					TweenLite.to(views[i][1],1,{alpha:0,onComplete:hidePage, onCompleteParams:[views[i][1]]});
				}
			}
		}
		private function hidePage(targ):void{
			targ.visible=false;
		}
		
		
	}
}