
package com.xml {

	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;
	import flash.events.*;
	import flash.events.EventDispatcher;

	public class WebConfig extends EventDispatcher {
	
		// private instance variables
		private var __BuildingID:Number;		// Unique building id
		private var __ProjectID:Number;		// Lasso ProjectID
		private var __KioskID:Number;			// Registration kiosk id
		private var __DevelopmentID:Number;	// Unique Developement id
		private var __RootDirectory:String;	// Application root directory
		private var __AuthURI:String;
		private var __UnitURI:String;
		private var __PolicyURI:String;

		// contact form
		private var __ContactURI:String;
		private var __EmailHost:String;
		private var __EmailFrom:String;
		private var __EmailFromName:String;
		private var __EmailTo:String;
		private var __EmailSubject:String;
		private var __EmailHostAuthentication:Boolean;
		private var __EmailHostUID:String;
		private var __EmailHostPWD:String;
		private var __EmailAllowDomain:String;
		
		private var __isDataLoaded:Boolean;		
		private var __theXML:XMLDocument;
		private var __theRequest:URLRequest;
		private var __theLoader:URLLoader;
	
		// constructor statement
		public function WebConfig(__theURL:String):void {
			// set instances up as dispatchers:
			__theRequest = new URLRequest(__theURL);
			__theLoader = new URLLoader(__theRequest);
			__theLoader.addEventListener(Event.COMPLETE, setProperties);
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

		public function get isDataLoaded():Boolean {
			//trace("get value = " + this.__isDataLoaded);
			return this.__isDataLoaded;
		}
		
		
		
		public function get ContactURI():String {
			//trace("get value = " + this.__ContactURI);
			return this.__ContactURI;
		}
		
		public function get EmailHost():String {
			//trace("get value = " + this.__EmailHost);
			return this.__EmailHost;
		}
		
		public function get EmailFrom():String {
			//trace("get value = " + this.__EmailFrom);
			return this.__EmailFrom;
		}
		
		public function get EmailFromName():String {
			//trace("get value = " + this.__EmailFromName);
			return this.__EmailFromName;
		}
		
		public function get EmailTo():String {
			//trace("get value = " + this.__EmailTo);
			return this.__EmailTo;
		}
		
		public function get EmailSubject():String {
			//trace("get value = " + this.__EmailSubject);
			return this.__EmailSubject;
		}
		
		public function get EmailHostAuthentication():Boolean {
			//trace("get value = " + this.__EmailHostAuthentication);
			return this.__EmailHostAuthentication;
		}
		
		public function get EmailHostUID():String {
			//trace("get value = " + this.__EmailHostUID);
			return this.__EmailHostUID;
		}
		
		public function get EmailHostPWD():String {
			//trace("get value = " + this.__EmailHostPWD);
			return this.__EmailHostPWD;
		}
		
		public function get EmailAllowDomain():String {
			//trace("get value = " + this.__EmailAllowDomain);
			return this.__EmailAllowDomain;
		}
			
		//retrieves all info for the database
		protected function setProperties(eventObj:Event){
			
			/*var __theXML:XML = new XML();
			__theXML.ignoreWhite = true;
			var tempThis = this;*/
			this.__isDataLoaded = false;
			
			__theXML = new XMLDocument(eventObj.target.data);
			this.__theXML.ignoreWhite = true;
			
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
											this.__BuildingID = parseFloat(webServiceNode.firstChild.nodeValue);
											trace("BuildingID = " + this.__BuildingID);
											break;
										case "ProjectID":
											this.__ProjectID = parseFloat(webServiceNode.firstChild.nodeValue);
											trace("ProjectID = " + __ProjectID);
											break;
										case "KioskID":
											this.__KioskID = parseFloat(webServiceNode.firstChild.nodeValue);
											trace("KioskID = " + this.__KioskID);
											break;
										case "DevelopmentID":
											this.__DevelopmentID = parseFloat(webServiceNode.firstChild.nodeValue);
											trace("DevelopmentID = " + this.__DevelopmentID);
											break;
										case "RootDirectory":
											this.__RootDirectory = webServiceNode.firstChild.nodeValue;
											trace("RootDirectory = " + this.__RootDirectory);
											break;
										case "AuthURI":
											this.__AuthURI = webServiceNode.firstChild.nodeValue;
											trace("AuthURI = " + this.__AuthURI);
											break;
										case "UnitURI":
											this.__UnitURI = webServiceNode.firstChild.nodeValue;
											trace("UnitURI = " + this.__UnitURI);
											break;
										case "PolicyURI":
											this.__PolicyURI = webServiceNode.firstChild.nodeValue;
											trace("PolicyURI = " + this.__PolicyURI);
											break;
									}
								}
								break;
								
							case "contactForm":
							
								for(var contactFormNode:XMLNode = sectionNode.firstChild; contactFormNode != null; contactFormNode = contactFormNode.nextSibling){
									//CONTACT FORM
									switch (contactFormNode.nodeName) {
										case "contactURI":
											this.__ContactURI = contactFormNode.firstChild.nodeValue;
											trace("ContactURI = " + this.__ContactURI);
											break;
										case "emailHost":
											this.__EmailHost = contactFormNode.firstChild.nodeValue;
											trace("EmailHost = " + __EmailHost);
											break;
										case "emailFrom":
											this.__EmailFrom = contactFormNode.firstChild.nodeValue;
											trace("EmailFrom = " + this.__EmailFrom);
											break;
										case "emailFromName":
											this.__EmailFromName = contactFormNode.firstChild.nodeValue;
											trace("EmailFromName = " + this.__EmailFromName);
											break;
										case "emailTo":
											this.__EmailTo = contactFormNode.firstChild.nodeValue;
											trace("EmailTo = " + this.__EmailTo);
											break;
										case "emailSubject":
											this.__EmailSubject = contactFormNode.firstChild.nodeValue;
											trace("EmailSubject = " + this.__EmailSubject);
											break;
										case "emailHostAuthentication":
											this.__EmailHostAuthentication = (contactFormNode.firstChild.nodeValue == "true");
											trace("EmailHostAuthentication = " + this.__EmailHostAuthentication);
											break;
										case "emailHostUID":
											this.__EmailHostUID = contactFormNode.firstChild.nodeValue;
											trace("EmailHostUID = " + this.__EmailHostUID);
											break;
										case "emailHostPWD":
											this.__EmailHostPWD = contactFormNode.firstChild.nodeValue;
											trace("EmailHostPWD = " + this.__EmailHostPWD);
											break;
										case "emailAllowDomain":
											this.__EmailAllowDomain = contactFormNode.firstChild.nodeValue;
											trace("EmailAllowDomain = " + this.__EmailAllowDomain);
											break;
									}
								}							
				
								break;
						}
					}
				}
			} // end for..loop
					
			//we know that all sections are now loaded so we broadcast that xml is loaded and ready to go
			onXMLLoaded();
		}
		
		//EVENT broadcasts that all xml has finished loading and is structured to pass off
		public function onXMLLoaded():void{
			this.__isDataLoaded = true;			
			trace("broadcasting onXMLLoaded event on: onXMLLoaded();");
			//dispatchEvent(new XMLEvent(XMLEvent.PACKAGED_INFO, false, false, this.__mainArray));
			dispatchEvent(new Event(Event.COMPLETE, this.__isDataLoaded));

		}		


	}
}