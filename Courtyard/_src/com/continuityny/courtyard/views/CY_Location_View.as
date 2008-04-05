/**
 * @author Greg
 * 
 * Location Manager View
 * 
 * 		Locations are represented as strings
 * 		
 * 		Each location has:
 * 			Arrive Function - The actions to perform TO arrive
 * 			onArrival Function - The actions to perform upon arrival
 * 			Depart Function - the actions to perform TO depart
 * 			onDeparture Function - the actions to perform upon depature
 * 
 * 			Default onDeparture action is to call Location defined by the ChangeLocation Event
 * 			
 * 		Currently the Departure function of each Location must fire a onDepartureDone event 
 * 		for the arrival of the new Location to trigger
 * 		
 */


//	Debug
import com.bourre.log.Logger;
import com.bourre.log.LogLevel;

//	Delegate
import com.bourre.commands.Delegate;

//	Event Broadcasting
import com.bourre.events.IEvent;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;

import com.continuityny.courtyard.CY_EventList;
import com.continuityny.courtyard.CY_EventBroadcaster;

//	MovieClipHelper
import com.bourre.visual.MovieClipHelper;

//	list of Views
import com.continuityny.courtyard.CY_ViewList;




import com.robertpenner.easing.*;
import mx.transitions.Tween;
import com.asual.swfaddress.SWFAddress;



