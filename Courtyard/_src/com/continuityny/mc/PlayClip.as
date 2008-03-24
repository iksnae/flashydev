import mx.utils.Delegate;
/**
 * @author Greg
 */
class com.continuityny.mc.PlayClip {
	
	private var INT:Number; 
	private var _MC:MovieClip; 
	private var LOOP:Boolean;
	private var LOOP_TIMES:Number;
	private var LOOP_COUNT:Number;
	private var START_FRAME:Number; 
	private var FRAMES:Number;
	private var END_FRAME:Number;
	private var FPS:Number; 
	
	public var whenDone:Function;
	
	public function PlayClip(_mc, fps, reverse:Boolean, loop:Boolean, loopTimes:Number, framesPer:Number, endFrame:Number){
		
			
			_MC = _mc;
			LOOP = (loop != undefined) ? loop : false; 
			
			FPS = (fps != undefined) ? fps : 33; 
			
			LOOP_COUNT = 0; 
			START_FRAME = _MC._currentframe;
			LOOP_TIMES = loopTimes;
			FRAMES = (framesPer != undefined) ? framesPer : 1; 
			END_FRAME = (endFrame != undefined) ? endFrame : _MC._totalframes; 
			// FRAMES = (framesPer != undefined) ? framesPer : 1; 
			
			if(reverse){
				//INT = setInterval(Delegate.create(this, prevFrame), FPS); 
				_MC.onEnterFrame = Delegate.create(this, prevFrame);
			}else{
				INT = setInterval(Delegate.create(this, nextFrame), FPS); 
				//_MC.onEnterFrame = Delegate.create(this, nextFrame);
			}
	}
	

	private function nextFrame(){
		
		//trace("next frame:"+_MC._currentframe+" LOOP_COUNT:"+LOOP_COUNT+" LOOP_TIMES:"+LOOP_TIMES);
		
		//if(END_FRAME != "undefined" && END_FRAME != ""){
			
			if(_MC._currentframe >= END_FRAME){
				delete _MC.onEnterFrame;
				clearInterval(INT);
				whenDone();
			}
			
	//	}
		
		
		if(_MC._currentframe>=_MC._totalframes) _MC.gotoAndStop(START_FRAME);
		
		_MC.gotoAndStop(_MC._currentframe+FRAMES); 
		
		if((_MC._currentframe == _MC._totalframes) && !LOOP){
			//clearInterval(INT);
			delete _MC.onEnterFrame;
			clearInterval(INT);
			whenDone();
		}
		
		if(LOOP){
		if(START_FRAME == _MC._currentframe){
			
			//trace("next frame:START_FRAME == _MC._currentframe - LOOP_COUNT:"+LOOP_COUNT);
			
			LOOP_COUNT++; 
			
			if(LOOP_COUNT == LOOP_TIMES){
				//trace("next frame:LOOP_COUNT == LOOP_TIMES");
				
				Delegate.create(this,stop)();	
				clearInterval(INT);
				whenDone();
				
			}
			
			
		}
		}
		
			
	}	
	
	
	private function prevFrame(){
		
		//trace("prev frame:"+_MC);
		if(_MC._currentframe==1) _MC.gotoAndStop(_MC._totalframes);
		
		_MC.gotoAndStop(_MC._currentframe-1); 
		if((_MC._currentframe == 1) && !LOOP){
			//clearInterval(INT);
			delete _MC.onEnterFrame;	
			clearInterval(INT);
				whenDone();
		}
		
		if(LOOP){
		if(START_FRAME == _MC._currentframe){
			
			LOOP_COUNT++; 
			
			if(LOOP_COUNT == LOOP_TIMES){
				//trace("next frame:LOOP_COUNT == LOOP_TIMES");
				Delegate.create(this,stop)();	
				clearInterval(INT);
				whenDone();
			}
		
		}
		}
		
		
	}	
	
	public function stop(){
		// trace("PlayClip:stop");
		delete _MC.onEnterFrame;
		_MC.stop();
		
	}
}