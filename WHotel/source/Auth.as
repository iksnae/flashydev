/**
    User class
    author: Braulio Pico
    version: 1
    modified: 06/12/2006
    copyright: Adobe Systems Incorporated

    This code defines a custom User class that allows you to create new users, save users information and specify user login information.
*/


import mx.services.*;

class Auth {
	
    // private instance variables
    private var __WebServiceURI:String;
	private var __WebServicePolicyURI:String;	

    public function get WebServiceURI():String {
		trace("get value = " + this.__WebServiceURI);
        return this.__WebServiceURI;
    }
	
    public function set WebServiceURI(value:String):Void {
		trace("set value = " + value);
        this.__WebServiceURI = value;
    }

    public function get WebServicePolicyURI():String {
		trace("get value = " + this.__WebServicePolicyURI);
        return this.__WebServicePolicyURI;
    }
	
    public function set WebServicePolicyURI(value:String):Void {
		trace("set value = " + value);
        this.__WebServicePolicyURI = value;
    }
	
	public function Auth(p_WebServiceURI:String, p_WebServicePolicyURI:String) {
		this.__WebServiceURI = p_WebServiceURI;
        this.__WebServicePolicyURI = p_WebServicePolicyURI;
	}


	public function ValidateUser(Email:String) {
		/*
		var webServiceURI:String = new String("http://shvotouchscreen.dev6.team5.com/XML/WebServices/WSAuth.asmx?WSDL");
		var webServicePolicyURI:String = new String("http://shvotouchscreen.dev6.team5.com/XML/crossdomain.xml");
		
		//http://www.adobe.com/devnet/flash/articles/fplayer_security.html
		System.security.loadPolicyFile(webServicePolicyURI);
				
		var webServicen:WebService = new WebService(webServiceURI);
		
		var oAuth = webServicen.ValidateUser(Email, 5);
		
		oAuth.onResult = function(sResult) {
			
			var oUserTable = new oAuth.UserTable();
			
			oUserTable = sResult;
			
			_global.validUser = oUserTable.IsValidUser;
			if (_global.validUser)
				new MovieClipLoader().loadClip("_swf/touchscreen_web/floorplans.swf", YOO.content_mc);
			
			//trace(_global.YOO);
			trace("valid email address = " + _global.validUser);
			_global.isWSComplete = true;
			
		} // end onResult event
		
		// On error to load data from the WebService, display an error message.
		oAuth.onFault = function(fault) {
			trace("Failed to load WebService data from http://shvotouchscreen.dev6.team5.com");
			_global.isWSComplete = true;
		}	
		*/
		;
		
	} // end function
	
	
	
	public function SaveUser(KioskId:Number, EmailAddress:String, AgentEmailAddress:String, NameTitle:String, NameFirst:String, NameLast:String, BusinessPhone:String, BusinessPhoneExtension:String, MobilePhone:String, HomePhone:String, Fax:String, Address1:String, Address2:String, City:String, State:String, Zip:String, Country:String, ContactPreferences:String, HowDidYouFindUs1:Number, HowDidYouFindUs2:Number, HowDidYouFindUsText:String, ApartmentSizeInterest:String, BrokerFirstName:String, BrokerLastName:String, BrokerCompany:String, BrokerBusinessPhone:String, BrokerBusinessPhoneExt:String, BrokerBusinessFax:String, BrokerMobilePhone:String, BrokerEmail:String, BrokerStreetAddress:String, BrokerSuiteAddress:String, BrokerStateAddress:String, BrokerCityAddress:String, BrokerZipCodeAddress:String, BrokerCountryAddress:String, PriceRange:Number, Gender:Number, Age:Number, Occupation:Number, Company:String, AnnualIncome:Number, BuyingPurpose:Number) {
		
		//var webServiceURI:String = new String("http://shvotouchscreen.dev6.team5.com/XML/WebServices/WSAuth.asmx?WSDL");
		//var webServicePolicyURI:String = new String("http://shvotouchscreen.dev6.team5.com/XML/crossdomain.xml");
		
		//http://www.adobe.com/devnet/flash/articles/fplayer_security.html
		System.security.loadPolicyFile(WebServicePolicyURI);
				
		var webServicen:WebService = new WebService(WebServiceURI);
		
		var oAuth = webServicen.SaveUser(KioskId, EmailAddress, AgentEmailAddress, NameTitle, NameFirst, NameLast, BusinessPhone, BusinessPhoneExtension, MobilePhone, HomePhone, Fax, Address1, Address2, City, State, Zip, Country, ContactPreferences, HowDidYouFindUs1, HowDidYouFindUs2, HowDidYouFindUsText, ApartmentSizeInterest, BrokerFirstName, BrokerLastName, BrokerCompany, BrokerBusinessPhone, BrokerBusinessPhoneExt, BrokerBusinessFax, BrokerMobilePhone, BrokerEmail, BrokerStreetAddress, BrokerSuiteAddress, BrokerStateAddress, BrokerCityAddress, BrokerZipCodeAddress, BrokerCountryAddress, PriceRange, Gender, Age, Occupation, Company, AnnualIncome, BuyingPurpose);
		
		oAuth.onResult = function(sResult) {

			trace("finish saving data");
			
		} // end onResult event
		
		// On error to load data from the WebService, display an error message.
		oAuth.onFault = function(fault) {
			trace("Failed to load WebService data from " + WebServiceURI);
		}			
	}
			
}