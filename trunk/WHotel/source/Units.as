import mx.services.*;

class Units {
	
    // private instance variables
    private var __WebServiceURI:String;
	private var __WebServicePolicyURI:String;	
	private var __isDataLoaded:Boolean;

    public function get WebServiceURI():String {
		//trace("get value = " + this.__WebServiceURI);
        return this.__WebServiceURI;
    }
	
    public function set WebServiceURI(value:String):Void {
		//trace("set value = " + value);
        this.__WebServiceURI = value;
    }

    public function get WebServicePolicyURI():String {
		//trace("get value = " + this.__WebServicePolicyURI);
        return this.__WebServicePolicyURI;
    }
	
    public function set WebServicePolicyURI(value:String):Void {
		//trace("set value = " + value);
        this.__WebServicePolicyURI = value;
    }
	
    public function get isDataLoaded():Boolean {
		//trace("get value = " + this.__isDataLoaded);
        return this.__isDataLoaded;
    }
	
	public function Units(p_WebServiceURI:String, p_WebServicePolicyURI:String) {
		this.__WebServiceURI = p_WebServiceURI;
        this.__WebServicePolicyURI = p_WebServicePolicyURI;
	}	
	
	public function GetByUnitID(obj_mc:MovieClip, UNIT_ID:Number) {
		SearchUnits(obj_mc, SearchType.ByUnitID, 0, null, UNIT_ID, null, null, 0, 0, 0);
	}
	
	public function SearchByFloor(obj_mc:MovieClip, DEVELOPMENT_ID:Number, UnitFloors:String, Furnished:Number) {
		SearchUnits(obj_mc, SearchType.ByFloor, DEVELOPMENT_ID, null, 0, null, UnitFloors, 0, 0, Furnished);
	}	

	public function SearchByPriceRange(obj_mc:MovieClip, BuildingIDs:String, LowerPriceLimit:Number, UpperPriceLimit:Number, Furnished:Number) {
		SearchUnits(obj_mc, SearchType.ByPriceRange, 0, BuildingIDs, 0, null, null, LowerPriceLimit, UpperPriceLimit, Furnished);
	}
	
	public function SearchByUnitType(obj_mc:MovieClip, BuildingIDs:String, UnitTypeIDs:String, Furnished:Number) {
		SearchUnits(obj_mc, SearchType.ByUnitType, 0, BuildingIDs, 0, UnitTypeIDs, null, 0, 0, Furnished);
	}
	
