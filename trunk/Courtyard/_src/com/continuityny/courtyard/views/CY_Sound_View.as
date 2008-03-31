

//	Debug
import com.bourre.log.Logger;
import com.bourre.log.LogLevel;

//	Delegate
import com.bourre.commands.Delegate;

//	Event Broadcasting
import com.bourre.events.IEvent;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;

import com.continuityny.courtyard.CY_EventList;
import com.continuityny.courtyard.CY_EventBroadcaster;

import com.bourre.visual.MovieClipHelper;

//	list of Views
import com.continuityny.courtyard.CY_ViewList;
import com.continuityny.courtyard.CY_Site_Model;
import com.continuityny.courtyard.views.CY_Location_View;
import com.continuityny.courtyard.views.CY_Home_View;
import com.continuityny.courtyard.views.CY_Nav_View;




/**
 * @author Greg
 */
class com.continuityny.courtyard.views.CY_Sound_View extends MovieClipHelper {
	
	
	
	private var MUSIC_FILE_ARRAY:Array;

	private var SOUND_BOARD : MovieClip; 
	private var SOUND_ARRAY : Array; 
	private var SOUND_LOADED_ARRAY : Array;

	private var ALL_LOADED : Boolean = false;

	private var CHECK_INT : Number;

	private var LOADED_COUNT : Number;

	private var FADE_INT : Number;

	private var MAIN_VOLUME : Number = 100;

	private static var MUTED : Boolean = false;	private var _config : Object; 
		public function CY_Sound_View( mc ) {
			super( CY_ViewList.VIEW_SOUND, mc );
			trace("CY_Sound_View: mc:   eee "+mc);
			
			_init();
			
			
	}
		
		
		
		
		

	
	
	
	public function _init(){
		
		//trace("	MB_Sound_View:Inited");
		
		_config = CY_Site_Model.getConfig() ;
		
		MUSIC_FILE_ARRAY 	= _config.audio;
		
		SOUND_ARRAY 		= new Array(); 
		SOUND_LOADED_ARRAY 	= new Array(); 
		
		//MUSIC_FILE_ARRAY["main"] 	= "AmazingAwaits.mp3";
		

		
		SOUND_BOARD = view.createEmptyMovieClip("soundboard_mc", 126003);
		
		
		for (var each : String in MUSIC_FILE_ARRAY) {
			SOUND_LOADED_ARRAY[each] = false; 
		}
		
	//	LOCATION_MANAGER = e.getTarget()[0];
	//	LOCATION_MANAGER.setTarget(TARGET_MC); 
		//loadSounds();
		
		trace("	MB_Sound_View:Inited - "+MUSIC_FILE_ARRAY.preload);
	
	}
	
	
	
	
	
	
	public function _loadSounds() : Void {
		
		trace("Sound_View:load sounds"); 
		
		for (var each : String in MUSIC_FILE_ARRAY) {
			
			var this_file = MUSIC_FILE_ARRAY[each]; 
			var this_name = each; 
			var d = SOUND_BOARD.getNextHighestDepth();
			SOUND_BOARD.createEmptyMovieClip(this_name+"_mc", d);
			
			
			SOUND_ARRAY[this_name] = new Sound(SOUND_BOARD[this_name+"_mc"]);
			
			var this_sound:Sound = SOUND_ARRAY[this_name];
			
			this_sound.loadSound("mp3/"+this_file, false);
			
			this_sound.onLoad = new Delegate(this, function (success, this_name){
			   if (success) {
			        //trace("Sound_View: Sound Loaded:"+this_name);
			       	SOUND_LOADED_ARRAY[this_name] = true; 
			    }
			}, this_name).getFunction();

			
		} // end for..in
		 
		checkAllLoaded();
		
	}


	public function _loadSound(refName:String, soundFile:String, callBack:Function) : Sound {
		
		trace("Sound_View:load sound - "+soundFile); 
			
		//	var this_file = MUSIC_FILE_ARRAY[each]; 
		//	var this_name = each; 
			var d = SOUND_BOARD.getNextHighestDepth();
			SOUND_BOARD.createEmptyMovieClip("sound_"+d+"_mc", d);
			var this_sound_mc = SOUND_BOARD["sound_"+d+"_mc"]; 
			
			var this_sound:Sound = SOUND_ARRAY[refName] = new Sound(this_sound_mc);
			
			//var this_sound:Sound = new Sound(this_sound_mc);
			
			this_sound.loadSound(soundFile, false);
			
			this_sound.onLoad =  Delegate.create(this, function (success){
			   if (success) {
			        //trace("Sound_View: Sound Loaded:"+this_name);
			       //	SOUND_LOADED_ARRAY[this_name] = true; 
			       callBack();
			       
			    }
			});
		 
		 return this_sound;
		//checkAllLoaded();
		
	}

	
	public function playSound(refName:String){
		
		if(MUTED){
			SOUND_ARRAY[refName].setVolume(0);
		}else{
			SOUND_ARRAY[refName].setVolume(100);	
		}
		
		SOUND_ARRAY[refName].stop();
		SOUND_ARRAY[refName].start(0);
		
		trace("play sound:"+SOUND_ARRAY[refName]+" ref:"+refName);
		
	}
	
	
	
