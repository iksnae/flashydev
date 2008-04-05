package com.bootlegcomedy.control
{
	import flash.events.EventDispatcher;
	import flash.utils.Proxy;
	import lt.uza.utils.Global;
	
	public class Observable extends Object
	{
		private static var instance:Observable = null;
		private static var allowInstantiation:Boolean = false;
		private var dispatcher:EventDispatcher;
		private var global:Global=Global.getInstance();
		
		
		private var observers:Array;
	
		
		
		public function Observable(){
			dispatcher = new EventDispatcher();
		}
		public static function getInstance() : Observable {
			if ( Observable.instance == null ) {
				Observable.allowInstantiation = true;
				Observable.instance = new Observable();
				Observable.allowInstantiation = false;
			}
			return Observable.instance;
		}
		
		
		public function addObserver(o:Object):void{
			/* Adds an observer to the set of observers for this object, 
			provided that it is not the same as some observer already in the set.
			*/
				
		}
		public function deleteObserver(o:Object):void{
				/* Deletes an observer from the set of observers of this object.
				*/
		}
		public function countObservers():Number{
			/*Returns the number of observers of this Observable object.
			*/
			return 	observers.length;
		}
		protected function setChanged():void{
			/*Marks this Observable object as having been changed; 
			the hasChanged method will now return true.*/		
		}
		public function clearChanged():void{
			/*Indicates that this object has no longer changed, or that it has 
			already notified all of its observers of its most recent change, 
			so that the hasChanged method will now return false.*/			
		}
		public function hasChanged():Boolean{
			// Tests if this object has changed.
			return true;		
		}
		public function notifyObservers():void{	
			/*If this object has changed, as indicated by the hasChanged method,
			 then notify all of its observers and then call the clearChanged 
			 method to indicate that this object has no longer changed
			*/
//			dispatcher.dispatchEvent();
					
		}
		
		public function dispatchEventWithObject(type:String, listener:Object):void{
			dispatcher.addEventListener(type,null);			
		}
	}
}