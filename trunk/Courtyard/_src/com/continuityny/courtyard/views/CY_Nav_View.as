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
import com.continuityny.mc.PlayClip;

import gs.TweenLite;
import gs.TweenFilterLite;

class com.continuityny.courtyard.views.CY_Nav_View 
	extends MovieClipHelper {
/* ****************************************************************************
* PRIVATE VARIABLES
**************************************************************************** */
//	Assets
	private var _txtColor	: TextField;
	
	private var _data : Object;
	private var _config : Object;

	
	private var default_duration : Number = .5;

	private var _details_mc		: MovieClip; 
	
	private var VIDEO_HANDLER	:FLVPlaybackHandler;
	
	private var VIDEO_PATH		:String = "flv/courtyard_high.flv";
	
	private var INT : Number;
	private var INT2 : Number;

	private var form_ath_cb_listener : Object;

	private var _detailLabel:TextFormat;
	private var _detailHeader:TextFormat;
	
	private var _superLabel:TextFormat;

	private var _form_field_array:Array = [];
	
	private var PERSISTANT_DATA;
	
	private var detail_array:Array;
	
	private var _SEARCH_RESULTS:Object;
	
	private var current_loc: String;
	private var FLVPBK : FLVPlayback;
	private var _amenities_mc : MovieClip;
	private var _find_but_mc : MovieClip;
	private var _slider_mc : MovieClip;

	private var loc_array : Array = ["home", "lobby", "market", "business",  "guest_room", "fitness", "outdoor"]; 
	
	private var a_x_array:Array = [118,176,269,446,577,741,830]; // slider positions 
	
	private var ARROW_INT:Number;
	private var PRELOAD_INT:Number;
	private var DELAYDONE:Boolean;
	
	private var CURRENT_ARROW_LOC : String;
	
	private var VIDEO_LISTENER : Object ; 
	
	/*
	 * 
	 * stay focused - 1: 615, 373
		cuepoint:EASY : 7.115 - 300,308
		cuepoint:LOBBYWIFI : 15.212 - 180,290
		cuepoint:BREAKFAST : 23.391 - 70,50
		cuepoint:BARANDLOUNGE : 34.269 - 38,330
		cuepoint:CASUALMEETING : 41.63 - 38,330
		 * 
		 * 
		 cuepoint:STAYENERGIZED : 0.135
		cuepoint:SNACKREFRESHMENTS : 5.921
		cuepoint:FRESHHEALTHY : 9.841
		cuepoint:ALWAYSOPEN : 15.762
		 * 
		 * 
		cuepoint:STAYCONNECTED : 0
		cuepoint:WIFILIBRARY : 6.629
		cuepoint:PRINTERFAX : 16.74
		cuepoint:DESKTOPWORKSTATION : 22.222	 * 
		 * 
		 * 
		 * cuepoint:STAYCOMFY : 0
		cuepoint:SMARTLYDESIGNED : 5.955
		cuepoint:ROOMTOSPREAD : 21.042
		cuepoint:ERGONOMIC : 36.031
		cuepoint:HISPEEDROOM : 43.773
		cuepoint:PLUSHBEDDING : 53.004
		 * 
		 * 
		 * cuepoint:STAYFIT : 0
		cuepoint:TEMPCONTROL : 5.078
		cuepoint:HOTTUB : 9.58
		cuepoint:TOWELSERVICE : 16.391
		cuepoint:EXERCISEEQUIP : 21.181
 * 
 * 
 * 
	 */
	
	
	/* ****************************************************************************
	* CONSTRUCTOR
	**************************************************************************** */
	function CY_Nav_View( 	mc 		: MovieClip, 
							details : MovieClip, 
							video	: MovieClip,
							tv		: MovieClip,
							amenities	: MovieClip ) {
		
		
		super( CY_ViewList.VIEW_NAV, mc );
		trace("CY_Nav_View: "+mc+" Details:"+details);
		_details_mc = details;
		_video_mc 	= video;
		_tv_mc = tv; 
		_amenities_mc = amenities; 
		
		_init();
		
	}
	
	
	
	private function _init( Void ) : Void {
	//	Position this Views main MovieClip
		view._x = 0;
		view._y = 0;
	
	//	init var, assets, events, ...
		
		_slider_mc 		= view.slider_nav_mc; 
		_tv_but_mc		= view.tv_but_mc;
		
		
		_detailLabel = new TextFormat("GothamRoundBold", 11, 0xFFFFFF);
		_detailLabel.align = "right";
		_detailLabel.leading = 2;
		
		_superLabel = new TextFormat("GothamRoundMed", 20, 0xFFFFFF);
		
		VIDEO_LISTENER  = new Object();
		
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
	 	
	 	var video_mask:MovieClip = _video_mc.attachMovie("mc_stage_size", "video_mask_mc", 1100,{_x:970});
	 	var vid_mc = _video_mc.createEmptyMovieClip("vid_mc", 1105);
	 	
	 	FLVPBK = FLVPlayback(_video_mc.vid_mc.attachMovie("FLVPlayback", "flvpb_mc",1000, {_x:74}));
		FLVPBK.setSize(800, 400)
		
		
		var path = "flv/"+loc+".flv";
		
		FLVPBK.bufferTime = 20;
		FLVPBK.load(path);
		//FLVPBK.pause();
		
		preloadVideo(loc);
		setCuePoints(loc);
		
		_video_mc.vid_mc['flvpb_mc'].setMask(_video_mc['video_mask_mc']);
		
		
		VIDEO_LISTENER.cuePoint =  Delegate.create(this, function(eventObject:Object):Void {
				trace("cuepoint:"+eventObject.info.name +" : "+eventObject.info.time);
				showCuePoint(eventObject.info.name, eventObject.info.parameters, 74); 
		});
		
		FLVPBK.addEventListener("cuePoint", VIDEO_LISTENER);  
		
	}
	
	
	
	
	private function showCuePoint(name:String, param:Object, offset:Number){
		
		trace("showcuepoint:"+name);
		var _mc = _video_mc.vid_mc;
		var super_mc:MovieClip = _mc.createEmptyMovieClip("super_mc", 1200);
		var _txt:TextField = super_mc.createTextField("_txt", 100, 0, 0, 400, 30);
		super_mc._alpha = 0; 
		super_mc._x = param._x + offset; 
		super_mc._y = param._y; 
		
		new Color(super_mc).setRGB(param.color);
		
		_txt.wordWrap = true; 
		_txt.autoSize = true; 
		_txt.selectable = false;
		_txt.embedFonts = true;
		_txt.text = name; 
		_txt.setTextFormat(_superLabel);
		
		TweenLite.to(super_mc, .5, {_alpha:100});
		TweenLite.to(super_mc, .5, {_alpha:0, delay:param.duration, overwrite:false});
		
	}
	
	private function preloadVideo(loc){
		
		trace("preloadVideo;"+loc);
		
		DELAYDONE = null; 
		
		PRELOAD_INT = setInterval(Delegate.create(this, function(){
				DELAYDONE = true; 
				clearInterval(PRELOAD_INT);
				trace("clear preload");
		}), 2000);
		
		VIDEO_LISTENER.playing   = Delegate.create(this, function(eventObject:Object):Void {
				trace("FLVPBK.fps:"+FLVPBK.metadata.framerate);
		});
		
				
				trace("video ready:"+FLVPBK.bufferTime);
					FLVPBK.removeEventListener("ready", VIDEO_LISTENER);  
					FLVPBK.removeEventListener("buffering", VIDEO_LISTENER);  
					
						CHECK_INT = setInterval(Delegate.create(this, function(){
							if(DELAYDONE){
								onVideoPreloaded(loc);
								clearInterval(CHECK_INT);
								trace("clear check delay done");
							}
						}), 250);
				
		});
		
		VIDEO_LISTENER.buffering   = Delegate.create(this, function(eventObject:Object):Void {
				// base_mc.buffer_mc._visible = true; 
				var bt = FLVPBK.bytesTotal;
				var bl = FLVPBK.bytesLoaded;
				var perc = Math.ceil(bl/bt * 100); 
				
				trace("video loading:"+perc);
				
				if(perc >= 100){
					FLVPBK.removeEventListener("buffering", VIDEO_LISTENER);  
				}
				
		});
		
		
		
		FLVPBK.addEventListener("ready", VIDEO_LISTENER);  
		FLVPBK.addEventListener("buffering", VIDEO_LISTENER);  
		
	}
	
	
	
	private function setCuePoints(loc){
		
		
		var cue_array = _data.locations.section[loc].cue;
		trace("setCuePoint:"+cue_array.length);
		for (var i : String in cue_array) {
			
			//FLVPBK.addASCuePoint(3, "TITLE YA BASTA", {_x:300,_y:300, color:0xFF9900});
									cue_array[i].title, 
									{	_x:Number(cue_array[i].x),
										_y:Number(cue_array[i].y), 
										color:Number(cue_array[i].color)
									});
			
			//FLVPBK.addASCuePoint(9, "FIRST SUPER");
		}
		
		
	
		
		
		
	}
	
	
	private function onVideoPreloaded(loc){
		trace("onPreloadVideo:"+loc);
		var _mc = _video_mc['video_mask_mc']; 
		var tw 	= new Tween(_mc, "_x", Quad.easeIn, _mc._x, 0, .75, true);
		
		//var _mc = _video_mc.vid_mc;
		var scope = this;
		//TweenFilterLite.to(scope._video_mc.vid_mc, 0, {blurFilter:{blurX:20, blurY:20}});
		
		//var _mc = _video_mc; 
		//new Tween(_mc, "_x", Quad.easeOut, _mc._x, 0, 1, true);
		FLVPBK.seek(0);
		
		var scope = this; 
		tw.onMotionFinished = function(){
			
			scope.FLVPBK.play();
			scope._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_ARRIVED, [loc]) );
			
			//var _mc = scope._video_mc.vid_mc;
			//TweenFilterLite.to(scope._video_mc.vid_mc, 2, {blurFilter:{blurX:0, blurY:0}});
		
		
		}	
		
	}
	
	
	
	private function stopVideo(){
		
		var _mc = _video_mc['video_mask_mc']; 
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970, .5, true);
		
		//var _mc = _video_mc; 
		//new Tween(_mc, "_x", Quad.easeOut, _mc._x, 400, 1, true);

		var scope = this; 
		tw.onMotionFinished = function(){
			scope.FLVPBK.stop();
			scope._video_mc.vid_mc.flvpb_mc.removeMovieClip();
			scope._video_mc.video_mask_mc.removeMovieClip();
		
		}
		
		FLVPBK.removeEventListener("cuePoint", VIDEO_LISTENER);  
	}

	
	
	
	private function showDetailLinks(loc){
		trace("CY_Nav_View: showDetailLinks: "+loc);
		var _mc = view.detail_nav_mc;
		var tw 	= new Tween(_mc, "_x", Quad.easeOut, _mc._x, -150, .5, true);
		var scope = this; 
		tw.onMotionFinished = function(){
			
		}
		
		var _mc = _details_mc.nav_base_mc;
		var w = _mc._width;
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970-w, .5, true);
		
		
		createDetailsNav(loc);
	}
	
	
	private function removeDetailLinks(loc){
		trace("CY_Nav_View: removeDetailLinks: "+loc);
		//view.detail_nav_mc._x = 0; 
		
		var _mc = view.detail_nav_mc;
		
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 0, 1, true);
		var scope = this; 
		
		tw.onMotionFinished = function(){
			scope._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_DEPARTED, [loc]));
		}
		
		var _mc = _details_mc.nav_base_mc;
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970, 1, true);
	}
	
	
	
	private function showDetail(e:IEvent){
		
		var loc = current_loc = e.getTarget()[0];
		//var _mc = detail_array[loc];
		var d = _details_mc.detail_base_mc.getNextHighestDepth();
		var loc_s = loc.split(",").join("");
		var base_loc 	= loc.split(",")[0];
		var detail_num 	= loc.split(",")[1];
		
		var _mc = _details_mc.detail_base_mc.attachMovie("mc_detail_pieces", "detail_page_"+loc_s+"_mc", d, {_x:10});
		
		_mc.copy_mc._alpha = 0; 
		
		for(var i=7; i>=1; i--){
			
			var det_mc : MovieClip = 	_mc['detail_'+i+'_mc'];
			trace("det_mc:"+det_mc);
			det_mc.x = det_mc._x;
			det_mc._x = 970;
			
			var r = (random(10)/10);
			var t = 1;
			TweenLite.to(det_mc, t, {_x:det_mc.x, delay:.12*(7-i), easing:Quint.easeOut});
			
			//new Tween(det_mc, "_x", Quad.easeOut, det_mc._x, det_mc.x, 1, true); 
		}
		
		TweenFilterLite.from(_mc, 1.5, {blurFilter:{blurX:30, blurY:30}, easing:Quad.easeOut});
		//TODO move this main section load
		new ImageLoader(_mc['detail_2_mc'], "images/det_images/"+base_loc+"_"+(Number(detail_num)+1)+"_d.jpg");
		new ImageLoader(_mc['detail_5_mc'], "images/det_images/"+base_loc+"_"+(Number(detail_num)+1)+"_c.jpg");
		
		
		var header_txt:TextField = _mc.copy_mc.header_txt;
		header_txt.text = _data.locations.section[base_loc].detail[detail_num].header;
		body_txt.text 	= _data.locations.section[base_loc].detail[detail_num].text;
		trace("body:"+_data.locations.section[base_loc].detail[detail_num].text+" header_txt:"+header_txt);
		
		header_txt.autoSize = true
		
		body_txt._y = header_txt._y + header_txt._height + 5;
		
		
		
		trace("CY_Nav_View: showDetail: "+loc+"   _mc:"+_mc+" d:"+d);
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 0, 1.7, true);
		var scope = this; 
		
		var _mc2 = _mc['detail_5_mc']; 
		
		tw.onMotionFinished = function(){
			
			TweenLite.to(_mc.copy_mc, 1, {_alpha:100});
			
			scope._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_ARRIVED, [loc]) );
			
			//TweenLite.to(_mc2, 10, {_x:_mc2._x-100, delay:.7});			
			
		}
		
		
		FLVPBK.pause();
	}
	
	
	
	private function removeDetail(e:IEvent){
		
		var loc = e.getTarget()[0];
		trace("CY_Nav_View: removeDetail: "+loc);
		//var _mc = detail_array[loc];
		var loc_s = loc.split(",").join("");
		var _mc = _details_mc.detail_base_mc["detail_page_"+loc_s+"_mc"]; 
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 10, .5, true);
		
		//_mc.copy_mc._alpha = 0; 
		TweenLite.to(_mc.copy_mc, 0, {_alpha:0});
		
		for(var i=1; i<=7; i++){
			
			var det_mc : MovieClip = 	_mc['detail_'+i+'_mc'];
			trace("det_mc:"+det_mc);
			//det_mc.x = det_mc._x;
			//det_mc._x = 970;
			
			//var r = (random(10)/10);
			var t = .5;
			TweenLite.to(det_mc, t, {_x:-det_mc._width});
			
			//new Tween(det_mc, "_x", Quad.easeOut, det_mc._x, det_mc.x, 1, true); 
		}
		
		
		var scope = this;
		
		tw.onMotionFinished = function(){
			var loc_s = loc.split(",").join("");
			scope._details_mc.detail_base_mc["detail_page_"+loc_s+"_mc"].removeMovieClip();
			trace("CY_Nav_View: removeDetail: "+loc_s+" _mc:"+scope._details_mc["detail_page_"+loc_s+"_mc"]);
		}
			scope._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_DEPARTED, [loc]) );
	}
	
	
	// hack untill fix location manager
	private function removeCurrentDetail(){
		var loc_s = current_loc.split(",").join("");
		var _mc = _details_mc.detail_base_mc["detail_page_"+loc_s+"_mc"]; 
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970, .5, true);	
	}
	
	
	private function onSliderNavClick(i){
				trace("loc_array:"+loc_array[i]+" i:"+i);
				
			CURRENT_ARROW_LOC = loc_array[i];
			centerSlider(i);
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, [loc_array[i]] ) );
						
	}
	
	private function onDetailNavClick(loc, _mc){
				trace("onDetailNavClick:"+loc);
				
				_mc.onRollOut();
				
				this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, [loc] ) );
						
	}
	
	public function _build( e : IEvent ){
		
		
		
		trace("CY_Nav_View: _build:"+view.nav_mc.slider_nav_mc);
		// _data = e.getTarget();
		
		_data 	= CY_Site_Model.getData() ;
		_config = CY_Site_Model.getConfig() ;
		
		
		detail_array = new Array();
		detail_array["lobby,1"] = _details_mc.detail_1_mc;
		detail_array["lobby,2"] = _details_mc.detail_2_mc;
		
		detail_array["market,1"] = _details_mc.detail_1_mc;
		detail_array["market,2"] = _details_mc.detail_2_mc;
		
		
		
		// *	MAIN NAV LOCATIONS and BUTTON CLICKS
		// *	- set locations and set the clicks
		// *
		
		for(var i:Number = 1; i<loc_array.length; i++){
			trace("loc_array:"+loc_array[i]);
			
			this._fireEvent(	new BasicEvent( CY_EventList.SET_LOCATION, [loc_array[i], 	
						Delegate.create(this,activateSection),  
						Delegate.create(this,removeSection)
						] ) );
			
			_slider_mc["nav_"+i+"_mc"].onRelease 	= Delegate.create(this, onSliderNavClick, i) ;
			_slider_mc["nav_"+i+"_mc"].onRollOver 	= mainOver;
			_slider_mc["nav_"+i+"_mc"].onRollOut 	= mainOut;

		}
		
		var scope = this; 
		_slider_mc.arrow_mc.onPress = function(){
			trace("slider press");
			var a_y = 522; 
			this.startDrag(false, 111, a_y, 828, a_y);	
			
			scope.setImageByArrowPosition();
		}
		
		_slider_mc.arrow_mc.onRelease = 
		_slider_mc.arrow_mc.onReleaseOutside = Delegate.create(this, getSectionByArrowPosition);
		
		
		// *	OVERLAY SECTIONS
		// *   these sections are different becuase they should return to the section 
		// *   that they were in after they click to close
		
		this._fireEvent(	new BasicEvent( CY_EventList.SET_LOCATION, 
			["tv", 		Delegate.create(this,activateTV),  
						Delegate.create(this,removeTV)
						] ) );
		
		this._fireEvent(	new BasicEvent( CY_EventList.SET_LOCATION, 
			["amenities", 		Delegate.create(this,activateAmen),  
								Delegate.create(this,removeAmen)
						] ) );
						
						
		
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
		
		
		
		
		
		view.logo_mc.onRelease = Delegate.create(this, function(){
			
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, ["home"] ) );
			
		});
		
		
		_tv_but_mc.onRelease = Delegate.create(this, function(){
			
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, ["tv"] ) );
			
		});
		
		_tv_but_mc.onRollOver = secondOver;
		_tv_but_mc.onRollOut 	= secondOut;
		
		_amen_but_mc.onRelease = Delegate.create(this, function(){
			
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, ["amenities"] ) );
			
		});
		
		_amen_but_mc.onRollOver = secondOver;
		_amen_but_mc.onRollOut 	= secondOut;
		
		
		_find_but_mc.onRollOver = secondOver;
		_find_but_mc.onRollOut 	= secondOut;
		
		
		_amenities_mc.close_but_mc.onRelease = Delegate.create(this, function(){
			
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, ["lobby"] ) );
			
		});
		
		
		
		/*view.slider_nav_mc.nav_2_mc._txt.text = "MARKET";
		
		
		
		
		view.detail_nav_mc.nav_1_mc.onRelease = Delegate.create(this, function(){
			var base = CY_Location_View.getBaseLiveLocation().split(",").join("");
			trace("base:"+base);
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, [base+",1"] ) );
			
		});
		
		view.detail_nav_mc.nav_2_mc.onRelease = Delegate.create(this, function(){
			var base = CY_Location_View.getBaseLiveLocation().split(",").join("");
			trace("base:"+base);
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, [base+",2"] ) );
			
		});*/
		
		var spacing_fmt:TextFormat = new TextFormat();
		spacing_fmt.letterSpacing = 5.7;
		spacing_fmt.font = "VerdanaBold";
		
		var _txt:TextField = view.bottom_nav_mc.bot_bar_mc.con_mc.box_txt; 
		_txt.text = _data.nodes.nodes;
		_txt.setTextFormat(spacing_fmt);
	}
	
	
	
	private function createDetailsNav(loc){
		
		
		for(var each in view.detail_nav_mc){
			var this_mc:MovieClip = view.detail_nav_mc[each];
			this_mc.removeMovieClip();
		}
		
		
		var loc_details = _data.locations.section[loc].detail;
		for(var i=0; i<loc_details.length; i++){
			trace(loc+" details:"+loc_details[i].title);
			
			//var this_nav_mc = view.detail_nav_mc.attachMovie("mc_det_nav_label", "nav_"+i+"_mc", (i*10));
			var this_nav_mc = view.detail_nav_mc.createEmptyMovieClip("nav_"+i+"_mc", (i*10));
			var lab = loc_details[i].title;
			createDetailLabel(this_nav_mc, lab);
			
			var prev_nav_mc = view.detail_nav_mc["nav_"+(i-1)+"_mc"];
			this_nav_mc._x = 1010; 
			//this_nav_mc._y = 130+(60*i);
			if(i == 0){
				this_nav_mc._y = 140; 
			}else{
				this_nav_mc._y = prev_nav_mc._y + prev_nav_mc._height + 30 ; 
			}
			
			
			/*var _txt:TextField = this_nav_mc._txt; 
			_txt.multiline = true; 
			_txt.text = loc_details[i].title;
			*/
			this._fireEvent(	new BasicEvent( CY_EventList.SET_LOCATION, 
			[loc+","+i, 	Delegate.create(this,showDetail),  
							Delegate.create(this,removeDetail)
						] ) );
						
			this_nav_mc.onRelease = Delegate.create(this, onDetailNavClick, loc+","+i, this_nav_mc) ;
			
		}	
		
	}
	
	
	private function createDetailLabel(_mc:MovieClip, str:String){
		
		var _txt:TextField = _mc.createTextField( "_txt", 100, 0, 0, 110, 20);
		_txt.html = true; 
		_txt.htmlText = str;
		_txt.wordWrap = true; 
		_txt.autoSize = true; 
		_txt.selectable = false;
		_txt.embedFonts = true;
		_txt.setTextFormat(_detailLabel);	
		
	}
	
	private function getSectionByArrowPosition(){
		
			var _mc:MovieClip = _slider_mc.arrow_mc; 
			
			
			
			
			_slider_mc.arrow_mc.stopDrag();
			
			clearInterval(ARROW_INT);
			
			if(_mc._x >= a_x_array[0] && _mc._x < a_x_array[1]){
				
				var loc = "lobby"; 
				var i = 1; 
				
			}else 
			if(_mc._x >= a_x_array[1] && _mc._x < a_x_array[2]){
				
				var loc = "market"; 
				var i = 2;
				
			}else
			if(_mc._x >= a_x_array[2] && _mc._x < a_x_array[3]){
				
				var loc = "business"; 
				var i = 3;
				
			}else
			if(_mc._x >= a_x_array[3] && _mc._x < a_x_array[4]){
				
				var loc = "guest_room"; // 577 741
				var i = 4;
				
			}else
			if(_mc._x >= a_x_array[4] && _mc._x < a_x_array[5]){
				
				var loc = "fitness"; 
				var i = 5;
				
			}else
			if(_mc._x >= a_x_array[5] && _mc._x < a_x_array[6]){
				
				var loc = "outdoor"; 
				var i = 6;
				
			}
			
			centerSlider(i);
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, [loc] ) );
		
	}
	
	
	
	private function setImageByArrowPosition(){
		
			trace("setImageByArrowPosition");
			
			var _mc:MovieClip = _slider_mc.arrow_mc; 
			
			//_slider_mc.arrow_mc.stopDrag();
			
			ARROW_INT = setInterval(Delegate.create(this, function(){
			
				if(_mc._x >= a_x_array[0] && _mc._x < a_x_array[1]){
					
					var loc = "lobby"; 
					var i = 1; 
					
				}else 
				if(_mc._x >= a_x_array[1] && _mc._x < a_x_array[2]){
					
					var loc = "market"; 
					var i = 2;
					
				}else
				if(_mc._x >= a_x_array[2] && _mc._x < a_x_array[3]){
					
					var loc = "business"; 
					var i = 3;
					
				}else
				if(_mc._x >= a_x_array[3] && _mc._x < a_x_array[4]){
					
					var loc = "guest_room"; // 577 741
					var i = 4;
					
				}else
				if(_mc._x >= a_x_array[4] && _mc._x < a_x_array[5]){
					
					var loc = "fitness"; 
					var i = 5;
					
				}else
				if(_mc._x >= a_x_array[5] && _mc._x < a_x_array[6]){
					
					var loc = "outdoor"; 
					var i = 6;
					
				}
				//trace("loc = :"+loc);
				
				if(loc != CURRENT_ARROW_LOC){
					
					trace("CURRENT_ARROW_LOC = :"+loc);
					CURRENT_ARROW_LOC = loc; 
					//CY_HOMEY.changeLocation(loc);	
					CY_Home_View( MovieClipHelper.getMovieClipHelper( 
								CY_ViewList.VIEW_HOME ) ).changeSection(loc);
								
								stopVideo();
					
				}
				
			}), 25);
			
		
	}
	
	private function centerSlider(i:Number){
		
		var l:Number = a_x_array[i-1];
		var r:Number = a_x_array[i];
		
		var x_pos = l+((r - l)/2); 
		
		var _mc = _slider_mc.arrow_mc; 
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, x_pos, .5, true);
		
		
	}
	
	

	private function activateTV() : Void {
		var _mc = _tv_mc.mask_mc; 
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 0, .5, true);
		this._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_ARRIVED, ["tv"]) );
	}
	
	private function removeTV() : Void {
		var _mc = _tv_mc.mask_mc; 
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970, .5, true);
		this._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_DEPARTED, ["tv"]) );
	}

	private function activateAmen() : Void {
		//var _mc = _ammenities_mc.mask_mc; 
		//var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 0, .5, true);
		
		//new PlayClip( _ammenities_mc.amen_anim_mc, 33);
		_amenities_mc._visible = true;
		 _amenities_mc.amen_anim_mc.gotoAndPlay("IN");
		this._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_ARRIVED, ["amenities"]) );
	}

	private function removeAmen() : Void {
		//var _mc = _ammenities_mc.mask_mc; 
		//var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970, .5, true);
		 _amenities_mc.amen_anim_mc.gotoAndPlay("OUT");
		this._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_DEPARTED, ["amenities"]) );
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
	
	
	
	private function mainOver(){
		//trace("mainOver");
		var _mc  = this;
	}
		
	private function mainOut(){
		//trace("mainOut");
		var _mc = this;
		TweenLite.to(_mc, .25, {mcColor:0x619544});
		
	}
	
	private function detailOver(){
		//trace("detailOver");
		var _mc  = this;
		TweenLite.to(_mc, .25, {mcColor:0x000000});
	}
	
	private function detailOut(){
		//trace("detailOut");
		var _mc  = this;
		TweenLite.to(_mc, .25, {mcColor:0xFFFFFF});
	}
	
	private function detailPress(){
		//trace("detailPress");
		var _mc  = this;
		TweenLite.to(_mc, 0, {mcColor:0xFFFF00});
	}
	
	
	
	private function secondOver(){
		//trace("secondOver");
		var _mc  = this['label_mc'];
		TweenLite.to(_mc, .25, {mcColor:0x8CC63F});
		
		var _mc = this['arrow_mc']; _mc.x = _mc._x; 
		TweenLite.to(_mc, .25, {_rotation:-90, _y:12, _x:"3"});
	}
	
	private function secondOut(){
		//trace("secondOut");
		var _mc  = this['label_mc'];
		TweenLite.to(_mc, .25, {mcColor:0x713158});
		
		var _mc = this['arrow_mc'];
		TweenLite.to(_mc, .25, {_rotation:0, _y:4, _x:_mc.x});
	}
	
	

}