class com.continuityny.courtyard.views.CY_Location_View 
	extends MovieClipHelper {

	private var address_listener : Object;
	
	private static var LOCATIONS : Object ; 
	private static var LIVE_LOCATION : String;
	private var LIVE_DATA : Object;
	private static var LIVE_E : IEvent; 
	private var DEPARTING_LOCATION : String;
	private static var DEPARTING_E : IEvent;
	private var INTERNAL_CALL : Boolean = false;
	
	private var INITIAL_LOCATION:String;

	private var INT : Number;

	private static var LIVE_PARAM : String; 
	
/* ****************************************************************************
* CONSTRUCTOR
**************************************************************************** */
	function CY_Location_View( mc : MovieClip ) {
		super( CY_ViewList.VIEW_LOCATION, mc );
		
		trace("CY_Location_View:"+mc);
		
		
		_init();
	}
	
	
/* ****************************************************************************
* PRIVATE FUNCTIONS
**************************************************************************** */
/**
* Init the view
* @param	Void
*/
	private function _init( Void ) : Void {
	
		var my_so:SharedObject = SharedObject.getLocal("video_cookie");
		
		/*
		 * If we set a shared object
		 *  
		 if(my_so.data.watched){
			INITIAL_LOCATION = "universe,welcome";
		}else{
			INITIAL_LOCATION = "universe,video";
		}
		 * */
		 
		 INITIAL_LOCATION = "ITS_A_NEW_STAY";		// INITIAL_LOCATION = "ITS_A_NEW_STAY";
		 
				
		address_listener 		= new Object();
		LOCATIONS 				= new Object();
		LIVE_DATA				= new Object();
		
		SWFAddress.onChange = Delegate.create(this, swfAddress_change);
		
		
		
	}
	
	
	private function setInitialLocation(loc:String){
		INITIAL_LOCATION = loc;	
	}
	
	public function setLocation(loc:String, arrivalFunction, departureFunction, 
											onArriveDone, onDepartDone){
		
		var loc_obj : Object = {	arrive:			arrivalFunction, 
									depart:			departureFunction, 
									onArrival:		onArriveDone,
									onDeparture:	onDepartDone
								};
		
		LOCATIONS[loc] = loc_obj;
		
		
		trace(">>> LocationView setLocation: "+loc);
	
	}
	
	
	
	
	
	
	public function changeLocation(e:IEvent){
		
		var loc : String = 	e.getTarget()[0];
		var data  = 		e.getTarget()[1];
		
		trace("\n*********************\n>>> LocationView changeLocation:"
						+loc+" LIVE_LOCATION:"+LIVE_LOCATION+" LIVE_DATA:"+data);
		
		DEPARTING_LOCATION  = LIVE_LOCATION;
		DEPARTING_E			= LIVE_E;
		LIVE_E 			= e; 
		LIVE_LOCATION 	= loc;
		LIVE_DATA 		= data;
		
		
		var params_str:String = "";
		
		// if there is data, set the parameter
		
		// TODO make this handle multiple paramaters
		
		
		// if the first param == the current first param
		// depart full string
		// else depart first param
		// cascade this
		// depart of first param needs to be able to clear secondonry items 
		
		
		var arr_array = loc.split(",");
		var dep_array = DEPARTING_LOCATION.split(",");
		
		
		trace(">>> LocationView depart: "+DEPARTING_LOCATION);
		
		if(LIVE_LOCATION != DEPARTING_LOCATION){
			
			
		
		 if(arr_array.length == 1 && dep_array.length == 1){
		
			if(arr_array[0] != dep_array[0]){
				
				LOCATIONS[DEPARTING_LOCATION].depart(DEPARTING_E);
				
			}
			
		 }else if(arr_array.length == 2 && dep_array.length == 1){
		 	
		 	if(arr_array[0] != dep_array[0]){
				
				LOCATIONS[DEPARTING_LOCATION].depart(DEPARTING_E);
				
			}else if(arr_array[0] == dep_array[0]){
				
				onDepartureDone(e);	
		 	}
		 	
		 }else if(arr_array.length == 1 && dep_array.length == 2){
		 	
		 	if(arr_array[0] != dep_array[0]){
				trace("you got the one");
				LOCATIONS[dep_array[0]].depart(DEPARTING_E);
				
			}else if(arr_array[0] == dep_array[0]){
				
				LOCATIONS[DEPARTING_LOCATION].depart(DEPARTING_E);
		 	}
		 	
		 }else if(arr_array.length == 2 && dep_array.length == 2){
		 	
		 	if(arr_array[0] != dep_array[0]){
				
				LOCATIONS[dep_array[0]].depart(DEPARTING_E);
				
			}else if(arr_array[0] == dep_array[0]){
				
				LOCATIONS[DEPARTING_LOCATION].depart(DEPARTING_E);
		 	}
		 	
		 }else if(DEPARTING_LOCATION == undefined){
			trace(">>> LocationView changeLocation - LIVE_LOCATION = undefiend");
			onDepartureDone(e);
		 }
			
		
		
		}
		
		
		/*if(data.uid != undefined ){
			params_str = ","+data["uid"];	
			//setLocation(LIVE_LOCATION+""+params_str, LOCATIONS[LIVE_LOCATION].arrive,LOCATIONS[LIVE_LOCATION].depart );
			//LIVE_PARAM = data.uid;
		
		}else if(data.aid != undefined ){
			params_str = ","+data["aid"];	
			//setLocation(LIVE_LOCATION+""+params_str, LOCATIONS[LIVE_LOCATION].arrive,LOCATIONS[LIVE_LOCATION].depart );
			//LIVE_PARAM = data.aid;
		
		}else{
			
			delete LIVE_PARAM;
				
		}*/
		
		/*
		if(DEPARTING_LOCATION == undefined){
			trace(">>> LocationView changeLocation - LIVE_LOCATION = undefiend");
			onDepartureDone();
		
		}else{
			trace(">>> LocationView depart: "+DEPARTING_LOCATION);
			LOCATIONS[DEPARTING_LOCATION].depart();
		
		}	*/
		
		
		
		//trace("params_str:"+params_str);
		
		//var address : String = LIVE_LOCATION+""+params_str;		var address : String = LIVE_LOCATION;
		
		INTERNAL_CALL = true;
		
		
		// ****************************
		// ** CHANGE TO SWFADDRESS **
		//	-- Added boolean to NOT DIPSATCH 
		//	-- "change" event if location changed internally
		// ****************************
		
		SWFAddress.setValue(address, false);
		
		
		
	}
	
	
	
	
	
	
	
	private function swfAddress_change(){
		
		
		var addr : String = SWFAddress.getValue();
		trace(">>> LocationView swfAddress_change - addr:"+addr);
		
			
		INTERNAL_CALL = false; 
		trace(">>> LocationView swfAddress_change Not Internal");
		
		
		// inital call, no paramters 
		if( (addr == "/") || (addr == "" )){ 
					
			trace(">>> LocationView - swfAddress_change initial call:"+INITIAL_LOCATION);
			this._fireEvent(new BasicEvent( CY_EventList.CHANGE_LOCATION, [INITIAL_LOCATION]) );
			
		}else{

			
			// strip backslashes			
		var stripped_addr = addr.split("/").join(""); 
		
		//trace(">>> LocationView - swfAddress_change stripped_addr.split:"+stripped_addr.split(",").length);
		
		var loc_array = stripped_addr.split(",");
		
			var base 		= loc_array[0];
			var second 		= loc_array[1];
			var third 		= loc_array[2];
			var fourth 		= loc_array[3];
			
			
			this._fireEvent(new BasicEvent( CY_EventList.CHANGE_LOCATION, [INITIAL_LOCATION]));
			
			trace(">>> LocationView - swfAddress_change - base:"+base);
		
		}
	
		
		
		 
	}
	
	
	
	
	
	
	
	
	public function onArrivalDone (e:IEvent){
		
		var d = e.getTarget();
		
		var loc 	= d[0];
		var data 	= d[1];
			trace(">>> LocationView onArrivalDone:"+loc);
			//trace("LocationView onArrivalDone:"+data.message);
		LOCATIONS[loc].onArrival(e);
		
	}
	
	public function onDepartureDone (e : IEvent){
		
		var loc = e.getTarget()[0];
		var data = e.getTarget()[1];
		trace(">>> LocationView onDepartureDone:"+loc);
		//trace("LocationView onDepartureDone:data - "+data);
		
		LOCATIONS[loc].onDeparture(e);
		
		trace(">>> LocationView arrive:"+LIVE_LOCATION +" LIVE_DATA: - "+LIVE_DATA.length);
		
		LOCATIONS[LIVE_LOCATION].arrive(LIVE_E);
		
		trace("*********************\n");
	}
	
	public static function getArrivingLocation():String{
		
		return LIVE_LOCATION; 
	}
	
	public static function getLiveLocation():String{
		
		return LIVE_LOCATION; 
	}
	
	public static function getBaseLiveLocation():String{
		trace("getBaseLiveLocation");
			if(LIVE_LOCATION.indexOf(",") != -1){
				var end:Number = LIVE_LOCATION.indexOf(",")+1;
				return LIVE_LOCATION.substr(0,end); 
				trace("CY_Location_View:base"+LIVE_LOCATION.substr(0,end));
			}else{
				return LIVE_LOCATION;
				trace("CY_Location_View:base"+LIVE_LOCATION);
			}
		
	}
	
	public static function getDepartingE():IEvent{
		//traceMe();
		return DEPARTING_E; 
	}
	
	
	
	
	public static function getSubLiveLocation():String{
		
		return LIVE_LOCATION.substr(LIVE_LOCATION.indexOf(",")+1); 
	}
	
	public static function getLiveParam():String{
	
		return LIVE_PARAM; 	
	}

/**
* Broadcast the event
* @usage	_fireEvent( new BasicEvent( EventList.MYTYPE, Object ) );
* @param	e
*/
	private function _fireEvent( e : IEvent ) : Void {
		trace("fire event");
			CY_EventBroadcaster.getInstance().broadcastEvent( e );
	}


/* ****************************************************************************
* PUBLIC FUNCTIONS
**************************************************************************** */
	
	
	
	

}