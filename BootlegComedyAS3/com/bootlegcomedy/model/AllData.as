﻿package com.bootlegcomedy.model{	import flash.net.URLLoader;	import flash.display.Loader;	import lt.uza.utils.Global;	import flash.display.BitmapData;	import flash.events.Event;	import flash.net.URLRequest;	import com.FlashDynamix.services.YouTube;	import com.FlashDynamix.events.YouTubeEvent;
	import com.bootlegcomedy.control.Observable;		public class AllData	{		private var global:Global = Global.getInstance();		private var textLoader:URLLoader=new URLLoader();		private var imageLoader:Loader=new Loader();		private var allImageContent:Array = new Array();		private var allTextContent:Array = new Array();		private var allArrayContent:Array=new Array();		private var yt:YouTube;				private var observable:Observable = Observable.getInstance();										private var navigationData:Array = new Array();				private var load_target:String;						private var dataXML_url:String="xml/data.xml";				private var dataXML:XML;				function AllData():void{						global.getNavData = getNavigationArray;			global.getArray = getArrayById;			global.addToArray = addToArray;			global.searchVideos=searchVideos;						yt = global.youtube;						getDataXML();						///make fake video data			makeFake();		}		private function makeFake():void{						var recent:Array=new Array();						for(var j=0;j<3;j++){				var vidObj1:VideoDataObject=new VideoDataObject();				vidObj1.VideoTitle = "Recent"+j;				vidObj1.VideoDescription="Description Test";				vidObj1.VideoID='svgUFb_N-Z0'				recent.push(vidObj1);			}						allArrayContent.push(['recentVideos',recent]);			trace(allArrayContent);				}		public function getImageById(id:String):BitmapData{			var bdata:BitmapData;			for(var i:Number=0; i<allImageContent.length; i++){				if(allImageContent[0]==id){					bdata = allImageContent[1];				}			}			return bdata;		}		public function getImageByNumber(num:Number):BitmapData{			var bdata:BitmapData = allImageContent[num];			return bdata;		}		public function getArrayById(id:String):Array{			trace('getArrayById: '+id);			var data:Array;			var datafound:Boolean=false;			for(var i:Number=0; i<allArrayContent.length; i++){				trace(allArrayContent[i][0]);				if(allArrayContent[i][0]==id){					datafound = true;					data = allArrayContent[i][1];				}			}			trace('  - datafound: '+datafound);			trace(data);			return data;		}					public function getTextById(id:String):String{						var txt:String;						for(var i:Number=0; i<allTextContent.length; i++){				if(allTextContent[0]==id){					txt = allTextContent[1];				}			}			return txt;		}		public function getTextByNumber(num:Number):String{			var bdata:String = allTextContent[num];			return bdata;		}		public function getNavigationArray():Array{			return navigationData;		}				private function getDataXML():void{			load_target = 'dataxml';			this.textLoader.addEventListener(Event.COMPLETE,this.textLoaded);			this.textLoader.load(new URLRequest(dataXML_url));		}		private function imageLoaded(e:Event):void{					}		private function textLoaded(e:Event):void{			trace('text loaded');			switch(load_target){				case "dataxml":					trace("root data loaded.");									dataXML = new XML(this.textLoader.data);					var navinfo:XMLList = dataXML..navEntry;					//trace(dataXML);					for(var i:Number=0;i<navinfo.length();i++){						trace(" - "+navinfo.attributes()[i]);						navigationData.push([navinfo.attributes()[i],navinfo.text()[i]]);						trace("     ----> "+navinfo.text()[i])					}					global.navDataReady();					popularVideoPlayList();				break;			}		}				private function parseNavigation(xml:XMLList):void{			trace('parseNavigation')						trace(xml.toXMLString());			popularVideoPlayList();					}		private function popularVideoPlayList():void{			yt.videosPlaylist("FEA9B456ECD8B7AB");		}		private function searchVideos(query:String){			yt.videosbyTag(query,1,10);		}		private function addToArray(o){			allArrayContent.push(o);		}							}}