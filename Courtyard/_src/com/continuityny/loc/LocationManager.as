


import com.continuityny.loc.Location;
import com.continuityny.nav.ClickTracker;
import com.continuityny.timing.PauseThis;
import com.continuityny.util.MCUtils;
import com.bourre.commands.Delegate;

/**
   LocationManager class 
   version 1.0
   5/1/2007
   Greg Pymm
    
     * Handles 'Locations' within a site
     * Uses SWFAddress to handle browser 'Location' interaction
     * 
     * @param _mc - root timeline
     * 
     */
   
 
class com.continuityny.loc.LocationManager {
	
	
	
	private var TRACEME:Boolean = false; 
	
	private static var CURRENT_LOCATION:String;
	private static var DEPARTING_LOCATION:String;
	private static var ARRIVING_LOCATION:String;
	 
	 private static var TARGET_MC:MovieClip ;
	 
	private static var MC_ARRAY:Array = new Array();

	private static var REL_ARRAY:Array 	= new Array();
	private static var OVER_ARRAY:Array = new Array();
	private static var OUT_ARRAY:Array 	= new Array();
	
	private static var LOCATION_OBJ_ARRAY:Array = new Array();
	private static var LOCATION_ARRAY:Array 	= new Array();
	private static var ARRIVE_ACTIONS:Array 	= new Array();
	private static var DEPART_ACTIONS:Array 	= new Array();
	private static var REACTIVATE_ARRAY : Array = new Array();
	
	private static var EXTERNAL_CLICK:Boolean; 
	private static var INTERNAL_CLICK:Boolean; 
	
	private static var DEPARTED:Boolean = true; 
	
	private static var CLICKS:ClickTracker;

	private static var LOCATIONS_DATA:Array;
	
	private static var onDeparted:Function; 
	
	public var test = "test"; 
	
	private var BUTTON_ENABLED : Boolean = false;
	
	// ~~~ Initialize as an ASBoradcaste(event dispatcher)
	static var _initializeDispatcher = AsBroadcaster.initialize(LocationManager.prototype);
	private var broadcastMessage:Function;
	public var addListener:Function;
	public var removeListener:Function;
	// ~~~~
	
	
	/*
	// ---------- initialized as EventDispatcher
	static 	var __initDispatcher = EventDispatcher.initialize(BlurTween.prototype);
	private	var dispatchEvent:Function;
	private	var dispatchQueue:Function;
	public	var eventListenerExists:Function;
	public	var addEventListener:Function;
	public	var removeEventListener:Function;
	public	var removeAllEventListeners:Function;
	// ---------- end of initialized as EventDispatcher
	*/
	
	
	
	// ~~~ Add "_scale_ property and "saveState()" method to all MovieClips
	static var __initMCUtilities:MCUtils = new MCUtils();
	

	public function LocationManager ( _mc:MovieClip )  {
		
		trace("Init LocationManager:"+_mc);
		
		TARGET_MC = _mc;
		
		CLICKS = new ClickTracker();
		
		SWFAddress.onChange = Delegate.create(this, onAddressChange);
		
		TARGET_MC.faux_address_txt.text = "Location:"+SWFAddress.getValue()
		+ " "+typeof(SWFAddress.getValue())+" c: "+getCurrentLocation() ; 
		
	}
	
	
	public function pauseClicks (s:Boolean){
		
		CLICKS.pause(s);
	}
	
	
	public function setLocation(s:String):Void {
		trace("LocationManager: setLocation:"+s);
		CURRENT_LOCATION = s;
	}
	
	
	public function setTarget(mc:MovieClip):Void {
		trace("LocationManager: setTarget:"+mc);
		TARGET_MC = mc; 
	}

	
	public function getCurrentLocation () : String {
		return CURRENT_LOCATION ;
	}
	
	public function getDepartingLocation () : String {
		return DEPARTING_LOCATION ;
	}
	
	public function getArrivingLocation () : String {
		trace("LocationManager:getArrivingLocation:"+ARRIVING_LOCATION);
		return ARRIVING_LOCATION ;
	}
	
	
	



