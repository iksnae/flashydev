/*
Proxy 


*/
package com.flashydev.model
{
	private var data:Object;
	
	public class Proxy
	{
		public static var NAME:String = "Proxy";
		
		public function Proxy(proxyName:String = null, data:Object = null):void{
			this.proxyName = (proxyName != null)?proxyName:NAME; 
			if (data != null) setData(data);
		}
		public function getData():Object{
			return data;
		}
		public function getProxyName():String{
			return proxyName;
		}
		public function onRegister():void{
			
		}
		public function onRemove():void{
			
		}
		public function setData(data:Object):void{
			this.data = data;
		}
	}
}