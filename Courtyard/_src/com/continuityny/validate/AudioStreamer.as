import mx.utils.Delegate;





class com.continuityny.validate.AudioStreamer {
	
	private var TARGET_MC:MovieClip;
	private var SOUND:Sound;
	
	private var LOADED_INTERVAL:Number;
	
	private var MUTED:Boolean;
	public var PAUSED:Boolean;
	
	private var LOADED:Boolean;
	
	public var mp3;
	
	private var LOOP:Boolean;
	private var FADE_INT:Number;
	
	private var PATH:String; 
	
	//public var ON:Boolean;
	
	public function AudioStreamer (_mc:MovieClip, path:String) {
			
			TARGET_MC = _mc;
			
			//AsBroadcaster.initialize(this);

			SOUND = new Sound(TARGET_MC);
			PATH = path; 
			
			setMedia(); 
			
			//SOUND.start();
	}
	

	
	
	
	public function setMedia (  ) {
		
		
	
		clearInterval(LOADED_INTERVAL);
		LOADED = false;
		
		//var this_scope = this;
		
		SOUND.onLoad = Delegate.create(this, function(success:Boolean) {
		
		   if (success) {
			  trace("sound loaded: "+ PATH);
			 // s.broadcastMessage("onLoaded");
			 LOADED = true;
			 //play(); 
		   }
		});


		SOUND.loadSound(PATH, false);
		
		
		
	}
	
	public function play () : Void{
		
		stop();
		
		if(TARGET_MC.ON){
			SOUND.setVolume(100);
		}else{
			SOUND.setVolume(0);
		}
			
		SOUND.start(0);
	}
	
	public function setVolume (n){
		
		SOUND.setVolume(n);
	}
	
	public function getSound ():Sound{
		return SOUND;
	}
	
	
	

	
	public function fadeOut(){
		
		trace("fadeOut");
		FADE_INT = setInterval(Delegate.create(this, function(){
			
			var g = SOUND.getVolume();
			trace("fading: volume - "+g);
			SOUND.setVolume(g-10);
			
			if(g <= 0) { 
				clearInterval(FADE_INT);
			//	clearInterval(INTERVAL);
				stop();
				trace("SOUND.stop(); ");
				SOUND.stop(); 
			}
			
		}), 100); 
		
	}
	
	public function stop () : Void {
		//this.broadcastMessage("onStop");
		//clearInterval(INTERVAL);
		SOUND.stop();
	}
	
	

	

	public function report () : Number {
		return SOUND.position/SOUND.duration ; 
	}
	
	
	
	
}