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
import com.continuityny.courtyard.views.CY_Sound_View;
import com.continuityny.courtyard.views.CY_Location_View;import com.continuityny.courtyard.views.CY_Home_View;

class com.continuityny.courtyard.commands.BuildSite 
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
		
		trace("CY BuildSite Executing");

		//CY_Site_Model( Model.getModel( CY_ModelList.MODEL_SITE ) ).organizeData( e );		
		CY_Home_View( MovieClipHelper.getMovieClipHelper( CY_ViewList.VIEW_HOME))._build(e);

		CY_Nav_View( MovieClipHelper.getMovieClipHelper( CY_ViewList.VIEW_NAV ) )._build(e);
		
		//CY_Sound_View( MovieClipHelper.getMovieClipHelper( CY_ViewList.VIEW_SOUND ) )._loadSounds();
		
		
	}

	
	public function toString() : String {
		return 'com.continuityny.courtyard.commands.BuildSite' + HashCodeFactory.getKey( this );
	}
	
}
