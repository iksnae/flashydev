﻿/** * @author k */// loggingimport flash.display.*;import flash.geom.*;import com.bourre.commands.Delegate;//import com.mosesSupposes.fuse.*;import gs.TweenLite;class com.continuityny.courtyard.views.CYPanel extends MovieClip {	public var _imageUrl:String = 'test.jpg';	private var _panes:Array = new Array();	private var _paneWidths:Array = new Array(120, 50, 35, 120, 75, 50, 20, 90, 40, 70, 160, 15, 65, 60);//970	private var _paneHeight:Number = 400;	private var _imageHolder:MovieClip;	private var _imageInner:MovieClip;	private var _imageLoader:MovieClipLoader;	private var _myBitmapData:BitmapData;	private var incre:Number = 0;	private var acceleration:Number = 10;	public function CYPanel(container) {		trace("Here i am: "+this);		//ZigoEngine.simpleSetup(Shortcuts,PennerEasing);		container.__proto__ = this.__proto__;		container.__constructor__ = CYPanel;		this = container;		init();	}	private function init():Void {		trace('CYPanel:init');		loadImage();	}	private function buildPanels():Void {		shuffleArray(_paneWidths);		var pos = 0;		for (var i = 0; i<_paneWidths.length; i++) {			var holder:MovieClip = this.createEmptyMovieClip('pane'+i, this.getNextHighestDepth());			var img:MovieClip = holder.createEmptyMovieClip('img'+i, holder.getNextHighestDepth());			var imgH:MovieClip = img.createEmptyMovieClip('img', holder.getNextHighestDepth());			var newPane:MovieClip = holder.createEmptyMovieClip('pane', holder.getNextHighestDepth());			// draw pane for masking			with (newPane) {				beginBitmapFill(_myBitmapData,new Matrix(),true,true);				moveTo(0,0);				lineTo(_paneWidths[i],0);				lineTo(_paneWidths[i],_paneHeight);				lineTo(0,_paneHeight);				endFill();			}			// draw the bitmap			with (imgH) {				beginBitmapFill(_myBitmapData,new Matrix(),true,true);				moveTo(0,0);				lineTo(1000,0);				lineTo(1000,500);				lineTo(0,500);				endFill();			}			//set and store the X pos			holder._x = pos;			holder.defx = pos;			holder.nextX = randX();			//offest the bitmap...			img._x = 0-pos;			//mask the bitmap			img.setMask(newPane);			// increment the offset			pos += newPane._width;			_panes.push(holder);				}		trace(_panes);		idleAnimation();	}	private function loadImage():Void {		trace('load image');		_imageHolder = this.createEmptyMovieClip('_imageHolder', this.getNextHighestDepth());		_imageInner = _imageHolder.createEmptyMovieClip('_imageInner', 0);		_imageLoader = new MovieClipLoader();		_imageLoader.addListener(this);		_imageLoader.loadClip(_imageUrl,_imageInner);	}	private function onLoadInit($clip:MovieClip) {		trace('image loaded');		imageLoaded();	}	private function imageLoaded():Void {		_myBitmapData = new BitmapData(this._imageHolder._width, this._imageHolder._height, true, 0x00000000);		_myBitmapData.draw(this._imageHolder);		buildPanels();		_imageHolder._alpha = 0;	}	private function shuffleArray(arr:Array):Void {		for (var i:Number = 0; i<arr.length; i++) {			var tmp = arr[i];			var randomNum = random(arr.length);			arr[i] = arr[randomNum];			arr[randomNum] = tmp;		}	}	private function randX():Number {		return Math.round(Math.random()*1000);	}	private function randTime():Number{		return (Math.round(Math.random()*10))+5;	}	private function idleAnimation():Void{		trace(idleAnimation)		for(var i in _panes){			setupPane(_panes[i]);		}	}	private function setupPane(targ:MovieClip):Void {		var p:MovieClip = targ;		var t:Number = randTime();		var x:Number = randX();		trace('move: '+p+' to: '+x+' in '+t+' secs.');		p.onRollOver =  function():Void{			this._parent.stopMotion();					};		p.onRollOut = function():Void{			this._parent.idleAnimation();		};		TweenLite.to(p,t,{_x:x,onComplete:keepMoving,onCompleteParams:[p],onCompleteScope:this});			}	private function keepMoving(targ:MovieClip):Void{		var p:MovieClip = targ;		var t:Number = randTime();		var x:Number = randX();		trace('move: '+p+' to: '+x+' in '+t+' secs.');		TweenLite.to(p,t,{_x:x,onComplete:keepMoving,onCompleteParams:[p],onCompleteScope:this});	}	private function stopMotion():Void{		trace('stopMotion');		for (var i:Number = 0; i<_panes.length; i++) {			TweenLite.killTweensOf(_panes[i],false);			TweenLite.to(_panes[i], 1.3,{_x:_panes[i].defx});		}			}}