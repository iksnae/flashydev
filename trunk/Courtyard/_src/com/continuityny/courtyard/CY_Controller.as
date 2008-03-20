/**
 * @author Greg
 */

	
//	Debug
import com.bourre.log.Logger;
import com.bourre.log.LogLevel;

//	Type
import com.bourre.core.HashCodeFactory;
import com.bourre.events.FrontController;

//	Commands and Event list
import com.continuityny.usoc.commands.*;
import com.continuityny.usoc.USOC_EventList;
	
class com.continuityny.courtyard.CY_Controller
	extends FrontController {
	
/* ****************************************************************************
* PRIVATE STATIC VAR
**************************************************************************** */		
	private static var _oI : CY_Controller;


/* ****************************************************************************
* PUBLIC STATIC FUNCTIONS
**************************************************************************** */		
	public static function getInstance( myDispatcher ) : CY_Controller  {
		if (!_oI) _oI = new CY_Controller( myDispatcher );
		return _oI;
	}
	
	
/* ****************************************************************************
* CONSTRUCTOR
**************************************************************************** */		
	public function CY_Controller( myDispatcher ) {
		super( myDispatcher );
		_oI = this;
		_init();
	}

	
/* ****************************************************************************
* PUBLIC FUNCTIONS
**************************************************************************** */
/**
* Push the event in the controller and link them to a command
* @param	Void
*/
	private function _init( Void ) : Void {
	
		//push ( USOC_EventList.DO_THIS, 		new DoThis() );	
		push ( USOC_EventList.BUILD_SITE, 		new BuildSite() );	
		push ( USOC_EventList.SET_DATA, 		new SetData() );	
		push ( USOC_EventList.SELECT_ATHLETE, 	new SelectAthlete() );	
		push ( USOC_EventList.SET_GALAXY_MC, 	new SetGalaxyMC() );
		
		push ( USOC_EventList.LOCATION_ON_ARRIVED, 		new OnLocationArrived() );	
		push ( USOC_EventList.LOCATION_ON_DEPARTED, 	new OnLocationDeparted() );	
		push ( USOC_EventList.SET_LOCATION, 			new SetLocation() );	
		push ( USOC_EventList.CHANGE_LOCATION, 			new ChangeLocation() );	
		
		push ( USOC_EventList.MUTE_SOUND, 			new MuteSound() );	
	}
	
/**
* Return the instance id
* @return
*/
	public function toString() : String {
		return 'om.continuityny.usoc.USOC_Controller' + HashCodeFactory.getKey( this );
	}
}



