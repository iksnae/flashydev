import mx.transitions.easing.*;
import mx.transitions.Tween;
import com.bourre.commands.*;
import com.mosesSupposes.fuse.*;
/**
 * @author mikeg
 */
class com.continuityny.effects.HandGrabScroll {
	
	var TARGET_MC:MovieClip;
	
	var textVar:String = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. <br><br>The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. <br><br>Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. <br><br>Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<br><br>";
	var textField_W:Number;
	var textField_H:Number;
	var scrollField_X:Number;
	var scrollField_Y:Number;
	
	var textSpeed:Number;
	var initMouse:Number;
	var movedMouse:Number;
	
	var nGrabberMover:Number;
	var nGrabberPosition:Number;
	
	var arrowTween:Tween;
	
	
	function HandGrabScroll(_mc:MovieClip, _wNum:Number, _hNum:Number, _xNum:Number, _yNum:Number){
	
		TARGET_MC=_mc;
		textField_W=_wNum;
		textField_H=_hNum;
		scrollField_X=_xNum;
		scrollField_Y=_yNum;
		
		buildScroller();
	
	}
	
	function buildScroller(){
		
		ZigoEngine.simpleSetup(Shortcuts, PennerEasing, FuseFMP, Fuse, FuseItem  );
		
		TARGET_MC.createEmptyMovieClip("scrollingTextfield",TARGET_MC.getNextHighestDepth());
		TARGET_MC.scrollingTextfield._x = scrollField_X;

		TARGET_MC.scrollingTextfield._y = scrollField_Y;
		
		TARGET_MC.scrollingTextfield.createEmptyMovieClip("scrollingText_mc",TARGET_MC.scrollingTextfield.getNextHighestDepth());
		TARGET_MC.scrollingTextfield.scrollingText_mc.createTextField("scrollingText_txt",0,0,0,textField_W,textField_H);
		
		TARGET_MC.scrollingFormat = new TextFormat();
		TARGET_MC.scrollingFormat.font = "Arial";
		TARGET_MC.scrollingFormat.embedFonts = true;
		TARGET_MC.scrollingTextfield.scrollingText_mc.scrollingText_txt.multiline = true;
		TARGET_MC.scrollingTextfield.scrollingText_mc.scrollingText_txt.wordWrap = true;
		TARGET_MC.scrollingTextfield.scrollingText_mc.scrollingText_txt.html = true;
		TARGET_MC.scrollingTextfield.scrollingText_mc.scrollingText_txt.selectable = false;
		TARGET_MC.scrollingTextfield.scrollingText_mc.scrollingText_txt.textColor = 0x333333;
		
		TARGET_MC.scrollingTextfield.scrollingText_mc.scrollingText_txt.htmlText = textVar+textVar+textVar+textVar+textVar;
		TARGET_MC.scrollingTextfield.scrollingText_mc.scrollingText_txt.autoSize = true;
		TARGET_MC.scrollingTextfield.scrollingText_mc.scrollingText_txt.setTextFormat(TARGET_MC.scrollingFormat);
		
		TARGET_MC.scrollingTextfield.createEmptyMovieClip("scrollingText_mask",TARGET_MC.scrollingTextfield.getNextHighestDepth());
		createSquare(TARGET_MC.scrollingTextfield.scrollingText_mask);
		
		TARGET_MC.scrollingTextfield.scrollingText_mc.Blur_blurY=0;
		TARGET_MC.scrollingTextfield.scrollingText_mc.setMask(TARGET_MC.scrollingTextfield.scrollingText_mask);
		
		interAction();
	
	}
	
	function createSquare(_mc:MovieClip) {
	
		_mc.moveTo(0,0);
		_mc.beginFill(0x000088);
		_mc.lineTo(textField_W,0);
		_mc.lineTo(textField_W,textField_H);
		_mc.lineTo(0,textField_H);
		_mc.endFill();
	
	}
	
