

import com.continuityny.xml.ParseXML;
import mx.utils.Delegate;

/**
 * @author Greg
 * 
 * Builds a multidimensional array of 'location' data
 * based on the sections in a site structure
 * for use with the LocationManager
 * 
 * @param SITE_DATA - multidimensional array of top 
 * level data for a site including XML files
 * 
 * @param fun - function to call after all XML is loaded
 * 
 */


class com.continuityny.loc.LocationData extends Array {
	
	private var LOCATIONS_DATA:Array; 
	public var onLoaded:Function; 
	
	private var LOADED:Boolean; 
	private var ALL_LOADED:Boolean;

	private var CHECK_INT : Number; 
	
	private var FUN : Function ; 
	
	public function LocationData(SITE_DATA:Array, fun:Function) {
		
		
		LOCATIONS_DATA = new Array(); 
		
		FUN = fun ; 
		
		var SITE_LOCATIONS = SITE_DATA.getData().location; 
		
		for (var each in SITE_LOCATIONS){
			
			var id = SITE_LOCATIONS[each].id.toString();
			var data = SITE_LOCATIONS[each].data;
			
			trace(id+" site data:"+data);
			
			//LOCATIONS_DATA[id] = new ParseXML({filePath:"xml/", dataFile:data});
			
			//trace("SITE_XML_DATA:"+SITE_XML_DATA.getData().location[0].id);
		}
		
		// checkAllLocationDataLoaded(LOCATIONS_DATA, Delegate.create(this, fun));  
		
		checkAllLocationDataLoaded();  
		
	}
	
	
	private function checkAllLocationDataLoaded(){
		
		trace("checkAllLocationDataLoaded:"+LOCATIONS_DATA["work"].length);
		
		CHECK_INT = setInterval(function(){
			
			ALL_LOADED = true; 
			
			for (var each : String in LOCATIONS_DATA) {
				
				ALL_LOADED = LOCATIONS_DATA[each].getLoaded(); 
				
				trace("LOADED LOCATIONS_DATA[each]");
				
				if(!ALL_LOADED){
					
					break; 	
				}
			}
			
			if(ALL_LOADED){ 
				trace("ALL_LOADED clearInterval");
				clearInterval(CHECK_INT); 
				
				for (var each : String in LOCATIONS_DATA) {
					LOCATIONS_DATA[each] = LOCATIONS_DATA[each].getData(); 
				}
				
				FUN(); 
				onLoaded(); 
			}
		
		}, 100); 
		
	}
	
	
	
	public function getData(){
		return LOCATIONS_DATA;
	}
	
}