import com.bourre.data.libs.LibEvent;
/**
 * @author Greg
 */
class com.continuityny.display.PreloadDisplay {

	private static var TARGET_MC : MovieClip;
	private static var percentTargetArray:Array;
	private static var urlTargetArray : Array;
	
	public function PreloadDisplay( _mc:MovieClip ) {
		
		TARGET_MC = _mc;
		
		percentTargetArray = new Array();
		urlTargetArray = new Array();
		
		// TODO 
		// - bring in
		// - bring out
	}
	
	
	public static function setPercentTarget( targ ){
		trace("setPercentTarget:"+targ);
		percentTargetArray.push(targ); 
	}
	
	public static function setUrlTarget( targ ){
		trace("setUrlTarget:"+targ);
		urlTargetArray.push(targ); 
	}
	
	
	public static function displayProgress(e:LibEvent){
		
		var __url 			= e.getLib().getURL();
		var pct_num:Number 	= e.getPerCent();
		var pct:String 		= "LOADING "+(100-pct_num);
			
		trace("display progress:"+pct);
		
		displayPercents(pct_num);
		displayUrls(__url);
		
	}
	
	
	public static function displayProgressMCL (target_mc:MovieClip, bytesLoaded:Number, bytesTotal:Number):Void {
    
		var l:Number = bytesLoaded;
		var t:Number = bytesTotal;
	
		var pct:Number 	= (Math.ceil(l/t * 100));
		var __url 		= target_mc._url;
		
		trace("displayProgressMCL:"+bytesLoaded+" our_progress:"+pct+" __url:"+__url );
		
		displayPercents(pct);
		displayUrls(__url);
	}
	
	
	
	private static function displayPercents(pct_num){
		
		for (var each : String in percentTargetArray) {
			
			var targ = percentTargetArray[each];
			trace("displayPercents:"+(typeof targ) );
			
			if( (typeof targ) == "movieclip") targ._xscale = pct_num;
			if( (typeof targ) == "object") targ.text = "LOADING "+(100-pct_num.toString());
			
		}	
	}
	
	
	private static function displayUrls(urL:String){
		
		for (var each : String in urlTargetArray) {
			
			var targ = urlTargetArray[each];
			trace("displayUrls"+(urL) );
			targ.text  = urL;
	
		}	
	}
	
	
	
}