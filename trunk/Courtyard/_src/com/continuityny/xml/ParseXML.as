import com.bourre.mvc.AbstractView;





class com.continuityny.xml.ParseXML extends com.continuityny.xml.LoadXML {

	
	private var traceme:Boolean = true; 
	
	private var MAIN_OBJ:Object;
	private var XML_DATA:Object;
	private var MAIN_NODE_NAME:String; 

	//private var COUNT:Number = 0; 
	
	public var onLoadComplete:Function;


	public function ParseXML (args:Object) {
		
		super(args);
		
		MAIN_OBJ = new Object();
			
	}

	// TODO add ability to handle text nodes
	private function successFun () {
		
		XML_DATA = _xml.firstChild.childNodes;
		
		//if(traceme) trace("FIRST NODE:"+_xml.firstChild.firstChild.nodeName);
		
		MAIN_NODE_NAME = _xml.firstChild.firstChild.nodeName;
		
		//MAIN_OBJ[MAIN_NODE] = new Array();
		
		init();
		
		
		
		super.successFun();
	
		
	}
	
	
	
	private function init () {
		
		trace("---XML Data---"); 
		
		digDown(XML_DATA, MAIN_OBJ, MAIN_NODE_NAME);
		
		//if(traceme) trace(MAIN_OBJ[MAIN_NODE_NAME][1].id+ " << First id ");
	}
	
	
	
	private function digDown (xml_data_node, temp_obj, array_name){
		
		
		trace("DigDown: array_name: "+array_name
		+" type:"+(typeof temp_obj[array_name])
		+" length:"+(temp_obj[array_name].length)); 
		
		
		//trace("DigDown: objItem"+objItem+" type:"+(typeof objItem)); 
		
		
		if( temp_obj[array_name] == undefined){
			trace("temp_obj[array_name] == undefined");
			temp_obj[array_name] = new Array();
		}
		
	
		
		for ( var item in xml_data_node ) {
	
			if	(	xml_data_node[item].nodeName == array_name && 
					( 	xml_data_node[item].attributes.active == "TRUE" || 
						xml_data_node[item].attributes.active == "true" ||
						getActive(xml_data_node[item] ) 
						)	) {
					
					
					
					//if(count == undefined) var count = 0; 
					
					if(traceme) trace("Node:"+array_name);
					
					// ~~ Take care of the ATTRIBUTES
					var itemAtts = new Array(); 
					itemAtts = xml_data_node[item].attributes; 
						
					if(traceme) trace("itemAtts: "+xml_data_node[item].attributes.active);
					// If there are no "order_by" attributes 
					// push an empty array into this array
					
						if(itemAtts["order_by"] == undefined){
							var array_count = temp_obj[array_name].length; 
							var objItem =  temp_obj[array_name][array_count] = new Array();
						}else{
							var objItem = temp_obj[array_name][ Number(itemAtts["order_by"]) ] = new Array();
						}
					
					
					
					// Add this nodes attributes to the array
					for(var eachAttr in itemAtts) {
						objItem[eachAttr] = itemAtts[eachAttr]; 
							if(traceme) trace("    @"+eachAttr+" = "+itemAtts[eachAttr]);
					}
					
					
					
					
					// ~~ Take care of the NODES
					//  Create arrays with node name and values of the node values
					for(var eachNode in xml_data_node[item].childNodes){
						
							var NAME = xml_data_node[item].childNodes[eachNode].nodeName;
							var VALUE = xml_data_node[item].childNodes[eachNode].childNodes[0].nodeValue;
							var ORDER = xml_data_node[item].childNodes[eachNode].attributes["order"];
							
							if(traceme) trace("Node - NAME:" +NAME+" ORDER: "+ ORDER+" VALUE: "+ VALUE);
							
							// If the attributes did not create this element
							if(objItem==undefined){
								trace("objItem undefined:"+NAME);
								var objItem = new Array();
							}
							
							// Arrange by "order" attribute or just push into array
							if ( objItem[NAME] == undefined ) { 
								trace(" objItem[NAME] == undefined:"+NAME);
								objItem[NAME] = new Array();
							
							}
							
							
							if(VALUE != null){
							
								if(ORDER == undefined){	
															
									objItem[NAME].push(VALUE);
									
								}else{
									objItem[NAME][ORDER] = VALUE;
								
								}
							}
					
							
							// Dig Down
							//digDown(xml_data_node[item].childNodes, objItem, xml_data_node[item].childNodes.firstChild.nodeName);
							
							var this_node = xml_data_node[item].childNodes[eachNode].childNodes[0];
							
							digDown(this_node, objItem, NAME);
					
					}
					
					
					// Remove Array if only one node of this name
					for( var eachNode in xml_data_node[item].childNodes ){
						
							var NAME = xml_data_node[item].childNodes[eachNode].nodeName;
							/*if(objItem[NAME].length == 1 ) 
							{
								objItem[NAME] = objItem[NAME].toString();  
								trace("Replace the array:"+objItem[NAME]+" | "+typeof objItem[NAME]);
							}*/
								
					}
					
					
					for( var eachNode in objItem ){
						
						if(objItem[eachNode]['active'] == "FALSE"){
							//delete objItem; 
						}
						
					}

					// TODO Something is screwey when you hit the last node
					
					// NO NEED TO digDown Right NOW. 
					//digDown(xml_data_node[item].childNodes, objItem, xml_data_node[item].childNodes.firstChild.nodeName);
					
				} // end if
				
		} // end for
		
		
	}
	




	
	public function getData ( ) : Object {
		return MAIN_OBJ;  
	}

	
	private function getActive(item):Boolean{
		
		for(var eachNode in item.childNodes){
				var NAME = item.childNodes[eachNode].nodeName;
				var VALUE = item.childNodes[eachNode].childNodes[0].nodeValue;
				//trace("getActive NAME: "+NAME+" | active:"+VALUE);
				if(NAME == 'active' && VALUE == 'TRUE'){
					return true;
				}else{
					return false;
				}
							
		}	
	}

}

