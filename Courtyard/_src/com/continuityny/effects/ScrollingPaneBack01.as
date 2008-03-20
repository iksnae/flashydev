import flash.display.*;
import mx.utils.Delegate;
/**
 * @author continuityuser
 */
class com.continuityny.effects.ScrollingPane {
	
	var TARGET_MC:MovieClip;
	var TARGET_IMG:MovieClip; //image_holder MC which the dynamic image was loaded into
	
	var TARGET_BMP1:MovieClip; 
	var TARGET_BMP2:MovieClip; 

	var TARGET_WIDTH:Number;
	var TARGET_HEIGHT:Number;
	var TARGET_X:Number;
	
	var TARGET_MC_DUP:MovieClip;
	
	var nIncrement:Number=1;
	
	var nInt:Number;
	
	function ScrollingPane(_mc:MovieClip){
		
		TARGET_MC=_mc;
		
		TARGET_IMG=TARGET_MC._parent.image_holder;
		
		TARGET_WIDTH=TARGET_IMG._width;
		TARGET_HEIGHT=TARGET_IMG._height;
		
		TARGET_BMP1=TARGET_MC.createEmptyMovieClip("bmp1", 1);//TARGET_MC.getNextHighestDepth());
		TARGET_BMP2=TARGET_MC.createEmptyMovieClip("bmp2", 2);//TARGET_MC.getNextHighestDepth());
		
		var displaybmp = new flash.display.BitmapData(TARGET_WIDTH, TARGET_HEIGHT, false, 1);
		displaybmp.draw(TARGET_IMG);
		
		TARGET_IMG._alpha=0;
		 
		TARGET_BMP1.attachBitmap(displaybmp, 1, "never", true);
		TARGET_BMP2.attachBitmap(displaybmp, 1, "never", true);
		
		TARGET_BMP2._x+=TARGET_WIDTH;
				
		
		nInt=setInterval(Delegate.create(this, movePicture), 31);
	
	}
	
	function movePicture(){
	
		TARGET_MC._x-=nIncrement;
		
		if (TARGET_MC._x<=-TARGET_WIDTH){
			TARGET_MC._x=0;
		}
	
	}
	
	
}