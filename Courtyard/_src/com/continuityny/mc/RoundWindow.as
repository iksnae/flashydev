﻿class com.continuityny.mc.RoundWindow {	public function RoundWindow() {	}	private function drawBevelRect(mc:MovieClip, col:Number, x:Number, y:Number, w:Number, h:Number, rad:Number) {		mc.clear();		//mc.lineStyle(0,0xff0000);		mc.beginFill(col);		mc.moveTo(x+rad,y);		mc.lineTo(x+w-rad,y);		mc.curveTo(x+w,y,x+w,y+rad);		mc.lineTo(x+w,y+h-rad);		mc.curveTo(x+w,y+h,x+w-rad,y+h);		mc.lineTo(x+rad,y+h);		mc.curveTo(x,y+h,x,y+h-rad);		mc.lineTo(x,y+100);		mc.curveTo(20,60,0,y+rad+15);		mc.lineTo(x,y+rad);		mc.curveTo(x,y,x+rad,y);		mc.endFill();	}	public function make(mc:MovieClip, mcol:Number, x:Number, y:Number, w:Number, h:Number, rad:Number, alpha:Number):MovieClip {		trace("make: "+mc);		var bmc:MovieClip = mc.createEmptyMovieClip("base_mc", 200);		bmc._x = x;		bmc._y = y;		drawBevelRect(bmc,mcol,0,0,w,h,rad);		setColor(bmc,mcol);		if (alpha != null) {			bmc._alpha = alpha;		}		return bmc;	}	private function setColor(mc:MovieClip, hex:Number):Void {		(new Color(mc)).setRGB(hex);	}}