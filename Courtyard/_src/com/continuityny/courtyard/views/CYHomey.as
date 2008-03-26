﻿/** * @author k */import com.bourre.commands.Delegate;import flash.display.BitmapData;import gs.TweenLite;import flash.geom.*;import mx.transitions.easing.*;class com.continuityny.courtyard.views.CYHomey extends MovieClip {				public var ReadyToGo:Boolean=false;	private var AutoStart:Boolean;		private var imageLoader:MovieClipLoader;		private var imageOutter:MovieClip;	private var imageInner:MovieClip;	private var imageHolder:MovieClip;		private var bandHolder:MovieClip;	private var backgroundHolder:MovieClip;	private var neutralHolder:MovieClip;		private var meDepth:Number;	private var meX:Number;	private var mmeX:Number;	private var neutNum:Number=0;	private var currentNum:Number = 0;	private var imageWidth:Number = 970;	private var imageHeight:Number = 400;	private var sliceCount:Number = 20;	private var sliceWidth:Number;			private var bitmaps:Array=new Array();	private var imageURLS:Array = new Array();	private var colors:Array=new Array(0x5F8437,0xB0CF61,0x5F8437,0xffffff);	private var allMasks:Array;	private var allBackgrounds:Array;	private var allBands:Array;	private var allNeutrals:Array;	private var movingPanels:Array=new Array();		private var imageWidths:Array=new Array(754,780,593,483,383);			private var defaultImageURLS:Array= new Array(											'images/new/lobby.png',											'images/new/fitness.png',											'images/new/market.png',											'images/new/room.png',											'images/new/biz.png',																						'images/lobby_w_lines.png',											'images/fitness_w_lines.png',											'images/market_w_lines.png',											'images/room_w_lines.png',											'images/biz_w_lines.png'																					);												private var sections:Array = new Array(											'LOBBY',											'MARKET',											'ROOM',											'FITNESS',											'BUSINESS',											'OUTDOOR'	);					// backgrounds		private var LobbyImage:MovieClip;	private var MarketImage:MovieClip;	private var RoomImage:MovieClip;	private var BusinessImage:MovieClip;	private var FitnessImage:MovieClip;		// masks	private var LobbyMask:MovieClip;	private var MarketMask:MovieClip;	private var RoomMask:MovieClip;	private var BusinessMask:MovieClip;	private var FitnessMask:MovieClip;		// color bands		private var Band0:MovieClip;	private var Band1:MovieClip;	private var Band2:MovieClip;	private var Band3:MovieClip;			// neutral images		private var LobbyNeutral:MovieClip;	private var MarketNeutral:MovieClip;	private var RoomNeutral:MovieClip;	private var BusinessNeutral:MovieClip;	private var FitnessNeutral:MovieClip;		// arrays for storiing/referencing the neutral images...		private var LobbySlices:Array = new Array();	private var MarketSlices:Array = new Array();	private var RoomSlices:Array = new Array();	private var BusinessSlices:Array = new Array();	private var FitnessSlices:Array = new Array();		private var AllSlices:Array;	private var FocusedMask:Array;			private var TemporarySliceArray:Array=new Array();			public function CYHomey(container,autoStart:Boolean) {						container.__proto__ = this.__proto__;		container.__constructor__ = CYHomey;		this = container;				trace(this);				AutoStart= autoStart;						imageURLS = defaultImageURLS;		sliceWidth = Math.round(imageWidth/sliceCount)+1;		trace('sliceWidth: '+sliceWidth);			trace('======================================================\r');				allBackgrounds = new Array(LobbyImage,MarketImage,RoomImage,BusinessImage,FitnessImage);		allMasks = new Array(LobbyMask,MarketMask,RoomMask,BusinessMask,FitnessMask);		FocusedMask = new Array(true,false,false,false,false);		allBands = new Array(Band0,Band1,Band2,Band3);		allNeutrals = new Array(LobbyNeutral,MarketNeutral,RoomNeutral,BusinessNeutral,FitnessNeutral);		init();	}		public function changeSection(id:String):Void{		var pagefound:Boolean;				stopMotion();				for(var i in sections){			if(sections[i] == id){				showMySlices(0);				pagefound = true;			}			}		if(pagefound){			trace('page set: '+id);			}else{			trace('page not found: '+id+'. plz check name' );		}			}	public function startMovie():Void{		if(ReadyToGo){			build();		}else{			trace('not ready!');		}	}		public function reset():Void{		ReadyToGo=true;		hideMySlices(0);		hideMySlices(1);		hideMySlices(2);		hideMySlices(3);		hideMySlices(4);		for(var h in allBackgrounds){			allBackgrounds[h].enabled=true;		}		for(var i in movingPanels){					keepMoving(movingPanels[i], movingPanels[i].type);		}			}			private function init():Void{		loadImages();	}				private function loadImages():Void{		trace('loading images...\r');		imageLoader = new MovieClipLoader();		imageLoader.addListener(this);		loadNextImage();		}	private function loadNextImage():Void{		imageHolder = createEmptyMovieClip('imageOutter', 0);		imageLoader.loadClip(imageURLS[currentNum],imageHolder);		trace('loading image: '+imageURLS[currentNum]);		currentNum++;	}			private function onLoadInit():Void{		var bmp:BitmapData=new BitmapData(imageHolder._width, imageHolder._height, true, 0x00000000);		bmp.draw(imageHolder);		bitmaps.push(bmp);		if(currentNum<imageURLS.length){			loadNextImage();		}else{			trace('all images loaded: '+bitmaps);				trace			delete imageLoader;			imageHolder.removeMovieClip();			ReadyToGo=true;			if(AutoStart){				build();			}		}	}			private function build():Void{		backgroundHolder = this.createEmptyMovieClip('backgroundHolder', this.getNextHighestDepth());		bandHolder = this.createEmptyMovieClip('bHolder',this.getNextHighestDepth());		neutralHolder = this.createEmptyMovieClip('neutralHolder',this.getNextHighestDepth());						for(var i in allBackgrounds){						allBackgrounds[i] = backgroundHolder.createEmptyMovieClip('BG'+i,backgroundHolder.getNextHighestDepth());			allBackgrounds[i].id = i;									allBackgrounds[i].onRollOver=function():Void{				this._parent._parent.showMe(this.id);			};			allBackgrounds[i].onRollOut=function():Void{				this._parent._parent.hideMe(this.id);			};			allBackgrounds[i].onRelease=function():Void{				this._parent._parent.showMySlices(this.id);			};						allBackgrounds[i].useHandCursor=false;									var bgHolder:MovieClip = allBackgrounds[i].createEmptyMovieClip('img',0);						bgHolder.beginBitmapFill(bitmaps[i],new Matrix(),true,true);			bgHolder.moveTo(0,0);			bgHolder.lineTo(imageWidths[i],0);			bgHolder.lineTo(imageWidths[i],imageHeight);			bgHolder.lineTo(0,imageHeight);			bgHolder.endFill();					allMasks[i] = backgroundHolder.createEmptyMovieClip('MASK'+i,backgroundHolder.getNextHighestDepth());			allMasks[i].moveT(0,0);			allMasks[i].beginFill(0xffffff);			allMasks[i].lineTo(0,0);			allMasks[i].lineTo(100,0);			allMasks[i].lineTo(100,imageHeight);			allMasks[i].lineTo(0,imageHeight);			allMasks[i].endFill();						allBackgrounds[i].setMask(allMasks[i]);							movingPanels.push(allMasks[i]);					}				for(var k:Number=0; k<allBands.length;k++){			makeBand(allBands[k],k);		}						createNeutrals();		idleAnimation();		trace('========================================================');	}			private function createNeutrals():Void{		/*		 * this method will build the neutral images, by creating sliced images		 * that reveal and hideMySlices when user clicks the home image		 */		 		for(var j:Number=0;j< allNeutrals.length;j++){						allNeutrals[j] = neutralHolder.createEmptyMovieClip('neut'+j, neutralHolder.getNextHighestDepth());		//	allNeutrals[j]._alpha=50;						for(var m:Number=0; m<sliceCount; m++){				var bg:MovieClip = allNeutrals[j].createEmptyMovieClip('bg'+m, allNeutrals[j].getNextHighestDepth());				var mask:MovieClip = bg.createEmptyMovieClip(allNeutrals[j]._name+'_mask'+m, allNeutrals[j].getNextHighestDepth());				var img:MovieClip = bg.createEmptyMovieClip('img', 0);								img.beginBitmapFill(bitmaps[j+5],new Matrix(),false,true);				img.moveTo(0,0);				img.lineTo(imageWidth,0);				img.lineTo(imageWidth,imageHeight);				img.lineTo(0,imageHeight);				img.endFill();																mask.beginFill(0xfff,50);				mask.moveTo(0,0);				mask.lineTo(sliceWidth,0);				mask.lineTo(sliceWidth,imageHeight);				mask.lineTo(0,imageHeight);				mask.endFill();				 			mask._x=m*50;	 			//img._x=0-(m*50);	 		//	trace(mask)	 			mask.id=m;	 			img.setMask(mask);	 			TemporarySliceArray.push(mask);	 						}		}		organizeSlices();	}	private function makeBand(targ:MovieClip,num:Number):Void{				targ = bandHolder.createEmptyMovieClip('band_'+num,num);		var w:Number= randBandWidth();		targ.beginFill(colors[num],40);		targ.moveTo(0,0);		targ.lineTo( w,0);		targ.lineTo( w,imageHeight);		targ.lineTo(0,imageHeight);		targ.endFill();						targ._x=randX();		targ._width = randBandWidth();		setupPanel(targ,'band');		movingPanels.push(targ);	}	/******************************************************	 * idleAnimation:	 * --------------------------------------------	 * 	this method determines if the clips passed	 * 	are to function normally or in focused mode	 *****************************************************/		private function idleAnimation():Void{		for(var i in allMasks){			if(FocusedMask[i]){			setupPanel(allMasks[i],'focused');			allMasks[i]._x = randX();			allMasks[i]._width = randWidth();			}else{				setupPanel(allMasks[i],'normal');				allMasks[i]._x = randX();				allMasks[i]._width = randWidth();			}		}	}		/******************************************************	 * setupPanel:	 * --------------------------------------------	 * 	this method initiates the "targ" MC's motion 	 * 	and stores the "type" property in that MC	 *****************************************************/		private function setupPanel(targ:MovieClip, type:String):Void{		var panel:MovieClip = targ;		var xpos:Number = randX();		var time:Number = randTime();		panel.type= type;		trace("SETUP: "+panel+"  "+type)		switch(type){						case 'normal':				TweenLite.to(panel,time,{_x:xpos,_width:randWidth(),onComplete:keepMoving,onCompleteParams:[panel],onCompleteScope:this});			break;						case 'focused':				TweenLite.to(panel,time,{_x:xpos,_width:randWidthFocused(),onComplete:keepMoving,onCompleteParams:[panel],onCompleteScope:this});			break;						case 'band':				TweenLite.to(panel,time,{_x:xpos,_width:randBandWidth(),onComplete:keepMoving,onCompleteParams:[panel],onCompleteScope:this});			break;		}	}										private function keepMoving(targ:MovieClip):Void{		if(ReadyToGo){			var panel:MovieClip = targ;			var time:Number = randTime();			var xpos:Number = randX();					switch(panel.type){				case 'normal':					TweenLite.to(panel,time,{_x:xpos,_width:randWidth(),onComplete:keepMoving,onCompleteParams:[panel],onCompleteScope:this});				break;				case 'focused':					TweenLite.to(panel,time,{_x:xpos,_width:randWidthFocused(),onComplete:keepMoving,onCompleteParams:[panel],onCompleteScope:this});				break;				case 'band':					TweenLite.to(panel,time,{_x:xpos,_width:randBandWidth(),onComplete:keepMoving,onCompleteParams:[panel],onCompleteScope:this});				break;			}		}	}					private function showMe(id:Number):Void{		if(ReadyToGo){			meDepth = allBackgrounds[id].getDepth();			allBackgrounds[id].swapDepths(backgroundHolder.getNextHighestDepth());			//bandHolder.swapDepths(this.getNextHighestDepth());			var xpos:Number =(imageWidth/2)-imageWidths[id]/2;			meX = allMasks[id]._x;					TweenLite.killTweensOf(allMasks[id],false);			TweenLite.to(allMasks[id], 1, {_x:xpos,_width:imageWidths[id]});			TweenLite.to(allBackgrounds[id],1,{_x:xpos});		}	}				private function hideMe(id:Number):Void{		if(ReadyToGo){		var callback:Function = Delegate.create(this,putMeBack);		TweenLite.to(allMasks[id], 1.3, {_x:meX,_width:50,onComplete:callback,onCompleteScope:this});		}		}			private	function putMeBack(id:Number):Void{		allBackgrounds[id].swapDepths(meDepth);		keepMoving(allMasks[id]);	}			/*	 * these methods will reveal and hide the neutral images....	 */	private function hideMySlices(id:Number):Void{		for(var i:Number=0; i<20; i++){			TweenLite.to(AllSlices[id][i],.6,{_x:AllSlices[id][i].altX});		}	}			private function showMySlices(id:Number):Void{		stopMotion();		for(var j:Number=0;j<AllSlices.length;j++){			if(id==j){				for(var i:Number=0; i<20; i++){					TweenLite.to(AllSlices[j][i],2.6,{_x:AllSlices[id][i].defX, ease:Strong.easeOut, onComplete:stopMotion, onCompleteScope:this});				}			}else{				hideMySlices(j);			}		}	}			private function organizeSlices():Void{		for(var i in TemporarySliceArray){		//	trace(TemporarySliceArray[i]._name);			TemporarySliceArray[i].defX=TemporarySliceArray[i]._x;					TemporarySliceArray[i].altX = ((TemporarySliceArray[i].id-(sliceCount/2))*(imageWidth*1.2)-sliceWidth);			TemporarySliceArray[i]._x= TemporarySliceArray[i].altX;								var key:String =  TemporarySliceArray[i]._name.substr(4,1);		//	trace(key);			switch(key){				case '0':					LobbySlices.push(TemporarySliceArray[i]);					break;				case '1':					MarketSlices.push(TemporarySliceArray[i]);					break;				case '2':					RoomSlices.push(TemporarySliceArray[i]);					break;				case '3':					BusinessSlices.push(TemporarySliceArray[i]);					break;				case '4':					FitnessSlices.push(TemporarySliceArray[i]);					break;				}		}		trace('LobbySlices:'+LobbySlices.length);		trace('MarketSlices:'+MarketSlices.length);		trace('RoomSlices:'+RoomSlices.length);		trace('BusinessSlices:'+BusinessSlices.length);		trace('LobbySlices:'+FitnessSlices.length);		AllSlices = new Array(LobbySlices,MarketSlices,RoomSlices,BusinessSlices,FitnessSlices);		TemporarySliceArray = null;		delete TemporarySliceArray;		//hideMySlices();	}				private function stopMotion():Void{			if(ReadyToGo){			trace('stopMotion');			ReadyToGo=false;			for(var h in allBackgrounds){				allBackgrounds[h].enabled=false;			}			for(var i in movingPanels){							TweenLite.killTweensOf(movingPanels[i],false);			//	TweenLite.to(movingPanels[i],0,{_x:movingPanels[i]._x});			}		}	}				// random calculators	private function randX():Number {		return Math.round(Math.random()*800);	}	private function randTime():Number{		return (Math.round(Math.random()*10))+5;	}	private function randWidth():Number{		return (Math.round(Math.random()*200))+25;	}	private function randBandWidth():Number{		return (Math.round(Math.random()*35))+5;	}	private function randWidthFocused():Number {		return (Math.round(Math.random()*230))+150;	}}