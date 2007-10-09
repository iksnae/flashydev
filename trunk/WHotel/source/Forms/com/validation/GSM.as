package com.validation {
	public class GSM
	{
		protected static var prefixOk:Boolean;
		
		public static function validate (n:String):Boolean {
			n = strip(n);
			var nr:Number = Number(n)*1;
			
			if(n.length != 10) {
				return false;
			}
			else if(isNaN(nr)) {
				return false;
			}
			
			prefixOk = checkPrefix(n);
			if(!prefixOk) {
				return false;
			} else {
				return true;
			}
		}
		
		private static function checkPrefix (s:String):Boolean {
			if(s.substring(0, 2) != '04') { 
				return false; 
			} 
			else {
				var provider = (s.substring(2, 3));
				if (provider == '7' || provider == '8' || provider == '9') {
					return true;
				}
			}
			return false;
		}
		
		private static function strip(s:String):String {
			s = s.split("\r").join("");
			s = s.split("\t").join("");
			s = s.split("\\").join("");
			s = s.split("/").join("");
			s = s.split(".").join("");
			while ( s.indexOf(" " ) != -1 ) {
				s= s.split(" ").join("");
			}
			if (s.substr(0,1) == " ") {
				s = s.substr( 1 );
			}
			if (s.substr( s.length-1, 1 ) == " ") {
				s = s.substr( 0, s.length - 1 );
			}
			return s;
		}
	}
}
