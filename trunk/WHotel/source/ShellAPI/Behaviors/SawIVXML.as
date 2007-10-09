package ShellAPI.Behaviors{
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.utils.*;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
    import flash.xml.XMLNodeType;
	import flash.events.*;
	
	import ShellAPI.Behaviors.XMLBehaviorAbstract;
	
	import events.XMLEvent;
	public class SawIVXML extends XMLBehaviorAbstract{

	private var __mainArray:Array;
	
    public function SawIVXML(targetURL:String){
    	trace("SawIVXML class instantiated with targetURL: " + targetURL);
    	
    	super(targetURL);
    }


    override public function execute():void{
    	trace("execute function called on: " + getQualifiedClassName(this));
    	
		//begin loading in the info
		__theRequest = new URLRequest(this.__theURL);
		__theLoader = new URLLoader(this.__theRequest);
		
		this.__theLoader.addEventListener(Event.COMPLETE, getNavInfo, false);
    }


    //retrieves all info for the database
	protected function getNavInfo(eventObj:Event):void{
		trace("getNavInfo function called on: " + getQualifiedClassName(this));

		__theXML = new XMLDocument(eventObj.target.data);
		this.__theXML.ignoreWhite = true;
		//trace("__theXML: " + __theXML);
		
		//create the main array that will hold all sections and sub sections, and will be 
		//passed on to the model
		__mainArray = new Array();
		
		//populate all section types
		for(var shellNode:XMLNode = this.__theXML.firstChild; shellNode != null; shellNode = shellNode.nextSibling){
			//SHELL
			if(shellNode.nodeName == "shell"){
				for(var sectionTypeNode:XMLNode = shellNode.firstChild; sectionTypeNode != null; sectionTypeNode = sectionTypeNode.nextSibling){
					//SECTIONTYPE
					if(sectionTypeNode.nodeName == "sectionType"){
						//CAROUSEL
						if(sectionTypeNode.attributes.type == "Carousel"){
							//call function to populate carousel shell info sections
							populateCarouselInfo(sectionTypeNode);
						}else if(sectionTypeNode.attributes.type == "EPK"){
							//call function to populate EPK shell info sections
							populateEPKInfo(sectionTypeNode);
						}
					}
				}
			}				
		}
		
		//we know that all sections are now loaded so we broadcast that xml is loaded and ready to go
		onXMLLoaded();
	}
	
	//populates the Carousel section info for the model
	protected function populateCarouselInfo(targetNode:XMLNode):void{
		trace("populateCarouselInfo function called on: " + getQualifiedClassName(this));
		
		//create the array that will hold all info for the carousel section
		var section:Array = new Array();
		section.type = targetNode.attributes.type;
		
		//iterate through all sections
		for(var sectionNode:XMLNode = targetNode.firstChild; sectionNode != null; sectionNode = sectionNode.nextSibling){
			//SECTION
			if(sectionNode.nodeName == "section"){
				//create a new object to hold sub-sections info
				var subSection:Object = new Object();
				subSection.swfURL = sectionNode.attributes.swfURL;
				
				//now push into the main section object
				section.push(subSection);
			}
		}
		
//		for(var i in section){
//			trace(section[i].swfURL);
//		}

		//now tranfer into the main array
		this.__mainArray.push(section);
	}
	
	//populates the EPK section info for the model
	protected function populateEPKInfo(targetNode:XMLNode):void{
		trace("populateEPKInfo function called on: " + getQualifiedClassName(this));
		
		//create the array that will hold all info for the carousel section
		var section:Array = new Array();
		section.type = targetNode.attributes.type;
		
		//iterate through all sections
		for(var sectionNode:XMLNode = targetNode.firstChild; sectionNode != null; sectionNode = sectionNode.nextSibling){
			//SECTION
			if(sectionNode.nodeName == "section"){
				//create a new object to hold sub-sections info
				var subSection:Object = new Object();
				subSection.swfURL = sectionNode.attributes.swfURL;
				
				//now push into the main section object
				section.push(subSection);
			}
		}
		
//		for(var i in section){
//			trace(section[i].swfURL);
//		}

		//now tranfer into the main array
		this.__mainArray.push(section);
	}




////////////////////////////////// EVENTS ///////////////////////////////////////////

    //EVENT broadcasts that all xml has finished loading and is structured to pass off
    public function onXMLLoaded():void{
    	trace("broadcasting onXMLLoaded event on: " + getQualifiedClassName(this));

    	dispatchEvent(new XMLEvent(XMLEvent.PACKAGED_INFO, false, false, this.__mainArray));
    }

}//end AmpdXML
}