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

class com.continuityny.usoc.commands.SetData 
	implements Command {

/* ****************************************************************************
* CONSTRUCTOR
**************************************************************************** */
	function SetData() {}
	
/* ****************************************************************************
* PUBLIC FUNCTIONS
**************************************************************************** */
/**
* This called by the FrontController when a event associated to it is triggered
* @param	e
*/
	public function execute( e : IEvent ) : Void {
		trace("SetData Executing");
	//	execute the stopClock method of the ModelClock object
	//	here the command name is the same as the function name, BUT it could be different
		USOC_Site_Model( Model.getModel( USOC_ModelList.MODEL_SITE ) ).organizeData();
	
		//USOC_Universe_View( MovieClipHelper.getMovieClipHelper( USOC_ViewList.VIEW_UNIVERSE ) ).populateUniverse();
		USOC_Universe_View( MovieClipHelper.getMovieClipHelper( USOC_ViewList.VIEW_UNIVERSE ) ).populate();
	}

	public function toString() : String {
		return 'com.continuityny.usoc.commands.SetData' + HashCodeFactory.getKey( this );
	}
	
}