import flash.display.*;
import mx.utils.Delegate;
/**
 * @author continuityuser
 */
class com.continuityny.effects.ScrollingPane {
	

	
	var TARGET_MC:MovieClip;
	var TARGET_IMG:MovieClip; // image_holder MC which the dynamic image was loaded into
	
	var TARGET_BMP1:MovieClip; 
	var TARGET_BMP2:MovieClip; 

	var TARGET_WIDTH:Number;
	var TARGET_HEIGHT:Number;
	var TARGET_X:Number;
	
	var TARGET_MC_DUP:MovieClip;
	
	var nIncrement:Number = 1;
	
	private var nInt:Number;
	public var onUpdate:Function;
	
	private var SNAP	: String; 
	private var SMOOTH	: Boolean; 
	
	//private static var SCROLLER_TARGET_ARRAY : Array;
	
	
	function ScrollingPane(_mc:MovieClip, _holder:MovieClip, snap:String, smooth:Boolean){
		
		
		trace("ScrollingPane trace");
		
		TARGET_MC = _mc;
		
		//SCROLLER_TARGET_ARRAY.push(TARGET_MC);
		
		TARGET_IMG = (_holder!= undefined) ? _holder : TARGET_MC._parent._parent.image_holder ; 
		//TARGET_IMG=TARGET_MC._parent._parent.image_holder;
		
		TARGET_WIDTH	=	TARGET_IMG._width;
		TARGET_HEIGHT	=	TARGET_IMG._height;
		
		SNAP 	= (snap == undefined) 	? "always" 	: snap ; 
		SMOOTH 	= (smooth == undefined) 	? true 		: smooth ; 
		
		//trace("w="+TARGET_WIDTH+" h="+TARGET_HEIGHT);
		
		TARGET_BMP1 = TARGET_MC.createEmptyMovieClip("bmp1", 1);//TARGET_MC.getNextHighestDepth());
		TARGET_BMP2 = TARGET_MC.createEmptyMovieClip("bmp2", 2);//TARGET_MC.getNextHighestDepth());
		
		var displaybmp = new flash.display.BitmapData(TARGET_WIDTH, TARGET_HEIGHT, false);
		displaybmp.draw(TARGET_IMG);
		
		TARGET_IMG._alpha = 0;
		 
		TARGET_BMP1.attachBitmap(displaybmp, 1, SNAP, SMOOTH);
		TARGET_BMP2.attachBitmap(displaybmp, 1, SNAP, SMOOTH);
		
		TARGET_BMP2._x += TARGET_WIDTH;
				
		//TARGET_MC._rotation = 45; 
		
		//trace("ScrollPnae _mc:"+_mc+" TARGET_WIDTH:"+TARGET_WIDTH+" displaybmp:"+displaybmp+"SMOOTH:"+SMOOTH);
	
	}
	
	public function moveInterval(){
		//if(nInt == undefined){
			nInt = setInterval(Delegate.create(this, movePicture), 33);
		//}
	}
	
	public function killInterval(){
		trace("kill interval");
		clearInterval(nInt);

	}
	
	function movePicture(){
	
		trace("move picture:"+nInt+" SNAP:"+SNAP+" SMOOTH:"+SMOOTH+" TARGET_MC:"+TARGET_MC);
		
		
		
		TARGET_MC._x -= nIncrement;
		
		if (TARGET_MC._x <= -TARGET_WIDTH){
			TARGET_MC._x = 0;
		}
		
		
		
		updateAfterEvent();
		
		onUpdate();
	
	}
	
	
}