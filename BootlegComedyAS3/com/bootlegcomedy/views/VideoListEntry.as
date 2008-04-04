﻿package com.bootlegcomedy.views{	import flash.display.*;	import flash.text.TextField;	import flash.events.MouseEvent;	import gs.TweenLite;
	import com.bootlegcomedy.model.VideoDataObject;	public class VideoListEntry extends Sprite	{		public var MyVideoData:VideoDataObject;		public  var Title:String;		public  var Description:String;			private var TitleText:TextField;		private var DescriptionText:TextField;		private var Thumb:Sprite;				private var DefaultBG:MovieClip;		private var OverBG:MovieClip;								public function VideoListEntry()		{			TitleText = this['title_txt'];			DescriptionText = this['description_txt'];			Thumb = this["thumb"];			DefaultBG = this['default_bg'];			OverBG = this['over_bg'];						this.TitleText.mouseEnabled=false;			this.DescriptionText.mouseEnabled=false;			this.Thumb.mouseEnabled=false;			init();		}				public function setTitle(str:String):void{			Title=TitleText.text=str;			}		public function populate(obj:VideoDataObject):void{			MyVideoData=obj;			this.TitleText.text=obj.VideoTitle;			this.DescriptionText.text=obj.VideoDescription;		}		private function init():void{			this.buttonMode=true;			this.useHandCursor=true;			this.addEventListener(MouseEvent.MOUSE_OVER,over);			this.addEventListener(MouseEvent.MOUSE_OUT,out);			this.addEventListener(MouseEvent.CLICK,click);		}		private function over(e:MouseEvent):void{		//	trace('over');			TweenLite.to(OverBG,.7,{alpha:1});		}		private function out(e:MouseEvent):void{			TweenLite.to(OverBG,.7,{alpha:0});		}		private function click(e:MouseEvent):void{		//	TweenLite.to(OverBG,.7,{alpha:0});		}			}}