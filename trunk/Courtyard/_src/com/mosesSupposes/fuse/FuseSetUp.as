/**
 * @author chad
 */
 // FUSE IMPORTS
import com.mosesSupposes.fuse.*;


class com.mosesSupposes.fuse.FuseSetUp {
	
	var SITE_FEATURES:Array;
	var SITE_EASE:String;
	var SITE_BLUR_ZERO:Boolean;
	var SITE_ROUND_RESULTS:Boolean;
	var SITE_OUTPUT_LEVEL:Number;
	var SITE_AUTOCLEAR:Boolean;
	/*
	var FUSE_PENNER:Function;
	var FUSE_FUSE:Function;
	var FUSE_ITEM:Function;
	var FUSE_FMP:Function;
	 */
	
	public function FuseSetUp( _ease:String, _blur_zero:Boolean, _round_results:Boolean, _output_level:Number, _autoclear:Boolean){
	/*
	 * _penner:Function, _fuse:Function, _fuse_item:Function, _fuse_fmp:Function, 
	 
	FUSE_PENNER = (_penner != undefined || null) ? _penner : PennerEasing;
	FUSE_FUSE = (_fuse != undefined || null) ? _fuse : PennerEasing;
	FUSE_ITEM = (_fuse_item != undefined || null) ? _fuse_item : PennerEasing;
	FUSE_FMP = (_fuse_fmp != undefined || null) ? _fuse_fmp : PennerEasing;
	*/
	SITE_EASE = (_ease != undefined || null) ? _ease : "easeOutQuint";
	SITE_BLUR_ZERO = (_blur_zero != undefined || null) ? _blur_zero : true;
	SITE_ROUND_RESULTS = (_round_results != undefined || null) ? _round_results : true;
	SITE_OUTPUT_LEVEL = (_output_level != undefined || null) ? _output_level : 1;
	SITE_AUTOCLEAR = (_autoclear != undefined || null) ? _autoclear : true;
	
		// FUSE REGISTER SETUP
		// Available Features (via moses) and other Third-Party devs
		//	ZigoEngine.simpleSetup(Shortcuts, PennerEasing, FuseFMP, Fuse, FuseItem, FuseXML, TextFX);
		ZigoEngine.register( PennerEasing,Fuse, FuseItem   );
		// FuseFX.register (colorFX);
		// FUSE ROUNDING
		ZigoEngine.ROUND_RESULTS = SITE_ROUND_RESULTS;
		// FUSE BLUR - false to retain default blur filter blurX & blurY setting of 4
		FuseFMP.BLUR_ZERO = SITE_BLUR_ZERO;
		// ZIGO ENGINE EASING DEFAULT - This is a universal default that can be overwritten on a granular level 
		ZigoEngine.EASING = SITE_EASE;
		// FUSE ERROR OUTPUT LEVEL - Debug output complexity
		// 0 = no traces;
		// 1 = normal errors and warnings
		// 2 = additional Fuse output
		// 3 = additional FuseItem output
		Fuse.OUTPUT_LEVEL = SITE_OUTPUT_LEVEL;
		// FUSE AUTOCLEAR - automatic cleanup of garbage from memory buffer
		Fuse.AUTOCLEAR = SITE_AUTOCLEAR;
	
	}
	
}