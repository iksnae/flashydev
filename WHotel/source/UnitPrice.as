class UnitPrice {
	
	public function SetUnitPrice(TextBoxName:String, KeyNum:Number, DeleteNum:Boolean):String {
		
		var strPrice:String = _root.mcMain.loader_mc[TextBoxName + "_txt"].text;
		var text_length:Number = 0;
		var priceIndex:Number = 0;
		
		if (DeleteNum) {
			text_length = strPrice.length;
			strPrice = strPrice.slice(0, (text_length - 1));
		} else {
			
			if (strPrice.length <10) {
				if (KeyNum > 0)
					strPrice += KeyNum.toString();
				else if (strPrice.length != 0)
					strPrice += KeyNum.toString();
			}
			
		}
		
		(TextBoxName == "MinPrice") ? priceIndex = 0 : priceIndex = 1;
		
		(strPrice != "") ? strPrice = strPrice.replace(",", "", 0) : strPrice = "";	
		
		_global.arrUnitPrice[priceIndex] = strPrice;
		
		return strPrice;
	}	
	
}