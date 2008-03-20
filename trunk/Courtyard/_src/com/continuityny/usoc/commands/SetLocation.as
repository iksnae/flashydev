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

class com.continuityny.usoc.commands.SetLocation 
	implements Command {

/* ****************************************************************************
* CONSTRUCTOR
**************************************************************************** */
	function SetLocation() {}
	
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
		
		/*var arrival_function : Function = function(){
			USOC_Nav_View( MovieClipHelper.getMovieClipHelper( 
				USOC_ViewList.VIEW_NAV ) ).videoBtnRelease();
		};
		
		var departure_function : Function = USOC_Nav_View( MovieClipHelper.getMovieClipHelper( 
				USOC_ViewList.VIEW_NAV ) ).closeVideo;
		//trace("arrival_function:"+arrival_function);
		
		//arrival_function();
		*/
		
		var loc = e.getTarget()[0]; 
		var arrival_function 	= e.getTarget()[1];
		var departure_function 	= e.getTarget()[2];
		var on_arrival_function 	= e.getTarget()[3];
		var on_departure_function = e.getTarget()[4];
		
		USOC_Location_View( MovieClipHelper.getMovieClipHelper( 
				USOC_ViewList.VIEW_LOCATION ) ).setLocation(	loc, 
																arrival_function, 
																departure_function, 
																on_arrival_function,
																on_departure_function);
		
		trace("setLocation Event:"+loc);
	
	}

	public function toString() : String {
		return 'com.continuityny.usoc.commands.SetLocation' + HashCodeFactory.getKey( this );
	}
	
}