	public function addClickTarget (mc:MovieClip, rel:Function, over:Function, out:Function) : Void {
		CLICKS.addClickTarget(mc, rel, over, out);
	}
	
	public function removeClickTarget (mc:MovieClip) : Void {
		CLICKS.removeClickTarget(mc);
	}
	
	
	
	
	
	
	
	public function setNavButton ( 	mc:MovieClip, 
								  	loc:String, 
									rel:Function, 
									over:Function, 
									out:Function, 
									reactivate:Boolean
									): Void {
		
		
		trace("LocationManager: setNavButton: "+loc);
		
		// Setup enable/disable sequence
		var CLICK_FUNCTION:Function = Delegate.create(this, function(){ClickFunc(mc, loc, rel);}); 

		// save mc and function for re-enabling
		LocationManager.MC_ARRAY[loc] = mc;
		LocationManager.REL_ARRAY[loc] = CLICK_FUNCTION;
		
		LocationManager.OVER_ARRAY[loc] = over;
		LocationManager.OUT_ARRAY[loc] = out;
		
		LocationManager.REACTIVATE_ARRAY[loc] = reactivate;
	

		// now set button
		CLICKS.addClickTarget(mc, CLICK_FUNCTION, over, out);
		

		
	}
	
	

	var ClickFunc:Function = function(mc:MovieClip, loc:String, rel:Function){ 
			
		
			INTERNAL_CLICK = true; 
			
			var s = DEPARTING_LOCATION = CURRENT_LOCATION;
			
			ARRIVING_LOCATION = loc; 
			
			//trace("this_scope.CURRENT_LOCATION:"+this_scope.CURRENT_LOCATION); 
			//trace("LocationManager.CURRENT_LOCATION:"+LocationManager.CURRENT_LOCATION); 
			
			
			var hasDelimeter = (loc.indexOf(",") == -1) ? false : true ; 
			
			trace("Location Manager: Call Fun - "+loc+" ~ hasDelimeter:"+hasDelimeter+" DEPARTED:"+DEPARTED);
			
			
			// TODO handle deeper locations with commas
			//if((loc!= s) && !hasDelimeter){
			//	if((loc!= s || ((loc== s) && hasDelimeter))){
			if(loc!= s ){
				DEPARTED = false; 
				
				DEPART_ACTIONS[s]();
				
				broadcastMessage("onDeparture", s);
				LOCATION_OBJ_ARRAY[s].departureAction(s);
				
				trace("Location Manager: onDeparture (s)- "+s+" : loc:"+loc+" DEPARTED:"+DEPARTED);
				
				if(BUTTON_ENABLED)disableButtons();
				
			}
			

			
			OUT_ARRAY[s]( MC_ARRAY[s] );
		
		//	if(loc == "home")OUT_ARRAY[loc]( MC_ARRAY[loc] );
			
		
			// dis-enable current section's button
	//		CLICKS.removeClickTarget(mc);
			
			onDeparted = new Delegate(this, doOnDeparted, rel, mc, loc, s).getFunction();
			
			if(DEPARTED){
				
				onDeparted(); 
				


			}
			

			
	};



	
		
	
	
	
	
