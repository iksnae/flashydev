

class com.continuityny.util.MCUtils {
	
	
	public function MCUtils ( )  {
		
		
		MovieClip.prototype.saveState = function(){
	
			this.x = this._x;
			this.y = this._y;
			this.alpha = this.a = this._alpha;
			this.rotation = this.r = this._rotation;
			
		};
		
		MovieClip.prototype.getScale = function():Number {
			return this._xscale;
		};
		
		MovieClip.prototype.setScale = function(n:Number) {
			this._xscale = this._yscale = n;
		};

		MovieClip.prototype.addProperty ("_scale", MovieClip.prototype.getScale, MovieClip.prototype.setScale); 
		
	}
	
	
}