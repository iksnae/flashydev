import mx.video.FLVPlayback;
/**
 * @author Greg
 */
 
 
class com.continuityny.media.FLVPlaybackHandler {
	
	private var FLV_PLAYBACK : FLVPlayback; 
	private var videoDone : Function ;  
	
	private var listener : Object ; 
	
	public function FLVPlaybackHandler(	flvPlayback:FLVPlayback,
										_onVideoDone:Function
										
										){
		
			videoDone 	= _onVideoDone; 
			listener 	= new Object();
		
			FLV_PLAYBACK = flvPlayback; 
			
			FLV_PLAYBACK.addEventListener("complete", listener);
			var scope = this;
			
			listener.complete = function(eventObject:Object):Void {
    				trace("complete");
    				scope.videoDone();

			};
			
			
			FLV_PLAYBACK.addEventListener("cuepoint", listener);
			
			listener.cuepoint = function(eventObject:Object):Void {
    				trace("complete");
    				scope.handleCue(eventObject);

			};
			
	}
	
	
	public function getPlayer():FLVPlayback{
		return FLV_PLAYBACK; 	
	}
	
}