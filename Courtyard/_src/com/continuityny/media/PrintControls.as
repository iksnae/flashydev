
import com.bourre.commands.Delegate;
/**
 * @author Greg
 */
class com.continuityny.media.PrintControls {

	private var LISTENER : Object;
	
	
	
	public function PrintControls( 	base_mc:MovieClip, 
									
									play_over_func:Function, 
									refresh_Over_Func:Function ){
		
		
		LISTENER = new Object();
		//FLV_PLAYBACK = FLVPback;
		
		base_mc.labels_mc.gotoAndStop(4); 
		
		base_mc.play_btn.onRelease = Delegate.create(this, function(){
			
			base_mc.labels_mc.gotoAndStop(4); 
			
			if(FLVPback.paused){
				FLVPback.play();
				base_mc.play_btn.gotoAndStop(1); 
			}else{
				FLVPback.pause();
				base_mc.play_btn.gotoAndStop(2); 
			}
		});
		
		base_mc.play_btn.onRollOver = Delegate.create(this, function(){
			base_mc.play_btn.pause_btn.gotoAndStop(2); 
			
			play_over_func();
			
			//REFLECTION.updateReflection();	
			
			if(FLVPback.paused){
				base_mc.labels_mc.gotoAndStop(1); 
			}else{
				base_mc.labels_mc.gotoAndStop(2); 
			}
		});
		
		base_mc.play_btn.onRollOut = Delegate.create(this, function(){
			base_mc.labels_mc.gotoAndStop(4); 
			base_mc.play_btn.pause_btn.gotoAndStop(1); 
		});
		
		base_mc.refresh_btn.onRelease = Delegate.create(this, function(){
				FLVPback.seek(0);
				FLVPback.play();
				base_mc.labels_mc.gotoAndStop(4); 
				base_mc.play_btn.gotoAndStop(1); 
		});
		
		base_mc.refresh_btn.onRollOver = Delegate.create(this, function(){
			refresh_Over_Func();
			//REFLECTION.updateReflection();	
			base_mc.labels_mc.gotoAndStop(3); 
		});
		
		base_mc.refresh_btn.onRollOut = Delegate.create(this, function(){
				base_mc.labels_mc.gotoAndStop(4); 
		});
		
		
		
		// set controls if externally played or paused
		
		LISTENER.buffering   = Delegate.create(this, function(eventObject:Object):Void {
				base_mc.buffer_mc._visible = true; 
		});
		
		
		LISTENER.playing   = Delegate.create(this, function(eventObject:Object):Void {
				base_mc.play_btn.gotoAndStop(1);  
				base_mc.buffer_mc._visible = false; 
		});
		
		LISTENER.paused   = Delegate.create(this, function(eventObject:Object):Void {
			base_mc.play_btn.gotoAndStop(2); 
		});
		
		
		
		FLV_PLAYBACK.addEventListener("playing", LISTENER);  
		FLV_PLAYBACK.addEventListener("paused", LISTENER);
		FLV_PLAYBACK.addEventListener("buffering", LISTENER);  
		

		
	}
	
	
}