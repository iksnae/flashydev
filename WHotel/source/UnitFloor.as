class UnitFloor {
	
	public function SetUnitFloor(MovieClipName:String, isChecked:Boolean) {
		switch(MovieClipName){
			case "floors3356_mc":
				if (isChecked)
					_global.arrUnitFloor[0] = "33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56";				
				else
					_global.arrUnitFloor[0] = 0;
				break;
			case "floors2330_mc":
				if (isChecked)			
					_global.arrUnitFloor[3] = "23,24,25,26,27,28,29,30";
				else
					_global.arrUnitFloor[3] = 0;
				break;		

		}
	}	
	
}