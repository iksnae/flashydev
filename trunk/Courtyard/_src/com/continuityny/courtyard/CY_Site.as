
/**
 * @author Greg

 * Based on Francis Bourre FrontController pattern
 * 
 */ 
 
 //	Debug
import com.bourre.log.Logger;
import com.bourre.log.LogLevel;
import com.bourre.utils.LuminicTracer;
//	Views
import com.continuityny.courtyard.views.CY_Nav_View;
import com.continuityny.courtyard.views.CY_Home_View;
//	Controller
import com.continuityny.courtyard.CY_Controller;
//	Models
import com.continuityny.courtyard.CY_Site_Model;
//	Personal EventBroadcaster
import com.continuityny.courtyard.CY_EventBroadcaster;

// Event Broadcasting
import com.bourre.events.IEvent;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;

import com.continuityny.courtyard.CY_EventList;


//	ConfigLoader
import com.bourre.data.libs.ConfigLoader;
import com.bourre.data.libs.XMLToObjectDeserializer;
import com.continuityny.courtyard.views.CY_Location_View;
import com.continuityny.courtyard.views.CY_Sound_View;
import com.continuityny.mc.ImageLoader;
import com.bourre.commands.Delegate;
import com.continuityny.mc.PlayClip;

// da site

class com.continuityny.courtyard.CY_Site extends MovieClip {
	
	
	private static var _config_path : String = "cy_xml/cy_config.xml";
	
	private var _config	: Object;	
	private var _data	: Object;	
	
	private var ModelCY : CY_Site_Model;
	
	private var TARGET_MC:MovieClip;
	private var preloader:MovieClip; 
	
	public function CY_Site( container ) {
				
			container.__proto__ 		= this.__proto__;
			container.__constructor__ 	= CY_Site;
			this 						= container;
			
			
			// Code to make Compnents work
			//this._lockroot = true;
			
			
			XMLToObjectDeserializer.DESERIALIZE_ATTRIBUTES 				= true;
			XMLToObjectDeserializer.PUSHINARRAY_IDENTICAL_NODE_NAMES 	= true;
		
		
			_init();
			_loadConfXML();
			
			_setStyle();
	}
	
	
	
	private function _init( Void ) : Void {
		
		trace("Init CY_Site");
		
		//	init the debugger
		Logger.getInstance().addLogListener( LuminicTracer.getInstance() );
		
		//	create the model
		ModelCY = new CY_Site_Model();
		
		//	init the controller with our custom EventBroadcaster class
		CY_Controller.getInstance( CY_EventBroadcaster.getInstance() );
	}
	
	/**
		* Load the config file
		* @param	Void
	*/
	
	
	private function _loadConfXML( Void ) : Void {
		Logger.LOG( "Application :: _loadConf" );
		_config = new Object();
		var _cfLoader : ConfigLoader = new ConfigLoader( _config );
		_cfLoader.addEventListener( ConfigLoader.onLoadInitEVENT, this, _loadData );
		_cfLoader.load(_config_path);
		
	}
	
		

	
	private function _loadData( Void ) : Void {
		
		_data = new Object();
		var _dataLoader : ConfigLoader = new ConfigLoader( _data );
		
		_dataLoader.addEventListener( ConfigLoader.onLoadInitEVENT, this, _build );
		_dataLoader.load(_config.paths.all_data);
		
	}
	
	
	
	
	/* Config Loaded Callback */
	private function _build(){
		
		trace("Site _build:"+_data+" HOME:"+_data.locations.home.loc);
		
		
		var ALL_DATA : Array = [_data, _config];
		
		var vLocationManager  : CY_Location_View = new CY_Location_View (this);
		
		var main : MovieClip = this.createEmptyMovieClip("main_mc", 1000 );
		
		preloader 	= main.attachMovie("mc_preloader", 	"preloader_mc", 9000, {_x:5, _y:75} );
		
		//var main_nav = main.createEmptyMovieClip("nav_mc", 1000 );
		var nav : MovieClip 	= main.attachMovie("mc_nav", 	"nav_mc", 		3000 );
		var details : MovieClip = main.attachMovie("mc_details","details_mc", 	2000, {_x:5, _y:75});
		var video : MovieClip 	= main.attachMovie("mc_video", 	"video_mc", 	1000, {_x:5, _y:75});
		video.mask_mc._x = 970; 
		//nav.attachMovie("mc_bottom_nav", 	"bottom_nav_mc", 2000 );
		
		var vNav  : CY_Nav_View = new CY_Nav_View ( nav, details, video );		
		
		var home : MovieClip = main.createEmptyMovieClip("home_mc", 500 );
		var vHome  : CY_Home_View = new CY_Home_View ( home );	
		
		//var vGalaxy  : CY_Galaxy_View = new CY_Galaxy_View ( galaxy );
		
		var sound : MovieClip = main.createEmptyMovieClip("sound_mc", 1202 );
		var vSound  : CY_Sound_View = new CY_Sound_View ( sound );
		
		
		//	the views are listening to the model
		ModelCY.addListener( vLocationManager );
		ModelCY.addListener( vNav );
		ModelCY.addListener( vHome );
		//ModelUSOC.addListener( vGalaxy );
		ModelCY.addListener( vSound );
		
		
		
		
		CY_EventBroadcaster.getInstance().broadcastEvent( new BasicEvent( CY_EventList.BUILD_SITE, ALL_DATA ) );
		var scope = this; 
		CY_EventBroadcaster.getInstance().broadcastEvent(	new BasicEvent( CY_EventList.SET_LOCATION, 
			["ITS_A_NEW_STAY", 
			Delegate.create(this, preloadStart), 
			Delegate.create(this, preloadDone) ] ));
		
		
		
		//new PlayClip( preloader.anim_mc, 33);
		preloader.whenDone = function(){
			trace("preloadAnimDone");
			CY_EventBroadcaster.getInstance().broadcastEvent( new BasicEvent( CY_EventList.CHANGE_LOCATION, ["home"] ) );
		}
		
		
	}
	
	private function preloadStart(){
		
		new PlayClip( preloader.anim_mc, 33);
		//TODO change to location gotten from URL - or skip preloader altogether
		CY_EventBroadcaster.getInstance().broadcastEvent( new BasicEvent( CY_EventList.LOCATION_ON_ARRIVED, ["home"] ) );
	}
	
	private function preloadDone(){
		
		preloader.removeMovieClip();
		CY_EventBroadcaster.getInstance().broadcastEvent( new BasicEvent( CY_EventList.LOCATION_ON_DEPARTED, ["home"] ) );
		
	}
	
	
	private function _setStyle() : Void {
		
		
		_global.style.setStyle("backgroundColor", 0xF1F6F0);
		_global.style.setStyle("fontSize",  10);
		_global.style.setStyle("embedFonts", true);
		_global.style.setStyle("fontFamily",  "GothamBold");
		_global.style.setStyle("color", 0x5F788C);
		_global.style.setStyle("rollOverColor", 0x9FB6C3);
		_global.style.setStyle("selectionColor", 0x67838F);
		_global.style.setStyle("textRollOverColor", 0xFFFFFF);
		_global.style.setStyle("textSelectedColor", 0xFFFFFF);

		
	}

































}

