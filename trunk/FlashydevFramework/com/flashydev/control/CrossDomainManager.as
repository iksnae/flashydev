package com.flashydev.control
{
	/*
	CrossDomainManager
	this xml utility will responsible for managing crossdomain policies..
	
	*/
	
	import flash.system.Security;
	import flash.system.SecurityDomain;
	
	
	public class CrossDomainManager
	{
		public function addPolicy(url:String):void{
			Security.loadPolicyFile(url);
		}
	}
}