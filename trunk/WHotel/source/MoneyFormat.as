/**
 * MoneyFormat, Version 1.
 * Transforms regular numbers into Currency Format, and also convert form currency to regular numbers 
 * Makes use of the String Class
 * Updates at: www.lordalex.org - reach@lordalex.org
 *
 * @author: LordAlex Leon
 * @version: 1.0.0
 **/
class MoneyFormat extends String {
	private var _sign:String;
	private var _sep:String;
	private var _dec:String;
	private var _decimals:Boolean;
	/**
      * MoneyFormat Constructor
	  * @param   sign_param  		[String]  The currency sign. ie: "$"
	  * @param   sep_param   		[String]  The unit delimiter. ie: ","
	  * @param   dec_param   		[String]  The decimal delimiter. ie: "."
	  * @param   decimals_param     [Boolean] Option to display last 2 decimal places. ie: true or false
	 **/
	function MoneyFormat(sign_param:String, sep_param:String, dec_param:String, decimals_param:Boolean) {
		(sign_param == undefined) ? _sign="$" : _sign=sign_param;
		(sep_param == undefined) ? _sep="," : _sep=sep_param;
		(dec_param == undefined) ? _dec="." : _dec=dec_param;
		(decimals_param == undefined) ? _decimals=true : _decimals=decimals_param;
	}
	
	public function toCustomMoney(amount_param:String, sign_param:String, sep_param:String, dec_param:String, decimals_param:Boolean):String {
		(sign_param == undefined) ? _sign="$" : _sign=sign_param;
		(sep_param == undefined) ? _sep="," : _sep=sep_param;
		(dec_param == undefined) ? _dec="." : _dec=dec_param;
		(decimals_param == undefined) ? _decimals=true : _decimals=decimals_param;
		return toMoney(amount_param);
	}
	
	/**
	 * toMoney method
	 * Takes one paramter and transforms the value into money format
	 * @param   amount_param	[String] Takes in a String value.
	 **/
	public function toMoney(amount_param:String):String {
		if ((amount_param == "") || (amount_param == undefined)) {
			return "";
		} else {
			var _myDot:Number;
			var _myString:String;
			var myvalue:String;
			var cents:String;
			var myLength:Number;
			var divide:Number;
			var dollars:String;
			(amount_param) ? _myString=amount_param.toString() : _myString="";
			_myDot = _myString.indexOf(".");
			if (_myDot<=0) {
				myvalue = _myString;
				cents = "00";
			} else {
				myvalue = _myString.substr(0, _myDot);
				cents = _myString.substr(_myDot+1, _myString.length);
			}
			if (myvalue.length>0) {
				myLength = myvalue.length;
				divide = myLength/3;
				if ((myLength%3) == 0) {
					divide = (myLength/3)-1;
				}
				for (var i = 1; i<=divide; i++) {
					myvalue = myvalue.substr(0, (myLength-(3*i)-(i-1)))+_sep+myvalue.substr((myLength-(3*i)-(i-1)), (3*i)+(i-1));
					myLength = myvalue.length;
				}
				dollars = myvalue;
			}
			else
				dollars = "0";
			if (cents.length>2) {
				cents = cents.substr(0, 2)+_dec+cents.substr(2, cents.length);
			} else if (cents.length == 1) {
				cents = cents+"0";
			}
			if (_decimals) {
				return _sign+dollars+_dec+cents;
			} else {
				return _sign+dollars;
			}
		}
	}
}
