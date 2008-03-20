/**
 * @author continuityuser
 */
class com.continuityny.util.Whats_inside {
	public function Whats_inside(lookHere:Object){
		trace("- - - - - - - - WHATS INSIDE : "+lookHere+" - - - - - - - - ");
		for(var xx:String in lookHere){
			trace("-> "+xx+": "+lookHere[xx]+": "+typeof(lookHere[xx]));	
		}
		trace(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
	}
	
}