	private function doOnDeparted(rel, mc, loc, s){
		
			// re-enable last section's button
				CLICKS.addClickTarget( 	MC_ARRAY[s], 
										REL_ARRAY[s], 
										OVER_ARRAY[s], 
										OUT_ARRAY[s] );
				
				
				// reset last button's state
				// this_scope.OUT_ARRAY[s]( this_scope.MC_ARRAY[s] );
				// trace("this_scope.MC_ARRAY[s]~~~"+MC_ARRAY[s]+" ~~~ "+s);
				
				//OUT_ARRAY[s]( MC_ARRAY[s] );
				
				if(loc == "home")OUT_ARRAY[loc]( MC_ARRAY[loc] );
				
			
				// dis-enable current section's button
				CLICKS.removeClickTarget(mc);
			
			
				// CALL additional RELEASE Function-ality 
				rel(mc);
				
				// Call Arrival functions
				ARRIVE_ACTIONS[loc]();
				
							
				broadcastMessage("onArrival", loc);
				trace("Location Manager: onArrival - "+loc);
				LOCATION_OBJ_ARRAY[loc].arrivalAction(loc);
				
				
				// Set current LIVE section
				LocationManager.CURRENT_LOCATION = loc;
				
				if(!EXTERNAL_CLICK) { 
				 
					SWFAddress.setValue('/'+loc+'/');  
					TARGET_MC.faux_address_txt.text = "Location:"+SWFAddress.getValue(); 
			
				}
			
			
			enableButtons();
			//buttonLock();
			
			//TARGET_MC.faux_address_txt.text = "Location:"+loc;
		
			delete EXTERNAL_CLICK; 
			delete INTERNAL_CLICK;
	}
	
	
	private function buttonLock (){
		
		
		trace("LocationManager:buttonLock");
		
		// diasble
		//for(var i=0; i<=MC_ARRAY.length;i++){
		for(var each in MC_ARRAY){
			
			if (TRACEME) trace('REMOVE '+MC_ARRAY[each]+" Length:"+MC_ARRAY.length+" CURRENT_LOCATION:"+CURRENT_LOCATION);
			CLICKS.removeClickTarget(MC_ARRAY[each]);
			
		}
		
		SWFAddress.onChange = null;
		
		//var this_scope = this; 
		
		// re-enable
		new PauseThis(Delegate.create(this, function(){
	
			//var this_scope = this_scope;  
			var s = CURRENT_LOCATION ;
			
			for(var each in MC_ARRAY){
			//for(var i=0; i<=MC_ARRAY.length;i++){
				if(each!=s){
				//if (TRACEME) trace('re-enable '+MC_ARRAY[each]);
				CLICKS.addClickTarget( MC_ARRAY[each], REL_ARRAY[each], OVER_ARRAY[each], OUT_ARRAY[each] );
				}
			}
			
			enableSWFAddress();
			
		}), 1000);
		
	}
	
	public function enableMC (mc:MovieClip, bool:Boolean){
		
		trace("LocationManager - enable mc:"+mc); 
		CLICKS.enableMC(mc, bool);
		
	}
	
	
	public function disableButtons(){
		BUTTON_ENABLED = false;
		for(var each in MC_ARRAY){
			
			// trace('REMOVE '+MC_ARRAY[each]+" Length:"+MC_ARRAY.length+" CURRENT_LOCATION:"+CURRENT_LOCATION);
			CLICKS.removeClickTarget(MC_ARRAY[each]);
			
		}
	}
	
	public function enableButtons(){
		
		var s = CURRENT_LOCATION ;
			trace("REACTIVATE_ARRAY[CURRENT_LOCATION]:"+REACTIVATE_ARRAY[CURRENT_LOCATION]+" s:"+s);
			for(var each in MC_ARRAY){
				//for(var i=0; i<=MC_ARRAY.length;i++){
				if((each != s) || (REACTIVATE_ARRAY[CURRENT_LOCATION])){
					// trace('re-enable '+MC_ARRAY[each]);
					if(each == "clients" && s == "clients"){
					
					CLICKS.addClickTarget( MC_ARRAY[each], null, OVER_ARRAY[each], OUT_ARRAY[each] );
					
					}else{
						
					CLICKS.addClickTarget( MC_ARRAY[each], REL_ARRAY[each], OVER_ARRAY[each], OUT_ARRAY[each] );
					
					}
				}
			}
			
		BUTTON_ENABLED = true;
	}
	
	
	
	private function enableSWFAddress(){
		
		trace("LocationManger:enableSWFAddress");
		SWFAddress.onChange = Delegate.create(this, onAddressChange);
		
	}
	
