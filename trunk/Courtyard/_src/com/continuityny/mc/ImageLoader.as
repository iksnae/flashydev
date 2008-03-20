import mx.utils.Delegate;
/**
 * @author Greg
 */




class com.continuityny.mc.ImageLoader  {
	
	
	private var _MCL:MovieClipLoader;
	
	private var _LISTENER:Object;
	
	public var onLoaded:Function;
	
	//public var onProgress:Function;
	
	public var loaded:Boolean = false; 
	
	public function ImageLoader(_mc:MovieClip,
								_src:String
								){
									
	
			trace("Image Loader ***  _mc:"+_mc+" src:"+_src);
			_LISTENER = new Object();
			
			_MCL = new MovieClipLoader();
			
			_MCL.addListener(_LISTENER);
			
			_LISTENER.onLoadInit = Delegate.create(this, function(){
				
				//trace("Load Complete: _mc"+	_mc);	
				loaded = true; 
				onLoaded();
				
			});
			
			
			//_LISTENER.onLoadProgress = Delegate.create(this, onProgress);
			
			_MCL.loadClip(_src, _mc);					
			
			
									
			}
	
}