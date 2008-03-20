/**
 * @author Greg
 */
class com.continuityny.loc.Location {
	
	
	
	// ~~~ Initialize as an ASBoradcaste(event dispatcher)
	static var _initializeDispatcher = AsBroadcaster.initialize(Location.prototype);
	private var broadcastMessage:Function;
	public var addListener:Function;
	public var removeListener:Function;
	// ~~~~
	
	
	public var onArrival:Function;
	public var onDeparture:Function;
	public var arrivalAction:Function;
	public var departureAction:Function;
	
	private var ID:String; 
	
	public function Location ( loc:String ) {
		
		ID = loc; 
		
	}
	
	public function setArrival(fun:Function){
		trace("Set Arrival");
		onArrival = fun; 
		
	}
	
	public function setDeparture(fun:Function){
		
		onDeparture = fun; 
		
	}
	
}