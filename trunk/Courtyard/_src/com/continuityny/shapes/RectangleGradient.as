
import de.alex_uhlmann.animationpackage.drawing.Rectangle;
import flash.geom.Matrix;

/**
 * @author gregpymm
 */

class com.continuityny.shapes.RectangleGradient {
	
	
	private static var TARGET_MC:MovieClip; 
	
	public function RectangleGradient(_mc:MovieClip, x, y, w, h){
		
		
		TARGET_MC = _mc;
		
		var myRectangle:Rectangle = new Rectangle(TARGET_MC, x,y,w,h);
		
		myRectangle.lineStyle(2,0x000000,100);
		
		var fillType:String = "linear";
		var colors:Array = [0x000000, 0x000000];
		var alphas:Array = [0, 100];
		var ratios:Array = [0x00, 0xFF];
		var matrix:Matrix = new Matrix();
		
		matrix.createGradientBox(w, h,0,-(w*.5));
		var spreadMethod:String = "pad";


		myRectangle.gradientStyle(fillType, colors, alphas, ratios,matrix);
		myRectangle.draw();
		
	}
	
	
}