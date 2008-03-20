/**
 * @author Greg
 */
class com.continuityny.data.IfActive {
	
	
	private var _o:Array;
	private var count:Number = 0; 
	
	public function IfActive(	o:Object ) {
		
			_o = new Array();
		
		trace("o.length:"+(typeof o)+" o.length:"+o.length);							
		
		if( o.length == undefined){
				var temp_obj= new Object();
				temp_obj = o;
				
				o = new Array(); 
				o.push( temp_obj );
		}

		for(var each in o){
			
			trace("o:"+o[each].title+" "+o[each].xname+" | each - "+each+" | "+o[each].active);
			
			//var ob = o[each];
			if(o[each].active == "true"){	
			
			
				
			//var temp_array = new Array();
			//temp_array = o[each] ; 
			_o.push( o[each] ) ;
					
			
			}
				
		}
	
	}
	
	
	public function getArray(){
		
		return _o;	
	}
	
	
	
}