	private function SearchUnits(obj_mc:MovieClip, CurrentSearchType:SearchType, DEVELOPMENT_ID:Number, BuildingIDs:String, UNIT_ID:Number, UnitTypeIDs:String, UnitFloors:String, LowerPriceLimit:Number, UpperPriceLimit:Number, Furnished:Number) {
		
		//var webServiceURI:String = new String("http://shvotouchscreen.dev6.team5.com/XML/WebServices/WSUnits.asmx?WSDL");
		//var webServicePolicyURI:String = new String("http://shvotouchscreen.dev6.team5.com/XML/crossdomain.xml");
		
		var oUnits;
		var UnitDetail:Boolean = (UNIT_ID > 0);
		var tempThis = this;
		
		tempThis.__isDataLoaded = false;

		//http://www.adobe.com/devnet/flash/articles/fplayer_security.html
		System.security.loadPolicyFile(WebServicePolicyURI);
				
		var webServicen:WebService = new WebService(WebServiceURI);
		
		switch(CurrentSearchType) {
			
			case SearchType.ByFloor:
				oUnits = webServicen.SearchUnitsByFloorFurnished(DEVELOPMENT_ID, UnitFloors, Furnished);
				trace("Get units by floor");
				break;

			case SearchType.ByPriceRange:
				oUnits = webServicen.SearchUnitsByPriceRangeFurnished(BuildingIDs, Furnished, LowerPriceLimit, UpperPriceLimit);
				trace("Get units by price");
				break;
				
			case SearchType.ByUnitType:
				oUnits = webServicen.SearchUnitsByUnitTypeFurnished(BuildingIDs, UnitTypeIDs, Furnished);
				trace("Get units by size (type)");
				break;
				
			case SearchType.ByUnitID:
				oUnits = webServicen.GetByUnitID(UNIT_ID);
				trace("Get units by id");
				break;				
		}
		
		oUnits.onResult = function(sResult) {
			
			var oUnitTable = new oUnits.UnitTable();
			var oUnitTypeRow = new oUnits.UnitTypeRow();
			var oUnitFloorplanRow = new oUnits.UnitFloorplanRow();
			var styler:MoneyFormat = new MoneyFormat();
			
			oUnitTable = sResult;
			oUnitTypeRow = oUnitTable.UnitTypeRecordSet;
			oUnitFloorplanRow = oUnitTable.UnitFloorplanRecordSet;
			
			// unit detail data
			if (UnitDetail) {
				
				// set unit detail data
				if (oUnitTable.UnitRecordSet.length > 0) {
					
					obj_mc.UnitName_txt.text = oUnitTable.UnitRecordSet[0].UNIT_NAME;
					obj_mc.UnitSqFt_txt.text = oUnitTable.UnitRecordSet[0].SQFT_INT + " Sq.Ft.";
					//obj_mc.UnitOffice_txt.text = oUnitTable.UnitRecordSet[0].OFFICE;
					obj_mc.UnitBedrooms_txt.text = oUnitTable.UnitRecordSet[0].BEDROOMS;
					obj_mc.UnitBaths_txt.text = oUnitTable.UnitRecordSet[0].BATHROOMS;
					obj_mc.UnitPrice_txt.text = styler.toCustomMoney(oUnitTable.UnitRecordSet[0].PRICE, "$", ",", "", false);
					obj_mc.UnitCommonCharge_txt.text = styler.toCustomMoney(oUnitTable.UnitRecordSet[0].MONTHLY_CHARGE, "$", ",", "", false);
					obj_mc.UnitRETaxes_txt.text = styler.toCustomMoney(oUnitTable.UnitRecordSet[0].RE_TAXES, "$", ",", "", false);					
					
				}
				
			// search result data
			} else {

				
				// controls result movieClip
				if (oUnitTable.UnitRecordSet.length > 0) {

					// Technically there are more than 6 pages. Each page can hold upto 20 units. 
					// Currently, there 207 units; therefore, 10 pages equals 200 units, plus 1 pages equal 7 units.
					// There is no space to place 11 page buttons in the flash movie.
					// We should come up with some idea on how to enable the app to do paging when the search 
					// result throws more than 120 units.
					
					// format text style
					var txtformat:TextFormat = new TextFormat();
					txtformat.font = "Gill Sans Std";
					txtformat.align = "left";
					txtformat.color = 0xffffff;
					txtformat.bold = false;
					txtformat.size = 12;
								
					// data position(x,y)
					var txtfld_ypos:Number = 14.8;
					var invbutt_ypos_offset:Number = -10.5;
					
					for(var i:Number = 0; i < oUnitTable.UnitRecordSet.length; i++) {

						if (i>0)
							txtfld_ypos += 37.5;  //37.5
											
						// ROW EVENT
						obj_mc["scrollpane"].content.attachMovie("invbutt_mc", "invbutt" + i.toString() + "_mc", obj_mc["scrollpane"].content.getNextHighestDepth(), {_x:0, _y:(txtfld_ypos+invbutt_ypos_offset)});
						obj_mc["scrollpane"].content["invbutt" + i.toString() + "_mc"].HiddenUnitID_txt.text = oUnitTable.UnitRecordSet[i].UNIT_ID;
						obj_mc["scrollpane"].content["invbutt" + i.toString() + "_mc"].HiddenFloorplanID_txt.text = "";
						for(var k = 0; k < oUnitFloorplanRow.length; k++)
							if (oUnitTable.UnitRecordSet[i].UNIT_FLOORPLAN_ID == oUnitFloorplanRow[k].UNIT_FLOORPLAN_ID)
								obj_mc["scrollpane"].content["invbutt" + i.toString() + "_mc"].HiddenFloorplanID_txt.text = oUnitFloorplanRow[k].FILENAME;
							
						obj_mc["scrollpane"].content["invbutt" + i.toString() + "_mc"].onRollOver = function() { this.gotoAndPlay("over"); };
						obj_mc["scrollpane"].content["invbutt" + i.toString() + "_mc"].onRollOut = function() { this.gotoAndPlay("out"); };					
						obj_mc["scrollpane"].content["invbutt" + i.toString() + "_mc"].onRelease = function() { _global.UnitID = this.HiddenUnitID_txt.text; if (this.HiddenFloorplanID_txt.text != "") { _global.FloorplanID = this.HiddenFloorplanID_txt.text; } else { _global.FloorplanID = null; }; _root.mcMain.resultsLoader_mc.play(); };
						
						
						// SIZE
						obj_mc["scrollpane"].content.createTextField("Size"+i.toString()+"_txt", obj_mc["scrollpane"].content.getNextHighestDepth(), 16, txtfld_ypos, 95, 20.3);
						for(var j = 0; j < oUnitTypeRow.length; j++)
							if (oUnitTable.UnitRecordSet[i].UNIT_TYPE_ID == oUnitTypeRow[j].UNIT_TYPE_ID)
								obj_mc["scrollpane"].content["Size"+i.toString()+"_txt"].text = oUnitTypeRow[j].TITLE_ABBR;
						obj_mc["scrollpane"].content["Size"+i.toString()+"_txt"].setTextFormat(txtformat);
						obj_mc["scrollpane"].content["Size"+i.toString()+"_txt"].selectable = false;
						
						// SQFT
						obj_mc["scrollpane"].content.createTextField("Sqft"+i.toString()+"_txt", obj_mc["scrollpane"].content.getNextHighestDepth(), 64, txtfld_ypos, 95, 20.3);
						obj_mc["scrollpane"].content["Sqft"+i.toString()+"_txt"].text = oUnitTable.UnitRecordSet[i].SQFT_INT;
						obj_mc["scrollpane"].content["Sqft"+i.toString()+"_txt"].setTextFormat(txtformat);
						obj_mc["scrollpane"].content["Sqft"+i.toString()+"_txt"].selectable = false;
						
						// TYPE
						obj_mc["scrollpane"].content.createTextField("Furnish"+i.toString()+"_txt", obj_mc["scrollpane"].content.getNextHighestDepth(), 114, txtfld_ypos, 128, 20.3);
						if (oUnitTable.UnitRecordSet[i].FURNISHED)
							obj_mc["scrollpane"].content["Furnish"+i.toString()+"_txt"].text = "FURNISHED";
						else
							obj_mc["scrollpane"].content["Furnish"+i.toString()+"_txt"].text = "UNFURNISHED";
						obj_mc["scrollpane"].content["Furnish"+i.toString()+"_txt"].setTextFormat(txtformat);
						obj_mc["scrollpane"].content["Furnish"+i.toString()+"_txt"].selectable = false;

						// APT
						obj_mc["scrollpane"].content.createTextField("Apt"+i.toString()+"_txt", obj_mc["scrollpane"].content.getNextHighestDepth(), 223, txtfld_ypos, 95, 20.3);
						obj_mc["scrollpane"].content["Apt"+i.toString()+"_txt"].text = oUnitTable.UnitRecordSet[i].UNIT_NAME;
						obj_mc["scrollpane"].content["Apt"+i.toString()+"_txt"].setTextFormat(txtformat);
						obj_mc["scrollpane"].content["Apt"+i.toString()+"_txt"].selectable = false;
						
						
						// PRICE
						obj_mc["scrollpane"].content.createTextField("Price"+i.toString()+"_txt", obj_mc["scrollpane"].content.getNextHighestDepth(), 273, txtfld_ypos, 128, 20.3);
						obj_mc["scrollpane"].content["Price"+i.toString()+"_txt"].text = styler.toCustomMoney(oUnitTable.UnitRecordSet[i].PRICE, "$", ",", "", false);
						obj_mc["scrollpane"].content["Price"+i.toString()+"_txt"].setTextFormat(txtformat);
						obj_mc["scrollpane"].content["Price"+i.toString()+"_txt"].selectable = false;
						
					} // end for loop
					tempThis.__isDataLoaded = true;
					//
					
				} else {
					obj_mc.attachMovie("noResults_mc", "noResults_mc", obj_mc.getNextHighestDepth(), {_x:0, _y:0});				
					trace("No units found!");
					tempThis.__isDataLoaded = true;
				} // end page count validation
				
				
			} // end search result
			
			// refresh scrollpane
			obj_mc["scrollpane"].invalidate();
							
		} // end onResult event
		
		// On error to load data from the WebService, display an error message.
		oUnits.onFault = function(fault) {
			obj_mc.attachMovie("noResults_mc", "noResults_mc", obj_mc.getNextHighestDepth(), {_x:0, _y:0});
			trace("Failed to load WebService.");
			tempThis.__isDataLoaded = true;
		}	
		
		trace("tempThis.__isDataLoaded = " + tempThis.__isDataLoaded);
		
	} // end function
		
	
}