/**
 * @author Greg
 */

	
//	Debug
import com.bourre.log.Logger;
import com.bourre.log.LogLevel;

//	Model
import com.bourre.core.Model;

//	Import the model list
import com.continuityny.usoc.USOC_ModelList;

//	Broadcasting event
import com.bourre.events.EventType;
import com.bourre.events.BasicEvent;
import com.continuityny.usoc.USOC_EventList;
import com.continuityny.usoc.USOC_EventBroadcaster;
import com.bourre.events.IEvent;

class com.continuityny.courtyard.CY_Site_Model 
	extends Model {

/* ****************************************************************************
* PRIVATE STATIC VAR 
**************************************************************************** */


/* ****************************************************************************
* PRIVATE VAR 
**************************************************************************** */
	
	// big ball o' data - from usoc_data.xml
	private static var _data 		: Object; 
	private static var _config 		: Object; 
	private static var _connections 		: Object; 
	

/* ****************************************************************************
* CONSTRUCTOR
**************************************************************************** */
	function CY_Site_Model() {
		super( USOC_ModelList.MODEL_SITE);
		
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
	
	public static function getConnections( Void ) : Object {
		return _connections; 
	}
	
	
	public function organizeData( e : IEvent ){
		
		_data = e.getTarget()[0]; 
		_config = e.getTarget()[1];
		_connections = e.getTarget()[2];
		
		
		trace("Model organizeData:"+_data);
		
	}

	public function addGalaxyMCToAthleteData( e : IEvent ) {
			
			// add a reference for the galaxy_mc to the big ball o' data
			var data = e.getTarget(); 
			
			trace("galaxy_mc:"+data["galaxy_mc"]+"  key:" +data["key"]);
			
			_data.athlete[data["key"]]["galaxy_mc"] = data["galaxy_mc"];
	
	}
	
	
	
	public static function getAthleteDataById(id) : Object {
		
		var data : Object; 
		var athletes_data = _data.athlete;  
		
		trace("idid:"+id);
		
			for (var i : Number = 0; i < (athletes_data.length); i++) {
				
				var aid = 	athletes_data[i].aid;
				//trace(sport_data[i].uid+" - "+id); 
				
				data = athletes_data[i];
				trace("data:"+aid+ " "+data.uid+" id:"+id);
				if(aid == id){
					break;
					trace("break data:"+data);
				}
		}
		
		return data;
		
	}

	

}
