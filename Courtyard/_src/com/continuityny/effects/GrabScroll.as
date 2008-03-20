import mx.transitions.easing.*;
import mx.transitions.Tween;
import com.bourre.commands.*;
import com.mosesSupposes.fuse.*;
/**
 * @author mikeg
 */
class com.continuityny.effects.GrabScroll {
	
	var TARGET_MC:MovieClip;
	
	var textVar:String = "<a href='asfunction:myFunc,1'><span class='link'><u>Click Me!</u></span></a><br><span class='headline'>FIELD </span><span class='body'>Industrial Design </span><br><span class='headline'>LOCATION </span><span class='body'>Chicago Office </span><br><span class='headline'>JOB LEVEL  </span><span class='body'>Mid-Level Staff </span><br><span class='headline'>JOB FUNCTIONS </span><a href='asfunction:myFunc,2'><span class='link'><u>Click Me!</u></span></a><br><span class='body'>3D Modeling & CAD, Design, Illustration, Motion Graphics, Product Development, Styling </span><br><br><span class='headline'>DESCRIPTION</span><br><a href='asfunction:myFunc,3'><span class='link'><u>Click Me!</u></span></a><br><span class='body'>A leading design firm in the Chicago area is looking for a seasoned 3-D Modeler / Renderer with a design background. This is an Intermediate level opportunity that will allow the right candidate to grow within our diverse team of designers. </span><br><br><span class='headline'>SPECIFIC SKILLS</span><br><a href='asfunction:myFunc,4'><span class='link'><u>Click Me!</u></span></a><br><span class='body'>Extensive experience with a NURBS modeler, Rhino is preferred. </span><br><span class='body'>Rendering experience, 3DS Max + Vray or brazil r/s or Maxwell is ideal</span><br><span class='body'>Proficiency in Photoshop, Illustrator and InDesign are a plus </span><br><span class='body'>Scripting / Programming knowledge is also a bonus </span><br><br><span class='headline'>TO APPLY: </span><br><a href='asfunction:myFunc,5'><span class='link'><u>Click Me!</u></span></a><br><span class='body'>Send resume, samples of work or online portfolio along with your cover letter to:  Samantha > sam@mcgarrybowen.com </span><br><br>";
	var textField_W:Number;
	var textField_H:Number;
	var scrollField_X:Number;
	var scrollField_Y:Number;
	
	var textSpeed:Number;
	var initMouse:Number;
	var movedMouse:Number;
	
	var nGrabberMover:Number;
	var nGrabberPosition:Number;
	var r:Number = 6;
	
	var arrowTween:Tween;
	
	var cssLoaded:Boolean=false;
	var scrollText:TextField;
	
	
	function GrabScroll(_mc:MovieClip, _wNum:Number, _hNum:Number, _xNum:Number, _yNum:Number){
	
		TARGET_MC=_mc;
		textField_W=_wNum;
		textField_H=_hNum;
		scrollField_X=_xNum;
		scrollField_Y=_yNum;
		
		buildScroller();
	
	}
	

	
	function myFunc(arg:String){
		trace ("You clicked number " + arg +"!!!");
	}
	
	function buildScroller(){
		
		ZigoEngine.simpleSetup(Shortcuts, PennerEasing, FuseFMP, Fuse, FuseItem  );
		
		TARGET_MC.createEmptyMovieClip("scrollingTextfield",TARGET_MC.getNextHighestDepth());
		TARGET_MC.scrollingTextfield._x = scrollField_X;

		TARGET_MC.scrollingTextfield._y = scrollField_Y;
		
		TARGET_MC.scrollingTextfield.createEmptyMovieClip("scrollingText_masked",TARGET_MC.scrollingTextfield.getNextHighestDepth());
		TARGET_MC.scrollingTextfield.scrollingText_masked.createEmptyMovieClip("scrollingText_button",TARGET_MC.scrollingTextfield.scrollingText_masked.getNextHighestDepth());
		TARGET_MC.scrollingTextfield.scrollingText_masked.scrollingText_button._alpha=0;
		TARGET_MC.scrollingTextfield.scrollingText_masked.createEmptyMovieClip("scrollingText_mc",TARGET_MC.scrollingTextfield.scrollingText_masked.getNextHighestDepth());
		TARGET_MC.scrollingTextfield.scrollingText_masked.scrollingText_mc.createTextField("scrollingText_txt",0,0,0,textField_W,textField_H);
		
		//TARGET_MC.scrollingFormat = new TextFormat();
		//TARGET_MC.scrollingFormat.font = "Frutiger LT Std 55 Roman";
		//TARGET_MC.scrollingFormat.embedFonts = true;
		scrollText=TARGET_MC.scrollingTextfield.scrollingText_masked.scrollingText_mc.scrollingText_txt;
		scrollText.multiline = true;
		scrollText.wordWrap = true;
		scrollText.html = true;
		scrollText.embedFonts = true;
		scrollText.selectable = false;
		scrollText._parent.myFunc = Delegate.create(this, myFunc);
		//TARGET_MC.scrollingTextfield.scrollingText_mc.scrollingText_txt.textColor = 0x333333;
		
		var newStyle:TextField.StyleSheet = new TextField.StyleSheet();
		
		newStyle.onLoad = Delegate.create(this, function(success:Boolean):Void {

		    if (success) {
				
		    	scrollText.styleSheet = newStyle;				

		        scrollText.htmlText = textVar+textVar+textVar+textVar+textVar;
				scrollText.autoSize = true;
		
				//create button to drag the scrollbar
				createSquare(TARGET_MC.scrollingTextfield.scrollingText_masked.scrollingText_button, scrollText._height);

		    } else {
		        trace("Error loading CSS file.");
		    }
		});
		
		newStyle.load("css/careers.css");
		
		TARGET_MC.scrollingTextfield.createEmptyMovieClip("scrollingText_mask",TARGET_MC.scrollingTextfield.getNextHighestDepth());
		createSquare(TARGET_MC.scrollingTextfield.scrollingText_mask, textField_H);
		createGrabber();
		
		TARGET_MC.scrollingTextfield.scrollingText_masked.scrollingText_mc.Blur_blurY=0;
		TARGET_MC.scrollingTextfield.scrollingText_masked.setMask(TARGET_MC.scrollingTextfield.scrollingText_mask);
		
		interAction();
	
	}

	
	function createSquare(_mc:MovieClip, _h:Number) {
		
		_mc.moveTo(0,0);
		_mc.beginFill(0x000088);
		_mc.lineTo(textField_W,0);
		_mc.lineTo(textField_W,_h);
		_mc.lineTo(0,_h);
		_mc.endFill();
	
	}
	
