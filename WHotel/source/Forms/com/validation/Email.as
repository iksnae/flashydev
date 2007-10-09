package com.validation {
	public class Email
	{
		protected static var i:Number;
		protected static var j:Number;
		protected static var l:Number; 
		protected static var foundPoint;
		
		public static function validate (e:String):Boolean {
			foundPoint = false;
			l = e.length;
			i = checkChars(e, 0, l);
			
			if(i <= 0) { return false; }
			j=i;
	
			while (i < l && e.charAt(i) == ".") {
				i++;
				j = checkChars(e, i, l);
				if (j == i) { return false; }
				i = j;
			}
			
			if (e.charAt(i) != "@"){
				return false;
			}
	
			do {
				i = j+1;
				j = checkChars(e, i, l);
				
				if (j == i) {
					return false;
				} else if (j == l) {
					j -= i;
					if(foundPoint && j>=2 && checkFirstLevelDomainChars(e, i, l)){
						return true;
					} else {
						return false;
					}
				}
				foundPoint = (e.charAt(j) == ".");
			} 
			while (i < l && foundPoint);
			return false;
		}
		
		private static function checkChars (s:String, i:Number, l:Number):Number {
			while (i < l && ("_-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789").indexOf(s.charAt(i)) != -1){
				i++;
			}
			return i;
		}
		
		private static function checkFirstLevelDomainChars (s:String, i:Number, l:Number):Boolean {
			while (i < l && ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ").indexOf(s.charAt(j)) != -1) {
				i++;
			}
			return (i == l);
		}
	}
}