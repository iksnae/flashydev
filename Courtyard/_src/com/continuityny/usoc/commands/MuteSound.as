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
import com.continuityny.usoc.views.USOC_Sound_View;

class com.continuityny.usoc.commands.MuteSound 
	implements Command {

/* ****************************************************************************
* CONSTRUCTOR
**************************************************************************** */
	function MuteSound() {}
	
/* ****************************************************************************
* PUBLIC FUNCTIONS
**************************************************************************** */
/**
* This called by the FrontController when a event associated to it is triggered
* @param	e
*/

	public function execute( e : IEvent ) : Void {
		trace("BuildSite Executing");

		var bool = e.getTarget()[0];
		
		USOC_Nav_View( MovieClipHelper.getMovieClipHelper( USOC_ViewList.VIEW_NAV ) ).soundMute(bool);
		
		USOC_Sound_View( MovieClipHelper.getMovieClipHelper( USOC_ViewList.VIEW_SOUND ) ).soundMute(bool);
	}


	public function toString() : String {
		return 'com.continuityny.usoc.commands.MuteSound' + HashCodeFactory.getKey( this );
	}
	
}