	function createGrabber(){
	
		TARGET_MC.createEmptyMovieClip("grabber", TARGET_MC.getNextHighestDepth());
		TARGET_MC.grabber._alpha=0;
		TARGET_MC.grabber.createEmptyMovieClip("shadow", TARGET_MC.grabber.getNextHighestDepth());
		TARGET_MC.grabber.createEmptyMovieClip("color", TARGET_MC.grabber.getNextHighestDepth());
		TARGET_MC.grabber.createEmptyMovieClip("highlight", TARGET_MC.grabber.getNextHighestDepth());
		TARGET_MC.grabber.highlight._alpha=0;
		
		// center point and radius of circle
		var x:Number = 0;//-r/2;
		var y:Number = 0;//-r/2;
		// constant used in calculation
		var A:Number = Math.tan(22.5 * Math.PI/180);
		// variables for each of 8 segments
		var endx:Number;
		var endy:Number;
		var cx:Number;
		var cy:Number;

		TARGET_MC.grabber.highlight.lineStyle(.25, 0x333333, 100);
		TARGET_MC.grabber.highlight.beginGradientFill("radial", [0xE027A9, 0x333333], [100, 100], [115, 255], {matrixType:"box", x:-1.5*r, y:-1.5*r, w:2.75*r, h:2.75*r, r:r});
		TARGET_MC.grabber.highlight.moveTo(x+r, y);
				
		TARGET_MC.grabber.color.lineStyle(.25, 0x333333, 100);
		TARGET_MC.grabber.color.beginGradientFill("radial", [0xCCCCCC, 0x333333], [100, 100], [115, 255], {matrixType:"box", x:-1.5*r, y:-1.5*r, w:2.75*r, h:2.75*r, r:r});
		TARGET_MC.grabber.color.moveTo(x+r, y);
		
		TARGET_MC.grabber.shadow.beginFill(0x000000, 100);
		TARGET_MC.grabber.shadow.moveTo(x+r, y);
		for (var angle:Number = 45; angle<=360; angle += 45) {
		   // endpoint
		   endx = r*Math.cos(angle*Math.PI/180);
		   endy = r*Math.sin(angle*Math.PI/180);
		   // control:
		   // (angle-90 is used to give the correct sign)
		   cx =endx + r* A *Math.cos((angle-90)*Math.PI/180);
		   cy =endy + r* A *Math.sin((angle-90)*Math.PI/180);
		   TARGET_MC.grabber.highlight.curveTo(cx+x, cy+y, endx+x, endy+y);
		   TARGET_MC.grabber.color.curveTo(cx+x, cy+y, endx+x, endy+y);
		   TARGET_MC.grabber.shadow.curveTo(cx+x, cy+y, endx+x, endy+y);
		}
		TARGET_MC.grabber.highlight.endFill();
		TARGET_MC.grabber.color.endFill();
		TARGET_MC.grabber.shadow.endFill();
	
	}
	
	function fadeHandArrows() {

		arrowTween = new Tween(TARGET_MC.hand.handArrow_mc, "_alpha", Regular.easeOut, 100, 0, .5, true);	

	}
	
	function moveGrabber(){
		
		TARGET_MC.grabber._x = TARGET_MC._xmouse;
		TARGET_MC.grabber._y = TARGET_MC._ymouse;
		TARGET_MC.grabber._alpha = 100;	
		
	}
	
	function rollOverTextField(){
		
		clearInterval(nGrabberMover);	
		Mouse.hide();	
		TARGET_MC.grabber.highlight._alpha=0;
			
		nGrabberMover = setInterval(Delegate.create(this,moveGrabber),10);				


	
	}
	
