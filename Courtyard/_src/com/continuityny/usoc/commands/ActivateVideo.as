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

class com.continuityny.usoc.commands.ActivateVideo 
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
	//	execute the stopClock method of the ModelClock object
	//	here the command name is the same as the function name, BUT it could be different
		//USOC_Site_Model( Model.getModel( USOC_ModelList.MODEL_SITE ) ).doThis();
		
	//	disable the start button on the ViewTools and enable the stop button
		
		//trace("arrival_function:"+arrival_function);
		
		var arrival_function : Function = USOC_Nav_View( MovieClipHelper.getMovieClipHelper( 
				USOC_ViewList.VIEW_NAV ) ).activateVideoPlayer;
		
		var departure_function : Function = USOC_Nav_View( MovieClipHelper.getMovieClipHelper( 
				USOC_ViewList.VIEW_NAV ) ).closeVideo;
		
		//arrival_function();
		
		USOC_Location_View( MovieClipHelper.getMovieClipHelper( 
				USOC_ViewList.VIEW_LOCATION ) ).setLocation("video", arrival_function);
		
	
	}

	public function toString() : String {
		return 'com.continuityny.usoc.commands.ActivateVideo' + HashCodeFactory.getKey( this );
	}
	
}
