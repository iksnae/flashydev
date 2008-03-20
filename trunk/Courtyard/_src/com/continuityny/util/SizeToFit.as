/**
 * @author Greg
 */
 
 
 
class com.continuityny.util.SizeToFit {
	
	private var _MC:MovieClip;
	
	public function SizeToFit(	_mc:MovieClip, 
								w:Number, 
								proportional:Boolean
								) {
	
		_MC = _mc; 
		
		
		
		var old_width:Number = _mc._width;
		
		_mc._width = w; 
		
		var resize_percent:Number = (w*100)/old_width; 
		
		_mc._yscale = resize_percent; 
		
		
		// trace("SizeToFit:resize_percent"+resize_percent+" old_width:"+old_width+" w:"+w);
			
	}
	
}