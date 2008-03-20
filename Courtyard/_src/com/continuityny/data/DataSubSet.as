/**
 * @author Greg
 */
class com.continuityny.data.DataSubSet {

	var _array:Array = [];
	
	public function DataSubSet(		o:Object, 
									node:String, 
									value:String, 
									traceme:Boolean
									) {
										
										
		for(var each in o){
			if(traceme)trace("DataSubSet:"+o[each].title);
			
			if(value == undefined){
				_array.push(o[each][node]);
			}else{
				if(o[each][node] == value){
				
					_array.push(o[each]);
				}
			}
				
		}
		
	
	}
	
	
	public function getArray(){
		
		return _array;	
	}
	
}