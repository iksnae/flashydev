package  com.husky.model.proxies
{
	import com.husky.model.PlayerData;
	
	public class FVLVideoProxy implements VideoProxy
	{
		private var _model:PlayerData = PlayerData.getInstance()
		public function FVLVideoProxy()
		{
		}

		public function init():void
		{
			if(_model.autoplay){
                _model.videoControllerView['playpause_btn'].toggle()
                _model.app.overlayView.alpha=0;
                _model.videoState.playing=true;
               playVideo()
            }
		}
		
		public function playVideo():void
		{
			var flv = _model.videoID;
			_model.ns.play(flv)
		}
		
	}
}