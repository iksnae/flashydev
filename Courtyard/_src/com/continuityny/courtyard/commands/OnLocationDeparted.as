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

class com.continuityny.courtyard.commands.OnLocationDeparted 
	implements Command {

/* ****************************************************************************
* CONSTRUCTOR
**************************************************************************** */
	function BuildSite() {}
	
/* ****************************************************************************
* PUBLIC FUNCTIONS
**************************************************************************** */
/**
* This called by the FrontController when a event associated to it is triggered
* @param	e
*/

	public function execute( e : IEvent ) : Void {
		//trace("OnLocationDeparted Executing:"+e.getTarget()[0]);

		//USOC_Site_Model( Model.getModel( USOC_ModelList.MODEL_SITE ) ).organizeData( e );
	
		//USOC_Universe_View( MovieClipHelper.getMovieClipHelper( USOC_ViewList.VIEW_UNIVERSE ) ).populate( e );
		
		CY_Location_View( MovieClipHelper.getMovieClipHelper( CY_ViewList.VIEW_LOCATION ) ).onDepartureDone( e );
	}


	public function toString() : String {
		return 'com.continuityny.courtyard.commands.OnLocationDeparted' + HashCodeFactory.getKey( this );
	}
	
}
