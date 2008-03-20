/**
 * @author Greg
 */


//	Type
import com.bourre.events.EventType;

/**
* Define all the event for the application
*/
class com.continuityny.courtyard.CY_EventList {
/* ****************************************************************************
* PUBLIC STATIC VARIABLES
**************************************************************************** */

		// Rememebr: Also add to the Array int the Controller
	public static var DO_THIS	: EventType 		= new EventType( "do_this" );
	public static var SET_DATA	: EventType 		= new EventType( "set_data" );
	public static var BUILD_SITE : EventType 		= new EventType( "build_site" );
	public static var SELECT_ATHLETE : EventType 	= new EventType( "select_athlete" );
	public static var SET_GALAXY_MC : EventType 	= new EventType( "set_galaxy_mc" );
	
	public static var LOCATION_ON_ARRIVED : EventType 	= new EventType( "location_on_arrived" );
	public static var LOCATION_ON_DEPARTED : EventType 	= new EventType( "location_on_departed" );

	public static var SET_LOCATION : EventType 			= new EventType( "set_location" );
	public static var CHANGE_LOCATION : EventType 		= new EventType( "change_location" );
	
	public static var MUTE_SOUND : EventType 		= new EventType( "mute_sound" );
	
	
	// ---- Events
	//
	// ** Video
	// showVideo / removeVideo
	// playVideo / stopVideo
	// select bandwidth
	// videoDonePlaying
	
	// Downloads
	// showDownloads/removeDownloads
	// downloadItem
	
	// ** Data
	// loadXml (site config, athletes)
	// dataLoaded
	
	// *** Search
	// searchByEmail
	
	// *** AthleteList
	// populateAthletes
	// selectAthlete 
	
	
	
	
	// ---- Models
	// - Site Model
	// 		- Store Data
	// 			- Site COnfig Data
	//			- Athlete Data
	//			- Gallaxy Data
	// 		- organize data
	
	// ---- VIEWS
	// - BaseUIView
	// 		- AthleteSearch
	//		- Downloads, View Universe, Play Video
	//		- search by email
	//  	- countdown
	//		- overall connections
	//
	// - USOC Universe
	//		- 200 athletes + USOC gallaxy
	//		- click to view message, (click message to jump to galaxy)
	//		- 
	// - Athlete Galaxy
	//		- render galaxy 
	// 		- 
	// - messageView 
	//		- create connection button
	//		- browse my ring button
	//		- tranform to accomadate form 
	// 		- form field validation
	//		- image vaildation
	//
	// - LocationView
	//		- interface with SWFAddress
	// 		
	
	
	
	
/* ****************************************************************************
* CONSTRUCTOR
**************************************************************************** */	
	function CY_EventList() {}
}



