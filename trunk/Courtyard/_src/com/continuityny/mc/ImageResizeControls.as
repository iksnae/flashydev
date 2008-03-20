import mx.utils.Delegate;

/** * @author gregpymm */class com.continuityny.mc.ImageResizeControls {

	
	
	private var _holder_mc : MovieClip;
	private var _base_mc : MovieClip;
	private var _plus_button_mc;
	private var _minus_button_mc;

	public function ImageResizeControls( 	image_holder_mc:MovieClip,
											base_mc:MovieClip
											) {
														
												
				_holder_mc 	= image_holder_mc;
				_base_mc 	= base_mc;
				
				//_init();
	}
	
	
	public function _init(){
		
		_plus_button_mc = _base_mc.plus_btn;
		_minus_button_mc = _base_mc.minus_btn;
		
		
		_plus_button_mc.onRelease = Delegate.create(this, function(){
			trace("plus:"+_holder_mc);
			_holder_mc._xscale = _holder_mc._yscale += 10;
			_holder_mc._x -= 5;
			_holder_mc._y -= 5;
			
		});
		
		_minus_button_mc.onRelease = Delegate.create(this, function(){
			trace("plus:"+_holder_mc);
			
			_holder_mc._xscale = _holder_mc._yscale -= 10;
			_holder_mc._x += 5;
			_holder_mc._y += 5;
			
		});
		
		
		_holder_mc.onPress =  function(){
			var w_extent : Number = -(this._width-114);
			var h_extent : Number = -(this._height-114);
			var _mc:MovieClip = this;
			_mc.startDrag(false, w_extent,h_extent,0,0);
		};
		
		_holder_mc.onRelease = 
		_holder_mc.onReleaseOutside =
		function(){
			
			this.stopDrag();
			
		};
		
	}
	
	public function kill(){
		_holder_mc.stopDrag();
		delete _holder_mc.onPress;
		delete _holder_mc.onRelease;
		delete _holder_mc.onReleaseOutside;
	}
	
	public function getScale():Number{
		return (100/_holder_mc._xscale);
	}
	
	public function getXOffset():Number{
		
		var scale = getScale();
		return -_holder_mc._x * scale; 	
	}
	
	public function getYOffset():Number{
		
		var scale = getScale();
		return -_holder_mc._y * scale;
	}
	
	
}