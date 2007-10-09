package ShellAPI.Factories{

import flash.utils.*;

import ShellAPI.Behaviors.*;
	public class XMLSimpleFactory {

	function XMLSimpleFactory(){
		trace("XMLSimpleFactory class instantiated");
	}


	//decides which type of XML Behavior to create based off the type parameter passed in
	public function createBehavior(theType:String, targetURL:String):XMLBehaviorAbstract{
		trace("createBehavior function called on: " + getQualifiedClassName(this));

		var theBehavior:XMLBehaviorAbstract;

		if(theType == "SawIVXML"){
			theBehavior = new SawIVXML(targetURL);
		}else if(theType == "WHotelXML"){
			theBehavior = new WHotelXML(targetURL);
		}

		return theBehavior;
	}
	
}
}