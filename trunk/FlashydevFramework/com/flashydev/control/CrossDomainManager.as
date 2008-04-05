package com.flashydev.control
{
	/*
	CrossDomainManager
	this xml utility will responsible for managing crossdomain policies..
	
	*/
	
	import flash.system.Security;
	import flash.system.SecurityDomain;
	
	private var __policies:Array = new Array();
	private var __security:Security = new Security)_;
	
	public class CrossDomainManager
	{
		public function addPolicy(url:String):void{
			
			__policies.push(url);
			__security.loadPolicyFile(url);
		}
		public function getPolicies():Array{
			return __policies;
		}
	}
}