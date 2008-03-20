
import flash.display.BitmapData;
import mx.utils.Delegate;
import flash.geom.ColorTransform;


/**
 * @author Greg
 */
 
class com.continuityny.effects.Reflect {
	
	
	private var TARGET_MC:MovieClip; 
	private var ORIG_BMP:BitmapData; 
	
	private var REFLECT_BMP:BitmapData; 
	
	private var GRAD_ID:String; 
	
	private var ORIGINAL_MC:MovieClip; 
	private var REFLECTION_MC:MovieClip; 
	private var GRADIANT_MC:MovieClip; 
	private var CONTAINER_MC:MovieClip; 
	
	private var GAP:Number; 
	private var REFLECT_HEIGHT:Number; 
	
	private var SELF_UPDATE:Boolean = false; 
	private var UPDATE_INT:Number; 
	
	static var REFLECTION_ARRAY:Array; 
	static var COUNT:Number; 
	
	private var WIDTH:Number; 
	private var HEIGHT:Number; 
	
	private var DEPTH:Number; 
	
	
	private static var labelMe:Boolean = false; 
	
	
	public function Reflect (	_mc:MovieClip, 
								gap:Number, 
								reflectHeight:Number, 
								mcHeight:Number, 
								selfUpdate:Boolean, 
								d:Number){
		
			
			
			TARGET_MC 	= _mc; 
			DEPTH 		= d; 
			
			GAP = (gap!= undefined) ? gap : 10 ; 
			
			SELF_UPDATE = (selfUpdate == undefined) ? false : selfUpdate ; 
			
			WIDTH = _mc._width;
			HEIGHT = (mcHeight == undefined) ? _mc._height : mcHeight; 
			
			//HEIGHT += (GAP*.5); 
			
			WIDTH = Stage.width; 
			
			//trace("Reflect:"+HEIGHT+" mc:"+_mc); 
			
			if (REFLECTION_ARRAY == undefined) REFLECTION_ARRAY = new Array() ; 
			REFLECTION_ARRAY.push(this); 
			if (COUNT == undefined){ COUNT = 1; } else { COUNT++; }; 
			
			REFLECT_HEIGHT = (reflectHeight!= undefined) ? reflectHeight : 30 ; 
			
		//	CONTAINER_MC = TARGET_MC._parent.createEmptyMovieClip("reflect_cont_"+COUNT+"_mc", (TARGET_MC.getDepth()+10)); 
			CONTAINER_MC = TARGET_MC._parent.createEmptyMovieClip("reflect_cont_"+COUNT+"_mc", (TARGET_MC.getDepth()+10)); 
		
		
			CONTAINER_MC.swapDepths(TARGET_MC);
			
			CONTAINER_MC._x = TARGET_MC._x; 
			//CONTAINER_MC._x = 0; 
			CONTAINER_MC._y = TARGET_MC._y; 
			
			REFLECTION_MC = CONTAINER_MC.createEmptyMovieClip("r_mc", 200); 
			
			if(labelMe){
				CONTAINER_MC.createTextField("num_txt",2456, (10+(COUNT*10)), 20, 30, 30);
				CONTAINER_MC.num_txt.text = COUNT; 
			}
			
			REFLECTION_MC._rotation = 180; 
			REFLECTION_MC._xscale = -100; 
			
			
			REFLECTION_MC.createEmptyMovieClip("inner_mc", 1000); 
	
			ORIG_BMP = new BitmapData(WIDTH, HEIGHT, true, 0x00000000);
			
			//REFLECTION_MC.a
			REFLECTION_MC.inner_mc.attachBitmap(ORIG_BMP, 400, "auto", false);
			
			REFLECTION_MC._y = (2*REFLECTION_MC._height) + GAP; 
			
			// REFLECTION_MC._y = GAP+100; 
			
			// REFLECTION_MC._x = -10; 
				var grad_depth = CONTAINER_MC.getNextHighestDepth();
				GRADIANT_MC = CONTAINER_MC.attachMovie("mc_gradiant", "gradiant_mc", grad_depth); 
				trace("TARGET_MC:"+TARGET_MC+" GRadient_mc:"+GRADIANT_MC); 
				GRADIANT_MC._width = WIDTH; 
				
				GRADIANT_MC._y = GAP+REFLECTION_MC._height;
				
				GRADIANT_MC._height = REFLECT_HEIGHT;//30; 
				REFLECTION_MC._alpha = 30; 
				
				REFLECTION_MC.cacheAsBitmap = true; 
				GRADIANT_MC.cacheAsBitmap = true; 
				
				REFLECTION_MC.setMask(GRADIANT_MC);
				
				
				if(SELF_UPDATE){
					
					trace("SelfUpdate:");
					autoUpdate();
				
				}
				
			REFLECTION_ARRAY[DEPTH] = CONTAINER_MC;
				
	}
	
	public function autoUpdate(){
		
		UPDATE_INT = setInterval(Delegate.create(this, updateReflection), 33);
				trace("Auto update:"+UPDATE_INT);
	}
	
	public function setHeight (n:Number){
		trace("setHeight:"+n); 
		HEIGHT = n; 
		
	}
	
	public function destroy (){
		trace("Reflect Destroy:"+CONTAINER_MC);
		
		clearInterval(UPDATE_INT); 
		CONTAINER_MC.removeMovieClip();
		
		delete REFLECT_BMP;
		
	}
	
	public function clear(){
		
		clearInterval(UPDATE_INT); 
		
	}
	
	public function updateReflection(){
		
		//trace("Reflect:"+HEIGHT+" mc:"+TARGET_MC); 
		WIDTH = Stage.width; 
		//trace("Reflect: - WIDTH"+WIDTH+"REFLECTION_MC:"+REFLECTION_MC+" depth:"+REFLECTION_MC.getDepth());
		
		ORIG_BMP = new BitmapData(WIDTH, HEIGHT, true, 0x00000000);
		ORIG_BMP.draw(TARGET_MC);
		REFLECTION_MC.inner_mc.attachBitmap(ORIG_BMP, 400, "auto", false);
		
		updateAfterEvent();
		
	}
	
	function updatePosition(){
		
		CONTAINER_MC._x = TARGET_MC._x;
		CONTAINER_MC._alpha = TARGET_MC._alpha;
		
	}
	
	function getTarget(): MovieClip{
		return TARGET_MC; 	
	}
	
	function updateAll(){
		
		for(var each in REFLECTION_ARRAY){
		// trace("REFLECTION_ARRAY[each]:"+UPDATE_INT+" : "+REFLECTION_ARRAY[each].getTarget()); 
			var r = REFLECTION_ARRAY[each];
			r.updateReflection(); 
			r.updatePosition(); 
		}
			
		
	}
	
	
	
	
}