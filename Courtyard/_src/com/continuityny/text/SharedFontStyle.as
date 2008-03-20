/**
 * @author Greg
 */
class com.continuityny.text.SharedFontStyle {
	
	
	
	public function SharedFontStyle(	_txt:TextField,
										_string:String, 
										tf:TextFormat
										 ) {
										 	
										 	
			_txt.embedFonts = true; 
			_txt.antiAliasType = "advanced";
			_txt.sharpness 	= -300;
			
			_txt.wordWrap = true;
			_txt.multiline = true; 
			
			_txt.autoSize = true; 
			
			_txt.thickness  = -100;
			 
			_txt.text		= _string;
			
			_txt.setTextFormat(tf);
		
	}
	
		
}