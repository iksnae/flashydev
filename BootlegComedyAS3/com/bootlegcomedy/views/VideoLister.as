package com.bootlegcomedy.views
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class VideoLister extends Sprite
	{
		
		private var PopularButton:MovieClip;
		private var RecentButton:MovieClip;
		private var SearchButton:MovieClip;
		
		
		
		
		public function VideoLister()
		{
			PopularButton = this['popular_btn'];
			RecentButton = this['recent_btn'];
			SearchButton = this['search_btn'];
		
			
			setupBtn(PopularButton);
			setupBtn(RecentButton);
			setupBtn(SearchButton);
			
			
			
		}
		private function setupBtn(targ:MovieClip):void{
			var hit:Sprite=new Sprite();
			hit.mouseEnabled=false;
			var txt:TextField= targ['txt'];
			txt.selectable=false;
			

			targ.buttonMode=true;
			targ.useHandCursor=true;
			
			hit.graphics.beginFill(0x000000);
			hit.graphics.drawRect(0,0,50,23);;
			hit.graphics.endFill();
			targ.addChild(hit);
			
			targ.swapChildren(hit,txt);
			
		}
		
	}
}