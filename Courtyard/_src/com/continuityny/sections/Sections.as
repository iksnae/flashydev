/**
 * @author chad
 */
class com.continuityny.sections.Sections {
	
	// PUBLIC VARS
	public static var SECTION:MovieClip;
	public static var SECTION_WIDTH:Number = 942;
	public static var SECTION_HEIGHT:Number = 310;
	public static var SECTION_GUTTER:Number = 10;
	public static var SECTION_X:Number = 0;
	public static var SECTION_Y:Number = 0;
	
	// PRIVATE VARS
	private static var SECTION_NAME:String;
	private static var PANEL_OBJ:Object;
	
	//CLASS VARS
	
	public function Sections(_section:MovieClip,_section_name:String ) {
		
		SECTION = _section;
		trace("SECTION : "+SECTION);
		SECTION_NAME = _section_name;
		trace("SECTION_NAME : "+SECTION_NAME);
		//PANEL_OBJ = _panel_obj;//, _panel_obj:Object
		//
		buildSection ();
	}
	 
	private static function buildSection (){
		
		
		SECTION._width = SECTION_WIDTH;
		SECTION._height = SECTION_HEIGHT;
		SECTION._x = SECTION_X;
		SECTION._y = SECTION_Y;
		
	}
	
	
}