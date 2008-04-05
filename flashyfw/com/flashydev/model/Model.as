  package com.flashydev.model
{
	import com.flashydev.control.Observable;
	
	public class Model implements Observable
	{
		
		private var _dataMap:Array=new Array();
		private static var instance:Model = null;
		private static var allowInstantiation:Boolean = false;
		
		
		
		public function addObserver(o):void{
			
		}
		public function removeObserver(o):void{
			
		}
		public function notifyObservers():void{
			
		}
		
		
		
		public static function getInstance() : Model {
			if ( Model.instance == null ) {
				Model.allowInstantiation = true;
				Model.instance = new Model();
				Model.allowInstantiation = false;
			}
			return Model.instance;
		}
		
		
		public function storeData(id:String,data=null):void{
			var obj:DataIO = new DataObject();
			
			obj.setID(id);
			obj.setData(data);
			
			_dataMap.push(obj);
		}
		
		public function getData(id:String):DataObject{
			var data:DataObject;
			for(var i in _dataMap){
				if(	_dataMap[i].getID()==id){
					data = _dataMap[i];
				}
			}
			return data;
		}
		public function deleteData(id:String):void{
			var data:DataObject;
			for(var i in _dataMap){
				if(	_dataMap[i].getID()==id){
					data = _dataMap[i];
					
				}
			}
		}
		
		
		
	}
}