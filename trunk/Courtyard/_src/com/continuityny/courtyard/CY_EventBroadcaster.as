/**
 * @author Greg
 */


//	Debug
import com.bourre.log.Logger;
import com.bourre.log.LogLevel;

//	EventBroadcaster
import com.bourre.events.EventBroadcaster;

class com.continuityny.courtyard.CY_EventBroadcaster 
	extends EventBroadcaster {
		
/* ****************************************************************************
* PRIVATE STATIC VARIABLES
**************************************************************************** */
	private static var _oI : CY_EventBroadcaster;
		

/* ****************************************************************************
* CONSTRUCTOR
**************************************************************************** */
	private function CY_EventBroadcaster( owner ) {
		super();
		_oOwner = owner ? owner : this;
		_init();
	}


/* ****************************************************************************
* PRIVATE FUNCTIONS
**************************************************************************** */
/**
* create a new instance of the CY_EventBroadcaster
* @return
*/
	private static function _buildInstance() : CY_EventBroadcaster	{
		CY_EventBroadcaster._oI = new CY_EventBroadcaster();
		return _oI;
	}
	

/* ****************************************************************************
* PUBLIC STATIC FUNCTIONS
**************************************************************************** */
/**
* get a reference to your object.
* used for singleton needs
* @return
*/
	public static function getInstance() : CY_EventBroadcaster	{
		return (CY_EventBroadcaster._oI instanceof CY_EventBroadcaster) ? CY_EventBroadcaster._oI : CY_EventBroadcaster._buildInstance();
	}
}


