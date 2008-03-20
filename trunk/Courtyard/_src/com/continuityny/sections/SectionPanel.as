import com.continuityny.effects.ScrollingPane;
import com.continuityny.sections.Sections;
import com.continuityny.mc.ImageLoader;

/**
 * @author chad
 */
 
 
class com.continuityny.sections.SectionPanel{
	
	
	// PUBLIC VARS
	public var PANEL:MovieClip;
	
	// PRIVATE VARS
	private static var PANEL_TYPE:String;
	private static var PANEL_SIDE:String;
	private static var PANEL_WIDTH:Number = (Sections.SECTION_WIDTH- Sections.SECTION_GUTTER)/2;
	private static var PANEL_HEIGHT:Number = Sections.SECTION_HEIGHT;
	// contains all of the SectionPanelElement(s)
	private static var PANEL_OBJ:Object;
	
	
	
	public function SectionPanel(_panel:MovieClip, _panel_type:String, _panel_side:String) {
		
		PANEL = _panel;
		trace("PANEL : "+PANEL);
		// "ScrollingPane", "colorPanel", glassPanel"
		PANEL_TYPE = _panel_type;
		trace("PANEL_TYPE : "+PANEL_TYPE);
		// "left" or "right"
		PANEL_SIDE = _panel_side;
		trace("PANEL_SIDE : "+PANEL_SIDE);
		// contains all of the PanelElements {_element_name:foo_mc, _element_id:1, _element_type:"ScrollingPane", _element_x:0, _element_y:0, 
		//PANEL_OBJ = _panel_obj;//, _panel_obj:Object){
		
		buildPanels ();
	}
	
	private function buildPanels (){
		
		PANEL._x =  (PANEL_SIDE == "right") ? (Sections.SECTION_X+(PANEL_WIDTH+Sections.SECTION_GUTTER)):Sections.SECTION_X ;
		//trace("PANEL._x : "+PANEL._x);
		//PANEL._y =  0;
		PANEL._width = PANEL_WIDTH;
		//trace("PANEL_WIDTH : "+PANEL_WIDTH);
		PANEL._height = PANEL_HEIGHT;
		//trace("PANEL_HEIGHT : "+PANEL_HEIGHT);

	}
	
}