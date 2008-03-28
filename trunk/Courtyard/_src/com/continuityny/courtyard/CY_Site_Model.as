/**
 * @author Greg
 */

	
//	Debug
import com.bourre.log.Logger;
import com.bourre.log.LogLevel;

//	Model
import com.bourre.core.Model;

//	Import the model list
import com.continuityny.courtyard.CY_ModelList;

//	Broadcasting event
import com.bourre.events.EventType;
import com.bourre.events.BasicEvent;
import com.continuityny.courtyard.CY_EventList;
import com.continuityny.courtyard.CY_EventBroadcaster;
import com.bourre.events.IEvent;

class com.continuityny.courtyard.CY_Site_Model 
	extends Model {

/* ****************************************************************************
* PRIVATE STATIC VAR 
**************************************************************************** */


/* ****************************************************************************
* PRIVATE VAR 
**************************************************************************** */
	
	private static var _data 		: Object; 
	private static var _config 		: Object; 
	

/* ****************************************************************************
* CONSTRUCTOR
**************************************************************************** */
	function CY_Site_Model() {
		super( CY_ModelList.MODEL_SITE);
		
	}



/* ****************************************************************************
* PRIVATE FUNCTIONS
**************************************************************************** */

/* ****************************************************************************
* PUBLIC FUNCTIONS
**************************************************************************** */
	
	public static function getData( Void ) : Object {
		return _data; 
	}
	
	public static function getConfig( Void ) : Object {
		return _config; 
	}
	
	
	
	public function organizeData( e : IEvent ){
		
		_data 	= e.getTarget()[0]; 
		_config = e.getTarget()[1];
		
		
		trace("Model organizeData:"+_data.locations.section[0].loc);
		
		for (var i:Number = 0; i<_data.locations.section.length; i++){
			
			var loc = _data.locations.section[i].loc;
			
			_data.locations.section[loc] = 	_data.locations.section[i];
			trace("loc:"+loc+" _data.section[loc]"+_data.locations.section[loc].loc );
			
		}
			
	}

	

	

}