	public function setArriveAction ( loc:String, f:Function ): Void {
		
		 ARRIVE_ACTIONS[loc] = f;
		 
	}
	
	
	
	
	public function setDepartAction ( loc:String, f:Function ): Void {
		
		 DEPART_ACTIONS[loc] = f;
		 

	}
	
	
	public function setupLocation ( loc:String, fa:Function, fd:Function ): Void {
		
		trace("Setup Location: "+loc);
		
		LOCATION_OBJ_ARRAY[loc] = new Location(loc);
		LOCATION_ARRAY[loc] = loc;
		ARRIVE_ACTIONS[loc] = fa;
		DEPART_ACTIONS[loc] = fd;
		
		LOCATION_OBJ_ARRAY[loc].arrivalAction = fa; 
		LOCATION_OBJ_ARRAY[loc].departureAction = fd; 
		
		// Set a release function for if no specific MC
		var CLICK_FUNCTION:Function = Delegate.create(this, function(){ClickFunc(null, loc);}); 
		REL_ARRAY[loc] = CLICK_FUNCTION;
		
		 
	}

	
	public function getLocation (loc:String):Location{
		return LOCATION_OBJ_ARRAY[loc];
	}
	
	
	
	public function callArriveAction ( loc:String, b:Boolean  ): Void {
		
		if(loc==undefined) var loc = CURRENT_LOCATION;
		
		trace("LocationManager: callArriveAction: "+loc+" type 	REL_ARRAY[loc]:"+(typeof REL_ARRAY[loc]));
		
		TARGET_MC.output_txt.text = "   |   call arrive action: "+loc+"   |   ";
		
		REL_ARRAY[loc]( MC_ARRAY[loc] );
		  
	}
	

	
	private function callCrumbAction ( loc:String  ): Void {
		
		trace("onCrumbClick callOpenAction");
		REL_ARRAY[loc](MC_ARRAY[loc]);
		  
	}
	
	
	public function callDepartAction ( loc:String  ): Void {
		
		DEPART_ACTIONS[loc]();
		  
	}
	
	public function setDeparted(){
		trace("Location Manger:SetDeparted"); 
		onDeparted(); 
		DEPARTED = true; 
	}
	
	private function onAddressChange () {
	
		// This handler triggers when the Browser address  bar changes. 
		// - Browser back/foward button. 
		// - SWFAddress.setValue Javascript Change. 
		// - When you arrive at the page for the first time. 

		trace("onChange: ARRIVING - "+ARRIVING_LOCATION);
		trace("onChange: DEPART   - " +DEPARTING_LOCATION);
		trace("onChange: CURRENT  - "+CURRENT_LOCATION);
			  
		TARGET_MC.output_txt.text += "Arr:"+ARRIVING_LOCATION+" Dep:"+DEPARTING_LOCATION+" Curr:"+CURRENT_LOCATION;
		
		var addr = SWFAddress.getValue();
		
		var stripped_addr = addr.substr(1,(addr.length-2)); // remove the backslashes
		
		var mess = "   |   Call onChange:"+addr+" --- "+stripped_addr+"    |   ";
		
		trace(mess);
		//TARGET_MC.output_txt.text += mess;
		
		if (stripped_addr == "" || stripped_addr == undefined) stripped_addr = "home"; // set for initial arrival to site
		
		if(getCurrentLocation() == undefined){ 		// Just Arrived
				
				setLocation(stripped_addr);
		
		}else if(getCurrentLocation() != undefined){ 	// Changed internally
				
			// Dont do anything. 'ArriveAction' already called. 
			
			if(!INTERNAL_CLICK){
				// changed externally 
				EXTERNAL_CLICK = true;  
				callArriveAction(stripped_addr);
			}
					
				
		}
	
	//TARGET_MC.output_txt.text = "stripped_addr:"+stripped_addr+ " | "+getCurrentLocation() ;
		
	}
	
	public function setUpLocations (scope, location_data){
			
			LOCATIONS_DATA = location_data; 
			trace("SetUpLocation");
			
			for(var location_name in LOCATIONS_DATA){
				
				trace("location:"+location_name); 
				
				setupLocation(location_name, Delegate.create(scope, scope[location_name+"ArrivalAction"]));
				
				//setNavButton(scope.TARGET_MC[location_name+"_mc"], location_name, scope.rel, scope.over, scope.out);															
			
				//scope.TARGET_MC[location_name+"_mc"].title_txt.text = location_name; 
			
			}
	}
	
	
}