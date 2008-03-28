/**
 * @author Greg
 */


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

//	MovieClipHelper
import com.bourre.visual.MovieClipHelper;

//	list of Views
import com.continuityny.usoc.USOC_ViewList;
import mx.controls.*;


import com.continuityny.validate.Validate;
import com.continuityny.form.SubmitForm;

import com.robertpenner.easing.*;
import mx.transitions.Tween;
import com.continuityny.timing.PauseMe;
import com.continuityny.usoc.views.USOC_Location_View;
import com.continuityny.usoc.views.USOC_Universe_View;
import com.continuityny.usoc.views.USOC_Galaxy_View;
import mx.video.FLVPlayback;
import com.continuityny.media.FLVPlaybackHandler;
import com.continuityny.mc.ImageLoader;
import com.continuityny.filetransfer.UploadFile;
import com.continuityny.usoc.USOC_ModelList;
import com.continuityny.usoc.USOC_Site_Model;
import com.continuityny.usoc.views.USOC_Sound_View;
import com.continuityny.mc.ImageResizeControls;

import com.bourre.data.libs.ConfigLoader;

import com.asual.swfaddress.SWFAddress;


//class net.webbymx.projects.tutorial01.views.ViewTools
class com.continuityny.usoc.views.USOC_Nav_View 
	extends MovieClipHelper {
/* ****************************************************************************
* PRIVATE VARIABLES
**************************************************************************** */
//	Assets
	private var _txtColor	: TextField;
	
	
	private var _athlete_list 	: List;
	private var _sport_cb 		: ComboBox; 
	
	private var _athlete_form_cb 		: ComboBox; 
	private var _sport_form_list : List;
	
	private var btn_mc	: MovieClip;
	
	private var LAST_ID : Number;

	private var _data : Object;
	private var _config : Object;
	private var _connections : Object ; 
	
	private var ATHLETE_MENU_OPEN : Boolean = false;

	private var sport_cb_listener 		: Object;
	private var athlete_list_listener 	: Object;
	private var form_avatar_listener 	: Object; 
	
	private var FORM_DATA : LoadVars; 
	
	private var ath_menu_min_y  : Number = 576;
	private var ath_menu_max_y 	: Number = 345;
	
	private var static_menu_min_y  : Number = 581;
	private var static_menu_max_y 	: Number = 534;
	
	private var default_duration : Number = .5;

	private var _message_mc		: MovieClip; 
	private var _support_message_mc : MovieClip;
	private var _athleteMenu_mc : MovieClip;
	private var _videoPlayer_mc : MovieClip;
	private var _staticMenu_mc 	: MovieClip; 
	
	private var _email_txt 		: TextField;
	private var _explore_mc 	: MovieClip; 
	private var _connect_mc 	: MovieClip; 
	private var _downloads_mc 	: MovieClip;
	private var _search_mc 		: MovieClip;	private var _search_field_mc 		: MovieClip;
	private var _form_mc		: MovieClip;
	private var _sound_switch_mc : MovieClip;
	private var _att_mc			: MovieClip;
	private var _omega_mc		: MovieClip; 
	private var _flvPlayback	: FLVPlayback;
	private var _about_mc		: MovieClip;
	private var UPLOADER 		: UploadFile; 
	private var RESIZER 		: ImageResizeControls;
	
	private var VIDEO_HANDLER	:FLVPlaybackHandler;
	
	private var VIDEO_PATH		:String = "flv/usoc_high.flv";
	
	private var INT : Number;
	private var INT2 : Number;

	private var form_ath_cb_listener : Object;

	
	private var _gothamBold:TextFormat;

	private var _form_field_array:Array = [];
	
	private var PERSISTANT_DATA;
	
	
	private var _SEARCH_RESULTS:Object;
	
	/* ****************************************************************************
* CONSTRUCTOR
**************************************************************************** */
	function USOC_Nav_View( mc : MovieClip ) {
		super( USOC_ViewList.VIEW_NAV, mc );
		trace("View: mc:"+mc);
		
		_init();
	}
	
	
/* ****************************************************************************
* PRIVATE FUNCTIONS
**************************************************************************** */
/**
* Init the view
* @param	Void
*/
	private function _init( Void ) : Void {
	//	Position this Views main MovieClip
		view._x = 0;
		view._y = 0;
	
	//	init var, assets, events, ...
		_message_mc			= view.top_nav_mc.athlete_mc.bubble_mc;
		_athleteMenu_mc 	= view.bottom_nav_mc.athlete_menu_mc;
		_videoPlayer_mc		= view.top_nav_mc.video_mc;
		_staticMenu_mc 		= view.bottom_nav_mc.static_menu_mc; 
		_explore_mc			= view.top_nav_mc.explore_mc;
		_connect_mc			= view.top_nav_mc.connect_mc;
		_downloads_mc		= view.top_nav_mc.downloads_mc;
		_search_mc			= view.top_nav_mc.search_panel_mc;
		_form_mc 			= view.top_nav_mc.form_mc;
		_email_txt 			= view.top_nav_mc.search_mc.email_txt;
		_sound_switch_mc	= view.bottom_nav_mc.bot_links_mc.sound_mc.switch_mc;
		_att_mc 			= view.bottom_nav_mc.bot_links_mc.sponsors_mc.att_mc;
		_omega_mc 			= view.bottom_nav_mc.bot_links_mc.sponsors_mc.omega_mc;
		_about_mc			= view.top_nav_mc.about_mc;
		_flvPlayback		= _videoPlayer_mc._flvPlayback;
		
		_athlete_form_cb	= view.form_mc.athletes_cb;
	//	Mouse events
			
	
	//init listeners
		sport_cb_listener 		= new Object();
		athlete_list_listener 	= new Object();
		form_avatar_listener 	= new Object(); 
		form_ath_cb_listener	= new Object();
		
		_athleteMenu_mc.swapDepths(6500);
		view.bottom_nav_mc.bottom_mc.swapDepths(6750);
		
		_athleteMenu_mc.setMask(view.bottom_nav_mc.menu_mask_mc);
		_staticMenu_mc.setMask(view.bottom_nav_mc.static_menu_mask_mc);
		
		_staticMenu_mc._y = static_menu_min_y;
		
		_gothamBold = new TextFormat("GothamBold", 11, 0x5F788C);
		
		
		/*TextField.prototype.selectAll = function(delay){
			if (delay){
				//trace("selectAll:"+delay);
				var tf = this;
				var ID = setInterval(function(){
					Selection.setFocus(tf);
					Selection.setSelection(0,tf.length);
					clearInterval(ID);
				}, delay);
			}else{
				//trace("selectAll:");
				Selection.setFocus(this);
				Selection.setSelection(0,this.length);
			}				  
		}
		
		
		
		var mouse_listener = new Object();
		
		mouse_listener.onMouseDown = mouse_listener.onMouseUp = Delegate.create(this, function(){
				//trace("oMouseDown:");
			var hitpoint:Object = new Object();
			hitpoint.x = view._xmouse;
			hitpoint.y = view._ymouse;
			view.localToGlobal(hitpoint);
	
			for(var each in _form_field_array){
				var this_form:TextField = _form_field_array[each];
					//trace("this_form:"+this_form+" x:"+view._xmouse+" y:"+view._ymouse);
				
			
				
				this_form.onSetFocus = function(oldFocus:Object) {
					//trace("setFocus");
					this.selectAll(100);
				}
				
				
				
			}
			
		});
		
		Mouse.addListener(mouse_listener);
		*/
		
		_form_field_array.push(_email_txt);
		_form_field_array.push(_form_mc.upload_txt);
		_form_field_array.push(_form_mc.name_ti);
		_form_field_array.push(_form_mc.location_ti);
		_form_field_array.push(_form_mc.email_ti);
		_form_field_array.push(_form_mc.message_ta);
		
		
		_form_mc.upload_txt.tabIndex = 1; 
		_form_mc.name_ti.tabIndex = 2; 
		_form_mc.location_ti.tabIndex = 3; 
		_form_mc.email_ti.tabIndex = 4; 
		_form_mc.message_ta.tabIndex = 5; 
		
		
		setFormFieldFocusAction();
		
	}

	
	private function setFormFieldFocusAction(){
		
		
		_search_mc.createTextField("hold_txt", 123567, -1000, -1000, 1, 1)
		
		for(var each in _form_field_array){
			
			var _txt:TextField = _form_field_array[each];
			
			_txt.onSetFocus = function(){
				if(!this.impure){
					this.default_text = this.text ;
					this.text = "" ;
				}
					
			}
	
			_txt.onKillFocus = function(){
				
				//Selection.setFocus(_search_mc.hold_txt);
				//_search_mc.hold_txt.setFocus();
				
				if(!this.impure){
					this.text = this.default_text ;
				}
			}
			
			_txt.onChanged = function(){
					this.impure = true ;
			}
			
		}
		
	}

/**
* Broadcast the event
* @usage	_fireEvent( new BasicEvent( EventList.MYTYPE, Object ) );
* @param	e
*/
	private function _fireEvent( e : IEvent ) : Void {
		trace("fire event: "+e);
		USOC_EventBroadcaster.getInstance().broadcastEvent( e );
	}


	public function _build( e : IEvent ){
		
		trace("Nav _build");
		// _data = e.getTarget();
		
		_data = USOC_Site_Model.getData();
		_config = USOC_Site_Model.getConfig();
		_connections = USOC_Site_Model.getConnections();
		
		// Set all Locations with name string and arrival and departure functions
		
		this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["universe,video", 	Delegate.create(this,activateVideoPlayer),  
						Delegate.create(this,removeVideoPlayer),
						Delegate.create(this,videoOnArrive),
						Delegate.create(this,videoOnDepart)
						] ) );
						
		this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["galaxy,video", 	Delegate.create(this,activateVideoPlayer),  
						Delegate.create(this,removeVideoPlayer),
						Delegate.create(this,videoOnArrive),
						Delegate.create(this,videoOnDepart)
						] ) );
		
		
		this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["universe,welcome", Delegate.create(this,activateWelcome),  Delegate.create(this,removeWelcome)] ) );
		
		this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["galaxy,welcome", Delegate.create(this,activateWelcome),  Delegate.create(this,removeWelcome)] ) );
		
		
		/*this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["universe,athlete", Delegate.create(this,selectAthlete),  Delegate.create(this,removeAthleteMessage)] ) );
			*/
		/*this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["galaxy,athlete", Delegate.create(this,selectAthlete),  Delegate.create(this,removeAthleteMessage)] ) );
			*/
		/*this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["galaxy,supporter", Delegate.create(this,makeSupporter),  Delegate.create(this,removeSupporterMessage)] ) );
		*/	
		this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["universe,downloads", Delegate.create(this,activateDownloads),  Delegate.create(this,removeDownloads)] ) );
	
		this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["galaxy,downloads", Delegate.create(this,activateDownloads),  Delegate.create(this,removeDownloads)] ) );
	
	
		this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["universe,search", Delegate.create(this,activateSearch),  Delegate.create(this,removeSearch)] ) );
			
		this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["galaxy,search", Delegate.create(this,activateSearch),  Delegate.create(this,removeSearch)] ) );
			
	
		/*this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["galaxy,connect", Delegate.create(this,activateForm),  Delegate.create(this,removeForm)] ) );
		*/
		
		this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["galaxy,form", Delegate.create(this,activateForm),  Delegate.create(this,removeForm)] ) );
		
			

		_omega_mc.onRelease = Delegate.create(this,function(){
			
			var url = _config.paths.omega;
			getURL(url, "_BLANK");	
		});
		
		_att_mc.onRelease = Delegate.create(this,function(){
			
			var url = _config.paths.att;
			getURL(url, "_BLANK");	
		});
		
		
		// create athlete locations 
		/*var athletes_data = _data.athlete; 
		for (var i : Number = 0; i < (athletes_data.length); i++) {
			
			var loc = "universe,athlete,"+athletes_data[i].uid;
			this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
				[loc, Delegate.create(this,selectAthlete),  Delegate.create(this,removeAthleteMessage)] ) );
		}*/

		/*var sel_listener = new Object();
		_email_ti.onSetFocus = function(){
			trace("focus email_ti");	
			Selection.setSelection(0, this.text.length);
		}
		Selection.addListener(sel_listener);*/
		
		
		
		buildFrame();
		buildSearch();
		
		buildAthleteMenu();
		
		activateMenus();
		
		INT = setInterval(Delegate.create(this, function(){
			this.activateStaticNav();
			clearInterval(this.INT);
			
			USOC_Universe_View( MovieClipHelper.getMovieClipHelper( USOC_ViewList.VIEW_UNIVERSE ) ).populate();
			
		}), 1000);
		
	
		
		_sound_switch_mc.onRelease = Delegate.create(this, function(){
			
			// if(this._currentframe == 1){
			trace("USOC_Sound_View.getMute():"+USOC_Sound_View.getMute());
			
			if(!USOC_Sound_View.getMute()) {
				trace("mute sound");
				/*this.gotoAndStop(2);
				USOC_Sound_View( MovieClipHelper.getMovieClipHelper( 
				USOC_ViewList.VIEW_SOUND ) ).soundMute(true);*/
				
				this._fireEvent(	new BasicEvent( USOC_EventList.MUTE_SOUND, [true] ) );
				
				
			}else{
				trace("unmute sound");
				/*this.gotoAndStop(1);
				USOC_Sound_View( MovieClipHelper.getMovieClipHelper( 
				USOC_ViewList.VIEW_SOUND ) ).soundMute(false);*/
				
				this._fireEvent(	new BasicEvent( USOC_EventList.MUTE_SOUND, [false] ) );
			}
				
				
		});
		
		
		
		var spacing_fmt:TextFormat = new TextFormat();
		spacing_fmt.letterSpacing = 5.7;
		spacing_fmt.font = "VerdanaBold";
		
		var _txt:TextField = view.bottom_nav_mc.bot_bar_mc.con_mc.box_txt; 
		_txt.text = _data.nodes.nodes;
		_txt.setTextFormat(spacing_fmt);
		
	}
	
	
	
	public function soundMute(bool){
		if(bool){
			_sound_switch_mc.gotoAndStop(2);
			_flvPlayback.volume = 0;
		}else{
			_sound_switch_mc.gotoAndStop(1);
			_flvPlayback.volume = 100;
		}
	}
	
	
	public function videoPlaying():Boolean{
		trace("_flvPlayback.playing:"+_flvPlayback.playing);
		return _flvPlayback.playing;
	}

	
	
	private function videoOnArrive(){
		trace("videoOnArrive");
		
		USOC_Sound_View( MovieClipHelper.getMovieClipHelper( 
				USOC_ViewList.VIEW_SOUND ) ).fadeSound(true);
	}	
	
	private function videoOnDepart(){
		trace("videoOnDepart");
		USOC_Sound_View( MovieClipHelper.getMovieClipHelper( 
				USOC_ViewList.VIEW_SOUND ) ).fadeSound(false);
	}	
	
	/*public function setMessage( d ) : Void {
		
		var data = d;
		
		trace("setMessage:"+data.uid);
	
		var id = data.uid;
		var base_loc:String = USOC_Location_View.getBaseLiveLocation(); 
		
		
		if(base_loc == "universe"){
			var x = data["galaxy_mc"]._x ;
			var y = data["galaxy_mc"]._y ;
		
		}else if(base_loc == "galaxy"){
			var x = 400 ;
			var y = 300 ;
		}
		
		view.top_nav_mc["athlete_mc"].removeMovieClip();
		view.top_nav_mc.attachMovie("mc_wire_athlete", "athlete_mc", 6000, {_x:x, _y:y});
		
		_message_mc = view.top_nav_mc["athlete_mc"].bubble_mc;
		
		_message_mc.mess_txt.text 		= data.message;
		_message_mc.name_txt.text 		= data.firstname + " "+data.lastname;
		_message_mc.connect_txt.text 	= data.network;
		_message_mc.id_txt.text = data.aid;
		
		_message_mc.browse_btn.onRelease 	= Delegate.create(this, 
			_fireEvent, new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["galaxy,athlete", data]) );
		
		_message_mc.support_btn.onRelease 	= Delegate.create(this, 
			_fireEvent, new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["connect", data]) );
			
		
			//_message_mc.browse_btn._visible = false;
		
		closeAthleteMenu();
	
	}*/
	
	
	
	/*private function removeAthleteMessage(){
			
			var sub_loc = USOC_Location_View.getSubLiveLocation(); 
			trace("sub_loc:"+sub_loc);
			
			if(sub_loc != "supporter"){
				view.top_nav_mc.athlete_mc.removeMovieClip();
			}
			
			
			this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_DEPARTED, ["athlete"]) );
	}*/
	
	
	
	/*public function setSupporterMessage( d ) : Void {
		
		var data = d;
		
		trace("setSupporterMessage:"+data["_mc"]._x);
	
		var id = data.uid;
		
		var x = data["_mc"]._x ;
		var y = data["_mc"]._y ;
		
		
		view.top_nav_mc["supporter_mc"].removeMovieClip();
		view.top_nav_mc.attachMovie("mc_wire_athlete", "supporter_mc", 7000, {_x:x, _y:y});
		
		_support_message_mc = view.top_nav_mc["supporter_mc"].bubble_mc;
		view.top_nav_mc["supporter_mc"]._x = x;
		view.top_nav_mc["supporter_mc"]._y = y; 
		_support_message_mc.mess_txt.text 		= "supporter";
		_support_message_mc.name_txt.text 		= data.firstname + " "+data.lastname;
		_support_message_mc.connect_txt.text 	= data.network;
		_support_message_mc.id_txt.text = data.uid;
		
		
		_support_message_mc.support_btn.onRelease 	= Delegate.create(this, 
			_fireEvent, new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["connect", id]) );
			

	}*/
	
	
	
	
	private function makeSupporter(data) : Void {
		trace("make supporter:"+data);
		//setSupporterMessage(data);
		
	}
	
	
	
	
	
	/*private function removeSupporterMessage() : Void {
		
		
		view.top_nav_mc["supporter_mc"].removeMovieClip();
		
		var sub_loc = USOC_Location_View.getSubLiveLocation(); 
		if(sub_loc != "supporter"){
			view.top_nav_mc.athlete_mc.removeMovieClip();
		}
		
		
		this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_DEPARTED, ["galaxy,supporter"]) );
	
	}*/
	
	
	

	private function buildFrame() : Void {
		
	}

	private function buildSearch() : Void {
		
	}


	private function buildAthleteMenu() : Void {
			
		
		var athletes_data 	= _data.athlete;  
		var sport_data 		= _data.sport; 
		
		_sport_cb 		= _athleteMenu_mc.createClassObject(ComboBox, "sport_cb", 10);
		_athlete_list 	= _athleteMenu_mc.createClassObject(List, "athlete_list", 20);
		
		
		// for form
		//TODO - move to form method
		
		
		_sport_cb.setSize(200); 
		_sport_cb._x = 5; 
		_sport_cb._y = 7;
		_athlete_list.setSize(200, 165); 
		_athlete_list._x = 5; 
		_athlete_list._y = 35; 
		
		var view_all_btn:MovieClip = _athleteMenu_mc.attachMovie("butEmpty","view_all_mc",100,{_x:10, _y:205});
		view_all_btn.updateButton("BROWSE ALL ATHLETES",190,18,9);
		//close_btn.setGraphic("leftSide", 3); // x
		view_all_btn.onRelease 	= Delegate.create(this, function(){
			this._fireEvent(new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["universe"]) );
			closeAthleteMenu();
		});
		
		populateAthletesBySport({data:"all"});
		
		// "Entire US Olympic Team" 
		_sport_cb.addItem({label:"- SELECT BY SPORT -"});
		_sport_cb.addItem({data:"all", label:"List All Athletes"});
		
		// POPULATE SPORTS
		for (var i : Number = 0; i < (sport_data.length); i++) {
				
				var name 				= 	sport_data[i].xlabel;
				var sport_athlete_data 	= 	sport_data[i]; // all athletes data for this sport
				
				//trace("name::"+name+" sport_data[i]:"+sport_data[i].athlete[0].aid);
				
				_sport_cb.addItem({data:sport_athlete_data, label:name});
				_sport_form_list.addItem({data:sport_athlete_data.uid, label:name}); //TODO - move to form
				/*if(sport_data[i].uid == "008"){
					
				}*/
				
				view._parent._cb.addItem({data:sport_athlete_data, label:name});
		}
		
		trace("combobox:"+_sport_cb.length);
		//_sport_cb.open();
		
		
		// SELECT SPORT HANDLING
		sport_cb_listener.change = Delegate.create(this, change_sport);
		_sport_cb.addEventListener("change", sport_cb_listener);
		

		// SELECT ATHLETE HANDLING
		athlete_list_listener.change = Delegate.create(this, select_athlete);
		_athlete_list.addEventListener("change", athlete_list_listener);
		
		
		
	}
	
	
	
	// HANDLERS (this view) ***************************************
	private function select_athlete(evt_obj:Object):Void {
		
			var selected:Object = evt_obj.target.selectedItem;
			var this_mc;
			// var data = new Array("athlete", selected.data, this_mc);
			
			//var data = new Array("galaxy", selected.data);
			
			this._fireEvent(new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["galaxy,athlete", selected.data]) );
			
		 	//var selected:Object = evt_obj.target.selectedItem;
		 	//trace("Athlete id:"+selected.data.uid);
		 	
		 	USOC_Galaxy_View( MovieClipHelper.getMovieClipHelper( USOC_ViewList.VIEW_GALAXY) ).view._visible = true;
		 	USOC_Universe_View( MovieClipHelper.getMovieClipHelper( USOC_ViewList.VIEW_UNIVERSE ) ).view._visible = false;
		 	//var this_mc;
		 	//var data = new Array(selected.data, this_mc);
		 	//this._fireEvent(new BasicEvent( USOC_EventList.SELECT_ATHLETE, data) );
		 	
	};
	
	
	private function change_sport(evt_obj:Object):Void  {
		 	var selected = evt_obj.target.selectedItem;
		 	trace("handler selected:"+selected.data.athlete[0].uid);
		 	this.populateAthletesBySport(selected);
	};
		
	
	private function select_avatar(evt_obj:Object):Void  {
		 	
		 	var selected = evt_obj.target.selectedItem;
		 	trace("select_avatar:"+selected.data);
		 	
		 	FORM_DATA.avatar_id = selected.data;
		 	
		 	
		 	
		 	loadAvatar(selected.data, false);
		 	//this.populateAthletesBySport(selected);
	};
	
	
	private function loadAvatar(d, upload:Boolean){
		
		trace("load avatar:"+d);
		
		var _mc : MovieClip = _form_mc.avatar_mc.img_mc.img_mc;
		_form_mc.upload_txt.text = "";
		
//		##     image (posted image file that is jpeg, bmp, gif or png)
//		##     xoffset (upper left corner x of crop)
//		##     yoffset (upper left corner y of crop)
//		##     scale   (positive number to scale down (eg, 2 = make halfsize))
//		##
//		##     OR
//		##     img_num (Use 0-4 to pick a default image instead of uploading)
		
		_form_mc.avatar_mc.img_mc._width 	= _form_mc.avatar_mc.img_mc._height = 120;
		_form_mc.avatar_mc.img_mc._y 		= _form_mc.avatar_mc.img_mc._x = -2;
		_form_mc.avatar_mc.img_mc._alpha = 0;
		
		_form_mc.avatar_mc.status_mc.gotoAndStop(2);
		
		if(upload){
			
			_form_mc.controls_mc._visible = true; 
			
			RESIZER._init();
			
			trace("loadAvatar upload");
			var il = new ImageLoader(_mc, d);
			
			FORM_DATA.avatar = d;
			FORM_DATA.avatar_id = "upload";
			
			il.onLoaded = Delegate.create(this, function(){
					var _size : Number	= 120;
					var img_mc : MovieClip = _form_mc.avatar_mc.img_mc;
					img_mc._x = img_mc._y = 0;
				
			var tw = new Tween(img_mc, "_alpha", Quad.easeOut, img_mc._alpha, 100, .5, true);
					
					//trace("img_mc._width:"+img_mc._width+"img_mc._height:"+img_mc._height);
					if(img_mc._width >= img_mc._height){
						var h = img_mc._height;
						img_mc._height = _size;
						img_mc._width = (img_mc._width*_size)/h;
					
					}else if(img_mc._width < img_mc._height){
						var w = img_mc._width;
						img_mc._width = _size;
						img_mc._height = (img_mc._height*_size)/w;
					}
			});
		
		}else{
			trace("loadAvatar sport");
			RESIZER.kill();
			_form_mc.controls_mc._visible = false; 
			
			var il = new ImageLoader(_mc, "sports/sport_"+d+".jpg");
			il.onLoaded = Delegate.create(this, function(){
				var img_mc : MovieClip = _form_mc.avatar_mc.img_mc;
				var tw = new Tween(img_mc, "_alpha", Quad.easeOut, img_mc._alpha, 100, .5, true);
				img_mc._width 	= img_mc._height = 120;
				img_mc._y 		= img_mc._x = -2;
			});
			
			FORM_DATA.avatar = "sports/sport_"+d+".jpg";
			
		}
		
		
	}
	
	
	
	
	
	
	// SITE EVENT HANDLERS *****************************************
	public function selectAthlete( data ){
		trace("setMessage");
		
		//setMessage(data);
		
	}
	
	
	
	
	
	
	// Athlete ComboBox Menu
	private function populateAthletesBySport(selected){
		
		var athletes_data ; 
		var data 	;
		var name 	: String;
		
		
		
		var athletes_data 	= _data.athlete; 
		var sport_data 		= _data.sport; 
		
		_athlete_list.removeAll();
		
		
		for (var i : Number = 0; i < (athletes_data.length); i++) {
			
			if( (selected.data.uid == athletes_data[i].sid) || (selected.data == "all") ){
				
				data = athletes_data[i];
				name = athletes_data[i].firstname + " " + athletes_data[i].lastname
				
				_athlete_list.addItem({data:data, label:name});
			}
			
		}
		
		
		
		
	}
	
	
	
	private function attachFormAthleteName(d:Object){
		
		var str:String = "You are supporting "+d.athlete_name+".";
		
		var ath_name_txt:TextField = _form_mc.createTextField( "ath_name_txt", 2000, 131, 41, 400, 20);
		ath_name_txt.text = str;
		ath_name_txt.selectable = false;
		ath_name_txt.embedFonts = true;
		ath_name_txt.setTextFormat(_gothamBold);
		
		
	}
	
	private function removeFormAthleteName(){
		_form_mc.ath_name_txt.removeTextField();
		
		
	}
	
	private function populateFormAthleteCB(selected){
		
		var athletes_data ; 
		var data 	;
		var name 	: String;
		
		if(_form_mc.athletes_cb == undefined){
			_athlete_form_cb = _form_mc.createClassObject(ComboBox, "athletes_cb", 10);
			_athlete_form_cb._x = 131; 
			_athlete_form_cb._y = 41; 
			_athlete_form_cb.setSize(240); 
			// 130, 40
			
			
			athletes_data = _data.athlete;  
			_athlete_form_cb.removeAll();
			_athlete_form_cb.addItem({data:"team", label:"Select an Athlete to Support"});
			
			for (var i : Number = 0; i < (athletes_data.length); i++) {
					
					
					data 	= 	athletes_data[i].aid;
					name 	= 	athletes_data[i].firstname + " " + athletes_data[i].lastname;
					
					// trace("athlete_form_cb name:"+name);
					_athlete_form_cb.addItem({data:data, label:name});
			}
			
			
			// SELECT ATHLETE FORM HANDLING
			form_ath_cb_listener.change = Delegate.create(this, change_form_athlete);
			_athlete_form_cb.addEventListener("change", form_ath_cb_listener);
		}else{
			
			_athlete_form_cb._visible = true; 	
			_athlete_form_cb.selectedIndex = 0; 
		}
	}
	
	
	private function setSupporterAthlete(aid){
		
		trace("setSupporterAthlete:SELECTED_AID - "+USOC_Galaxy_View.SELECTED_AID+" :"+_athlete_form_cb.length); 
		
		if(_athlete_form_cb.length != undefined){ // infinte loop safeguard
		
		
			for(var i = 0;  i <= _athlete_form_cb.length; i++){
				trace("setSupporterAthlete data:"+_athlete_form_cb.getItemAt(i).data+" i:"+i);
				if(_athlete_form_cb.getItemAt(i).data == USOC_Galaxy_View.SELECTED_AID){
					_athlete_form_cb.selectedIndex = i; 
					
					break;	
				} 
			}
		}
		
		
	}
	
	private function change_form_athlete(evt_obj:Object):Void  {
		 	
		 	var selected = evt_obj.target.selectedItem;
		 	trace("change_form_athlete:"+selected.data+ " name:"+selected.label);
		 	
		 	FORM_DATA.support_aid 	= selected.data;
		 	//FORM_DATA.athlete_id 	= selected.data;
		 	FORM_DATA.athlete_name 	= selected.label;
		 	
		 //	this.populateAthletesBySport(selected);
	};
	
	
	
	private function activateMenus() : Void {
	
		var t = default_duration; 
		
		
		_athleteMenu_mc.handle_mc.onPress = Delegate.create(this, function(){
			
				var _mc : MovieClip = _athleteMenu_mc;
				_mc.startDrag(false, 23, this.ath_menu_max_y, 23, this.ath_menu_min_y);
		});
		
		_athleteMenu_mc.handle_mc.onReleaseOutside =
		_athleteMenu_mc.handle_mc.onRelease = Delegate.create(this, function(){
		
			var _mc = _athleteMenu_mc;
				_mc.stopDrag();
			
			if(this.ATHLETE_MENU_OPEN){
				this.closeAthleteMenu();
			}else{
				var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, this.ath_menu_max_y, t, true);
				this.ATHLETE_MENU_OPEN = true;
			}	
		});
	}
	
	
	
	public function closeAthleteMenu(){
		
		var t = default_duration; 
		var _mc = _athleteMenu_mc;
		var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, ath_menu_min_y, t, true);
		ATHLETE_MENU_OPEN = false;
	}
	
	


	// video methods
	public function activateVideoPlayer() : Void {
		
		trace("activateVideoPlayer");
		var my_so:SharedObject = SharedObject.getLocal("video_cookie");
		
		
		
		var t = default_duration; 
		var _mc : MovieClip = _videoPlayer_mc;
		var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, _data.video.y, t, true);
		
		if(my_so.data.watched){
			var close_btn:MovieClip = _mc.attachMovie("butEmpty","close_mc",5000,{_x:720, _y:75});
			close_btn.updateButton("",16,16,9);
			close_btn.setGraphic("leftSide", 3); // x
		}
		
		var prop_obj = {_x:150, _y:100, _width:590, _height:333}; 
		_videoPlayer_mc.attachMovie("FLVPlayback", "_flvPlayback", 100, prop_obj);
		
		_flvPlayback 				= _videoPlayer_mc["_flvPlayback"];
		_flvPlayback.skin 			= _config.paths.videoskin;
		_flvPlayback.bufferTime 	= 10; 
		_flvPlayback.skinAutoHide 	= false; 
		
		if(USOC_Sound_View.getMute()){
			_flvPlayback.volume = 0; 
		}else{
			_flvPlayback.volume = 100; 
		}
		
		_videoPlayer_mc.header1_txt.text = _data.video.header1; 
		_videoPlayer_mc.header2_txt.text = _data.video.header2;
		
		VIDEO_HANDLER = new FLVPlaybackHandler(_flvPlayback, Delegate.create(this, returnToMain));
		
		VIDEO_HANDLER.getPlayer().play(VIDEO_PATH);
		
		
		//_mc._btn.swapDepths(200);
		//_mc._btn.onRelease = Delegate.create(this, videoDone); 
		
		close_btn.onRelease = Delegate.create(this, returnToMain); 
		
		this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_ARRIVED, ["universe,video"]) );
		
		my_so.data.watched = true; // TODO - move this to watched half way later

	}
	
	
	
	private function videoDone(){
			trace("video done");
			
		this._fireEvent(new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["welcome"]) );
		
	}
	
	
	private function removeVideoPlayer() : Void {
		
		trace("removeVideoPlayer");
		var t = default_duration; 
		var _mc : MovieClip = _videoPlayer_mc;
		var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, -700, t, true);
		
		VIDEO_HANDLER.getPlayer().stop();
		_flvPlayback.removeMovieClip();
		
		this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_DEPARTED, ["universe,video"]) );
		
	}
	
	
	
	// Static Nav - (watch video, downloads, view entire universe)
	private function activateStaticNav() : Void {
		// 534, 581
		var t = default_duration; 
		var _mc : MovieClip = _staticMenu_mc;
		var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, static_menu_max_y, t, true);
		
		var base:String = USOC_Location_View.getBaseLiveLocation().split(",").join("");
		
		_mc.video_btn.onRelease 	= Delegate.create(this, callLiveLocation, "video" );
		
		_mc.downloads_btn.onRelease = Delegate.create(this, callLiveLocation, "downloads" );
			
		_mc.about_btn.onRelease 	= Delegate.create(this, callLiveLocation, "welcome" );
			
	
		view.top_nav_mc.search_mc.search_btn.onRelease 	= Delegate.create(this, initSearch);
		
		
		/*_connect_mc._btn.onRelease 	= Delegate.create(this, 
			_fireEvent, new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["connect", {uid:"002"}]) );
		
		_explore_mc._btn.onRelease 	= Delegate.create(this, 
			_fireEvent, new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["universe"]) );*/
		
		//_mc.downloads_btn.onRelease = Delegate.create(this, activateVideoPlayer); 
		//_mc.all_btn.onRelease 		= Delegate.create(this, activateVideoPlayer); 
	}
	
	
	
	private function callLiveLocation(second){
		var base = USOC_Location_View.getBaseLiveLocation().split(",").join("");	
		this._fireEvent(new BasicEvent( USOC_EventList.CHANGE_LOCATION, [base+","+second]) );
	}
	

	private function removeStaticNav() : Void {
		
		var t = default_duration; 
		var _mc : MovieClip = _staticMenu_mc;
		var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, static_menu_min_y, t, true);
	
	}
	
	
	
	private function toDownloadsTransition(){
		
		
		this._fireEvent(new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["universe"]) );
		
			
	}
	
	// Downlaods
	private function activateDownloads(){
		
		trace("activateDownloads");
		var t = default_duration; 
		var _mc : MovieClip = _downloads_mc;
		var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, _data.downloads.y, t, true);
		
		
		var close_btn:MovieClip = _mc.attachMovie("butEmpty","close_mc",5000,{_x:290, _y:5});
		close_btn.updateButton("",16,16,9);
		close_btn.setGraphic("leftSide", 3); // x
		
		close_btn.onRelease = Delegate.create(this, returnToMain);
		
		var left 	= 39; 
		var top 	= 55; 
		
		_downloads_mc.header_txt._x = left; 
		_downloads_mc.header_txt.text = _data.downloads.header;
		
		// 54, 40, 220
		var dl_1_btn:MovieClip = _mc.attachMovie("butEmpty","dl_1_mc",100,{_x:left, _y:top});
		dl_1_btn.updateButton(_data.downloads.d1.label,240,18,9);
		dl_1_btn.onRelease = Delegate.create(this, downloadFile, _data.downloads.d1.file);
		
		var dl_2_btn:MovieClip = _mc.attachMovie("butEmpty","dl_2_mc",200,{_x:left, _y:top+30});
		dl_2_btn.updateButton(_data.downloads.d2.label,240,18,9);
		dl_2_btn.onRelease = Delegate.create(this, downloadFile, _data.downloads.d2.file);
		
		var dl_3_btn:MovieClip = _mc.attachMovie("butEmpty","dl_3_mc",300,{_x:left, _y:top+60});
		dl_3_btn.updateButton(_data.downloads.d3.label,240,18,9);
		dl_3_btn.onRelease = Delegate.create(this, downloadFile, _data.downloads.d3.file);
		
		var dl_4_btn:MovieClip = _mc.attachMovie("butEmpty","dl_4_mc",400,{_x:left, _y:top+90});
		dl_4_btn.updateButton(_data.downloads.d4.label,240,18,9);
		dl_4_btn.onRelease = Delegate.create(this, downloadFile, _data.downloads.d4.file);
		
	}
	
	private function downloadFile(file:String){
		getURL(file,"BLANK");
	}

	private function removeDownloads(){
		trace("removeDownloads");
			var t = default_duration; 
			var _mc : MovieClip = _downloads_mc;
			var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, -233, t, true);
			
			var base = USOC_Location_View.getBaseLiveLocation().split(",").join("");
			this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_DEPARTED, [base+",downloads"]) );
	}
	
	
	private function returnToMain(b){
		
		var base = USOC_Location_View.getBaseLiveLocation().split(",").join("");
		this._fireEvent(new BasicEvent( USOC_EventList.CHANGE_LOCATION, [base]) );
		
		trace("returnToMain: base - "+base);		trace("returnToMain: live - "+USOC_Location_View.getLiveLocation());		trace("returnToMain: arr - "+USOC_Location_View.getArrivingLocation());		trace("returnToMain: sub - "+USOC_Location_View.getSubLiveLocation());
		// SWFAddress.back();
		
	}
	
	private function returnToMain2(b){
		
		SWFAddress.back();
		
	}
	
		// Search
	private function activateSearch(){
		
		trace("activateSearch");
		var t = default_duration; 
		var _mc : MovieClip = _search_mc;
		var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, 130, t, true);
		
		var close_btn:MovieClip = _mc.attachMovie("butEmpty","close_mc",5000,{_x:400, _y:5}); //430
		close_btn.updateButton("",16,16,9);
		close_btn.setGraphic("leftSide", 3); // x
		
		close_btn.onRelease = Delegate.create(this, returnToMain);
		
		_email_txt.impure = false; 
		_email_txt.text = "Enter Email Address"; 
		//nitSearch(_email_txt.text);
		
		Selection.setFocus(_search_mc.hold_txt);
	
	}
	
	private function initSearch(){
		
		trace("search for:"+_email_txt.text);
		
		var addr = _email_txt.text;
		
		var email_valid:Boolean = (Validate.email(addr));
		
		if(email_valid){
			_loadSearchXML(addr);
			
		}else{
			_email_txt.text = "Please enter valid email"; 
		}
	}
	
	
	  private function _loadSearchXML( addr:String ) : Void {
	  	var url:String = _config.query.email_search;
		trace( "Application :: _loadSearchXML:" +_config.query.email_search);
		_SEARCH_RESULTS = new Object();		_SEARCH_RESULTS.addr = addr;
		
		var _cfLoader : ConfigLoader = new ConfigLoader( _SEARCH_RESULTS );
		_cfLoader.addEventListener( ConfigLoader.onLoadInitEVENT, this, searchCallback, addr );
		_cfLoader.load(_config.query.email_search+"?email="+addr);
		
	}
    
	private function loadSearchAvatar(img_src:String){
		
		trace("load search avatar:"+img_src);
		
		var _mc : MovieClip = _search_mc.avatar_mc.img_mc.img_mc;
		
		_search_mc.avatar_mc.img_mc._y 		= _form_mc.avatar_mc.img_mc._x = -2;
		_search_mc.avatar_mc.img_mc._alpha = 0;
		
		_search_mc.avatar_mc.status_mc.gotoAndStop(2);
		
		
			trace("loadAvatar sport");
			RESIZER.kill();
			
			var il = new ImageLoader(_mc, img_src);
			il.onLoaded = Delegate.create(this, function(){
				var img_mc : MovieClip = _search_mc.avatar_mc.img_mc;
				var tw = new Tween(img_mc, "_alpha", Quad.easeOut, img_mc._alpha, 100, .5, true);
				img_mc._y 		= img_mc._x = -2;
			});
			
	}
	
	
	
	private function searchCallback(addr){
		
		
		
		
		var base = USOC_Location_View.getBaseLiveLocation().split(",").join("");
		this._fireEvent(new BasicEvent( USOC_EventList.CHANGE_LOCATION, [base+",search"]) );
		
		_search_mc.prev_btn._visible = false; 
		
		var num_results:Number = _SEARCH_RESULTS.supporter.length; 
		
		trace("searchCallback - length:"+_SEARCH_RESULTS.supporter.length+" - "+_SEARCH_RESULTS.supporter);
		
	//	if(_SEARCH_RESULTS.supporter.length == 0 || _SEARCH_RESULTS.supporter.length == undefined){		if( _SEARCH_RESULTS.supporter.length == undefined){
			
			_SEARCH_RESULTS.supporter = new Array(_SEARCH_RESULTS.supporter); 
			
			trace("searchCallback: createArray:"+_SEARCH_RESULTS.supporter.length);
			var num_results:Number = _SEARCH_RESULTS.supporter.length; 
		}
		
		
		
		trace("searchCallback: supp:length"+num_results+" addr:"+_SEARCH_RESULTS.addr);
		
		_SEARCH_RESULTS.count = 1; 
		
		
		if(_SEARCH_RESULTS.supporter == undefined || (num_results == 0) ){
			
			clearResult();
			trace("no results found for that email address");
			
		}else{
			
			if(num_results == undefined){
				clearResult();
				trace("No result was found for that email address");
			
			}else if(num_results == 1){
				
				_search_mc.next_btn._visible = false; 				_search_mc.prev_btn._visible = false; 
				loadResult(_SEARCH_RESULTS.count);
				
			}else if(num_results > 1){
			
				_search_mc.next_btn._visible = true; 
				
				
				trace(num_results+" results was found for that email address");
				
				
				loadResult(_SEARCH_RESULTS.count);
				
				_search_mc.next_btn.onRelease = 
				_search_mc.next_btn.onReleaseOutside = Delegate.create(this, function(){
				
					loadResult(++_SEARCH_RESULTS.count);
					_search_mc.prev_btn._visible = true; 
					if(_SEARCH_RESULTS.count == num_results){
						_search_mc.next_btn._visible = false; 
					}
					
				});
				
				_search_mc.prev_btn.onRelease = 				_search_mc.prev_btn.onReleaseOutside = Delegate.create(this, function(){
				
					loadResult(--_SEARCH_RESULTS.count);
					_search_mc.next_btn._visible = true; 
					if(_SEARCH_RESULTS.count == 1){
						_search_mc.prev_btn._visible = false; 
					}
					
				});
		
		
				
			}
			
		}
		
	}
	
	
	private function loadResult(r:Number){
		
		trace("loadResult:"+r);
		var n = r-1; 
		
		var supp = _SEARCH_RESULTS.supporter[n];
		 var num_results:Number = _SEARCH_RESULTS.supporter.length; 
		 
		 
		_search_mc.header_txt.text = num_results +" RESULTS FOR "+_SEARCH_RESULTS.addr.toUpperCase(); 
		_search_mc.display_txt.text = "Displaying "+r+" of "+num_results ; 
		_search_mc.name_txt.text = supp.fullname+" - "+supp.location ; 
		_search_mc.message_txt.text = supp.message; 
		_search_mc.connect_txt.text = supp.fullname+" is supporting "+supp.athlete_name; 
		
		loadSearchAvatar(supp.img_src);
		
		_search_mc.jump_btn._visible = true; 
		
		_search_mc.jump_btn.onRelease = Delegate.create(this, function(){
			_email_txt.text = "Enter Email Address"; 
			this._fireEvent(new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["galaxy,supporter",{uid:supp.uid}]) );
		});
		
	}
	
	
	private function clearResult(){
		
		trace("clearResult:");
		
		_search_mc.header_txt.text 	= ""; 
		_search_mc.display_txt.text = "" ; 
		_search_mc.name_txt.text 	= "" ; 
		_search_mc.message_txt.text = ""; 
		_search_mc.connect_txt.text = "There are no results for that email address."; 
		
		
		_search_mc.jump_btn._visible = false; 
		_search_mc.next_btn._visible = false; 
	}
	
	
	private function removeSearch(){
		trace("removeSearch");
			var t = default_duration; 
			var _mc : MovieClip = _search_mc;
			var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, -373, t, true);
			var base = USOC_Location_View.getBaseLiveLocation().split(",").join("");
			this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_DEPARTED, [base+",search"]) );
	}
	
	
	// Form - CONNECT
	private function activateForm(d){
		
		trace("Nav_View: activateForm:uid - "+d.uid);
		trace("Nav_View: activateForm:aid - "+d.aid);
		trace("Nav_View: activateForm:aid - "+d.aid+" length - "+d.length);
		trace("Nav_View: PERSISTANT_DATA:"+PERSISTANT_DATA+" uid:"+PERSISTANT_DATA.uid);
		
		_form_mc.gotoAndStop(1);
		
	//	if(d.icode != undefined){
				
			if(PERSISTANT_DATA == undefined && (d.icode != undefined) ){
				PERSISTANT_DATA 	= d;
				var this_ath_data 	= d; 
			}else{
				var this_ath_data 	= PERSISTANT_DATA;
			}
		
		//}else{
			
		//	var this_ath_data = d;
		//}
		
		var t = default_duration; 
		var _mc : MovieClip = _form_mc;
		var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, 75, t, true);
		
		FORM_DATA = new LoadVars();
		
		if(this_ath_data.icode == undefined ){ // UNINVITED PATH - Team USA
			
			populateFormAthleteCB("all");
			FORM_DATA.invited = false;
			removeFormAthleteName();
			
			FORM_DATA.athlete_id = 0; 
				
		}else{ // INVITED PATH - not Team USA
			
			if(this_ath_data.aid == 0){
				populateFormAthleteCB("all");			}else{
				attachFormAthleteName(this_ath_data);
			}
			
			FORM_DATA.invited = true;
			FORM_DATA.icode = this_ath_data.icode;
			
			FORM_DATA.athlete_id = this_ath_data.aid;
			FORM_DATA.support_aid = this_ath_data.aid;
		
		}
			FORM_DATA.data = this_ath_data; 
			
		_mc.debug_txt.text = "supporting athlete:"+this_ath_data.uid; 
		
		initFormStepOne(this_ath_data);
	}
	
	
	

	
	
	
	private function initFormStepOne(d){
		
		
		// reset form
		_form_mc.gotoAndStop(1);
		_form_mc.controls_mc._visible = false; 
		_form_mc.avatar_mc.status_mc.gotoAndStop(1);
		_form_mc.error_txt.text = "";
		
		

		var plus_btn:MovieClip = _form_mc.controls_mc.attachMovie("butEmpty","plus_btn",100,{_x:8, _y:3});
		plus_btn.setGraphic("leftSide", 4); // +
		plus_btn.updateButton("",16,16,9);
		
		var minus_btn:MovieClip = _form_mc.controls_mc.attachMovie("butEmpty","minus_btn",200,{_x:88, _y:3});
		minus_btn.setGraphic("leftSide", 5); // -
		minus_btn.updateButton("",16,16,9);
		
		var _mc = _form_mc.avatar_mc.img_mc;
		RESIZER = new ImageResizeControls(_mc, _form_mc.controls_mc);
		
		/*Selection.setFocus(_form_mc.message_ta);
		
		var focusListener:Object = new Object();
		focusListener.onSetFocus = function(oldFocus_txt, newFocus_txt) {
		   // oldFocus_txt.border = false;
		    //newFocus_txt.border = true;
		    
		    Selection.setSelection(0, 5);
		};
		
		Selection.addListener(focusListener);
		*/

		
		//Selection.setFocus(_txt);
		//Selection.setSelection(0, 5);
		
		_form_mc.header_txt.text 	= _data.form1.header1;
		_form_mc.instr_txt.text 	= _data.form1.header2;
		_form_mc.instr2_txt.text 	= _data.form1.emaildisplay;
		
		_form_mc.message_ta.text 	= _data.form1.messagedefault;
		_form_mc.location_ti.text	= _data.form1.locationdefault;
		_form_mc.email_ti.text		= _data.form1.emaildefault;
		_form_mc.name_ti.text		= _data.form1.namedefault;
		
		// test data - remove later
		/*_form_mc.message_ta.text 	= "i love lamp";
		_form_mc.location_ti.text	= "new york city";
		_form_mc.email_ti.text		= "greg@pymm.com";
		_form_mc.name_ti.text		= "gregory p.";
		*/
		
		
		_sport_form_list 	= _form_mc.createClassObject(List, "sport_list", 20);
		
		_sport_form_list._x = 9;
		_sport_form_list._y = 213;
		_sport_form_list.setSize(243, 151);
		
		UPLOADER = new UploadFile(_form_mc, Delegate.create(this, loadAvatar));
		
		// POPULATE SPORTS
		var sport_data 		= _data.sport; 
		for (var i : Number = 0; i < (sport_data.length); i++) {
				var name 				= 	sport_data[i].xlabel;
				var sport_athlete_data 	= 	sport_data[i]; // all athletes data for this sport
				//trace("name::"+name+" sport_data[i].uid:"+sport_data[i].uid);
				_sport_form_list.addItem({data:sport_athlete_data.uid, label:name}); 
		}
		
		// SELECT FORM AVATAR HANDLING
		form_avatar_listener.change = Delegate.create(this, select_avatar);
		_sport_form_list.addEventListener("change", form_avatar_listener);
		
		_athlete_form_cb._visible = true; 
		_sport_form_list._visible = true; 
		
		setSupporterAthlete(d.aid); // TODO Put this back
			//_athlete_form_cb.selectedIndex = 10; 
		
		if(FORM_DATA.message != undefined){
			_form_mc.message_ta.text = FORM_DATA.message;
		}
		
		_form_mc.cancel_btn.onRelease = Delegate.create(this, cancelForm);
			
		_form_mc.step2_btn.onRelease = Delegate.create(this, validateStepOne, d ); //_form_mc.gotoAndStop(2);
		
		
		FORM_DATA.icode = d.icode; 
		
		if(d.icode == undefined || (d.icode != undefined && d.aid == 0) ){ 
			FORM_DATA.support_aid 	= _athlete_form_cb.selectedItem.data;
		 	//FORM_DATA.athlete_id 	= selected.data;
			FORM_DATA.athlete_name 	= _athlete_form_cb.selectedItem.label;
		}	
		
	}
	
	private function cancelForm(){
						returnToMain();
						_global._r.galaxyEnabled(true);
						_global._r.unHideMessages();
	}
	
	private function validateStepOne(d){
		
	
		//var validate = new Validate();
		// is not blak.. special cahracters
		///
		var message_valid:Boolean = (Validate.message(_form_mc.message_ta.text))
					&&(Validate.blank(_form_mc.message_ta.text)) && (_form_mc.message_ta.text!=_data.form1.messagedefault);
		
		var name_valid:Boolean = (Validate.message(_form_mc.name_ti.text))
					&&(Validate.blank(_form_mc.name_ti.text))&& (_form_mc.name_ti.text!=_data.form1.namedefault);
					
		var loc_valid:Boolean = (Validate.message(_form_mc.location_ti.text))
					&&(Validate.blank(_form_mc.location_ti.text))&& (_form_mc.location_ti.text!=_data.form1.locationdefault);
					
		var email_valid:Boolean = (Validate.email(_form_mc.email_ti.text))
					&&(Validate.blank(_form_mc.email_ti.text))&& (_form_mc.email_ti.text!=_data.form1.emaildefault);
					
		var avatar_valid:Boolean = (FORM_DATA.avatar_id != undefined); 
		
		//var athlete_valid:Boolean = (FORM_DATA.athlete_id != undefined); 
		var support_valid:Boolean = (FORM_DATA.support_aid != undefined); 
		
		
		if(	message_valid && name_valid	&& loc_valid && email_valid && avatar_valid && support_valid) {
			
			FORM_DATA.uid 			= 	d.uid ;
			FORM_DATA.message 		= _form_mc.message_ta.text; 
			FORM_DATA.name 			= _form_mc.name_ti.text; 	
			FORM_DATA.location 		= _form_mc.location_ti.text; 
			FORM_DATA.email 		= _form_mc.email_ti.text; 
		
			//FORM_DATA.image			= "./upload/"+UPLOADER.getFileName(); 
		
			
			if(FORM_DATA.avatar_id == "upload"){ // uploaded image avatar
				FORM_DATA.image			= "./upload/"+UPLOADER.getFileName(); 
				FORM_DATA.scale 		= RESIZER.getScale();
				FORM_DATA.xoffset 		= RESIZER.getXOffset();
				FORM_DATA.yoffset 		= RESIZER.getYOffset();
				trace("upload scale:"+FORM_DATA.scale+" x:"+FORM_DATA.xoffset+" y:"+FORM_DATA.yoffset);
			
			}else{	// sport avatar
				FORM_DATA.img_num			= FORM_DATA.avatar_id;
			}
			
			initformStepTwo();
			
			
		}else{
		
		_form_mc.error_txt.text = ((!message_valid)		?	"Please enter a valid message.\n"	:"")
								+ ((!name_valid)		?	"Please enter a valid name.\n"	:"")
								+ ((!loc_valid)			?	"Please enter a valid location.\n"	:"")
								+ ((!email_valid)		?	"Please enter a valid email.\n"	:"")
								+ ((!avatar_valid)		?	"Please select a valid avatar.\n"	:"")
								+ ((!support_valid)		?	"Please select an athlete to support.\n" :"")
		}
	}
	private function initformStepTwo(){
		
		_form_mc.gotoAndStop(2);
		
		_athlete_form_cb._visible = false; 
		_sport_form_list._visible = false; 
		
		_form_mc.ath_name_txt.removeTextField();
		
		// 
		
		
		_form_field_array.push(_form_mc.f_email_1_ti);
		_form_field_array.push(_form_mc.f_email_2_ti);
		_form_field_array.push(_form_mc.f_email_3_ti);
		_form_field_array.push(_form_mc.f_email_4_ti);
		_form_field_array.push(_form_mc.f_email_5_ti);
		//_form_field_array.push(_form_mc.email_message_ta);
		
		_form_mc.f_email_1_ti.tabIndex = 1;
		_form_mc.f_email_2_ti.tabIndex = 2;
		_form_mc.f_email_3_ti.tabIndex = 3;
		_form_mc.f_email_4_ti.tabIndex = 4;
		_form_mc.f_email_5_ti.tabIndex = 5;
		_form_mc.email_message_ta.tabIndex = 6;
		
		_form_mc.header_txt.text 	= _data.form2.header1;
		_form_mc.instr_txt.text 	= _data.form2.message;
		_form_mc.email_message_ta.text		= _data.form2.messagedefault;
		
		_form_mc.f_email_1_ti.text	= _data.form2.emaildefault1;
		_form_mc.f_email_2_ti.text	= _data.form2.emaildefault2;
		_form_mc.f_email_3_ti.text	= _data.form2.emaildefault3;
		_form_mc.f_email_4_ti.text	= _data.form2.emaildefault4;
		_form_mc.f_email_5_ti.text	= _data.form2.emaildefault5;
		
		_form_mc.athlete_txt.text 	= "You are supporting "+FORM_DATA.athlete_name; 
		_form_mc.message_txt.text 	= FORM_DATA.message; 
		_form_mc.name_txt.text	 	= FORM_DATA.your_name; 
		
		
		setFormFieldFocusAction();
		//test data - remove later
		/*	
		_form_mc.f_email_1_ti.text	= "gregs_friend@email.com";
		_form_mc.f_email_2_ti.text	= "gregs_other_friend@email.com";
		
		_form_mc.email_message_ta.text 	= "do you also love lamp?"; 
		*/
		
		_form_mc.step3_btn.onRelease 	= Delegate.create(this, validateStepTwo); 
		_form_mc.back_btn.onRelease 	= Delegate.create(this, initFormStepOne); 
		
	}
	
	private function validateStepTwo(){
		
		
		var message_valid:Boolean = (Validate.message(_form_mc.email_message_ta.text))
					&&(Validate.blank(_form_mc.email_message_ta.text));
	
		var email_1_valid:Boolean = (Validate.email(_form_mc.f_email_1_ti.text))
					&&(Validate.blank(_form_mc.f_email_1_ti.text))&& (_form_mc.f_email_1_ti.text!=_data.form2.emaildefault1);
		
		var email_2_valid:Boolean = (Validate.email(_form_mc.f_email_2_ti.text))
					&&(Validate.blank(_form_mc.f_email_2_ti.text))&& (_form_mc.f_email_2_ti.text!=_data.form2.emaildefault2);
		
		if((_form_mc.f_email_3_ti.text!=_data.form2.emaildefault3) && _form_mc.f_email_3_ti.text!=""){
			var email_3_valid:Boolean = (Validate.email(_form_mc.f_email_3_ti.text));
		}else{
			var email_3_valid:Boolean = true;
		}
		
		if((_form_mc.f_email_4_ti.text!=_data.form2.emaildefault4)&& _form_mc.f_email_4_ti.text!=""){
			var email_4_valid:Boolean = (Validate.email(_form_mc.f_email_4_ti.text));
		}else{
			var email_4_valid:Boolean = true;
		}
		
		if((_form_mc.f_email_5_ti.text!=_data.form2.emaildefault5)&& _form_mc.f_email_5_ti.text!=""){
			var email_5_valid:Boolean = (Validate.email(_form_mc.f_email_5_ti.text));
		}else{
			var email_5_valid:Boolean = true;
		}
		
		
		if(message_valid&&email_1_valid&&email_2_valid&&email_3_valid&&email_4_valid&&email_5_valid){
			
			FORM_DATA.to_email1 	= _form_mc.f_email_1_ti.text; 
			FORM_DATA.to_email2 	= _form_mc.f_email_2_ti.text; 
			FORM_DATA.to_email3 	= _form_mc.f_email_3_ti.text; 
			FORM_DATA.to_email4 	= _form_mc.f_email_4_ti.text; 
			FORM_DATA.to_email5 	= _form_mc.f_email_5_ti.text; 	
			FORM_DATA.email_message = _form_mc.email_message_ta.text; 
		
			//FORM_DATA.icode			=	"ABC123"; // set earlier
			//initformStepThree();
			
			//FORM_DATA.support_aid = 1;
			
			if(FORM_DATA.invited == true){
				var url:String = _config.query.add_supporter;
			}else{
				var url:String = _config.query.add_nofriend_supporter;
			}
			
			trace("validate url:"+url);
			
			var callback:Function = Delegate.create(this, form2Callback);
			new SubmitForm(url, FORM_DATA, "GET", callback);
			
			
			//?uid=5&name=Johnny&location=New+York&message=HEY&email=brian%40wholok.com&email_message=DOIT&to_email1=wholok%40gmail.com&to_email2=bseitz%40acm.org&icode=ABC123
			
			
		}else{
		
		_form_mc.error_txt.text = ((!message_valid)		?	"Please enter a valid message.\n"	:"")
								+ ((!email_1_valid)		?	"The first email is invalid.\n"	:"")
								+ ((!email_2_valid)		?	"The second email is invalid.\n"	:"")
								+ ((!email_3_valid)		?	"The third email is invalid.\n"	:"")
								+ ((!email_4_valid)		?	"The fourth email is invalid.\n"	:"")
								+ ((!email_5_valid)		?	"The fifth email is invalid.\n"	:"");
		}
		
		
	}
	
	private function form2Callback(answer:String, uid_from_query:String){
		
		trace("form2Callback:data uid - "+uid_from_query);
		
		if(answer == "valid"){
			
			if(FORM_DATA.invited == false){
				FORM_DATA.uid = uid_from_query; // SET UID from info returned from server if UNIVITED PATH	
			}
			
			initformStepThree(uid_from_query);
			
		}else if(answer == "invalid"){
			
			_form_mc.error_txt.text = "There was a problem with your submission. Please try again later.";
		
		}else if(answer == "connection"){
		
			_form_mc.error_txt.text = "There was a problem with the connection. Please try again later.";
		
		}
		
	}
	
	
	private function initformStepThree(d){
		
		//validateStepTwo();
		var uid = "5"; //TODO assign uid
		
		_form_mc.gotoAndStop(3);
		
		_form_field_array.push(_form_mc.validation_ti);
		
		_form_mc.header_txt.text 	= _data.form3.header1;
		_form_mc.instr_txt.text 	= _data.form3.message;
		
		_form_mc.uid_ti.text = FORM_DATA.uid;
		
		
		_form_mc.cancel_btn.onRelease = Delegate.create(this, cancelForm);
			
		_form_mc.validate_btn.onRelease = Delegate.create(this, validateStepThree, d);
		
		
		setFormFieldFocusAction();
		
		
	}
	
	
	private function validateStepThree(d){
			
			trace("formCodeValidation:"+d);
			
			var send_vars:LoadVars = new LoadVars();
			send_vars.uid  = FORM_DATA.uid;
			send_vars.vcode = _form_mc.validation_ti.text;
			
			var url = _config.query.validate_supporter;
			//?uid=5&vcode=ABC123
			
			var callback:Function = Delegate.create(this, form3Callback);
			new SubmitForm(url, send_vars, "GET", callback, false);
			
	}
	
	private function form3Callback(answer:String){
		
		trace("form3Callback");
		
		if(answer=="valid"){
			initFormStepFour();
		}else if(answer=="invalid"){
			_form_mc.error_txt.text = "There was a problem with your submission. Please resubmit your Validation code or try again later.";
		}else if(answer=="connection"){
			_form_mc.error_txt.text = "There was a problem with the connection. Please try again later.";
		}
		
	}
	
	private function initFormStepFour(){
		
		trace('initFormStepFour');
		_form_mc.gotoAndStop(4);
		
		_form_mc.header_txt.text 	= _data.form4.header1;
		_form_mc.instr_txt.text 	= _data.form4.message;
		
		
		_form_mc.view_btn.onRelease = Delegate.create(this, 
			_fireEvent, new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["galaxy,supporter", {uid:FORM_DATA.uid}]) );

		delete PERSISTANT_DATA;
	}
	
	
	private function removeForm(){
		trace("removeForm");
			var t = default_duration; 
			var _mc : MovieClip = _form_mc;
			var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, -400, t, true);
			
			_athlete_form_cb._visible = false; 	
			
			var base = USOC_Location_View.getBaseLiveLocation().split(",").join("");
			
			this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_DEPARTED, ["galaxy,form"]) );
	}
	
	
	// Welcome
	private function activateWelcome() : Void{
		
		trace("activateWelcome");
		// 83, 106
		// 415, 272
		
		
		_about_mc.header1_txt.autoSize = true;
		_about_mc.header2_txt.autoSize = true;
		_about_mc.concat1_txt.autoSize = true;
		_about_mc.concat2_txt.autoSize = true;
		_about_mc.concat3_txt.autoSize = true;
		_about_mc.concat4_txt.autoSize = true;
		_about_mc.message_txt.autoSize = true;
		_about_mc.maxSupporters_txt.autoSize = true;
		_about_mc.nodes_txt.autoSize = true;
		_about_mc.maxNetSize_txt.autoSize = true;
		
		_about_mc.header1_txt.text = _data.welcome.explore.header1;
		_about_mc.header2_txt.text = _data.welcome.explore.header2;
		_about_mc.concat1_txt.text = _data.welcome.explore.concat1;
		_about_mc.concat2_txt.text = _data.welcome.explore.concat2;
		_about_mc.concat3_txt.text = _data.welcome.explore.concat3;
		_about_mc.concat4_txt.text = _data.welcome.explore.concat4;
		_about_mc.message_txt.text = _data.welcome.connect.message;
		_about_mc.maxSupporters_txt.text = _data.nodes.nodes;
		_about_mc.nodes_txt.text 		= _data.athlete.length;
		_about_mc.maxNetSize_txt.text = _data.nodes.maxnetsize;
		
		_about_mc.header2_txt._x = _about_mc.header1_txt._x - _about_mc.header2_txt._width;
		
		var line1_width:Number = _about_mc.maxSupporters_txt._width + _about_mc.concat1_txt._width + _about_mc.nodes_txt._width + _about_mc.concat2_txt._width;
		_about_mc.maxSupporters_txt._x = 370 - (line1_width/2);
		_about_mc.concat1_txt._x = _about_mc.maxSupporters_txt._x + _about_mc.maxSupporters_txt._width;
		_about_mc.nodes_txt._x = _about_mc.concat1_txt._x + _about_mc.concat1_txt._width;
		_about_mc.concat2_txt._x = _about_mc.nodes_txt._x + _about_mc.nodes_txt._width;
		
		var line2_width:Number = _about_mc.concat3_txt._width + _about_mc.maxNetSize_txt._width + _about_mc.concat4_txt._width;
		_about_mc.concat3_txt._x = 370 - (line2_width/2);
		_about_mc.maxNetSize_txt._x = _about_mc.concat3_txt._x + _about_mc.concat3_txt._width;
		_about_mc.concat4_txt._x = _about_mc.maxNetSize_txt._x + _about_mc.maxNetSize_txt._width;
		
		/*
		_explore_mc.header_1_txt.text = _data.welcome.explore.header1;
		_explore_mc.header_2_txt.text = _data.welcome.explore.header2;
		
		_explore_mc.connect_num_txt.text 	= _connections.nodes;
		_explore_mc.ath_num_txt.text 		= _data.athlete.length;
		
		_connect_mc.message_txt.text = _data.welcome.connect.message;
		*/
		
		
		var t = default_duration; 
		/*var _mc : MovieClip = _explore_mc;
		var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, _data.welcome.explore.y, t, true); //106
		
		var _mc2 : MovieClip = _connect_mc;
		var tw2 = new Tween(_mc2, "_y", Quad.easeOut, _mc2._y, _data.welcome.connect.y, t, true); // 222
		*/
		
		var _mc : MovieClip = _about_mc;
		var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, 120, t, true); //106
		
		/*var close_btn:MovieClip = _mc2.attachMovie("butEmpty","close_mc",5000,{_x:300, _y:5});
		close_btn.setGraphic("leftSide", 3); // x
		close_btn.updateButton("",16,16,9);
		close_btn.onRelease = Delegate.create(this, returnToMain);
		
		var close2_btn:MovieClip = _mc.attachMovie("butEmpty","close_mc",5000,{_x:310, _y:5});
		close2_btn.setGraphic("leftSide", 3); // x
		close2_btn.updateButton("",16,16,9);
		close2_btn.onRelease = Delegate.create(this, returnToMain);
		
		*/
		
		var start_btn:MovieClip = _mc.attachMovie("butEmpty","start_btn",100,{_x:300, _y:225});
		start_btn.updateButton("START NOW",140,22,9);
		//start_btn.onRelease = Delegate.create(this, returnToMain);
		
		var base = USOC_Location_View.getBaseLiveLocation().split(",").join("");
		start_btn.onRelease = Delegate.create(this, returnToMain  );
	}
	
	
	private function removeWelcome() : Void{
		trace("removeWelcome");
		var t = default_duration; 
		
		/*var _mc : MovieClip = _explore_mc;
		var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, -400, t, true);
		
		var _mc2 : MovieClip = _connect_mc;
		var tw2 = new Tween(_mc2, "_y", Quad.easeOut, _mc2._y, -400, t, true);*/
		
		var _mc : MovieClip = _about_mc;
		var tw = new Tween(_mc, "_y", Quad.easeOut, _mc._y, -330, t, true);
		var base = USOC_Location_View.getBaseLiveLocation().split(",").join("");
		this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_DEPARTED, [base+",welcome"]) );
	}
	
	
	
	
	/************************************************************************/
	/* Utility Methods */
	
	
	
	private function getAthleteDataById(id) : Object {
		
		var data : Object; 
		var athletes_data = _data.athlete;  
		
		trace("idid:"+id);
		
			for (var i : Number = 0; i < (athletes_data.length); i++) {
				
				var uid = 	athletes_data[i].uid;
				//trace(sport_data[i].uid+" - "+id); 
				
				data = athletes_data[i];
				trace("data:"+uid+ " "+data.uid+" id:"+id);
				if(uid == id){
					break;
					trace("break data:"+data);
				}
		}
		
		return data;
		
	}
	

	

}