	private function checkAllLoaded() : Void {
	
		//trace("Sound_View:checkAllLoaded:"); 
	
		LOADED_COUNT = 0; 
		
		clearInterval(CHECK_INT);
		
		CHECK_INT = setInterval(Delegate.create(this, function(){
			
				var TEMP_ARRAY = new Array(); 
		
				for (var each : String in SOUND_LOADED_ARRAY) {
					TEMP_ARRAY.push(	SOUND_LOADED_ARRAY[each] ); 
				}
		
				view.check3_txt.text = "Sound_View: Check Loaded"+TEMP_ARRAY.length;
				view.check_txt.text = "Sound_View: Check Loaded"+TEMP_ARRAY[LOADED_COUNT];
				
				if(TEMP_ARRAY[LOADED_COUNT]){
					
					view.check2_txt.text = "Sound_View: Loaded"+LOADED_COUNT;
					
					LOADED_COUNT++; 
				
					if(LOADED_COUNT>TEMP_ARRAY.length-1){
						clearInterval(CHECK_INT);	
						playMainMusic(); 
					}
				}
				
			
		}),100); 
	}

	
	private function playMainMusic() : Void {
		
		
		var main_sound:Sound = SOUND_ARRAY["main"]; 
		
		view.check4_txt.text = "sound loaded:"+main_sound.getVolume(); 
		
		main_sound.setVolume(MAIN_VOLUME);
		main_sound.start();	
		
		main_sound.onSoundComplete = Delegate.create(this, playMainMusic);
	
	}
	
	
	
	public function fadeDownMusic(){
		
		clearInterval(FADE_INT);
		var main_sound:Sound = SOUND_ARRAY["main"]; 
		
		FADE_INT = setInterval(Delegate.create(this, function(){
			
			var v = main_sound.getVolume(); 
			main_sound.setVolume(v-5);
			MAIN_VOLUME = main_sound.getVolume();
			//trace("set volume:"+v); 
			if(v <= 0) {   MAIN_VOLUME = 0; main_sound.setVolume(0); clearInterval(FADE_INT); }
			
		}), 10); 
		
	}
	
	public function fadeUpMusic(){
		
		clearInterval(FADE_INT);
		var main_sound:Sound = SOUND_ARRAY["main"]; 
	
		FADE_INT = setInterval(Delegate.create(this, function(){
			
			var v = main_sound.getVolume(); 
			main_sound.setVolume(v+5);
			MAIN_VOLUME = main_sound.getVolume();
			//trace("set volume:"+v); 
			if(v >= 100) clearInterval(FADE_INT);
			
		}), 10); 
		
	}
	
	
	public function fadeSound(this_sound:String){
		
		var TEMP_INT:Number;
		//clearInterval(TEMP_INT);
		var main_sound:Sound = SOUND_ARRAY[this_sound]; 
		
		TEMP_INT = setInterval(Delegate.create(this, function(){
			
			var v = main_sound.getVolume(); 
			main_sound.setVolume(v-3);
			//MAIN_VOLUME = main_sound.getVolume();
			//trace("set volume:"+v); 
			if(v <= 0) {  
				 main_sound.setVolume(0); 
				 
				 main_sound.stop();
				 clearInterval(TEMP_INT); }
			
		}), 20); 
		
	}
	
	
	public function fadeUpSound(this_sound:String){
		
		var TEMP_INT:Number;
		//clearInterval(TEMP_INT);
		var main_sound:Sound = SOUND_ARRAY[this_sound]; 
		
		TEMP_INT = setInterval(Delegate.create(this, function(){
			
			var v = main_sound.getVolume(); 
			main_sound.setVolume(v-3);
			//MAIN_VOLUME = main_sound.getVolume();
			//trace("set volume:"+v); 
			if(v >= 100) {  
				 main_sound.setVolume(100); 
				// main_sound.stop();
				 clearInterval(TEMP_INT); }
			
		}), 20); 
		
	}
	
	
	
	
	public static function getMute():Boolean{
		return MUTED;	
	}
	
	
	public function soundMute(bool){
		//var bool = e.getTarget();
		trace("CY_Sound_View:onSoundMute:"+bool);
		MUTED = bool; 
		//fadeSound(bool);
	}
	
	
	/*public function fadeSound(bool){
		trace("CY_Sound_View:fadeSound:"+bool);
		if(bool){
			fadeDownMusic();
		}else if(!bool){
			
			var video_playing : Boolean = CY_Nav_View( MovieClipHelper.getMovieClipHelper( 
				CY_ViewList.VIEW_NAV ) ).videoPlaying();
				
			if(!MUTED && !video_playing)fadeUpMusic();
		}
		
	}*/
	
	

}