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
import com.continuityny.usoc.views.USOC_Universe_View;
import com.continuityny.usoc.views.USOC_Location_View;

class com.continuityny.usoc.commands.OnLocationArrived 
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
		
		trace("OnLocationArrived Executing - loc: "+e.getTarget()[0]);

		//USOC_Site_Model( Model.getModel( USOC_ModelList.MODEL_SITE ) ).organizeData( e );
	
		//USOC_Universe_View( MovieClipHelper.getMovieClipHelper( USOC_ViewList.VIEW_UNIVERSE ) ).populate( e );
		
		USOC_Location_View( MovieClipHelper.getMovieClipHelper( USOC_ViewList.VIEW_LOCATION ) ).onArrivalDone( e );
	}


	public function toString() : String {
		return 'com.continuityny.usoc.commands.OnLocationArrived' + HashCodeFactory.getKey( this );
	}
	
}
