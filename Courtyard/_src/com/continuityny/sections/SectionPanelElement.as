/**
 * @author chad
 */
class com.continuityny.sections.SectionPanelElement extends MovieClip{
	
	private var ELEMENT:MovieClip;
	private var ELEMENT_CONTENT:MovieClip;
	private var ELEMENT_TYPE:String;
	private var ELEMENT_ID:Number;
	private var ELEMENT_X:Number;
	private var ELEMENT_Y:Number;
	private var ELEMENT_WIDTH:Number;
	private var ELEMENT_HEIGHT:Number;
	
	
	public function SectionPanelElement(_element:MovieClip, 
	_element_content:MovieClip,
	_element_type:String, 
	_element_id:Number, 
	_element_x:Number, 
	_element_y:Number , 
	_element_width:Number, 
	_element_height:Number
	) {
		
			ELEMENT	= _element;
			ELEMENT_CONTENT= _element_content;
			ELEMENT_TYPE= _element_type;
			ELEMENT_ID= _element_id;
			ELEMENT_X= _element_x;
			ELEMENT_Y= _element_y;
			ELEMENT_WIDTH= _element_width;
			ELEMENT_HEIGHT= _element_height;
 
			buildPanelElement();
	}
	
	private function buildPanelElement (){
		
		ELEMENT._x =   ELEMENT_X;
		trace("ELEMENT_X : "+ELEMENT_X);
		ELEMENT._y =  ELEMENT_Y;
		trace("ELEMENT_Y : "+ELEMENT_Y);
		ELEMENT._width = ELEMENT_WIDTH;
		trace("ELEMENT_WIDTH : "+ELEMENT_WIDTH);
		ELEMENT._height = ELEMENT_HEIGHT;
		trace("ELEMENT_HEIGHT : "+ELEMENT_HEIGHT);

	}
	
}