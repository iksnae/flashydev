// =========================== START

//Reflect Class v2.1:
import flash.display.BitmapData;

class com.continuityny.effects.Reflect_ref {
	//Ben Pritchard 2005
	//Pixelfumes.com
	private var version:String = "2.1";
	private var mcBMP:BitmapData;
	private var reflectionBMP:BitmapData;
	private var updateInt:Number;
	
	private function redrawBMP(mc:MovieClip):Void {
		// redraws bitmap - Mim Gamiet [2006]
		mcBMP.dispose();
		mcBMP = new BitmapData(mc._width, mc._height, true, 0xFFFFFF);
		mcBMP.draw(mc);
	}
	
	function Reflect(mc:MovieClip, alpha:Number, ratio:Number, updateTime:Number, offset:Number) {
		//create a bmp obj out of it
		redrawBMP(mc);
		reflectionBMP = new BitmapData(mc._width, mc._height, true, 0xFFFFFF);
		reflectionBMP.draw(mc);
		mc.createEmptyMovieClip("reflection_mc", mc.getNextHighestDepth());
		mc.reflection_mc.attachBitmap(mcBMP, 1);
		mc.reflection_mc._yscale = -100;
		mc.reflection_mc._y = mc._height+offset;
		//create the gradient mask
		mc.createEmptyMovieClip("gradientMask_mc", mc.getNextHighestDepth());
		var fillType:String = "linear";
		var colors:Array = [0xFFFFFF, 0xFFFFFF];
		var alphas:Array = [alpha, 0];
		var ratios:Array = [0, ratio];
		var matrix = {matrixType:"box", x:0, y:0, w:mc._width, h:mc._height/4, r:(90/180)*Math.PI};
		var spreadMethod:String = "pad";
		mc.gradientMask_mc.beginGradientFill(fillType, colors, alphas, ratios, matrix, spreadMethod);
		mc.gradientMask_mc.moveTo(0, 0);
		mc.gradientMask_mc.lineTo(0, mc._height/2);
		mc.gradientMask_mc.lineTo(mc._width, mc._height/2);
		mc.gradientMask_mc.lineTo(mc._width, 0);
		mc.gradientMask_mc.lineTo(0, 0);
		mc.gradientMask_mc.endFill();
		mc.gradientMask_mc._y = mc._height/2;
		mc.reflection_mc.cacheAsBitmap = true;
		mc.gradientMask_mc.cacheAsBitmap = true;
		mc.reflection_mc.setMask(mc.gradientMask_mc);
		if (updateTime && updateTime > 0) updateInt = setInterval(this, "update", updateTime, mc);
	}
	private function update(mc):Void {
		redrawBMP(mc);
		reflectionBMP.draw(mc);
		mc.reflection_mc.attachBitmap(mcBMP, 1);
	}

}