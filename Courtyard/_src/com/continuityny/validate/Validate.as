



class com.continuityny.validate.Validate {
	
	
	
	
	public static function email(address:String){
		
		return  (
		(address.indexOf("@") == -1) || (address.indexOf(".") == -1) ||
		!(checkIfContains(address, "#$%^&*()+") )
		) ? false : true ;
	
	}
	
	
	public static function multi_email(addresses:String){
		
		var temp_array = addresses.split(",");
		
		var isvalid:Boolean = true;
		
		for(var i:Number = 0; i<temp_array.length; i++){
			
			trace("multi:"+temp_array[i]);
			
			if (!email(temp_array[i])) {
				isvalid = false;
				break;
			}
		}
		
		//trace("multi:"+isvalid);
		
		return isvalid; 
		
	}
	
	
	
	
	public static function message(s:String){
		
		return (  
		!(  checkIfContains(s, "#$%^&*()+")  )  ) ? false : true ;
		
	}
	
	public static function blank(s:String){
		
		return (s == '') ? false : true ;
		
	}
	
	public static function multi(){
		
		//trace("arguments:"+arguments.length);
		
		var isvalid:Boolean = true;
		
		for(var i:Number = 0; i<arguments.length; i++){
			
			if (!arguments[i]) {
				isvalid = false;
				break;
			}
		}
		//trace("multi:"+isvalid);
		return isvalid; 
		
		
		
	}
	
	
	private static function checkIfContains(x:String, y:String):Boolean {
		
		var isvalid:Boolean = true;
		
		for(var i:Number = 0; i<y.length; i++){
			//trace("sub:"+y.substr(i,1) );
			if (x.indexOf( y.substr(i,1) ) != -1) {
				isvalid = false;
				break;
			}
		}
		return isvalid; 
	}
	
	
	/*public function getValid():Boolean{
		return valid;
	}
	
	public function report():String {
		
		var report = "";
		
		if(!NAME) report += "YOUR NAME, ";
		if(!EMAIL) report += "YOUR EMAIL, ";
		if(!FRIENDS_EMAILS) report += "YOUR FRIENDS EMAILS, ";
		if(!MESSAGE) report += "MESSAGE,  ";
		
		report += "... ";
		
		return report; 
		
	}
	public function report2():String {
		
		return "Name: "+NAME+" "+obj.name+" Email: "+EMAIL+" "+obj.email+" Friends:"+FRIENDS_EMAILS+" "
		+obj.friends_emails+" Message:"+MESSAGE+" "+obj.email_message+" Optin:"+OPTIN+" "+obj.optin;
		
	}*/
	
}

