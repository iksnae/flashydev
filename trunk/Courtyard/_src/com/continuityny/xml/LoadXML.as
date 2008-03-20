


class com.continuityny.xml.LoadXML extends Array {

	private var _xml:XML; 
	private var dataFile:String ;
	private var errorText:String;
	private var XMLstatusNum:String;  
	private var XMLstatusDescript:String;  
	private var responseList = new Array();
	private var args_obj:Object;
	
	private var LOCAL:Boolean; 
	
	private var data_loaded:Boolean = false;
	
	public var onLoadComplete:Function;
	
	public function LoadXML (args) {
		
			var o:LoadXML = this;
			
			args_obj = args;
			dataFile = args.filePath + args.dataFile;
			
			if(dataFile=="") dataFile = "data.xml" ;  // DEFAULT FILE
			
			LOCAL = (new LocalConnection().domain() == "localhost") ? true : false ; 
			dataFile 	= (LOCAL) ? dataFile : dataFile+"?noCache="+random(999999); 
			
		
			_xml = new XML();
			
			_xml.ignoreWhite = true;
			_xml.load(dataFile);
			_xml.onLoad = function (success:Object) {
				
				if (success) { 
					o.data_loaded = true;
					o.successFun(); 
					
					o.onLoadComplete();
					
				}else{ 
					o.errorFun();
				}
			};
	
	}
	

	private function successFun () : Void {
			
			trace("XML LOADED....");
			trace("\n\n----------------------\n"+_xml+
				  "\n------------------------\n\n");
				
				trace("ARGS: "+args_obj.args);
				args_obj.fun(args_obj.args);
	}
	
	public function errorFun () : Void {
			errorText = "** XML ERROR\n\n"+errorCheck(_xml)[0]+","+errorCheck(_xml)[0];
			trace(errorText);
	}
	

	public function getLoaded () : Boolean{
		
		return data_loaded;
	}

	
	// XML Error Check Subroutine
	private function errorCheck (tOBJ:Object) : Array{
		// Init local variables.
		XMLstatusNum = tOBJ.status;
		XMLstatusDescript = "";
		
		if (XMLstatusNum == 0) {
			XMLstatusDescript = "XML Data Loaded.";
		}
		if (XMLstatusNum == -2) {
			XMLstatusDescript = "Termination Error in CDATA.  "+XMLstatusNum;
		}
		if (XMLstatusNum == -3) {
			XMLstatusDescript = "Termination Error in DECLARATION.  "+XMLstatusNum;
		}
		if (XMLstatusNum == -4) {
			XMLstatusDescript = "Termination Error in DOCTYPE.  "+XMLstatusNum;
		}
		if (XMLstatusNum == -5) {
			XMLstatusDescript = "Termination Error in COMMENT.  "+XMLstatusNum;
		}
		if (XMLstatusNum == -6) {
			XMLstatusDescript = "Malformed Error in XML.  "+XMLstatusNum;
		}
		if (XMLstatusNum == -7) {
			XMLstatusDescript = "Out of memory Error.  "+XMLstatusNum;
		}
		if (XMLstatusNum == -8) {
			XMLstatusDescript = "Termination Error in ATTRIBUTE.  "+XMLstatusNum;
		}
		if (XMLstatusNum == -9) {
			XMLstatusDescript = "Error in START/END tag.  "+XMLstatusNum;
		}
		if (XMLstatusNum == -10) {
			XMLstatusDescript = "Error in END/START tag.  "+XMLstatusNum;
		}
		
		responseList = [XMLstatusNum, XMLstatusDescript];
		
		return responseList;
	} // END errorCheck

}



