/*
Develper:  LordAlex Leon. 
Contact:    www.lordalex.org - lordalexlc@hotmail.com
License:   You can use this script as you see fit, a small mention would be appreatiated if used for commercial purposes.
*/
//this adds a global function to the string object
String.prototype.currencyFormat = function() {
	//use like this
	//tester = "1";
	//trace(tester.currencyFormat());

	var myString = this.toString();
	//var myString = amount.toString();
	var myDot = myString.indexOf(".");
	var coin="$";

	if (myDot<=0) {
		var myvalue = myString;
		var cents = "00";
	} else {
		var myvalue = myString.substr(0,myDot);
		var cents = myString.substr(myDot+1,myString.length);
	}
	
	if (myvalue.length>0) {
		var myLength = myvalue.length;
		var divide = myLength/3;
		if ((myLength % 3)==0) {
			var divide = (myLength/3)-1;
		}

		for (var i=1; i<=divide; i++) {
			var myvalue = myvalue.substr(0,(myLength-(3*i)-(i-1))) + "," + myvalue.substr((myLength-(3*i)-(i-1)),(3*i)+(i-1));
			myLength = myvalue.length;
		}
		dollars = myvalue;		
	 }

	if (cents.length>2) {
		cents = Math.round(cents.substr(0,2) + "." + cents.substr(2,cents.length));
	} else if (cents.length==1){
		cents = cents + "0";
	}

	return coin + dollars + "." + cents;
};