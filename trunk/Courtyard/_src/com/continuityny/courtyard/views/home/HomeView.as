﻿/** * @author k */import flash.display.BitmapData;import flash.geom.*;import com.bourre.commands.Delegate; import com.continuityny.courtyard.views.home.HomeData;import com.continuityny.courtyard.views.home.SlicedPanel;import com.continuityny.courtyard.views.home.HomeSliced;import com.continuityny.courtyard.views.home.HomeThumb;class com.continuityny.courtyard.views.home.HomeView extends MovieClip {		private var homeData:HomeData;		private var bandHolder:MovieClip;	private var thumbHolder:MovieClip;	private var sliceHolder:MovieClip;		private var OnRevealFinished:Function;	private var OnImagesLoaded:Function;		public var imageHolder:MovieClip;		private var allThumbs:Array=new Array();		private var th0:HomeThumb;	private var th1:HomeThumb;	private var th2:HomeThumb;	private var th3:HomeThumb;	private	var th4:HomeThumb;	private var th5:HomeThumb;		public function HomeView(container,onRevealComplete,onImagesLoaded) {		trace('HomeView');						OnRevealFinished = onRevealComplete;		OnImagesLoaded = onImagesLoaded;				container.__proto__ = this.__proto__;		container.__constructor__ = HomeView;		this = container;							_global.HomeMuthaFuckinShell= this;						homeData=HomeData.getInstance();				// i kno this isn't declared anywhere else				init();	}	public function changeSections(id:String):Void{		trace("changesection id:"+id);		//hideSlices(currentSectionNum);		if(id!='home'){			for(var i=0;i<homeData.sections.length;i++){				if(id==homeData.sections[i]){					showSlices(i);				}else{					hideSlices(i)					}			}		}else{			startMotion();			for(var j=0;j<homeData.sections.length;j++){				hideSlices(j);			}		}	}		private function showSlices(i : Number) : Void {		this['neutral'+i].revealPage();	}	private function hideSlices(i : Number) : Void {		this['neutral'+i].hidePage();	}		private function init():Void{	//	homeData.loadImages();	homeData.setShell(this);	}		public function imagesLoaded():Void{		build();	}	private function build():Void{		this.bandHolder = this.createEmptyMovieClip("bandHolder", 3);		this.thumbHolder = this.createEmptyMovieClip("thumbHolder", 2);		this.sliceHolder = this.createEmptyMovieClip("sliceHolder", 1);					for(var i=0;i< homeData.sections.length; i++){			trace(homeData.sections[i])			var neutral_bmp:BitmapData = homeData.bitmaps[i+6];			var slice_mc:SlicedPanel=new HomeSliced(this.createEmptyMovieClip("neutral"+i, 100+i),neutral_bmp,this);			var thumb_mc : HomeThumb = new HomeThumb(this.thumbHolder.createEmptyMovieClip("thumb"+i, (50+i)),homeData.bitmaps[i],homeData.sections[i]);				thumb_mc.id = i;			allThumbs.push(thumb_mc);			trace(thumb_mc);		}		storeThumbs();		OnImagesLoaded();		intro();			}		private function startMotion(){		trace("startMotion");		for(var j=0;j<homeData.sections.length;j++){			var targ:HomeThumb = this.thumbHolder["thumb"+j];			targ.startMotion();			targ.enable();				}	}	private function stopMotion(){		trace("stopMotion");		for(var j=0;j<homeData.sections.length;j++){		//	trace(this.thumbHolder["thumb"+j])			var targ:HomeThumb = this.thumbHolder["thumb"+j];			targ.startMotion();			targ.disable();				}	}		private var introPhase:Number=0;		public function intro(){		this['intro'+introPhase]();		introPhase++;	}				private function storeThumbs():Void{				th0 = this.thumbHolder['thumb0'];		th1 = this.thumbHolder['thumb1'];		th2 = this.thumbHolder['thumb2'];		th3 = this.thumbHolder['thumb3'];		th4 = this.thumbHolder['thumb4'];		th5 = this.thumbHolder['thumb5'];				th0.offset = -100;		th1.offset = 120;		th2.offset = 300;		th3.offset = 240;		th4.offset = 100;		th5.offset = 590;						th0.moveAndSize({xpos:0,width:0});		th1.moveAndSize({xpos:0,width:0});		th3.moveAndSize({xpos:300,width:0});		th2.moveAndSize({xpos:300,width:0});		th4.moveAndSize({xpos:450,width:0});		th5.moveAndSize({xpos:450,width:0});				th0.disable();		th1.disable();		th2.disable();		th3.disable();		th4.disable();		th5.disable();						th0.swapDepths(1);		th1.swapDepths(4);		th2.swapDepths(5);		th3.swapDepths(6);		th4.swapDepths(3);		th5.swapDepths(2);	}		private function intro0(){		th0.preview(50, 390);		th1.preview(400, 200);	}	private function intro1(){		th0.preview(0, 150,-200);		th1.preview(150, 150,0);	}	private function intro2(){		th2.preview(300, 380);		th3.preview(520, 300);	}	private function intro4(){		th2.preview(300, 150,250);		th3.preview(450, 150,200);	}	private function intro5(){		th4.preview(600, 250,300);		th5.preview(700, 250);	}	private function intro6(){		th4.preview(600, 150,300);		th5.preview(700, 250);	}	private function intro7(){		th0.preview(0, 162);		th1.preview(162, 162);		th2.preview(324, 162);		th3.preview(486, 162);		th4.preview(648, 162);		th5.preview(810, 162);	}	private function intro8(){		th0.startMotion();		th1.startMotion();		th2.startMotion();		th3.startMotion();		th4.startMotion();		th5.startMotion();		th0.enable();		th1.enable();		th2.enable();		th3.enable();		th4.enable();		th5.enable();			}				public function finito(){		trace('finito!');		stopMotion();		OnRevealFinished()	}	public function putMeOnTop(targ:HomeThumb){		targ.swapDepths(thumbHolder.getNextHighestDepth());	}	public function putMeBack(targ:HomeThumb){		targ.swapDepths(targ.currentDepth);	}}