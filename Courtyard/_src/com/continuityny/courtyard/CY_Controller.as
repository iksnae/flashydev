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
import com.continuityny.courtyard.commands.*;
import com.continuityny.courtyard.CY_EventList;
	
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
	
		//push ( CY_EventList.DO_THIS, 		new DoThis() );	
		push ( CY_EventList.BUILD_SITE, 			new BuildSite() );	
		
		push ( CY_EventList.LOCATION_ON_ARRIVED, 	new OnLocationArrived() );	
		push ( CY_EventList.LOCATION_ON_DEPARTED, 	new OnLocationDeparted() );	
		push ( CY_EventList.SET_LOCATION, 			new SetLocation() );	
		push ( CY_EventList.CHANGE_LOCATION, 		new ChangeLocation() );	
		
		//push ( CY_EventList.MUTE_SOUND, 			new MuteSound() );	
	}
	
/**
* Return the instance id
* @return
*/
	public function toString() : String {
		return 'om.continuityny.courtyard.CY_Controller' + HashCodeFactory.getKey( this );
	}
}



