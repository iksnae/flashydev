package ShellAPI.Behaviors{
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.xml.XMLDocument;
	
public class XMLBehaviorAbstract extends EventDispatcher{

	//create some variables
    protected var __theXML:XMLDocument;
    protected var __theURL:String;
    protected var __theRequest:URLRequest;
    protected var __theLoader:URLLoader;

	function XMLBehaviorAbstract(targetURL:String){
		trace("XMLBehaviorAbstract class instantiated with targetURL: " + targetURL);

		if(targetURL == "" || targetURL == null){
			trace("WARNING: targetURL not set in XMLBehaviorAbstract");
		}

		//set the __theURL
		this.__theURL = targetURL;

		//create the XML object
		__theXML = new XMLDocument();
	}


	//performs the behavior
    public function execute():void{
    }
	
}//end XMLAbstract
}