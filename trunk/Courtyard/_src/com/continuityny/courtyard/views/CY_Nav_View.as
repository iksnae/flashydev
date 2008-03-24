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

import com.continuityny.courtyard.CY_EventList;
import com.continuityny.courtyard.CY_EventBroadcaster;

//	MovieClipHelper
import com.bourre.visual.MovieClipHelper;

//	list of Views
import com.continuityny.courtyard.CY_ViewList;
import mx.controls.*;


import com.continuityny.validate.Validate;
import com.continuityny.form.SubmitForm;

import com.robertpenner.easing.*;
import mx.transitions.Tween;
import com.continuityny.timing.PauseMe;
import com.continuityny.courtyard.views.CY_Location_View;
import mx.video.FLVPlayback;
import com.continuityny.media.FLVPlaybackHandler;
import com.continuityny.mc.ImageLoader;
import com.continuityny.filetransfer.UploadFile;
import com.continuityny.courtyard.CY_ModelList;
import com.continuityny.courtyard.CY_Site_Model;
import com.continuityny.courtyard.views.CY_Sound_View;
import com.continuityny.mc.ImageResizeControls;

import com.bourre.data.libs.ConfigLoader;

import com.asual.swfaddress.SWFAddress;


//class net.webbymx.projects.tutorial01.views.ViewTools
class com.continuityny.courtyard.views.CY_Nav_View 
	extends MovieClipHelper {
/* ****************************************************************************
* PRIVATE VARIABLES
**************************************************************************** */
//	Assets
	private var _txtColor	: TextField;
	
	

	private var _data : Object;
	private var _config : Object;

	private var FORM_DATA : LoadVars; 
	
	private var default_duration : Number = .5;

	private var _details_mc		: MovieClip; 	private var _video_mc		: MovieClip; 	private var _sound_switch_mc		: MovieClip; 
	
	private var VIDEO_HANDLER	:FLVPlaybackHandler;
	
	private var VIDEO_PATH		:String = "flv/courtyard_high.flv";
	
	private var INT : Number;
	private var INT2 : Number;

	private var form_ath_cb_listener : Object;

	private var _gothamBold:TextFormat;

	private var _form_field_array:Array = [];
	
	private var PERSISTANT_DATA;
	
	private var detail_array:Array;
	
	private var _SEARCH_RESULTS:Object;
	
	private var current_loc: String;
	private var FLVPBK : FLVPlayback;

	
	
	
	/* ****************************************************************************
* CONSTRUCTOR
**************************************************************************** */
	function CY_Nav_View( mc : MovieClip, details:MovieClip, video:MovieClip ) {
		super( CY_ViewList.VIEW_NAV, mc );
		trace("CY_Nav_View: "+mc+" Details:"+details);		
		_details_mc = details;
		_video_mc 	= video;
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
		//_message_mc			= view.top_nav_mc.athlete_mc.bubble_mc;
		
		
		_gothamBold = new TextFormat("GothamBold", 11, 0x5F788C);
		
		
		
	}

	

/**
* Broadcast the event
* @usage	_fireEvent( new BasicEvent( EventList.MYTYPE, Object ) );
* @param	e
*/
	private function _fireEvent( e : IEvent ) : Void {
		trace("CY_Nav_View: fire event: "+e);
		CY_EventBroadcaster.getInstance().broadcastEvent( e );
	}



	private function activateSection(e:IEvent){
		
		var loc = e.getTarget()[0];
		trace("CY_Nav_View: activateSection: "+loc);
		setVideo(loc);
		//setImage();
		
		showDetailLinks(loc);
		
		//this._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_ARRIVED, [loc]) );
		
	}
	
	
	
	private function removeSection(e:IEvent){
		var loc = e.getTarget()[0];
		trace("CY_Nav_View: removeSection: "+loc);
		
		/*var dep_e = CY_Location_View( MovieClipHelper.getMovieClipHelper( 
				CY_ViewList.VIEW_LOCATION ) ).getDepartingE();
		var dep_loc = dep_e.getTarget()[0];	
		trace("CY_Nav_View: removeSection: dep_loc: "+dep_loc+" --- "+dep_e);
			removeDetail(dep_loc);*/
			removeCurrentDetail(); // hack untill above works
		removeDetailLinks(loc);
		stopVideo();
	}
	
	
	
	private function setVideo(loc){
		
	 	// FLVPBK = _video_mc._flvPlbk;
	 	FLVPBK = FLVPlayback(_video_mc.attachMovie("FLVPlayback", "flvpb_mc",1000, {_x:30}));
		FLVPBK.setSize(800, 400)
		
		var path = "flv/"+loc+".flv";
		FLVPBK.play(path);
		FLVPBK.pause();
		
		var _mc = _video_mc.mask_mc; 
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 0, .5, true);
		
		var scope = this; 
		tw.onMotionFinished = function(){
			FLVPBK.play();
		}
		
		
		
	}
	
	private function stopVideo(loc){
		
		var _mc = _video_mc.mask_mc; 
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970, .5, true);
		scope.FLVPBK.stop();
		_video_mc.flvpb_mc.removeMovieClip();

		var scope = this; 
		tw.onMotionFinished = function(){
			scope.FLVPBK.stop();
		}
		
	}

	
	
	
	private function showDetailLinks(loc){
		trace("CY_Nav_View: showDetailLinks: "+loc);		//view.detail_nav_mc._x = -90; 
		var _mc = view.detail_nav_mc;
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, -90, .5, true);
		var scope = this; 
		tw.onMotionFinished = function(){
			scope._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_ARRIVED, [loc]) );
		}
		
		var _mc = _details_mc.nav_base_mc;
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 835, .5, true);
	}
	
	
	private function removeDetailLinks(loc){
		trace("CY_Nav_View: removeDetailLinks: "+loc);
		//view.detail_nav_mc._x = 0; 
		
		var _mc = view.detail_nav_mc;
		
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 0, .5, true);
		var scope = this; 
		tw.onMotionFinished = function(){
			scope._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_DEPARTED, [loc]));
		}
		
		var _mc = _details_mc.nav_base_mc;
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970, .5, true);
	}
	
	
	
	private function showDetail(e:IEvent){
		var loc = current_loc = e.getTarget()[0];
		var _mc = detail_array[loc];
		trace("CY_Nav_View: showDetail: "+loc+"   _mc:"+_mc);
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 0, .5, true);
		var scope = this; 
		tw.onMotionFinished = function(){
			scope._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_ARRIVED, [loc]) );
		}
	}
	
	
	
	private function removeDetail(e:IEvent){
		
		var loc = e.getTarget()[0];
		trace("CY_Nav_View: removeDetail: "+loc);
		var _mc = detail_array[loc];
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970, .5, true);
		var scope = this;
		
		tw.onMotionFinished = function(){
			scope._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_DEPARTED, [loc]) );
		}
	}
	
	// hack untill fix location manager
	private function removeCurrentDetail(){
		var _mc = detail_array[current_loc];
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970, .5, true);	
	}
	
	public function _build( e : IEvent ){
		
		trace("CY_Nav_View: _build:"+view.nav_mc.slider_nav_mc);
		// _data = e.getTarget();
		
		_data = CY_Site_Model.getData();
		_config = CY_Site_Model.getConfig();
		
		detail_array = new Array();
		detail_array["lobby,1"] = _details_mc.detail_1_mc;
		detail_array["lobby,2"] = _details_mc.detail_2_mc;
		
		detail_array["market,1"] = _details_mc.detail_1_mc;
		detail_array["market,2"] = _details_mc.detail_2_mc;
		
		
		this._fireEvent(	new BasicEvent( CY_EventList.SET_LOCATION, 
			["lobby", 	Delegate.create(this,activateSection),  
						Delegate.create(this,removeSection)
						] ) );
						
		this._fireEvent(	new BasicEvent( CY_EventList.SET_LOCATION, 
			["market", 	Delegate.create(this,activateSection),  
						Delegate.create(this,removeSection)
						] ) );
						
		this._fireEvent(	new BasicEvent( CY_EventList.SET_LOCATION, 
			["lobby,1", 	Delegate.create(this,showDetail),  
							Delegate.create(this,removeDetail)
						] ) );
		this._fireEvent(	new BasicEvent( CY_EventList.SET_LOCATION, 
			["lobby,2", 	Delegate.create(this,showDetail),  
							Delegate.create(this,removeDetail)
						] ) );
		
		this._fireEvent(	new BasicEvent( CY_EventList.SET_LOCATION, 
			["market,1", 	Delegate.create(this,showDetail),  
							Delegate.create(this,removeDetail)
						] ) );
		this._fireEvent(	new BasicEvent( CY_EventList.SET_LOCATION, 
			["market,2", 	Delegate.create(this,showDetail),  
							Delegate.create(this,removeDetail)
						] ) );
		
		/*
		this._fireEvent(	new BasicEvent( CY_EventList.SET_LOCATION, 
			["universe,welcome", Delegate.create(this,activateWelcome),  Delegate.create(this,removeWelcome)] ) );
		
		this._fireEvent(	new BasicEvent( CY_EventList.SET_LOCATION, 
			["galaxy,welcome", Delegate.create(this,activateWelcome),  Delegate.create(this,removeWelcome)] ) );
		*/
		
		
		
		
		
		INT = setInterval(Delegate.create(this, function(){
			//this.activateStaticNav();
			clearInterval(this.INT);
			
			//CY_Universe_View( MovieClipHelper.getMovieClipHelper( CY_ViewList.VIEW_UNIVERSE ) ).populate();
			
		}), 1000);
		
	
		
		_sound_switch_mc.onRelease = Delegate.create(this, function(){
			
			// if(this._currentframe == 1){
			trace("CY_Sound_View.getMute():"+CY_Sound_View.getMute());
			
			if(!CY_Sound_View.getMute()) {
				trace("mute sound");
				/*this.gotoAndStop(2);
				CY_Sound_View( MovieClipHelper.getMovieClipHelper( 
				CY_ViewList.VIEW_SOUND ) ).soundMute(true);*/
				
				this._fireEvent(	new BasicEvent( CY_EventList.MUTE_SOUND, [true] ) );
				
				
			}else{
				trace("unmute sound");
				/*this.gotoAndStop(1);
				CY_Sound_View( MovieClipHelper.getMovieClipHelper( 
				CY_ViewList.VIEW_SOUND ) ).soundMute(false);*/
				
				this._fireEvent(	new BasicEvent( CY_EventList.MUTE_SOUND, [false] ) );
			}
				
				
		});
		
		
		
		var slider:MovieClip = view.slider_nav_mc; 
		
		slider.nav_1_mc.onRelease = Delegate.create(this, function(){
			
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, ["lobby"] ) );
			
		});
		
		slider.nav_2_mc._txt = "MARKET";
		slider.nav_2_mc.onRelease = Delegate.create(this, function(){
			
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, ["market"] ) );
			
		});
		
		view.logo_mc.onRelease = Delegate.create(this, function(){
			
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, ["home"] ) );
			
		});
		
		
		view.slider_nav_mc.nav_2_mc._txt.text = "MARKET";
				view.detail_nav_mc.nav_1_mc._txt.text = "NUMBER ONE";		view.detail_nav_mc.nav_2_mc._txt.text = "NUMBER TWO";
		
		
		
		view.detail_nav_mc.nav_1_mc.onRelease = Delegate.create(this, function(){
			var base = CY_Location_View.getBaseLiveLocation().split(",").join("");
			trace("base:"+base);
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, [base+",1"] ) );
			
		});
		
		view.detail_nav_mc.nav_2_mc.onRelease = Delegate.create(this, function(){
			var base = CY_Location_View.getBaseLiveLocation().split(",").join("");
			trace("base:"+base);
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, [base+",2"] ) );
			
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
			//_flvPlayback.volume = 0;
		}else{
			_sound_switch_mc.gotoAndStop(1);
			//_flvPlayback.volume = 100;
		}
	}
	
	
	
	
	
	

}