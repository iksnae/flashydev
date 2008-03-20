/**
 * @author Greg
 */

	
//	Debug
import com.bourre.log.Logger;
import com.bourre.log.LogLevel;

//	Implement
import com.bourre.commands.Command;

//	Hash
import com.bourre.core.HashCodeFactory;

//	Type
import com.bourre.events.IEvent;

//	Model
import com.bourre.core.Model;
import com.continuityny.usoc.USOC_Site_Model;
import com.continuityny.usoc.USOC_ModelList;

//	Views
import com.bourre.visual.MovieClipHelper;
import com.continuityny.usoc.USOC_ViewList;
import com.continuityny.usoc.views.USOC_Nav_View;
import com.continuityny.usoc.views.USOC_Location_View;
import com.bourre.commands.Delegate;
import com.continuityny.usoc.views.USOC_Sound_View;

class com.continuityny.usoc.commands.ChangeLocation 
	implements Command {

/* ****************************************************************************
* CONSTRUCTOR
**************************************************************************** */
	function ActivateVideo() {}
	
/* ****************************************************************************
* PUBLIC FUNCTIONS
**************************************************************************** */
/**
* This called by the FrontController when a event associated to it is triggered
* @param	e
*/
	public function execute( e : IEvent ) : Void {
		
		var loc : String = 	e.getTarget()[0];
		var data  = 		e.getTarget()[1];
		//var param  = 		e.getTarget()[2];
		
		trace("Event: ChangeLocation  loc - "+loc+" data - "+data.uid);
		
		USOC_Location_View( MovieClipHelper.getMovieClipHelper( 
				USOC_ViewList.VIEW_LOCATION ) ).changeLocation(loc, data);
	
	
	}

	public function toString() : String {
		return 'com.continuityny.usoc.commands.ChangeLocation' + HashCodeFactory.getKey( this );
	}
	
}
