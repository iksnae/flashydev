package com.bootlegcomedy.views
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import com.bootlegcomedy.model.VideoDataObject;
	import lt.uza.utils.Global;
	import flash.events.MouseEvent;

	public class VideoLister extends Sprite
	{
		private var global:Global= Global.getInstance();
		private var PopularButton:MovieClip;
		private var RecentButton:MovieClip;
		private var SearchButton:MovieClip;
		private var ListHolder:Sprite;
		private var ListArray:Array=new Array();
	
		
		
		
		
		public function VideoLister()
		{
			this.mouseEnabled=false;
			
			PopularButton = this['popular_btn'];
			RecentButton = this['recent_btn'];
			SearchButton = this['search_btn'];
		
			
			setupBtn(PopularButton);
			setupBtn(RecentButton);
			setupBtn(SearchButton);
			
			PopularButton.addEventListener(MouseEvent.CLICK,tabClick);
			RecentButton.addEventListener(MouseEvent.CLICK,tabClick);
			SearchButton.addEventListener(MouseEvent.CLICK,tabClick);
			
			//getList();
			
		}
		private function setupBtn(targ:MovieClip):void{
			var hit:Sprite=new Sprite();
			hit.mouseEnabled=false;
			var txt:TextField= targ['txt'];
			txt.selectable=false;
			txt.mouseEnabled=false;
			

			targ.buttonMode=true;
			targ.useHandCursor=true;
			
			hit.graphics.beginFill(0x000000);
			hit.graphics.drawRect(0,0,50,23);;
			hit.graphics.endFill();
			targ.addChild(hit);
			ListHolder = new Sprite();
			ListHolder.x=6;
			ListHolder.y=32;
			
			addChild(ListHolder);

			
			targ.swapChildren(hit,txt);
			global.buildList=buildList;
			
			
		}
		public function buildList(arr:Array):void{
			clearList(arr);
			
			
			
		}
		private function getPopularVideos():void{
			var list:Array = global.getArray('popularVideos');
			buildList(list);
			trace(list);
		}
		private function getRecentVideos():void{
			var list:Array = global.getArray('recentVideos');
			buildList(list);
			trace(list);
		}
		private function toggleSearchView():void{
			
		}
		private function clearList(arr):void{
			for(var i=0;i<listItems.length;i++){
				trace(listItems[i].name);
				ListHolder.removeChild(listItems[i]);
	//			listItems[i].deleteMe();
			}
			populateList(arr);
		}
		private var listItems:Array=new Array();
		private function populateList(arr:Array):void{
			listItems = new Array();
			for(var i:Number=0;i<arr.length;i++){
				var data:VideoDataObject = arr[i];
				var entry:VideoListEntry = new VideoListEntry();
				entry.populate(data);
				entry.y=i*40
				entry.addEventListener(MouseEvent.CLICK,entryClick);
				ListHolder.addChild(entry);
				listItems.push(entry);
				//trace(data.VideoTitle);
			}
		}
		private function tabClick(e:MouseEvent):void{
			trace('CLICKED: '+e.currentTarget.name);
			switch(e.currentTarget.name){
				case 'popular_btn':
					getPopularVideos();
				break;
				case 'recent_btn':
					getRecentVideos();
				break;
				case 'search_btn':
					toggleSearchView();
				break;
			}
			
		}
		private function entryClick(e:MouseEvent):void{
			trace('CLICKED: '+e.currentTarget.MyVideoData);
			
			global.playVideo(e.currentTarget.MyVideoData);
		}
		
	}
}