	function rollOutTextField(){	
	
		if ((TARGET_MC._xmouse-scrollField_X)>0 && (TARGET_MC._ymouse-scrollField_Y)>0){

			if ((TARGET_MC._xmouse-scrollField_X)<TARGET_MC.scrollingTextfield.scrollingText_mask._width && (TARGET_MC._ymouse-scrollField_Y)<TARGET_MC.scrollingTextfield.scrollingText_mask._height){
				TARGET_MC.grabber.highlight._alpha=100;

			}else{
				clearInterval(nGrabberMover);
				TARGET_MC.grabber._alpha = 0;	
				Mouse.show();		

			}

		}else{
				clearInterval(nGrabberMover);					
				TARGET_MC.grabber._alpha = 0;	
				Mouse.show();

			}
	
	}
	
	function returnHeight():Number{
		return TARGET_MC.scrollingTextfield.scrollingText_masked.scrollingText_mc.scrollingText_txt._height;
	}
	
	function returnY(){//:Number{
		return TARGET_MC.scrollingTextfield.scrollingText_masked._y;
		//trace(TARGET_MC.scrollingTextfield.scrollingText_masked._y);
	}
	
	function checkGrabber_Y(){
		
		var oldPosition:Number=initMouse;
		initMouse=TARGET_MC._ymouse;
	
	}
	
	public function pressTextField(_mc:MovieClip){

		delete TARGET_MC.scrollingTextfield.scrollingText_masked.onEnterFrame;
		TARGET_MC.scrollingTextfield.scrollingText_masked.Blur_blurY=0;
		TARGET_MC.grabber.color._alpha=60;
		TARGET_MC.grabber._xscale=TARGET_MC.grabber._yscale=90;		
		initMouse = TARGET_MC._ymouse;	
		startDrag(  _mc._parent  ,  false   ,  0   ,   -(_mc._height-textField_H)   ,   0  ,   0  );
		nGrabberPosition = setInterval(Delegate.create(this,checkGrabber_Y),200);	
	
	}
	
	public function releaseTextField(){
		
		clearInterval(nGrabberPosition);
		movedMouse = TARGET_MC._ymouse;
		TARGET_MC.grabber.color._alpha=100;
		TARGET_MC.grabber._xscale=TARGET_MC.grabber._yscale=100;
		moveText(initMouse,movedMouse);
		stopDrag();
	}
	
	function interAction(){
		
		//scrollText.embedFonts = true;
		
		//TARGET_MC.hand.swapDepths(TARGET_MC.getNextHighestDepth());
		
		var myText_mc:MovieClip=TARGET_MC.scrollingTextfield.scrollingText_masked.scrollingText_button;
		
		var tRollOver:Delegate = new Delegate(this, rollOverTextField);
		myText_mc.onRollOver = tRollOver.getFunction();
		
		var tRollOut:Delegate = new Delegate(this, rollOutTextField);
		myText_mc.onRollOut = tRollOut.getFunction();
		
		var tPress:Delegate = new Delegate(this, pressTextField,myText_mc);
		myText_mc.onPress = tPress.getFunction();
		
		var tRelease:Delegate = new Delegate(this, releaseTextField);
		myText_mc.onRelease = myText_mc.onReleaseOutside = tRelease.getFunction();
	
	}
	
	function moveText(_ini:Number, _mov:Number) {
		
		var maskHeight:Number=textField_H;
		var speed:Number = (Math.abs(_ini-_mov))/5;
		TARGET_MC.scrollingTextfield.scrollingText_masked.onEnterFrame = Delegate.create(this,function() {
			var newsClip=TARGET_MC.scrollingTextfield.scrollingText_masked;
			speed += -speed*.075;
			//trace(newsClip._y);
			returnY();
			if (_ini<_mov) {
				//move text down
				if (newsClip._y<=0) {	
					trace("down");				
					newsClip._y += speed;
					newsClip.Blur_blurY=speed/2;
					if (newsClip._y>0 || newsClip._y==0){
						newsClip._y=0;
						newsClip.Blur_blurY=0;
						delete newsClip.onEnterFrame;
					}
				}
			} else {
				//move text up
				if (newsClip._y>-(newsClip._height-maskHeight)) {
					newsClip.Blur_blurY=speed/2;
					newsClip._y -= speed;
				
					if (newsClip._y<-(newsClip._height-maskHeight)){
						newsClip._y=-(newsClip._height-maskHeight);
						newsClip.Blur_blurY=0;
						delete newsClip.onEnterFrame;
					}

				}
			}

			
			if (newsClip._y<-(newsClip._height-maskHeight) || newsClip._y== -(newsClip._height-maskHeight)){
						newsClip._y=-(newsClip._height-maskHeight);
						newsClip.Blur_blurY=0;
						delete newsClip.onEnterFrame;
					}
					
			if (speed<.05){
				newsClip.Blur_blurY=0;
				delete newsClip.onEnterFrame;
			}
			

		});		
	}
}



