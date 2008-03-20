import mx.transitions.easing.*;
import mx.transitions.Tween;
import mx.utils.Delegate;


import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;
import com.continuityny.mb.MB_Nav_View;
import com.continuityny.effects.Reflect;
import com.continuityny.text.TextLine2;
import com.continuityny.text.SharedFontStyle;

/**
 * @author continuityuser
 */
 
 
 
class com.continuityny.nav.ClientList {
	
	
	
	private var TARGET_MC:MovieClip;
	
	private var aClientName:Array;
	private var aClientDest:Array;
	private var listLength:Number;
	private var listSpacing:Number=18;
	
	private var glassHeight:Number;
	private var whiteHeight:Number;
	
	private var NAV_VIEW:MB_Nav_View;
	
	public var REFLECTION:Reflect; 
	
	
	public function ClientList(		view_scope:MB_Nav_View, 
									_mc:MovieClip, 
									client_data:Array
									){
		
		TARGET_MC =_mc;
		
		NAV_VIEW = view_scope; 
		 
		aClientName = client_data;
		listLength = aClientName.length;
		
		buildList();
		
		
		trace("ClientList"); 
	}
	
	
	private function buildList(){
		
		
		TARGET_MC.whiteBack.setMask(TARGET_MC.whiteMask);
		
		TARGET_MC.whiteBack._height = ((listLength+1)*listSpacing)+15;
		
		whiteHeight = TARGET_MC.whiteBack._height;
		
		
		TARGET_MC.glass._height 	= TARGET_MC.whiteBack._height+16;		
		TARGET_MC.whiteLine._y 		= -TARGET_MC.glass._height;
		
		TARGET_MC.createEmptyMovieClip("listHolder", TARGET_MC.getNextHighestDepth());
		TARGET_MC.listHolder._y 	= -TARGET_MC.whiteBack._height+15;
		TARGET_MC.listHolder._x 	= TARGET_MC.whiteBack._x+15;
		
		
		for (var i:Number=0; i < listLength; i++){
			
			TARGET_MC.listHolder.attachMovie("listItem", "listItem"+i, i);
		
			var newItem = TARGET_MC.listHolder["listItem"+i];
			
			newItem.myNum 		= i;
			newItem.whiteHeight = whiteHeight;
			newItem.clientName 	= aClientName[i]["xname"].toUpperCase();
			
			newItem.clientID	= aClientName[i]["work_id"];
			
			var tf:TextFormat 	= new TextFormat("Frutiger_Bold_IMPORTED", 9.5, 0x333333);
			tf.letterSpacing = (newItem.clientName.length>17) ? -.25 : .25 ; 
			
			newItem.listItem_txt.text 	= newItem.clientName;
			new SharedFontStyle(newItem.listItem_txt, newItem.clientName, tf);
			
			newItem._y = ( i * listSpacing );
			newItem._x = -5;
			
			var this_scope = this; 
			
			newItem.onRollOver = function(){
				this_scope.moveMask(this);
				new Color(this).setRGB(0x880057); 
			};
			
			newItem.onDragOut = newItem.onRollOut = function(){ new Color(this).setRGB(0x333333); };	
			
			// TODO - move this into Nav_View setUpLocation - Take Data outta here. Set Externally. 
			newItem.onRelease = function(){  clientClick(); };	
			
			var location_name = "work,"+aClientName[i]["work_id"]; 
			
					
		};		

	};
	
	private function moveMask(_mc){
		
		//trace("Move Mask:"+this); 
	
		var rolled = _mc;
		var rolledValue:Number	=-(rolled.whiteHeight-rolled._y)+13;
		
		var mc = rolled._parent._parent.whiteMask;
		new Tween(mc, "_y", Regular.easeOut, mc._y, rolledValue, .1, true);
		
	
	}
	
	
	
	function clientClick(){
		
		var clicked = this;
		
		// trace("Client List clicked.clientID: "+clicked.clientID);
		
		NAV_VIEW.clickClient(clicked.clientID);
	
	
	};
	
	
}