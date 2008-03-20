import mx.transitions.easing.*;
import mx.transitions.Tween;
import mx.utils.Delegate;


import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;
import com.continuityny.mb.MB_Nav_View;
import com.continuityny.effects.Reflect;
import com.continuityny.text.TextLine2 ;

/**
 * @author continuityuser
 */
 
 
 
class com.continuityny.nav.AgencyList {
	
	
	
	private var TARGET_MC:MovieClip;
	
	private var aAgencyName:Array;
	private var aAgencyDest:Array;
	private var listLength:Number;
	private var listSpacing:Number=21;
	
	private var glassHeight:Number;
	private var whiteHeight:Number;
	
	private var NAV_VIEW:MB_Nav_View;
	
	public var REFLECTION:Reflect; 
	
	
	public function AgencyList(		view_scope:MB_Nav_View, 
									_mc:MovieClip, 
									agency_data:Array
									){
		
		TARGET_MC =_mc;
		
		NAV_VIEW = view_scope; 
		 
		aAgencyName = agency_data;
		//agency_data[2]["name"]
		listLength = aAgencyName.length;
		
		buildList();
		
		
		trace("AgencyList"); 
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
			
			TARGET_MC.listHolder.attachMovie("alistItem", "alistItem"+i, i);
		
			var newItem = TARGET_MC.listHolder["alistItem"+i];
			
			newItem.myNum 		= i;
			newItem.whiteHeight = whiteHeight;
			newItem.agencyName 	= aAgencyName[i]["name"].toUpperCase();
			newItem.agencyTitle = aAgencyName[i]["title"];
			
			
			newItem.listItemName_txt.text 	= newItem.agencyName ;
			newItem.listItemTitle_txt.text 	= newItem.agencyTitle ;
			newItem._y = ( i * listSpacing );
			
			
			var this_scope = this; 
			
			newItem.onRollOver = function(){
				this_scope.moveMask(this);
				new Color(this).setRGB(0x880057); 
			};
			
			newItem.onRollOut = function(){ new Color(this).setRGB(0x333333); };	
			
			newItem.onRelease = function(){  agencyClick(); };	
			
		
			
					
		};		

	};
	
	private function moveMask(_mc){
		
		//trace("Move Mask:"+this); 
	
		var rolled = _mc;
		var rolledValue:Number	=-(rolled.whiteHeight-rolled._y)+13;
		
		var mc = rolled._parent._parent.whiteMask;
		new Tween(mc, "_y", Regular.easeOut, mc._y, rolledValue, .1, true);
		
	
	}
	
	
	
	function agencyClick(){
		
		var clicked = this;
		
		trace("Agency List clicked.agencyID: "+clicked.agencyID);
		
		//NAV_VIEW.clickAgency(clicked.agencyID);
	
	
	};
	
	
}