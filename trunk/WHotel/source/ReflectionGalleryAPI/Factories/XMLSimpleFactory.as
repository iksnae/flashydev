package ReflectionGalleryAPI.Factories{

import flash.utils.*;

import ReflectionGalleryAPI.Behaviors.*;
	public class XMLSimpleFactory {

	function XMLSimpleFactory(){
		trace("XMLSimpleFactory class instantiated");
	}


	//decides which type of XML Behavior to create based off the type parameter passed in
	public function createBehavior(theType:String, targetURL:String):XMLBehaviorAbstract{
		trace("createBehavior function called on: " + getQualifiedClassName(this));

		var theBehavior:XMLBehaviorAbstract;

		if(theType == "WGalleryXML"){
			theBehavior = new WGalleryXML(targetURL);
		}else if(theType == "CollegeFestXML"){
			//theBehavior = new CollegeFestXML(targetURL);
		}

		return theBehavior;
	}
	
}
}