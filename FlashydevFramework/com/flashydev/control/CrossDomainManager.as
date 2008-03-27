package com.flashydev.control
{
	/*
	CrossDomainManager
	this xml utility will responsible for managing crossdomain policies..
	
	*/
	
	import flash.system.Security;
	import flash.system.SecurityDomain;
	
	private var __policies:Array = new Array();
	
	public class CrossDomainManager
	{
		public function addPolicy(url:String):void{
			
			__policies.push(url);
			Security.loadPolicyFile(url);
		}
		public function getPolicies():Array{
			return __policies;
		}
	}
}