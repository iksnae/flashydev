import mx.utils.Delegate;
/**
 * @author Greg
 */
class com.continuityny.timing.Updater {
	
	
	private var UPDATE_ARRAY:Array; 
	private var UPDATE_INTERVAL:Number;
	
	
	
	public function Updater() {
		
	
		UPDATE_ARRAY = new Array(); 
		UPDATE_INTERVAL = setInterval(Delegate.create(this, universalUpdate), 33); 
		
	}


	private function universalUpdate(){
		
		for(var each in UPDATE_ARRAY){
				UPDATE_ARRAY[each](); 
		}
	}
	
	
	public function addToUpdater(name:String, func:Function){
		UPDATE_ARRAY[name] = func; 
	}
	
	public function removeFromUpdater(name:String){
		delete UPDATE_ARRAY[name];
	}
	
	
	
}