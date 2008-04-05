package com.flashydev.model
{
	public class DataObject extends Object implements DataIO
	{
		
		private var _id:String;
		private var _data;
		
		public function DataObject()
		{
	
			super();
		}
		
		public function setID(id:String):void
		{
			_id = id;
		}
		
		public function getData():Object
		{
			return _data;
		}
		
		public function setData(o):void
		{
			_data = o;
		}
		
		public function getID():String
		{
			return _id;
		}
		
	}
}