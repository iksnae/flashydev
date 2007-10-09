
class UnitFurnished {

	public function SetUnitFurnished(MovieClipName:String, isChecked:Boolean) {
		switch(MovieClipName){
			case "Unit_Furnished":
				if (isChecked)
					_global.arrUnitFurnished[0] = 1;				
				else
					_global.arrUnitFurnished[0] = 0;
				break;
			case "Unit_UnFurnished":
				if (isChecked)
					_global.arrUnitFurnished[1] = 1;
				else
					_global.arrUnitFurnished[1] = 0;					
				break;
		}
	}
}