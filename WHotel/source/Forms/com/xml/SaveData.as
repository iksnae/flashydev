
package com.xml {

	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLVariables;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;
	import flash.events.*;
	import flash.events.EventDispatcher;

	public class SaveData extends EventDispatcher {
	
		// private instance variables

		private var __isSavedUser:Boolean;
		private var __isDataSaved:Boolean;
		private var __theXML:XMLDocument;
		private var __theRequest:URLRequest;
		private var __theLoader:URLLoader;
	
		// constructor statement
		public function SaveData(__theURL:String, __data:URLVariables):void {
			// set instances up as dispatchers:
			__theRequest = new URLRequest(__theURL);
			//__theLoader = new URLLoader(__theRequest);
			__theLoader = new URLLoader();
			
			//__theLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			__theRequest.data = __data;
			
			__theRequest.method = URLRequestMethod.POST;
			__theLoader.addEventListener(Event.COMPLETE, handleResponse);
			__theLoader.load(__theRequest);
		}
		
		public function get isSavedUser():Boolean {
			//trace("get value = " + this.__isSavedUser);
			return this.__isSavedUser;
		}
		
		public function get isDataSaved():Boolean {
			//trace("get value = " + this.__isDataSaved);
			return this.__isDataSaved;
		}
		
		
		// retrieves all info for the database
		protected function handleResponse(eventObj:Event){
			
			this.__isDataSaved = false;
			
			__theXML = new XMLDocument(eventObj.target.data);
			this.__theXML.ignoreWhite = true;
			trace("__theXML:: " + __theXML);
			
			//populate all section types
			for(var userNode:XMLNode = __theXML.firstChild; userNode != null; userNode = userNode.nextSibling){
				//USERTABLE
				trace("userNode.nodeName:: " + userNode.nodeName);
				if(userNode.nodeName == "isSavedUser"){
					
					trace("userNode.firstChild.nodeValue:: " + userNode.firstChild.nodeValue);
					this.__isSavedUser = (userNode.firstChild.nodeValue == "true");
					trace("isSavedUser:: " + this.__isSavedUser);
				}
				
			} // end for..loop
					
			//we know that all sections are now loaded so we broadcast that xml is loaded and ready to go
			onXMLLoaded();
		}
		
		//EVENT broadcasts that all xml has finished loading and is structured to pass off
		public function onXMLLoaded():void{
			this.__isDataSaved = true;			
			trace("broadcasting onXMLLoaded event on:: onXMLLoaded();");
			//dispatchEvent(new XMLEvent(XMLEvent.PACKAGED_INFO, false, false, this.__mainArray));
			dispatchEvent(new Event(Event.COMPLETE, this.__isDataSaved));
		}		
		
	} // end class
}