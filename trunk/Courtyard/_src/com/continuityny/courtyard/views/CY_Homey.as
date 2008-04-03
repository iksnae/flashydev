﻿/** * @author k */import com.bourre.commands.Delegate; import flash.display.BitmapData;import gs.TweenLite;import flash.geom.*;import mx.transitions.easing.*;class com.continuityny.courtyard.views.CY_Homey extends MovieClip {		private var imageLoader:MovieClipLoader;	private var imageHolder:MovieClip;	private var currentImageNum:Number=0;	private var imageWidth:Number = 970;	private var imageHeight:Number = 400;	private var sliceCount:Number = 20;	private var sliceWidth:Number=50;	private var timing:Number = 1.7;		private var currentSectionName:String;	private var currentSectionNum:Number;			private var bitmaps:Array = new Array();	private var offsets:Array = new Array(-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10);	private var colors:Array=new Array(0x5F8437,0xB0CF61,0x5F8437,0xffffff);	private var thumbnailWidths:Array=new Array();	private var thumbnailXPos:Array=new Array(-180,-100,-100,-200,-300,-50);	private var movingParts:Array = new Array();		private var FocusedMask = new Array(true,false,false,false,false,true);		private var ReadyToGo:Boolean;		private var imageURLS:Array= new Array(											'images/new/lobby.jpg',											'images/new/market.jpg',											'images/new/biz.jpg',											'images/new/room.jpg',											'images/new/fitness.jpg',											'images/new/outdoor.jpg',																						'images/lobby_w_lines.jpg',											'images/market_w_lines.jpg',											'images/biz_w_lines.jpg',											'images/room_w_lines.jpg',											'images/fitness_w_lines.jpg',											'images/outdoorStill.jpg'																					);												private var sections:Array = new Array(											'lobby',											'market',											'business',											'guest_room',											'fitness',											'outdoor'	);		private var LobbyThumb:MovieClip;	private var MarketThumb:MovieClip;	private var RoomThumb:MovieClip;	private var BusinessThumb:MovieClip;	private var FitnessThumb:MovieClip;	private var OutdoorThumb:MovieClip;	private var ThumbImageHolder:MovieClip;		// color bands		private var Band0:MovieClip;	private var Band1:MovieClip;	private var Band2:MovieClip;	private var Band3:MovieClip;	private var BandHolder:MovieClip;			private var LobbyNeutral:MovieClip;	private var MarketNeutral:MovieClip;	private var RoomNeutral:MovieClip;	private var BusinessNeutral:MovieClip;	private var FitnessNeutral:MovieClip;	private var OutdoorNeutral:MovieClip;	private var NeutralImageHolder:MovieClip;		private var AllThumbs:Array=new Array(LobbyThumb,MarketThumb,RoomThumb,BusinessThumb,FitnessThumb,OutdoorThumb);	private var AllNeutrals:Array=new Array(LobbyNeutral,MarketNeutral,RoomNeutral,BusinessNeutral,FitnessNeutral,OutdoorNeutral);	private var AllBands:Array=new Array(Band0,Band1,Band2,Band3);		private var OnChangeLocation:Function;	private var OnImagesLoaded:Function;	private var OnRevealFinished:Function;	private var showingNeutralImage:Boolean;					public function CY_Homey(container,onImagesLoaded:Function,onRevealComplete:Function) {		OnRevealFinished = onRevealComplete;		OnImagesLoaded = onImagesLoaded;		container.__proto__ = this.__proto__;		container.__constructor__ = CY_Homey;		this = container;		init();	}	public function changeSection(id:String):Void{		trace("changesection id:"+id);		if(id!=='home'){			trace("changesection !home:"+id);			if(id!=undefined){				trace("changesection IS undefined!!!");				startMotion();				for(var i:Number=0;i<sections.length;i++){					if(sections[i] == id){						trace(id+"  opening: "+sections[i]);						showSlices(i);					}				}			}else{				trace("changesection IS undefined");				stopMotion();				}		}else{			trace("changesection IS home:"+id);			//introMotion();			collapseAll();			hideSlices(currentSectionNum);		}	} 	public function showThumb(id:String):Void{		trace("reveal thumb: "+id);		for(var i:Number=0;i<sections.length;i++){			if(sections[i] == id){				this['expand'+i]();			}		}	}	private function init():Void{		loadImages();	}	private function introMotion():Void{		showingNeutralImage=false;		trace('introMotion');		for(var i:Number=0;i<movingParts.length;i++){			AllThumbs[i]._visible=true;			introMoves(movingParts[i]);					}	}		private function startMotion():Void{		showingNeutralImage=false;		trace('startMotion');		for(var i:Number=0;i<movingParts.length;i++){			AllThumbs[i]._visible=true;			keepMoving(movingParts[i]);					}	}		private function stopMotion():Void{		trace('stopMotion');		for(var i:Number=0;i<movingParts.length;i++){			TweenLite.killTweensOf(movingParts[i],false);				AllThumbs[i]._visible=false;		}	}			/******************************************************	 * loadImages:	 * --------------------------------------------	 * 	this method initiates the image loading process	 *****************************************************/		private function loadImages():Void{		trace('loading images...');		imageLoader = new MovieClipLoader();		imageLoader.addListener(this);		loadNextImage();		}		/******************************************************	 * loadNextImage:	 * --------------------------------------------	 * 	this method loads the next image from the imageURLs array	 *****************************************************/		private function loadNextImage():Void{		imageHolder = createEmptyMovieClip('imageOutter', 0);		imageLoader.loadClip(imageURLS[currentImageNum],imageHolder);				trace('loading image: '+imageURLS[currentImageNum]);		currentImageNum++;	}		/******************************************************	 * onLoadInit:	 * --------------------------------------------	 * 	this method is called when an external image is	 * 	finished loading. it then takes the loaded image	 * 	and converts it to local bitmap data. finally it	 * 	checks to see if all images have been loaded. if 	 * 	all images are not loaded it loads the next image.	 * 	if all images are loaded, it deletes the loader	 * 	clips and set the ReadyToGo property to true and 	 * 	calls build() method.	 *****************************************************/	 	private function onLoadInit():Void{		var bmp:BitmapData=new BitmapData(imageHolder._width, imageHolder._height, true, 0x00000000);		thumbnailWidths.push(bmp.width)		bmp.draw(imageHolder);		bitmaps.push(bmp);				if(currentImageNum<imageURLS.length){			loadNextImage();		}else{			trace('all images loaded!');						ReadyToGo=true;			delete imageLoader;			imageHolder.removeMovieClip();			// setup holders			ThumbImageHolder = this.createEmptyMovieClip('thumbImageHolder', 0);			BandHolder = this.createEmptyMovieClip('thumbImageHolder', 1);			NeutralImageHolder = this.createEmptyMovieClip('neutralImageHolder', 2);												// setup slices			for(var i:Number=0; i<AllNeutrals.length;i++){				AllNeutrals[i] = NeutralImageHolder.createEmptyMovieClip(sections[i], i);				AllNeutrals[i].id=i;//				AllNeutrals[i]._alpha=50;				buildSlices(AllNeutrals[i],bitmaps[i+AllNeutrals.length]);			}			// setup thumbs			for(var j:Number=0; j<AllThumbs.length;j++){				AllThumbs[j] = ThumbImageHolder.createEmptyMovieClip(sections[j], ThumbImageHolder.getNextHighestDepth());				AllThumbs[j].id=j;			//	AllThumbs[j]._alpha=50;				AllThumbs[j].onRollOver=Delegate.create(this,expandThumb,j);				AllThumbs[j].onRollOut=Delegate.create(this,collapseAll);				AllThumbs[j].onRelease=Delegate.create(this,changeSection,sections[j]);				buildThumb(AllThumbs[j],bitmaps[j],j);			}			// setup bands			for(var k:Number=0;k<AllBands.length;k++){				AllBands[k]	= BandHolder.createEmptyMovieClip('band'+k,k);				makeBand(AllBands[k],k);			}			OnImagesLoaded();		}	}			private function buildSlices(mc:MovieClip, bmp:BitmapData):Void {		mc._visible=false;		for(var k:Number=0;k<20;k++){			var imgSlice:MovieClip = mc.createEmptyMovieClip('slice'+k, k);			var newBmp:BitmapData = new BitmapData(sliceWidth,imageHeight,false);			newBmp.copyPixels(bmp,new Rectangle(k*sliceWidth,0,sliceWidth,imageHeight),new Point(0,0));			imgSlice.attachBitmap(newBmp, 0);			imgSlice._x=(k*sliceWidth);			imgSlice.defX=imgSlice._x;			imgSlice.altX=(((offsets[k])*imageWidth)*1.5)-100;		}		hideSlicesWithoutTween(mc.id);		}			private function buildThumb(mc:MovieClip, bmp:BitmapData, num:Number):Void{			var mask:MovieClip = ThumbImageHolder.createEmptyMovieClip('mask'+num, ThumbImageHolder.getNextHighestDepth());		mask.beginFill(0x000000, 100);		mask.moveTo(0,0);		mask.lineTo(100,0);		mask.lineTo(100,imageHeight);		mask.lineTo(0,imageHeight);		mask.endFill();						mc.beginBitmapFill(bmp,new Matrix(),true,true);		mc.moveTo(0,0);		mc.lineTo(thumbnailWidths[num],0);		mc.lineTo(thumbnailWidths[num],imageHeight);		mc.lineTo(0,imageHeight);		mc.endFill();				mc.setMask(mask);		if(!FocusedMask[num]){			setupPanel(mask,'normal');			}else{			setupPanel(mask,'focused');			}	}	private function makeBand(targ:MovieClip,num:Number):Void{				targ = BandHolder.createEmptyMovieClip('band_'+num,num);		var w:Number= randBandWidth();		targ.beginFill(colors[num]);		targ.moveTo(0,0);		targ.lineTo( w,0);		targ.lineTo( w,imageHeight);		targ.lineTo(0,imageHeight);		targ.endFill();				targ._width = randBandWidth();		setupPanel(targ,'band');				movingParts.push(targ);	}				private function getReady():Void{		for(var i in AllNeutrals){			 AllNeutrals[i]._alpha=100;		}	}				private function hideSlices(num:Number):Void{		trace("hideSlices: "+num+" :  "+AllNeutrals[num]);				for(var i in AllNeutrals[num]){			TweenLite.to(AllNeutrals[num][i],timing,{_x:AllNeutrals[num][i].altX,ease:Strong.easeIn});		}		AllNeutrals[num]._visible=true;	}		private function hideSlicesWithoutTween(num:Number):Void{		trace("hideSlices: "+num+" :  "+AllNeutrals[num]);		for(var i in AllNeutrals[num]){			AllNeutrals[num][i]._x=AllNeutrals[num][i].altX;		}		AllNeutrals[num]._visible=true;	}			private  function showSlices(num:Number):Void{		AllNeutrals[num].swapDepths(NeutralImageHolder.getNextHighestDepth());			if(currentSectionNum!=undefined){			trace("showSlices: "+num+" :  "+AllNeutrals[num]);			hideSlices(currentSectionNum);			currentSectionNum = num;		for(var i in AllNeutrals[num]){				TweenLite.to(AllNeutrals[num][i],timing,{_x:AllNeutrals[num][i].defX,ease:Strong.easeOut,delay:timing*.3,onComplete:revealComplete,onCompleteScope:this});			}		}else{					currentSectionNum = num;			for(var j in AllNeutrals[num]){				TweenLite.to(AllNeutrals[num][j],timing,{_x:AllNeutrals[num][j].defX, ease:Strong.easeOut,onComplete:revealComplete,onCompleteScope:this});			}		}	}	private function setupPanel(targ:MovieClip, type:String):Void{		trace("SETUP: "+panel+"  "+type);		var panel:MovieClip = targ;		panel.type= type;		panel._x=-200;		if(type=='focused') panel.swapDepths(ThumbImageHolder.getNextHighestDepth());		movingParts.push(panel);			}			private function keepMoving(targ:MovieClip):Void{			var panel:MovieClip = targ;		var time:Number = randTime();		var xpos:Number = randX();			switch(panel.type){			case 'normal':				TweenLite.to(panel,time,{_x:xpos,_width:randWidth(),onComplete:keepMoving,onCompleteParams:[panel],onCompleteScope:this});				break;			case 'focused':				TweenLite.to(panel,time,{_x:xpos,_width:randWidthFocused(),onComplete:keepMoving,onCompleteParams:[panel],onCompleteScope:this});				break;			case 'band':				TweenLite.to(panel,time,{_x:xpos,_width:randBandWidth(),onComplete:keepMoving,onCompleteParams:[panel],onCompleteScope:this});				break;		}	}	private function introMoves(targ:MovieClip):Void{			var panel:MovieClip = targ;		var time:Number = randTime()/2;		var xpos:Number = randX();			switch(panel.type){			case 'normal':				TweenLite.to(panel,time,{_x:xpos,_width:randWidth(),onComplete:keepMoving,onCompleteParams:[panel],onCompleteScope:this});				break;			case 'focused':				TweenLite.to(panel,time,{_x:xpos,_width:randWidthFocused(),onComplete:keepMoving,onCompleteParams:[panel],onCompleteScope:this});				break;			case 'band':				TweenLite.to(panel,time,{_x:xpos,_width:randBandWidth(),onComplete:keepMoving,onCompleteParams:[panel],onCompleteScope:this});				break;		}	}		private var lastDepth:Number;	private var lastWidth:Number;	private var lastMaskX:Number;			private function expandThumb(num:Number):Void{		/*		//trace("expandThumb: "+num)		var mask = ThumbImageHolder['mask'+num];		var image = ThumbImageHolder[sections[num]];		var xpos:Number =(imageWidth/2)-thumbnailWidths[num]/2;		var highestDepth:Number = ThumbImageHolder.getNextHighestDepth();		// store current depth		lastDepth = mask.getDepth();		lastWidth = mask._width;		lastMaskX = mask._x;		// move to highest depth		trace("Move me to the Top-----> "+ThumbImageHolder[sections[num]]+' from: '+lastDepth+'  to:'+highestDepth);		ThumbImageHolder[sections[num]].swapDepths(highestDepth);				// animate		TweenLite.to(mask,timing,{_x:xpos,_width:thumbnailWidths[num]});		TweenLite.to(image,timing,{_x:xpos})*/		this['expand'+num]();					}	/*	 * WOW!!! I didn't think these creative changes would be soucha pain, but i either	 * have to re-write the whol class or just throw in some hard-coded methods that	 * move everything to it's designated position... 	 * 	 * after several attemps to just modify this class to work as desired, I've deceided	 * to go with the latter option.	 * 	 * here are the expand functions to be called on rollover:	 *	 */	private function expand0():Void{		var offset:Number = 10;		//thumb0		TweenLite.to(ThumbImageHolder["mask0"],timing,{_x:offset,_width:thumbnailWidths[0]});		TweenLite.to(ThumbImageHolder["lobby"],timing,{_x:offset});		offset+=thumbnailWidths[0]+15;		//thumb1		TweenLite.to(ThumbImageHolder["mask1"],timing,{_x:offset,_width:40});		TweenLite.to(ThumbImageHolder["market"],timing,{_x:offset});		offset+=40+15;		//thumb2		TweenLite.to(ThumbImageHolder["mask2"],timing,{_x:offset,_width:35});		TweenLite.to(ThumbImageHolder["business"],timing,{_x:offset});		offset+=35+15;		//thumb3		TweenLite.to(ThumbImageHolder["mask3"],timing,{_x:offset,_width:30});		TweenLite.to(ThumbImageHolder["guest_room"],timing,{_x:offset});		offset+=30+15;		//thumb4		TweenLite.to(ThumbImageHolder["mask4"],timing,{_x:offset,_width:25});		TweenLite.to(ThumbImageHolder["fitness"],timing,{_x:offset});		offset+=25+15;		//thumb5		TweenLite.to(ThumbImageHolder["mask5"],timing,{_x:offset,_width:20});		TweenLite.to(ThumbImageHolder["outdoor"],timing,{_x:offset});	}	private function expand1():Void{		var offset:Number = 10;		//thumb0		TweenLite.to(ThumbImageHolder["mask0"],timing,{_x:offset,_width:80});		TweenLite.to(ThumbImageHolder["lobby"],timing,{_x:offset});		offset+=80+15;		//thumb1		TweenLite.to(ThumbImageHolder["mask1"],timing,{_x:offset,_width:thumbnailWidths[1]});		TweenLite.to(ThumbImageHolder["market"],timing,{_x:offset});		offset+=thumbnailWidths[1]+15;		//thumb2		TweenLite.to(ThumbImageHolder["mask2"],timing,{_x:offset,_width:70});		TweenLite.to(ThumbImageHolder["business"],timing,{_x:offset});		offset+=70+15;		//thumb3		TweenLite.to(ThumbImageHolder["mask3"],timing,{_x:offset,_width:60});		TweenLite.to(ThumbImageHolder["guest_room"],timing,{_x:offset});		offset+=60+15;		//thumb4		TweenLite.to(ThumbImageHolder["mask4"],timing,{_x:offset,_width:50});		TweenLite.to(ThumbImageHolder["fitness"],timing,{_x:offset});		offset+=50+15;		//thumb5		TweenLite.to(ThumbImageHolder["mask5"],timing,{_x:offset,_width:40});		TweenLite.to(ThumbImageHolder["outdoor"],timing,{_x:offset});	}	private function expand2():Void{		var offset:Number = 10;		//thumb0		TweenLite.to(ThumbImageHolder["mask0"],timing,{_x:offset,_width:130});		TweenLite.to(ThumbImageHolder["lobby"],timing,{_x:offset});		offset+=130+15;		//thumb1		TweenLite.to(ThumbImageHolder["mask1"],timing,{_x:offset,_width:110});		TweenLite.to(ThumbImageHolder["market"],timing,{_x:offset});		offset+=110+15;		//thumb2		TweenLite.to(ThumbImageHolder["mask2"],timing,{_x:offset,_width:thumbnailWidths[2]});		TweenLite.to(ThumbImageHolder["business"],timing,{_x:offset});		offset+=thumbnailWidths[2]+15;		//thumb3		TweenLite.to(ThumbImageHolder["mask3"],timing,{_x:offset,_width:90});		TweenLite.to(ThumbImageHolder["guest_room"],timing,{_x:offset});		offset+=90+15;		//thumb4		TweenLite.to(ThumbImageHolder["mask4"],timing,{_x:offset,_width:70});		TweenLite.to(ThumbImageHolder["fitness"],timing,{_x:offset});		offset+=70+15;		//thumb5		TweenLite.to(ThumbImageHolder["mask5"],timing,{_x:offset,_width:50});		TweenLite.to(ThumbImageHolder["outdoor"],timing,{_x:offset});	}	private function expand3():Void{		var offset:Number = 10;		//thumb0		TweenLite.to(ThumbImageHolder["mask0"],timing,{_x:offset,_width:120});		TweenLite.to(ThumbImageHolder["lobby"],timing,{_x:offset});		offset+=120+15;		//thumb1		TweenLite.to(ThumbImageHolder["mask1"],timing,{_x:offset,_width:110});		TweenLite.to(ThumbImageHolder["market"],timing,{_x:offset});		offset+=110+15;		//thumb2		TweenLite.to(ThumbImageHolder["mask2"],timing,{_x:offset,_width:100});		TweenLite.to(ThumbImageHolder["business"],timing,{_x:offset});		offset+=100+15;		//thumb3		TweenLite.to(ThumbImageHolder["mask3"],timing,{_x:offset,_width:thumbnailWidths[3]});		TweenLite.to(ThumbImageHolder["guest_room"],timing,{_x:offset});		offset+=thumbnailWidths[3]+15;		//thumb4		TweenLite.to(ThumbImageHolder["mask4"],timing,{_x:offset,_width:90});		TweenLite.to(ThumbImageHolder["fitness"],timing,{_x:offset});		offset+=90+15;		//thumb5		TweenLite.to(ThumbImageHolder["mask5"],timing,{_x:offset,_width:80});		TweenLite.to(ThumbImageHolder["outdoor"],timing,{_x:offset});	}		private function expand4():Void{		var offset:Number = 10;		//thumb0		TweenLite.to(ThumbImageHolder["mask0"],timing,{_x:offset,_width:50});		TweenLite.to(ThumbImageHolder["lobby"],timing,{_x:offset});		offset+=50+15;		//thumb1		TweenLite.to(ThumbImageHolder["mask1"],timing,{_x:offset,_width:40});		TweenLite.to(ThumbImageHolder["market"],timing,{_x:offset});		offset+=40+15;		//thumb2		TweenLite.to(ThumbImageHolder["mask2"],timing,{_x:offset,_width:30});		TweenLite.to(ThumbImageHolder["business"],timing,{_x:offset});		offset+=30+15;		//thumb3		TweenLite.to(ThumbImageHolder["mask3"],timing,{_x:offset,_width:20});		TweenLite.to(ThumbImageHolder["guest_room"],timing,{_x:offset});		offset+=20+15;		//thumb4		TweenLite.to(ThumbImageHolder["mask4"],timing,{_x:offset,_width:thumbnailWidths[4]});		TweenLite.to(ThumbImageHolder["fitness"],timing,{_x:offset});		offset+=thumbnailWidths[4]+15;		//thumb5		TweenLite.to(ThumbImageHolder["mask5"],timing,{_x:offset,_width:10});		TweenLite.to(ThumbImageHolder["outdoor"],timing,{_x:offset});	}	private function expand5():Void{		var offset:Number = 10;		//thumb0		TweenLite.to(ThumbImageHolder["mask0"],timing,{_x:66,_width:55});	//	TweenLite.to(ThumbImageHolder["lobby"],timing,{_x:66});		offset+=50;		//thumb1		TweenLite.to(ThumbImageHolder["mask1"],timing,{_x:136,_width:75});	//	TweenLite.to(ThumbImageHolder["market"],timing,{_x:136});		offset+=40;		//thumb2		TweenLite.to(ThumbImageHolder["mask2"],timing,{_x:226,_width:95});	//	TweenLite.to(ThumbImageHolder["business"],timing,{_x:226});		offset+=30;		//thumb3		TweenLite.to(ThumbImageHolder["mask3"],timing,{_x:336,_width:100});	//	TweenLite.to(ThumbImageHolder["guest_room"],timing,{_x:336});		offset+=20;		//thumb4		TweenLite.to(ThumbImageHolder["mask4"],timing,{_x:446,_width:135});	//	TweenLite.to(ThumbImageHolder["fitness"],timing,{_x:446});		offset+=90;		//thumb5		TweenLite.to(ThumbImageHolder["mask5"],timing,{_x:596,_width:thumbnailWidths[5]});		TweenLite.to(ThumbImageHolder["outdoor"],timing,{_x:596});	}	private function collapseAll():Void{		var offset:Number = 10;		//thumb0		TweenLite.to(ThumbImageHolder["mask0"],timing,{_x:offset,_width:135});		TweenLite.to(ThumbImageHolder["lobby"],timing,{_x:offset+thumbnailXPos[0]});		offset+=150;		//thumb1		TweenLite.to(ThumbImageHolder["mask1"],timing,{_x:offset,_width:135});		TweenLite.to(ThumbImageHolder["market"],timing,{_x:offset+thumbnailXPos[1]});		offset+=150;		//thumb2		TweenLite.to(ThumbImageHolder["mask2"],timing,{_x:offset,_width:135});		TweenLite.to(ThumbImageHolder["business"],timing,{_x:offset+thumbnailXPos[2]});		offset+=150;		//thumb3		TweenLite.to(ThumbImageHolder["mask3"],timing,{_x:offset,_width:135});		TweenLite.to(ThumbImageHolder["guest_room"],timing,{_x:offset+thumbnailXPos[3]});		offset+=150;		//thumb4		TweenLite.to(ThumbImageHolder["mask4"],timing,{_x:offset,_width:135});		TweenLite.to(ThumbImageHolder["fitness"],timing,{_x:offset+thumbnailXPos[4]});		offset+=150;		//thumb5		TweenLite.to(ThumbImageHolder["mask5"],timing,{_x:offset,_width:135});		TweenLite.to(ThumbImageHolder["outdoor"],timing,{_x:offset+thumbnailXPos[5]});	}			private function collapseThumb(num:Number):Void{		//trace("collapseThumb: "+num)		var mask = ThumbImageHolder['mask'+num];		var image = ThumbImageHolder[sections[num]];					//animate		TweenLite.to(image,timing,{_x:0});		TweenLite.to(mask,timing,{_x:lastMaskX,_width:lastWidth,onComplete:putMeBack,onCompleteParams:[mask],onCompleteScope:this});		}	private function putMeBack(id:MovieClip):Void{			// put back to original depth			id.swapDepths(lastDepth);			keepMoving(id);	}	private function revealComplete():Void{		if(!showingNeutralImage){			trace('revealComplete')			showingNeutralImage=true;			OnRevealFinished();			stopMotion();					}	}		// random calculators	private function randX():Number {		return Math.round(Math.random()*(imageWidth-75));	}	private function randTime():Number{		return (Math.round(Math.random()*7))+3;	}	private function randWidth():Number{		return (Math.round(Math.random()*200))+25;	}	private function randBandWidth():Number{		return (Math.round(Math.random()*35))+5;	}	private function randWidthFocused():Number {		return (Math.round(Math.random()*230))+150;	}			/*	 *  this is a where al of the new code related to the changes	 *  in design require a specific intro animation and rollover	 *  reaction more like a accordian	 * 	 */	private var homePreset0:Array = new Array(		[16,770],		[779,40],		[819,35],		[854,30],		[884,25],		[909,20],		[292,15]	);		private function moveClips(num:Number):Void{				var widths:Array=new Array();		var xpos:Array=new Array();		var startingXpos:Number=0;				// calculate width space of second largest clip		var max:Number =  ((imageWidth-thumbnailWidths[num])/5)+10;		// then for loops thru calculating all 6 widths and addinf to widhts array		for(var i:Number=0;i<6;i++){			var newWidth:Number = (max-(5*i));			var newXpos:Number=startingXpos;			if(num!=i){				//if not the targeted clip				widths.push(newWidth);				startingXpos += newWidth; 			}else{				//if IS the targeted clip				widths.push(max)				startingXpos += max;			}					}				var obj:Object = {			widths:widths,			xpos:xpos,			targWidth:thumbnailWidths[num]		};		reposition(obj);			}	private function reposition(obj:Object):Void{		for(var i=0; i<AllThumbs.length;i++){				TweenLite.to(AllThumbs[sections[i]],timing,{_x:obj.widths[i],_width:obj.xpos[0]});				TweenLite.to(AllThumbs['mask'],timing, {_x:obj.xpos[i],_width:obj.widths[i]})		}	}		 }