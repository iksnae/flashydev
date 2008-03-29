package com.flashydev.model
{
	public class Model
	{
		
		protected var dataMap:Array=new Array();
		
		public function Model(){
			
		}
		public function getInstance():Model{
			return this;
		}
		
		
		public function addToModel(proxyID:String):void{
			
		}
		
		public function getData(proxyName:String):void{
			return dataMap[proxyID];
		}
		
	}
}