

//	Debug
import com.bourre.log.Logger;
import com.bourre.log.LogLevel;

//	Delegate
import com.bourre.commands.Delegate;

//	Event Broadcasting
import com.bourre.events.IEvent;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;

import com.continuityny.usoc.USOC_EventList;
import com.continuityny.usoc.USOC_EventBroadcaster;

import com.bourre.visual.MovieClipHelper;

//	list of Views
import com.continuityny.usoc.USOC_ViewList;
import com.continuityny.usoc.USOC_Site_Model;
import com.continuityny.usoc.views.USOC_Location_View;
import com.continuityny.usoc.views.USOC_Universe_View;
import com.continuityny.usoc.views.USOC_Nav_View;




/**
 * @author Greg
 */
class com.continuityny.usoc.views.USOC_Sound_View extends MovieClipHelper {
	
	
	
	private var MUSIC_FILE_ARRAY:Array;

	private var SOUND_BOARD : MovieClip; 
	private var SOUND_ARRAY : Array; 
	private var SOUND_LOADED_ARRAY : Array;

	private var ALL_LOADED : Boolean = false;

	private var CHECK_INT : Number;

	private var LOADED_COUNT : Number;

	private var FADE_INT : Number;

	private var MAIN_VOLUME : Number = 100;

	private static var MUTED : Boolean = false; 
	
	
		public function USOC_Sound_View( mc ) {
			super( USOC_ViewList.VIEW_SOUND, mc );
			trace("USOC_Sound_View: mc:   eee "+mc);
			
			_init();
			
			
	}
		
		
		
		
		

	
	
	
	public function _init(){
		
		//trace("	MB_Sound_View:Inited");
		
		MUSIC_FILE_ARRAY 	= new Array();
		SOUND_ARRAY 		= new Array(); 
		SOUND_LOADED_ARRAY 	= new Array(); 
		
		MUSIC_FILE_ARRAY["main"] 	= "AmazingAwaits.mp3";
		

		
		SOUND_BOARD = view.createEmptyMovieClip("soundboard_mc", 126003);
		
		
		for (var each : String in MUSIC_FILE_ARRAY) {
			SOUND_LOADED_ARRAY[each] = false; 
		}
		
	//	LOCATION_MANAGER = e.getTarget()[0];
	//	LOCATION_MANAGER.setTarget(TARGET_MC); 
		//loadSounds();
		
	
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
	
	public static function getMute():Boolean{
		return MUTED;	
	}
	
	
	public function soundMute(bool){
		//var bool = e.getTarget();
		trace("USOC_Sound_View:onSoundMute:"+bool);
		MUTED = bool; 
		fadeSound(bool);
	}
	
	
	public function fadeSound(bool){
		trace("fadeSound:"+bool);
		if(bool){
			fadeDownMusic();
		}else if(!bool){
			
			var video_playing : Boolean = USOC_Nav_View( MovieClipHelper.getMovieClipHelper( 
				USOC_ViewList.VIEW_NAV ) ).videoPlaying();
				
			if(!MUTED && !video_playing)fadeUpMusic();
		}
		
	}
	
	

}