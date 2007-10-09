
class UnitType {

	public function SetUnitType(MovieClipName:String, isChecked:Boolean) {
		switch(MovieClipName){
			case "UnitType_ST":
				if (isChecked)
					_global.arrUnitType[0] = 1;				
				else
					_global.arrUnitType[0] = 0;
				break;
			case "UnitType_1BR":
				if (isChecked)
					_global.arrUnitType[1] = 3;	
				else
					_global.arrUnitType[1] = 0;					
				break;
			case "UnitType_2BR":
				if (isChecked)			
					_global.arrUnitType[2] = 4;	
				else
					_global.arrUnitType[2] = 0;	
				break;
			case "UnitType_PH":
				if (isChecked)			
					_global.arrUnitType[3] = 7;
				else
					_global.arrUnitType[3] = 0;
				break;		
		}
	}
}