package com.flashydev.control
{
	public interface Observable
	{
		
		function addObserver(o):void;
		function removeObserver(o):void;
		function notifyObservers():void;
	}
}