	function fadeHandArrows() {

		arrowTween = new Tween(TARGET_MC.hand.handArrow_mc, "_alpha", Regular.easeOut, 100, 0, .5, true);	

	}
	
	function moveGrabber(){
		
		TARGET_MC.hand._x = TARGET_MC._xmouse;
		TARGET_MC.hand._y = TARGET_MC._ymouse;
		
	}
	
	function rollOverTextField(){
			
		Mouse.hide();	
		
		TARGET_MC.hand._alpha = 100;				
		nGrabberMover = setInterval(Delegate.create(this,moveGrabber),10);				

		fadeHandArrows();
	
	}
	
	function rollOutTextField(){
	
		clearInterval(nGrabberMover);
		TARGET_MC.hand._alpha = 0;	
		Mouse.show();
		
	
	}
	
	function checkGrabber_Y(){
		
		var oldPosition:Number=initMouse;
		initMouse=TARGET_MC._ymouse;
	
	}
	
	function pressTextField(_mc:MovieClip){

		arrowTween.stop();
		delete TARGET_MC.scrollingTextfield.scrollingText_mc.onEnterFrame;
		TARGET_MC.scrollingTextfield.scrollingText_mc.Blur_blurY=0;
		TARGET_MC.hand.handArrow_mc._alpha = 100;		
		initMouse = TARGET_MC._ymouse;	
		startDrag(  _mc  ,  false   ,  0   ,   -(_mc._height-textField_H)   ,   0  ,   0  );
		nGrabberPosition = setInterval(Delegate.create(this,checkGrabber_Y),150);	
	
	}
	
	function releaseTextField(){
		
		clearInterval(nGrabberPosition);
		movedMouse = TARGET_MC._ymouse;
		fadeHandArrows();
		moveText(initMouse,movedMouse);
		stopDrag();
	}
	
	function interAction(){
		
		TARGET_MC.hand.swapDepths(TARGET_MC.getNextHighestDepth());
		
		var myText_mc:MovieClip=TARGET_MC.scrollingTextfield.scrollingText_mc;
		
		var tRollOver:Delegate = new Delegate(this, rollOverTextField);
		myText_mc.onRollOver = tRollOver.getFunction();
		
		var tRollOut:Delegate = new Delegate(this, rollOutTextField);
		myText_mc.onRollOut = myText_mc.onDragOut = tRollOut.getFunction();
		
		var tPress:Delegate = new Delegate(this, pressTextField,myText_mc);
		myText_mc.onPress = tPress.getFunction();
		
		var tRelease:Delegate = new Delegate(this, releaseTextField);
		myText_mc.onRelease = myText_mc.onReleaseOutside = tRelease.getFunction();
	
	}
	
	function moveText(_ini:Number, _mov:Number) {
		
		var maskHeight:Number=textField_H;
		var speed:Number = (Math.abs(_ini-_mov))/5;
		TARGET_MC.scrollingTextfield.scrollingText_mc.onEnterFrame = function() {
			
			speed += -speed*.075;
			if (_ini<_mov) {
				if (this._y<=0) {					
					this._y += speed;
					this.Blur_blurY=speed;
					if (this._y>0 || this._y==0){
						this._y=0;
						this.Blur_blurY=0;
						delete this.onEnterFrame;
					}
				}
			} else {
				if (this._y>-(this._height-maskHeight)) {
					this.Blur_blurY=speed;
					this._y -= speed;
					if (this._y<-(this._height-maskHeight)){
						this._y=-(this._height-maskHeight);
						this.Blur_blurY=0;
						delete this.onEnterFrame;
					}

				}
			}
	
			if (speed<.05) {
				//speed=0;
				trace("deleted");
				this.Blur_blurY=0;
				delete this.onEnterFrame;
			}
			

		};
		
		/*ZigoEngine.doTween(TARGET_MC.scrollingTextfield.scrollingText_mc, 
							'Blur_blur', 
							[5],1, Strong.easeOut, 0, 
							Delegate.create(this, function(){
								//end
							})
							);*/
	}
}



