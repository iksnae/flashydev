import com.continuityny.mc.ImageLoader;
import mx.utils.Delegate;
import flash.display.BitmapData;
import com.continuityny.util.SizeToFit; 

/**
 * @author Greg
 */
class com.continuityny.bitmap.ResampleImage extends MovieClip {
	
	private var TARGET_MC:MovieClip;
	private var IMAGE_MC:MovieClip;
	private var _BITMAP:BitmapData;
	private var SIZE : Number;

	private var BMP_MC : MovieClip; 
	
	public var whenLoaded:Function;

	private var DEPTH : Number;
	
	public function ResampleImage(_mc:MovieClip, _src:String, depth:Number, size:Number, percent:Boolean) {
		
		super(); 
		
		
		trace("Resample:"+_mc); 
		
		TARGET_MC = _mc; 
		
		IMAGE_MC = TARGET_MC.createEmptyMovieClip("image_mc", depth); 
		
		SIZE = size; 
		// _src:String = DATA["gallery_src"]; 
		// if source undefined load default path structure
		
		/*if(_src == undefined || _src == ""){
			_src = "img/SMALL/"+DATA["uid"]+"_sm.jpg";
		}*/
		BMP_MC = TARGET_MC.createEmptyMovieClip("bmp_mc", depth+1); 
		
		trace("Resample src:"+_src);
		
		var img 	= new ImageLoader(IMAGE_MC, _src);
		
		DEPTH = depth; 
		
		img.onLoaded = Delegate.create(this, function(){
			
			// new ResampleBitmap(target_mc, source_mc, new_scale) : MC
			_BITMAP = new BitmapData(IMAGE_MC._width, IMAGE_MC._height, true, 0x00);
			
			//TARGET_MC.info_mc.createEmptyMovieClip("bmp_mc", 100);
			//BMP_MC._xscale = BMP_MC._yscale = SIZE;
			
			
			
			_BITMAP.draw(IMAGE_MC);
			IMAGE_MC.unloadMovie();
			IMAGE_MC.removeMovieClip();
			
			
			
			//IMAGE_MC._y = 15; 
			//IMAGE_MC._x = 0;
			BMP_MC.attachBitmap(_BITMAP, DEPTH, "auto", true); 
			
			if(!percent || (percent==undefined))new SizeToFit(BMP_MC, SIZE);
			
			whenLoaded();
			
		});
		
		
	}
	
	public function update(){
		trace("update resample"); 
		_BITMAP.draw(IMAGE_MC);
		BMP_MC.attachBitmap(_BITMAP, DEPTH, "auto", true); 
	}
	
	
	public function getMC(): MovieClip{
		
		return BMP_MC;
		
	}
}