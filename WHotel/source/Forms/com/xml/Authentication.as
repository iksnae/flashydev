
package com.xml {

	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;
	import flash.events.*;
	import flash.events.EventDispatcher;

	public class Authentication extends EventDispatcher {
	
		// private instance variables

		private var __isValidUser:Boolean;
		private var __isDataLoaded:Boolean;
		private var __theXML:XMLDocument;
		private var __theRequest:URLRequest;
		private var __theLoader:URLLoader;
	
		// constructor statement
		public function Authentication(__theURL:String):void {
			// set instances up as dispatchers:
			__theRequest = new URLRequest(__theURL);
			__theLoader = new URLLoader(__theRequest);
			__theLoader.addEventListener(Event.COMPLETE, getUserValidation);
		}
		
		public function get isValidUser():Boolean {
			//trace("get value = " + this.__isValidUser);
			return this.__isValidUser;
		}
		
		public function get isDataLoaded():Boolean {
			//trace("get value = " + this.__isDataLoaded);
			return this.__isDataLoaded;
		}
			
		// retrieves all info for the database
		protected function getUserValidation(eventObj:Event){
			
			this.__isDataLoaded = false;
			
			__theXML = new XMLDocument(eventObj.target.data);
			this.__theXML.ignoreWhite = true;
			
			//populate all section types
			for(var userNode:XMLNode = __theXML.firstChild; userNode != null; userNode = userNode.nextSibling){
				//USERTABLE
				//trace("userNode.nodeName:: " + userNode.nodeName);
				if(userNode.nodeName == "isValidUser"){
					this.__isValidUser = (userNode.firstChild.nodeValue == "true");
					trace("isValidUser:: " + this.__isValidUser);
				}
				
			} // end for..loop
					
			//we know that all sections are now loaded so we broadcast that xml is loaded and ready to go
			onXMLLoaded();
		}
		
		//EVENT broadcasts that all xml has finished loading and is structured to pass off
		public function onXMLLoaded():void{
			this.__isDataLoaded = true;			
			trace("broadcasting onXMLLoaded event on:: onXMLLoaded();");
			//dispatchEvent(new XMLEvent(XMLEvent.PACKAGED_INFO, false, false, this.__mainArray));
			dispatchEvent(new Event(Event.COMPLETE, this.__isDataLoaded));
		}		
		
	} // end class
}