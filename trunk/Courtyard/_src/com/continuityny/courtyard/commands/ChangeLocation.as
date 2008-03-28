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
import com.continuityny.courtyard.CY_Site_Model;
import com.continuityny.courtyard.CY_ModelList;

//	Views
import com.bourre.visual.MovieClipHelper;
import com.continuityny.courtyard.CY_ViewList;
import com.continuityny.courtyard.views.CY_Nav_View;
import com.continuityny.courtyard.views.CY_Location_View;
import com.bourre.commands.Delegate;
import com.continuityny.courtyard.views.CY_Sound_View;
import com.continuityny.courtyard.views.CY_Home_View;class com.continuityny.courtyard.commands.ChangeLocation 
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
		
		trace("Event: ChangeLocation  loc - "+loc+" data - "+data);
		
		CY_Location_View( MovieClipHelper.getMovieClipHelper( 
				CY_ViewList.VIEW_LOCATION ) ).changeLocation(e);
		
		
		//CY_Home_View( MovieClipHelper.getMovieClipHelper( 
			//	CY_ViewList.VIEW_HOME ) ).changeSection(loc);
	
	
	}

	public function toString() : String {
		return 'com.continuityny.courtyard.commands.ChangeLocation' + HashCodeFactory.getKey( this );
	}
	
}
