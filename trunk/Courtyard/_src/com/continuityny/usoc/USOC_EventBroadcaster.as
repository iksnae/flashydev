/**
 * @author Greg
 */


//	Debug
import com.bourre.log.Logger;
import com.bourre.log.LogLevel;

//	EventBroadcaster
import com.bourre.events.EventBroadcaster;

class com.continuityny.usoc.USOC_EventBroadcaster 
	extends EventBroadcaster {
		
/* ****************************************************************************
* PRIVATE STATIC VARIABLES
**************************************************************************** */
	private static var _oI : USOC_EventBroadcaster;
		

/* ****************************************************************************
* CONSTRUCTOR
**************************************************************************** */
	private function USOC_EventBroadcaster( owner ) {
		super();
		_oOwner = owner ? owner : this;
		_init();
	}


/* ****************************************************************************
* PRIVATE FUNCTIONS
**************************************************************************** */
/**
* create a new instance of the USOC_EventBroadcaster
* @return
*/
	private static function _buildInstance() : USOC_EventBroadcaster	{
		USOC_EventBroadcaster._oI = new USOC_EventBroadcaster();
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
	public static function getInstance() : USOC_EventBroadcaster	{
		return (USOC_EventBroadcaster._oI instanceof USOC_EventBroadcaster) ? USOC_EventBroadcaster._oI : USOC_EventBroadcaster._buildInstance();
	}
}


