import mx.utils.Delegate;
import com.continuityny.effects.DistortImage;
/**
 * @author Greg
 */
class com.continuityny.usoc.tests.Test_distort {

	private var TARGET_MC : MovieClip;
	private var DISTORT_MC : MovieClip;
	private var DISTORTION:DistortImage;
	
	
	public function Test_distort(_mc) {
		
		TARGET_MC = _mc;
		
		TARGET_MC.createEmptyMovieClip("container_mc", 100);
		DISTORT_MC = TARGET_MC["container_mc"];
		
		trace("test distort:"+DISTORT_MC);
		var _mcl:MovieClipLoader = new MovieClipLoader();
		var listen = new Object();
		_mcl.loadClip("./swf/galaxy_1210_a.swf", DISTORT_MC);
		
		
		listen.onLoadInit = Delegate.create(this, doDistort);
		_mcl.addListener(listen);
		
	}
	
	
	private function doDistort(){
		
		trace("doDistort");
		
		var NEW_MC:MovieClip = TARGET_MC.createEmptyMovieClip("new_mc", 1000);
		
		DISTORTION = new DistortImage(NEW_MC, DISTORT_MC, 2, 2);			
				
				DISTORTION.setTransform(	-400, 0,
											0, 700, 
											
											700, 700, 
											1000, 0
								);
		
	}
	
	
	
}