
import mx.transitions.easing.*;
import mx.transitions.*;
import flash.external.*;
import mx.utils.Delegate;


/**
 * @author Greg
 */
class com.continuityny.usoc.USOC_Loader {
	
	
	private var TARGET_MC : MovieClip;
	private var LOCAL : Boolean;
	private var MAIN_MCL : MovieClipLoader;
	private var MAIN_LISTENER : Object;
	private var STAGE_LISTENER : Object;
	private var COUNT : Number;
	private var BAR_INT : Number;
	private var PAUSE_INT : Number;

	
	public function USOC_Loader(_mc:MovieClip) {
		
		TARGET_MC = _mc;
		
		init();
	}
	
	
	private function init(){
		
		Stage.scaleMode = "noScale"; 
		Stage.align = "LT"; 
		
		var _mc = TARGET_MC.about_mc;
				new Tween(_mc, "_y", Regular.easeOut, _mc._y, 90, .5, true);
				
		LOCAL = (new LocalConnection().domain() == "localhost") ? true : false ; 
		
		STAGE_LISTENER = new Object();
		Stage.addListener(STAGE_LISTENER); 
		STAGE_LISTENER.onResize = Delegate.create(this, position); 
		
		COUNT = 0; 
		
		TARGET_MC.createEmptyMovieClip("all_mc", 100); // Clip to hold main SWF
		TARGET_MC["all_mc"]._alpha = 0; 

		MAIN_MCL = new MovieClipLoader();
		MAIN_LISTENER = new Object(); 
		
		MAIN_MCL.addListener(MAIN_LISTENER);

		MAIN_LISTENER.onLoadProgress = Delegate.create(this, upDateProgress); 
		
		MAIN_LISTENER.onLoadStart = Delegate.create(this, function(){		
			var mc = TARGET_MC.percentage_mc;
			new Tween(mc, "_y", Regular.easeOut, mc._y, 375, .5, true);
		});
		
		MAIN_LISTENER.onLoadComplete = Delegate.create(this, function(){	
			//TARGET_MC.all_mc._alpha = 100; 
				TARGET_MC.loading_mc._visible = false; 
				TARGET_MC.all_mc._lockroot = true;// Help components work
				
				PAUSE_INT = setInterval(Delegate.create(this, function(){
					TARGET_MC["all_mc"]._alpha = 100; 
					clearInterval(PAUSE_INT); 
				}), 1000); 
				
				var _mc = TARGET_MC.about_mc;
				new Tween(_mc, "_y", Regular.easeIn, _mc._y, -300, .5, true);
				
			position();
			//TARGET_MC["all_mc"]._alpha = 100; 
			
		});
		
		MAIN_LISTENER.onLoadInit = Delegate.create(this, function(){	
		});
		
		
		var mc = TARGET_MC.bottom_bar_mc.bottom_bar_mc;
		new Tween(mc, "_y", Regular.easeOut, mc._y, 4, .5, true);
		
		TARGET_MC.bg_mc._alpha = 100; 
		
		TARGET_MC.bottom_bar_mc.swapDepths(500);
		TARGET_MC.logo_mc.swapDepths(50);
		//TARGET_MC.color_mc.swapDepths(50);
		
		TARGET_MC.about_mc.swapDepths(1245);
		
		loadMain();
		
		BAR_INT = setInterval(Delegate.create(this, positionBottomBar), 10); 

		
		
	}
	
	
private function fade(	_mc:MovieClip, n:Number	){
	//trace("fade"+_mc+" - "+n);
	new Tween(_mc, "_alpha", Regular.easeOut, _mc._alpha, n, 1, true);
}





private function upDateProgress (target_mc:MovieClip, bytesLoaded:Number, bytesTotal:Number):Void {
    
	var l:Number = bytesLoaded;
	var t:Number = bytesTotal;
	
	var our_progress:String =  (Math.ceil(bytesLoaded/bytesTotal * 100)).toString();
	
	//trace(target_mc + ".onLoadProgress with " + bytesLoaded + " bytes of " + bytesTotal+" - "+Math.ceil(our_progress)+"%");
		
		//TARGET_MC.mask_mc.output_mc.text_txt.text = "LOADING "+(our_progress);
		
		//TARGET_MC.loading_mc.report_txt.text = "LOADING "+(our_progress);
		TARGET_MC.about_mc.loading_txt.text = "LOADING "+(our_progress)+"%";
		
		if(our_progress == "0") our_progress = "" ; 
		var this_mask_mc = TARGET_MC.mask_mc;
		this_mask_mc.mask_mc._xscale = our_progress;
		

}




// 


private function loadMain (){ // Create a callback function to load main SWF;
		
		var swf_file = "./USOC_Main_00.swf";
		
		if(LOCAL){
			MAIN_MCL.loadClip(swf_file, TARGET_MC.all_mc);
		}else{
			MAIN_MCL.loadClip(swf_file+"?noCache="+(random(99999999)), TARGET_MC.all_mc);
		}
		
}



private function position(){
	
	TARGET_MC.all_mc._y = 0; 
	TARGET_MC.all_mc._x = (Stage.width/2)-450; 

	TARGET_MC.bg_mc._x = 0; 
	TARGET_MC.bg_mc._width = Stage.width;
	
	TARGET_MC.logo_mc._x = (Stage.width/2); 
	
	TARGET_MC.mask_mc._x = (Stage.width/2); 
	
	positionBottomBar();
	
}


private function positionBottomBar(){
	
	var bottom_Y = ExternalInterface.call("getOnscreenY", "browser");

	// output_mc.text_txt.text = bottom_Y;
	TARGET_MC.output_mc.swapDepths(123456789);
	
	TARGET_MC.all_mc.nav_mc.bottom_nav_mc._y = (bottom_Y - 604); 
	TARGET_MC.all_mc.floor_mc._y = (bottom_Y - 250); 
	
	TARGET_MC.about_mc._x = Stage.width/2;
	
	var x_offset = TARGET_MC.all_mc._x; 
	var swidth = Stage.width; 
	var top_nav_mc = TARGET_MC.all_mc.nav_mc.top_nav_mc;
	top_nav_mc.search_mc._x = -x_offset;
	//top_nav_mc.search_mc._x = swidth - 400 - x_offset; 
	var TOO_WIDE:Boolean = (swidth>900);
	top_nav_mc.countdown_mc._x = (TOO_WIDE) ? (swidth - 420 - x_offset) : (480 - x_offset);
	top_nav_mc.logo_mc._x 	= (TOO_WIDE) 	? ((swidth/2)-85-x_offset) 	: (365 - x_offset);
	//( (Stage.width) < 900) ? 400 : (Stage.width/2) ; 
	
	// 12 23
	
	var bot_nav_mc = TARGET_MC.all_mc.nav_mc.bottom_nav_mc;
	bot_nav_mc._x = 36 - x_offset; 
		//bot_nav_mc.menu_mask_mc._x 		= 24 - TARGET_MC.all_mc._x; 
	
	bot_nav_mc.static_menu_mc._x 		= (TOO_WIDE) ? (Stage.width - 500 ) : (406 ); 
	bot_nav_mc.static_menu_mask_mc._x 	= (TOO_WIDE) ? (Stage.width - 490  ) : (396 ); 
	
	bot_nav_mc.bot_links_mc._x 	= (TOO_WIDE) ? (Stage.width - 431 - 36 ) : (431 ); 
	
	// TARGET_MC.all_mc.galaxy_mc._x = (Stage.width/2)-400;
	
	//TARGET_MC.all_mc._alpha = 100; 
	
	updateAfterEvent();
}







		
		
		
	
}