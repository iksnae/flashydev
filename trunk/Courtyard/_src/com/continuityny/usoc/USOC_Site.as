
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
import com.continuityny.usoc.views.USOC_Nav_View;
import com.continuityny.usoc.views.USOC_Universe_View;
//	Controller
import com.continuityny.usoc.USOC_Controller;
//	Models
import com.continuityny.usoc.USOC_Site_Model;
//	Personal EventBroadcaster
import com.continuityny.usoc.USOC_EventBroadcaster;

// Event Broadcasting
import com.bourre.events.IEvent;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;

import com.continuityny.usoc.USOC_EventList;


//	ConfigLoader
import com.bourre.data.libs.ConfigLoader;
import com.bourre.data.libs.XMLToObjectDeserializer;
import com.continuityny.usoc.views.USOC_Location_View;
import com.continuityny.usoc.views.USOC_Galaxy_View;
import com.continuityny.usoc.views.USOC_Sound_View;
import com.continuityny.mc.ImageLoader;import com.bourre.commands.Delegate;

// da site

class com.continuityny.usoc.USOC_Site extends MovieClip {
	
	
	private static var _config_path : String = "usoc_xml/usoc_config.xml";
	
	private var _config	: Object;	
	private var _data	: Object;	
	private var ModelUSOC : USOC_Site_Model;
	private var _connections : Object;
	private var _athlete : Object; 
	
	private var TARGET_MC:MovieClip;	private var _nodes : Object;
		public function USOC_Site( container ) {
				
			container.__proto__ 		= this.__proto__;
			container.__constructor__ 	= USOC_Site;
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
		
		trace("Init USOC_Site");
		
		//	init the debugger
		Logger.getInstance().addLogListener( LuminicTracer.getInstance() );
		
		//	create the model
		ModelUSOC = new USOC_Site_Model();
		
		//	init the controller with our custom EventBroadcaster class
		USOC_Controller.getInstance( USOC_EventBroadcaster.getInstance() );
	}
	
	/**
		* Load the config file
		* @param	Void
	*/
	
	
	private function _loadConfXML( Void ) : Void {
		Logger.LOG( "Application :: _loadConf" );
	//	creating the object holding the result for a map
		_config = new Object();
	//	creating the config loader
		var _cfLoader : ConfigLoader = new ConfigLoader( _config );
	//	define the callback once the xml is loaded
		_cfLoader.addEventListener( ConfigLoader.onLoadInitEVENT, this, _loadConnectonsXML );
	//	load by default the "config.xml" file 
		_cfLoader.load(_config_path);
		
	}
	
	private function _loadConnectonsXML( Void ) : Void {
		trace( "Application :: _loadConnectonsXML" );
	//	creating the object holding the result for a map
		_nodes = new Object();
	//	creating the config loader
		var _cfLoader : ConfigLoader = new ConfigLoader( _nodes);
	//	define the callback once the xml is loaded
		_cfLoader.addEventListener( ConfigLoader.onLoadInitEVENT, this, _loadAthleteData );
	//	load by default the "config.xml" file 
		_cfLoader.load(_config.query.connections);
	}
	
	private function _loadAthleteData( Void ) : Void {
		trace("nodes:"+_nodes.nodes);
		trace( "Application :: _loadAthletesData: "+_config.paths.athlete_data );
	//	creating the object holding the result for a map
		_athlete = new Object();
	//	creating the config loader
		var _cfLoader : ConfigLoader = new ConfigLoader( _athlete );
	//	define the callback once the xml is loaded
		_cfLoader.addEventListener( ConfigLoader.onLoadInitEVENT, this, _loadData );
	//	load by default the "config.xml" file 
		_cfLoader.load(_config.paths.athlete_data);
		
		
	}
	
	/*private function _loadNodeCountData( Void ) : Void {
		trace( "Application :: _loadNodeCountData:"+_config.paths.athlete_data );
	//	creating the object holding the result for a map
		_nodes = new Object();
	//	creating the config loader
		var _cfLoader : ConfigLoader = new ConfigLoader( _nodes );
	//	define the callback once the xml is loaded
		_cfLoader.addEventListener( ConfigLoader.onLoadInitEVENT, this, _loadData );
	//	load by default the "config.xml" file 
		_cfLoader.load(_config.query.connections);
		
		
	}*/
	
