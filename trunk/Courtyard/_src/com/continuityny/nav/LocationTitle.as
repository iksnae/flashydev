// FUSE IMPORTS
import com.mosesSupposes.fuse.*;
import com.continuityny.text.SharedFontStyle;
import com.continuityny.effects.Reflect;
// CONTINUITY IMPORTS
// import com.continuityny.effects.Reflect;


/**
 * @author chad
 */
class com.continuityny.nav.LocationTitle {
	
	var TARGET_MC:MovieClip;
	var LOCATION_STR:String;
	var UP_Y:Number = 0;
	var DOWN_Y:Number = 45;

	private var TEXT_FORMAT : TextFormat;
	private var _TXT : TextField;
	
	private var REFLECTION : Reflect ;  		
	
	public function LocationTitle (_mc:MovieClip){
		
		TARGET_MC = _mc;
		
		TEXT_FORMAT 	= new TextFormat("Frutiger_IMPORTED", 27, 0x000000);
		_TXT 			= TARGET_MC.location_mc.location_txt;
		REFLECTION 		= new Reflect(TARGET_MC, 2, 15, 30 ); 
	}
	
	public function validateLocation (_location:String){
		
		LOCATION_STR = _location;
		
		trace("validateLocation"+LOCATION_STR);
		
		

		if (LOCATION_STR == "agency" || LOCATION_STR == "contact"  ||LOCATION_STR == "careers" || LOCATION_STR == "vision" ||LOCATION_STR == "news" || LOCATION_STR == "belief" ||LOCATION_STR == "who we are" ||LOCATION_STR == "clients" ){

			
			showTitle ();
			
		}else{
		
			emptyTitle ();
		 	hideTitle ();
		
		}
	}


	private function showTitle (){
		
		trace("showTitle:"+LOCATION_STR);
		//TARGET_MC.location_mc.location_txt.text = LOCATION_STR;
		
		new SharedFontStyle(_TXT, LOCATION_STR, TEXT_FORMAT); 
		//_TXT.text = LOCATION_STR;
		
		var f:Fuse = new Fuse ();
		
		f.push ({ 	target:		TARGET_MC.location_mc, 
					y:			UP_Y, 
					ease:		"easeOutQuad",
					seconds:	.5,
					delay:		1,
					updfunc:	updateReflection,
					updscope:	this
					
					});
		
		f.start(true);
	
	}
	
	private function updateReflection(){
			REFLECTION.updateReflection();	
	}
	
	public function hideTitle (){
		trace("hideTitle");
		//TARGET_MC.location_mc.location_txt.text = LOCATION_STR;
		
		new SharedFontStyle(_TXT, LOCATION_STR, TEXT_FORMAT); 
		//_TXT.text = LOCATION_STR;
		
		var f:Fuse = new Fuse ();
		
		f.push ({	target:		TARGET_MC.location_mc, 
					y:			DOWN_Y, 
					ease:		"easeInQuad", 
					seconds:	.5, 
					//delay:		1,
					updfunc:	updateReflection,
					updscope:	this
					});
					
		f.push({func:emptyTitle});
		
		f.start(true);
		
	}
	
	private function emptyTitle (){
		trace("emptyTitle");
		//TARGET_MC.location_mc.location_txt.text = "";
		//new SharedFontStyle(_TXT, "", TEXT_FORMAT); 
		_TXT.text = "";
		
	}
	
	
}