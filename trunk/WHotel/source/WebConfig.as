/*
    User class
    author: Braulio Pico
    version: 1
    modified: 09/23/2007
    copyright: Adobe Systems Incorporated

    tempThis code defines a custom config class that allows you to set the properties in the flash application.

	import mx.events.EventDispatcher.*;
*/

class WebConfig {

 	// we have to declare the dispatchEvent,
 	// addEventListener and removeEventListener
 	// methods that EventDispatcher sets up:
 	//function dispatchEvent() {};
 	//function addEventListener() {};
 	//function removeEventListener() {};
	
	// private instance variables
	private var __BuildingID:Number;		// Unique building id
	private var __ProjectID:Number;		// Lasso ProjectID
	private var __KioskID:Number;			// Registration kiosk id
	private var __DevelopmentID:Number;	// Unique Developement id
	private var __RootDirectory:String;	// Application root directory
	private var __AuthURI:String;
	private var __UnitURI:String;
	private var __PolicyURI:String;
	

    // constructor statement
    public function WebConfig(targetXML:String) {
  		// set instances up as dispatchers:
  		//mx.events.EventDispatcher.initialize(this);
		load(targetXML);
    }
	
    public function get BuildingID():Number {
		//trace("get value = " + this.__BuildingID);
        return this.__BuildingID;
    }
	
    public function get ProjectID():Number {
		//trace("get value = " + this.__ProjectID);
        return this.__ProjectID;
    }
	
    public function get KioskID():Number {
		//trace("get value = " + this.__KioskID);
        return this.__KioskID;
    }

    public function get DevelopmentID():Number {
		//trace("get value = " + this.__DevelopmentID);
        return this.__DevelopmentID;
    }
	
    public function get RootDirectory():String {
		//trace("get value = " + this.__RootDirectory);
        return this.__RootDirectory;
    }	
	
		
    public function get AuthURI():String {
		//trace("get value = " + this.__AuthURI);
        return this.__AuthURI;
    }
	
    public function get UnitURI():String {
		//trace("get value = " + this.__UnitURI);
        return this.__UnitURI;
    }
		
    public function get PolicyURI():String {
		//trace("get value = " + this.__PolicyURI);
        return this.__PolicyURI;
    }	


	

    //retrieves all info for the database
	public function load(targetXML:String):Void{
		var __theXML:XML = new XML();
		__theXML.ignoreWhite = true;
		var tempThis = this;
		
		__theXML.onLoad = function(success:Boolean) {
			if(success) {
				trace("Success");
				//populate all section types
				for(var configNode:XMLNode = __theXML.firstChild; configNode != null; configNode = configNode.nextSibling){
					//CONFIGURATION
					//trace("configNode.nodeName = " + configNode.nodeName);
					if(configNode.nodeName == "configuration"){
						for(var sectionNode:XMLNode = configNode.firstChild; sectionNode != null; sectionNode = sectionNode.nextSibling){
							//SECTION
							switch (sectionNode.nodeName) {
								case "webService":
									for(var webServiceNode:XMLNode = sectionNode.firstChild; webServiceNode != null; webServiceNode = webServiceNode.nextSibling){
										//WEBSERVICE
										switch (webServiceNode.nodeName) {
											case "BuildingID":
												tempThis.__BuildingID = parseFloat(webServiceNode.childNodes[0].firstChild);
												trace("BuildingID = " + tempThis.__BuildingID);
												break;
											case "ProjectID":
												tempThis.__ProjectID = parseFloat(webServiceNode.childNodes[0].firstChild);
												trace("ProjectID = " + tempThis.__ProjectID);
												break;
											case "KioskID":
												tempThis.__KioskID = parseFloat(webServiceNode.childNodes[0].firstChild);
												trace("KioskID = " + tempThis.__KioskID);
												break;
											case "DevelopmentID":
												tempThis.__DevelopmentID = parseFloat(webServiceNode.childNodes[0].firstChild);
												trace("DevelopmentID = " + tempThis.__DevelopmentID);
												break;
											case "RootDirectory":
												tempThis.__RootDirectory = webServiceNode.childNodes[0].firstChild;
												trace("RootDirectory = " + tempThis.__RootDirectory);
												break;
											case "AuthURI":
												tempThis.__AuthURI = webServiceNode.childNodes[0].firstChild;
												trace("AuthURI = " + tempThis.__AuthURI);
												break;
											case "UnitURI":
												tempThis.__UnitURI = webServiceNode.childNodes[0].firstChild;
												trace("UnitURI = " + tempThis.__UnitURI);
												break;
											case "PolicyURI":
												tempThis.__PolicyURI = webServiceNode.childNodes[0].firstChild;
												trace("PolicyURI = " + tempThis.__PolicyURI);
												break;
										}
									}
									break;
									
								case "contactForm":
									break;
							}
						}
					}	
				}
			} else
				trace("XML failed to load! Please try again tomorrow...");
		}
		
		__theXML.load(targetXML);
	}

}