	private function _loadData( Void ) : Void {
		
		//for (var i : String in _athlete) {
		//	trace( "Application :: _loadData:"+_athlete[i].aid +" i:"+i);
		//}
		
		trace( "Application :: _loadData:"+_athlete.athlete.length +" _athlete.athlete[0].aid:"+_athlete.athlete[0].aid);
		
		_data = new Object();
		var _dataLoader : ConfigLoader = new ConfigLoader( _data );
		
		
		_dataLoader.addEventListener( ConfigLoader.onLoadInitEVENT, this, _build );
		_dataLoader.load(_config.paths.all_data);
		
		
	
		
	}
	
	
	
	
	/* Config Loaded Callback */
	private function _build(){
		
		_data.athlete 	= _athlete.athlete; 
		_data.nodes		= _nodes; 
		trace("Site _build:"+_data+" nodes:"+_nodes.nodes);
		
		//	Instanciating the views
		
		
		
		
		//ModelUSOC.setData( _data );
		
		var galaxy : MovieClip = this.attachMovie("mc_galaxy", "galaxy_mc", 400 );
		
		var ALL_DATA : Array = [_data, _config, _connections];
		
		// SPECIAL CASE - Galaxy swf laods externally. 
		var _swf_mc = galaxy.createEmptyMovieClip("swf_mc", 1100);
		
		var __IL:ImageLoader = new ImageLoader(_swf_mc, "./galaxy.swf?nocache="+random(99999));
		
			// Wait untill galaxy swf loads before we build rest of site. 
		__IL.onLoaded = Delegate.create(this, function(){
			
			var vLocationManager  : USOC_Location_View = new USOC_Location_View (this);
			ModelUSOC.addListener( vLocationManager );
			
				
			var nav : MovieClip = this.createEmptyMovieClip("nav_mc", 1000 );
			nav.attachMovie("mc_nav", 			"top_nav_mc", 1000 );
			nav.attachMovie("mc_bottom_nav", 	"bottom_nav_mc", 2000 );
			
			var vNav  : USOC_Nav_View = new USOC_Nav_View ( nav );		
			
			var universe : MovieClip = this.createEmptyMovieClip("universe_mc", 500 );
			var vUniverse  : USOC_Universe_View = new USOC_Universe_View ( universe );	
			
			
	
			
			var vGalaxy  : USOC_Galaxy_View = new USOC_Galaxy_View ( galaxy );
			
			var sound : MovieClip = this.createEmptyMovieClip("sound_mc", 1202 );
			var vSound  : USOC_Sound_View = new USOC_Sound_View ( sound );
			
			
			
				
			//	the views are listening to the model
			
			ModelUSOC.addListener( vNav );
			ModelUSOC.addListener( vUniverse );
			ModelUSOC.addListener( vGalaxy );
			ModelUSOC.addListener( vSound );
			
		
			
			USOC_EventBroadcaster.getInstance().broadcastEvent( new BasicEvent( USOC_EventList.BUILD_SITE, ALL_DATA ) );
		
			
		});
		
		
		
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









//TODO

/*
 * 
 * preoader - make pretty - med
 * 
 * universe 
 * - fade in athletes - low
 * - attach network size to databse data
 * - bug: have to click see my chain twice to get into galaxy
 * - transition to galaxy
 * 
 * form
 * - create switch for invited/uninvited path
 * 	- activate pulldown for univited user athete support
 * 
 * uninvited
 * 		- validation code
 * 		- php image process
 * 		- jump back to chain
 * 		- draw in new node (basically a click on last node)
 * 		
 * location manager
 * - handle 'from email' url
 * 		- invited supporter 
 * 			- icode
 * 			- jump to athlete, draw chain
 * 			- open form
 * 	
 * 	- handle link back to your message
 * 		- same as above with no open form
 *  
 *  
 *  galaxy
 *  - add 'sport' to athlete
 *  - enter to athlete
 *  - enter to supporter
 *  - cick to another supporter from athlete
 *  - clik to another suporter from supporter 
 *  
 *  
 *  overall 
 *  - when dowload/video/about/search are clicked
 *  	they will go back to universe and "back to message" node comes up
  * * 
 */
























}

