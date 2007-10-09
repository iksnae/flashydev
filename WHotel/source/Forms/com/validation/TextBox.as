package com.validation {
	public class TextBox
	{
	
		public static function validate (s:String):Boolean {
		
			s = trim(s);
			if (s == "")
				return false;
			
			return true;
			
		}
		
		public static function trim (str:String):String {
			
			var returnstr = "";
			var i:int;
			
			for (i=0; i<=str.length && (str.substr(i, 1) == " "); i++) {}
			
			returnstr = str.substr(i, str.length-i);
			
			for (i=returnstr.length-1; i>=0 && (returnstr.substr(i, 1) == " "); i--) {}
			
			returnstr = returnstr.substr(0, i+1);
			
			return returnstr;
		}
		
	}
}