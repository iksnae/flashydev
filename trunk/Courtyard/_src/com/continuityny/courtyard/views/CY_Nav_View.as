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
import com.continuityny.mc.ImageLoader;import com.continuityny.mc.MultiLoader;
import com.continuityny.filetransfer.UploadFile;
import com.continuityny.courtyard.CY_ModelList;
import com.continuityny.courtyard.CY_Site_Model;
import com.continuityny.courtyard.views.CY_Sound_View;import com.continuityny.courtyard.views.CY_Home_View;
import com.continuityny.mc.ImageResizeControls;

import com.bourre.data.libs.ConfigLoader;

import com.asual.swfaddress.SWFAddress;
import com.continuityny.mc.PlayClip;

import gs.TweenLite;
import gs.TweenFilterLite;
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

	
	private var default_duration : Number = .5;

	private var _details_mc		: MovieClip; 	private var _video_mc		: MovieClip; 	private var _sound_switch_mc		: MovieClip; 
	
	private var VIDEO_HANDLER	:FLVPlaybackHandler;
	
	private var VIDEO_PATH		:String = "flv/courtyard_high.flv";
	
	private var INT : Number;
	private var INT2 : Number;

	private var form_ath_cb_listener : Object;

	private var _detailLabel:TextFormat;
	private var _detailHeader:TextFormat;	private var _detailBody:TextFormat;
	
	private var _superLabel:TextFormat;

	private var _form_field_array:Array = [];
	
	private var PERSISTANT_DATA;
	
	private var detail_array:Array;
	
	private var _SEARCH_RESULTS:Object;
	
	private var current_loc: String;
	private var FLVPBK : FLVPlayback;	private var TV_FLVPBK : FLVPlayback;	private var _tv_mc : MovieClip;
	private var _amenities_mc : MovieClip;
	private var _find_but_mc : MovieClip;	private var _tv_but_mc : MovieClip;	private var _amen_but_mc : MovieClip;
	private var _slider_mc : MovieClip;
	private var _drop_mc:MovieClip; 
		private var selected_detail_mc:MovieClip; 
	
	private var loc_array : Array = ["home", "lobby", "market", "business",  "guest_room", "fitness", "outdoor"]; 	private var color_array : Array = ["home", 0x619544, 0x8CC63F, 0xB4D670, 0xF7931D, 0x625D84, 0xB0CEEC]; 
	
	private var a_x_array:Array = [90,167,300,478,609,754,855]; // slider positions 
	
	private var detail_am_array:Array;	private var detail_bg_array:Array;
	private var det_x_array : Array ; 
	
	private var ARROW_INT:Number;
	private var PRELOAD_INT:Number;	private var CHECK_INT:Number;
	private var ROTATE_INT:Number;
	private var DELAYDONE:Boolean;	private var INITIAL_VIDEO_PLAY:Boolean;
	
	private var FIND_OPEN:Boolean;
	private var CURRENT_ARROW_LOC : String;	private var LIVE_AMEN_LOC : String;
	
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
		detail_bg_array = new Array(); 
		
		_sound_switch_mc = view.sound_btn;
		_slider_mc 		= view.slider_nav_mc; 
		_tv_but_mc		= view.tv_but_mc;		_find_but_mc	= view.find_but_mc;		_amen_but_mc	= view.amen_but_mc;
		//_drop_mc		= view.drop_mc;		var d_mc		= view._parent.attachMovie("mc_drop_masked", "drop_mc", 12349); 
		_drop_mc 		= d_mc.drop_mc; 
		
		_detailLabel = new TextFormat("GothamRoundBold", 11, 0xFFFFFF);
		_detailLabel.align = "right";
		_detailLabel.leading = 2;
		
		_superLabel = new TextFormat("GothamRoundMed", 20, 0xFFFFFF);
		
		VIDEO_LISTENER  = new Object();
		
		
		_drop_mc._visible = false; 
		_drop_mc.bg_mc._rotation = -90; 
		_drop_mc.bg_mc._y = -30; 		_drop_mc.bg_mc._x = -50; 
		
		_form_field_array.push(_drop_mc.form_mc.city_txt);
		
		setFormFieldFocusAction();
		
		
		_drop_mc.form_mc.find_mc.onRelease = function(){
			
			getURL("http://www.marriott.com/search/default.mi");	
		}
		
		
		_slider_mc.arrow_mc._visible = false; 
		
		setLinks();
		
		
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
		
		var caption = _data.locations.section[loc].caption;
		if(caption.line1 != undefined || caption[0].line1 != undefined){
			showCaption(caption, 0);
		}
		
		
		
		
		if(_data.locations.section[loc].rotate == "true"){
			
			var neutral_rotate_mc = _details_mc.detail_base_mc.createEmptyMovieClip("rotate_mc", 5); 
			neutral_rotate_mc._x = 864-52; 
			
			for(var j=2; j>=1; j--){
				var rot_mc = neutral_rotate_mc.createEmptyMovieClip("rotate_"+j+"_mc", (100*j));
				rot_mc._x = 58; 
				new ImageLoader(rot_mc, "images/"+loc+"_"+(j+1)+".jpg");
			}
			var caption = _data.locations.section[loc].caption;
			startRotate(neutral_rotate_mc, caption, 3);
		}else{
			neutral_rotate_mc._visible = false; 
		}
		
		
		
		//this._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_ARRIVED, [loc]) );
		
		//preloadDetailImages(loc);
		
	}
	
	
	
	
	
	private function showCaption(caption, n){
		
		TweenLite.to(view.caption_mc, .5, {_y:426, delay:1});
		
		updateCaption(caption, n);
	}
	
	private function hideCaption(){
		TweenLite.to(view.caption_mc, .25, {_y:475, delay:0, ease:Quad.easeIn});
	}
	
	private function removeNeutralRotate(){
		
		var _mc = _details_mc.detail_base_mc.rotate_mc; 
		TweenLite.to(_mc, .25, {_x:1770, ease:Quad.easeIn});
		
		stopRotate();
	}
	
	
	
	
	private function updateCaption(caption, n:Number){
		
		var nn = (n == undefined) ? 0 : n ;	

		if(caption.length == undefined){
			view.caption_mc.loc_txt.text 	= caption.line1;			view.caption_mc.loc2_txt.text 	= (caption.line2 == undefined) ? "" : caption.line2;		}else{
			view.caption_mc.loc_txt.text 	= caption[n].line1;
			view.caption_mc.loc2_txt.text 	= (caption[n].line2 == undefined) ? "" : caption[n].line2;
		
		}
		
		
		
		view.caption_mc.loc2_txt._y = view.caption_mc.loc_txt._y + 11;
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
			hideCaption();
			hideCloseButton();
			
			removeNeutralRotate();
			
	}
	
	
	
	private function setVideo(loc){
		
	 	// FLVPBK = _video_mc._flvPlbk;
	 	
	 	_video_mc._visible = true; 
	 	
	 	var video_mask:MovieClip = _video_mc.attachMovie("mc_stage_size", "video_mask_mc", 1100,{_x:970});
	 	var vid_mc = _video_mc.createEmptyMovieClip("vid_mc", 1105);
	 	
	 	FLVPBK = FLVPlayback(_video_mc.vid_mc.attachMovie("FLVPlayback", "flvpb_mc",1000, {_x:79}));
		FLVPBK.setSize(800, 400);
		
		
		var path = "flv/"+loc+".flv";
		
		FLVPBK.bufferTime = 10;
		
		
		FLVPBK.load(path);
		
		
		setVideoControls();
		
		preloadVideo(loc);
		setCuePoints(loc);
		
		_video_mc.vid_mc['flvpb_mc'].setMask(_video_mc['video_mask_mc']);
		
		
		if(loc != "outdoor"){
			TweenLite.to(_video_mc.preloader_mc, .5, {_y:350});
		}
				
		_video_mc.preloader_mc.title_txt.text = _data.locations.section[loc].cue[0].title;		_video_mc.preloader_mc.loading_txt.text = "LOADING "+_data.locations.section[loc].title+" VIDEO TOUR";
		
		_video_mc.preloader_mc.swapDepths(1200);
		
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
		FLVPBK.pause();
		
		DELAYDONE = null; 
		
		clearInterval(PRELOAD_INT);
		clearInterval(PRELOAD_INT);
		
		INITIAL_VIDEO_PLAY = true; 
		
		PRELOAD_INT = setInterval(Delegate.create(this, function(){
				DELAYDONE = true; 
				clearInterval(PRELOAD_INT);
				trace("clear preload");
		}), 2000);
		
		
		VIDEO_LISTENER.playing   = Delegate.create(this, function(eventObject:Object):Void {
			trace("VIDEO_LISTENER.playing:");
				setVideoControls(true); // playing
				if(INITIAL_VIDEO_PLAY){
					CY_Sound_View( MovieClipHelper.getMovieClipHelper( 
								CY_ViewList.VIEW_SOUND ) ).playSound("video", true);
					INITIAL_VIDEO_PLAY = false; 
				}else{
					CY_Sound_View( MovieClipHelper.getMovieClipHelper( 
								CY_ViewList.VIEW_SOUND ) ).playSound("video", false);
				}
		});		
		VIDEO_LISTENER.ready   = Delegate.create(this, function(eventObject:Object):Void {
				
				trace("VIDEO_LISTENER.ready - FLVPBK.fps:"+FLVPBK.metadata.framerate);
				
				
				
				CHECK_INT = setInterval(Delegate.create(this, function(){
							if(DELAYDONE){
								
								clearInterval(CHECK_INT);
								trace("clear check delay done");
								onVideoPreloaded(loc);
							}
						}), 250);
						
				FLVPBK.removeEventListener("ready", VIDEO_LISTENER);  
				//setVideoControls(true); // playing
		});
				
		
		VIDEO_LISTENER.progress   = Delegate.create(this, function(eventObject:Object):Void {
				// base_mc.buffer_mc._visible = true; 
				var bt = FLVPBK.bytesTotal;
				var bl = FLVPBK.bytesLoaded;
				var perc = Math.ceil(bl/bt * 100); 
				
				trace("video loading: perc "+perc+" bt:"+" bl:"+bl);				trace("video loading:"+_video_mc.preloader_mc.bar_mc.perc_mc);
				_video_mc.preloader_mc.bar_mc.perc_mc._xscale = perc;
				
				//TODO SWITCH PARADIGM TO GO OFF PLAY() instead of LOAD()
				
				if(perc >= 100 && (bt != 0) ){
					
					
						/*CHECK_INT = setInterval(Delegate.create(this, function(){
							if(DELAYDONE){
								
								clearInterval(CHECK_INT);
								trace("clear check delay done");
								onVideoPreloaded(loc);
							}
						}), 250);
						*/
						
						FLVPBK.removeEventListener("progress", VIDEO_LISTENER);  
				}
				
		});
		
		VIDEO_LISTENER.complete   = Delegate.create(this, function(eventObject:Object):Void {				
				trace("FLVPBK.complete:");
				
				/*CY_Sound_View( MovieClipHelper.getMovieClipHelper( 
								CY_ViewList.VIEW_SOUND ) ).fadeSound("video");*/
				stopVideo();
				FLVPBK.removeEventListener("complete", VIDEO_LISTENER);  
		});
		
		VIDEO_LISTENER.paused   = Delegate.create(this, function(eventObject:Object):Void {
			setVideoControls(false); // playing
			
			CY_Sound_View( MovieClipHelper.getMovieClipHelper( 
								CY_ViewList.VIEW_SOUND ) ).pauseSound("video");
								
		});
		
		
		FLVPBK.addEventListener("ready", VIDEO_LISTENER);  		FLVPBK.addEventListener("progress", VIDEO_LISTENER);  		FLVPBK.addEventListener("playing", VIDEO_LISTENER);  		FLVPBK.addEventListener("complete", VIDEO_LISTENER);  		FLVPBK.addEventListener("paused", VIDEO_LISTENER);  
		
	}
	
	
	
	private function setCuePoints(loc){
		
		
		var cue_array = _data.locations.section[loc].cue;
		trace("setCuePoint:"+cue_array.length);
		//for (var i : String in cue_array) {		for (var i : Number = 1; i<cue_array.length; i++) {
			
			//FLVPBK.addASCuePoint(3, "TITLE YA BASTA", {_x:300,_y:300, color:0xFF9900});			FLVPBK.addASCuePoint(	Number(cue_array[i].time), 
									cue_array[i].title, 
									{	_x:Number(cue_array[i].x),
										_y:Number(cue_array[i].y), 										duration:Number(cue_array[i].duration), 
										color:Number(cue_array[i].color)
									});
			
			//FLVPBK.addASCuePoint(9, "FIRST SUPER");
		}
		
		
	
		
		
		
	}
	
	
	private function onVideoPreloaded(loc){
		trace("onPreloadVideo:"+loc);
		var _mc = _video_mc['video_mask_mc']; 
		var tw 	= new Tween(_mc, "_x", Quad.easeIn, _mc._x, 0, .75, true);
		
		
		TweenLite.to(_video_mc.preloader_mc, .25, {_y:402, ease:Quad.easeIn});
		
		TweenLite.to(_video_mc.bg_mc, .5, {_x:0, delay:.5, ease:Quad.easeOut});
		
		hideCaption();
		
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
			scope._video_mc._visible = false; 
			FLVPBK.removeMovieClip();
		
		}
		
		FLVPBK.removeEventListener("cuePoint", VIDEO_LISTENER);  
		
		TweenLite.to(_video_mc.bg_mc, .5, {_x:970});
		
		CY_Sound_View( MovieClipHelper.getMovieClipHelper( 
								CY_ViewList.VIEW_SOUND ) ).fadeSound("video")
								
								
	}

	
	
	
	private function showDetailLinks(loc){
		trace("CY_Nav_View: showDetailLinks: "+loc);		//view.detail_nav_mc._x = -90; 
		var _mc = view.detail_nav_mc;
		var tw 	= new Tween(_mc, "_x", Quad.easeOut, _mc._x, -150, .5, true);
		var scope = this; 
		tw.onMotionFinished = function(){
			
		}
		
		var _mc = _details_mc.nav_base_mc;
		var w = _mc._width;
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970-116, .5, true);
		
		
		createDetailsNav(loc);
	}
	
	private function openFindCourtyard(){
		trace("open find");
		
		_drop_mc._visible = true; 
		var scope = this; 
		TweenLite.to(_drop_mc.bg_mc, .25, {_y:0, _rotation:0, _x:0,
			onComplete:Delegate.create(this, showForm)} ); 
		
	}
	
	private function showForm(){
		trace("sho form");
		TweenLite.to(_drop_mc.close_but_mc, .25, {_alpha:100}); 		TweenLite.to(_drop_mc.form_mc, .5, {_alpha:100}); 
	}
	
	private function closeFindCourtyard(){
		
		trace("close find");
		
		_drop_mc.close_but_mc._alpha = 0; 		_drop_mc.form_mc._alpha = 0; 		
		_drop_mc.form_mc.stateDrop.close(); 		_drop_mc.form_mc.countryDrop.close();  
		
		TweenLite.to(_drop_mc.bg_mc, .5, {_y:-30, _x:-50, _rotation:-90, onComplete:hideFind, scope:this}); 
		
	}
	
	private function hideFind(){
		
		_drop_mc._visible = false; 
		
	}
	
	
	private function removeDetailLinks(loc){
		trace("CY_Nav_View: removeDetailLinks: "+loc);
		//view.detail_nav_mc._x = 0; 
		
		var _mc = view.detail_nav_mc;
		
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 0, 1, true);
		var scope = this; 
		
		
		removeDetailNav();
		
		
		tw.onMotionFinished = function(){
			scope._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_DEPARTED, [loc]));
		}
		
		var _mc = _details_mc.nav_base_mc;
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970, 1, true);
	}
	
	
	
	private function showDetail(e:IEvent){
		
		var loc = current_loc = e.getTarget()[0];
		
		trace("show detail:"+loc);
		
		//** Dissect LOCATION and build Detail Page **//
		var d = _details_mc.detail_base_mc.getNextHighestDepth();
		var loc_s = loc.split(",").join("");
		var base_loc 	= loc.split(",")[0];
		var detail_num 	= loc.split(",")[1];
		
		var _mc = _details_mc.detail_base_mc.attachMovie("mc_detail_pieces", "detail_page_"+loc_s+"_mc", d, {_x:10});
		
		_mc.copy_mc._alpha = 0; 
		
		 det_x_array = new Array();
		
		//** Save X Position and Collapse Detail slices **//
		for(var i=7; i>=1; i--){
			var det_mc : MovieClip = 	_mc['detail_'+i+'_mc'];
			det_x_array[i] = det_mc._x;
			det_mc._x = 970;
		}
		
		
		new Color(_mc['detail_4_mc']).setRGB(color_array[getIndexByLoc(base_loc)]);
		
		//** Build Detail Image Arrays **//
		var targ_array:Array = new Array();		var src_array:Array = new Array();
		
		targ_array.push(_mc['detail_2_mc']); src_array.push("images/det_images/"+base_loc+"_"+(Number(detail_num)+1)+"_d.jpg");		targ_array.push(_mc['detail_5_mc']); src_array.push("images/det_images/"+base_loc+"_"+(Number(detail_num)+1)+"_c.jpg");		targ_array.push(_mc['detail_6_mc']); src_array.push("images/det_images/"+base_loc+"_"+(Number(detail_num)+1)+"_b.jpg");		targ_array.push(_mc['detail_7_mc']); src_array.push("images/det_images/"+base_loc+"_"+(Number(detail_num)+1)+"_a.jpg");
		
		//** Load 'em **//
		new MultiLoader(	src_array, targ_array, 
							Delegate.create(this, detailInTransition, loc), 
							Delegate.create(this, showDetailLoadProgress)
						);
		
		
		//** Build Image Rotation if Applicable  **//
		if(_data.locations.section[base_loc].detail[detail_num].rotate == "true"){
			for(var j=4; j>=1; j--){
				var rot_mc = _mc.rotate_mc.createEmptyMovieClip("rotate_"+j+"_mc", (100*j));
				new ImageLoader(rot_mc, "images/det_images/"+base_loc+"_"+(Number(detail_num)+1)+"_b_"+j+".jpg");
			}
			var caption = _data.locations.section[base_loc].detail[detail_num].caption;
			startRotate(_mc.rotate_mc, caption, 4);
		}else{
			_mc.rotate_mc._visible = false; 
		}
		
		
		//** Build Detail Title + Copy **//
		var header_txt:TextField = _mc.copy_mc.header_txt;		var body_txt:TextField = _mc.copy_mc.body_txt;
		header_txt.text = _data.locations.section[base_loc].detail[detail_num].header;
		body_txt.text 	= _data.locations.section[base_loc].detail[detail_num].text;
		trace("body:"+_data.locations.section[base_loc].detail[detail_num].text+" header_txt:"+header_txt);
		
		header_txt.autoSize = true		body_txt.autoSize 	= true
		
		body_txt._y = header_txt._y + header_txt._height + 5;
		
		
		//** Display Caption if Applicable **//
		var caption = _data.locations.section[base_loc].detail[detail_num].caption;
		if(caption.line1 != undefined || caption[0].line1 != undefined){
			showCaption(caption, 0);
		}
		
		
		//** Set Close Button **//
		_details_mc.close_mc.label_mc.onRelease = Delegate.create(this, function(){
			
			var base = CY_Location_View.getBaseLiveLocation().split(",").join("");
			trace("base:"+base);
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, [base] ) );
			
		});
		
		_details_mc.close_mc.label_mc.onRollOver = shiftLabelOver;
		_details_mc.close_mc.label_mc.onRollOut  = shiftLabelOut;
		
		stopVideo();
		
		
	}
	
	
	private function detailInTransition(loc){
		
		trace("detailInTransition:"+loc);
		//** Transition after Detail Images Load **//
		
		var loc_s = loc.split(",").join("");
		var base_loc 	= loc.split(",")[0];
		var detail_num 	= loc.split(",")[1];
		
		var _mc = _details_mc.detail_base_mc["detail_page_"+loc_s+"_mc"];
		
		_mc.copy_mc._alpha = 0; 
		
		//** Slices **//
		for(var i=7; i>=1; i--){
			var det_mc : MovieClip = 	_mc['detail_'+i+'_mc'];
			var r = (random(10)/10);
			var t = 1;
			TweenLite.to(det_mc, t, {_x:det_x_array[i], delay:.12*(7-i), easing:Quint.easeOut});
		}
		
		//** Entire Clip **//
		TweenFilterLite.from(_mc, 1.5, {blurFilter:{blurX:30, blurY:30}, easing:Quad.easeOut});
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 0, 1.7, true);
		var scope = this; 
		
		tw.onMotionFinished = function(){
			TweenLite.to(_mc.copy_mc, 1, {_alpha:100});
			scope.showCloseButton();
			scope._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_ARRIVED, [loc]) );
		}
		
		
	}
	
	
	private function showDetailLoadProgress(perc:Number){
		trace("loading:"+perc);
		
	}
	
	
	private function startRotate(base_mc, caption, n){
		
		
			var count = 1; 
		
			ROTATE_INT = setInterval(Delegate.create(this, function(){
				
				var rot_mc = base_mc["rotate_"+count+"_mc"];
				trace("rotate:"+rot_mc);
				rot_mc._x = 58;
				var t = 1; 
				TweenLite.to(rot_mc, t, {_x:-526-58, easing:Quad.easeOut});
				TweenFilterLite.from(rot_mc, t, {blurFilter:{blurX:30, blurY:30}, easing:Quad.easeOut, overwrite:false});
				
				//var caption = _data.locations.section[loc].caption;
				updateCaption(caption, count-1);
		
				count++;
				
				if(count == n){clearInterval(ROTATE_INT)}
				
			}), 5000);
			// new ImageLoader(rot_mc, "images/det_images/"+base_loc+"_"+(Number(detail_num)+1)+"_b_"+j+".jpg");
			
		
		//startRotate(_mc.rotate_mc);	
	}
	
	private function stopRotate(base_mc){
			clearInterval(ROTATE_INT); 
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
		
		TweenLite.to(_mc.rotate_mc, .5, {_x:-_mc.rotate_mc._width});
		
		var scope = this;
		
		tw.onMotionFinished = function(){
			var loc_s = loc.split(",").join("");
			scope._details_mc.detail_base_mc["detail_page_"+loc_s+"_mc"].removeMovieClip();
			trace("CY_Nav_View: removeDetail: "+loc_s+" _mc:"+scope._details_mc["detail_page_"+loc_s+"_mc"]);
		}
			scope._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_DEPARTED, [loc]) );
			
		
		hideCaption();
		hideCloseButton();
		
		
		
	}
	
	private function showCloseButton(){
		TweenLite.to(_details_mc.close_mc, .5, {_y:382, easing:Quint.easeIn});
	}
	
	private function hideCloseButton(){
		TweenLite.to(_details_mc.close_mc, .5, {_y:411, easing:Quint.easeIn});
	}
	
	// hack untill fix location manager
	private function removeCurrentDetail(){
		var loc_s = current_loc.split(",").join("");
		var _mc = _details_mc.detail_base_mc["detail_page_"+loc_s+"_mc"]; 
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970, .5, true);	
	}
	
	
	private function onSliderNavClick(i){
				trace("loc_array:"+loc_array[i]+" i:"+i);
				_slider_mc.arrow_mc._visible = true; 
				var loc = loc_array[i]; 
				
			CURRENT_ARROW_LOC = loc;
			centerSlider(i);
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, [loc] ) );
			
			CY_Home_View( MovieClipHelper.getMovieClipHelper( 
								CY_ViewList.VIEW_HOME ) ).changeSection(loc);
				
						
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
			/*Delegate.create(this, function(){
				
				 ANIMANIAC.showThumb(loc_array[i]);
				CY_Home_View( MovieClipHelper.getMovieClipHelper( 
								CY_ViewList.VIEW_HOME ) ).showThumb("outdoor");
				mainOver();;
			}, i);
			*/			
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
				_sound_switch_mc.gotoAndStop("OFF");
				CY_Sound_View( MovieClipHelper.getMovieClipHelper( 
				CY_ViewList.VIEW_SOUND ) ).soundMute(true);
				
				CY_Sound_View( MovieClipHelper.getMovieClipHelper( 
				CY_ViewList.VIEW_SOUND ) ).fadeSound("video");
				
				//this._fireEvent(	new BasicEvent( CY_EventList.MUTE_SOUND, [true] ) );
				
				view.bars_mc._visible = false; 
				
			}else{
				trace("unmute sound");
				_sound_switch_mc.gotoAndStop("ON");
				CY_Sound_View( MovieClipHelper.getMovieClipHelper( 
				CY_ViewList.VIEW_SOUND ) ).soundMute(false);
				
				//CY_Sound_View( MovieClipHelper.getMovieClipHelper( 
				//CY_ViewList.VIEW_SOUND ) ).fadeUpSound("video");
				
				// this._fireEvent(	new BasicEvent( CY_EventList.MUTE_SOUND, [false] ) );
				
				view.bars_mc._visible = true; 
				
				
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
		_find_but_mc.onRelease 	= Delegate.create(this, function(){
			
			if(FIND_OPEN){
				closeFindCourtyard();
				FIND_OPEN = false; 
			}else{
				openFindCourtyard();
				FIND_OPEN = true; 
			}
		});
		
		_drop_mc.close_but_mc.onRelease 	= Delegate.create(this, closeFindCourtyard);
			
			
		_amenities_mc.close_but_mc.onRelease = Delegate.create(this, function(){
			
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, ["lobby"] ) );
			
		});
		
		
		
		/*view.slider_nav_mc.nav_2_mc._txt.text = "MARKET";
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
			
		});*/
		
		var spacing_fmt:TextFormat = new TextFormat();
		spacing_fmt.letterSpacing = 5.7;
		spacing_fmt.font = "VerdanaBold";
		
		var _txt:TextField = view.bottom_nav_mc.bot_bar_mc.con_mc.box_txt; 
		_txt.text = _data.nodes.nodes;
		_txt.setTextFormat(spacing_fmt);
	}
	
	
	
	private function createDetailsNav(loc){
		
		selected_detail_mc = null;
		for(var each in view.detail_nav_mc){
			var this_mc:MovieClip = view.detail_nav_mc[each];
			this_mc.removeMovieClip();
		}
		
		
		var loc_details = _data.locations.section[loc].detail;
		for(var i=0; i<loc_details.length; i++){
			trace(loc+" details:"+loc_details[i].title);
			
			//var this_nav_mc = view.detail_nav_mc.attachMovie("mc_det_nav_label", "nav_"+i+"_mc", (i*10));
			var this_nav_mc = view.detail_nav_mc.createEmptyMovieClip("nav_"+i+"_mc", ((i+1)*10));
			var lab = loc_details[i].title;
			createDetailLabel(this_nav_mc, lab);
			
			//this_nav_mc.attachMovie("mc_detail_pebble", "bg_mc", 50);
			
			
			var prev_nav_mc = view.detail_nav_mc["nav_"+(i-1)+"_mc"];
			this_nav_mc._x = 1010; 
			//this_nav_mc._y = 130+(60*i);
			if(i == 0){
				this_nav_mc._y = 165; 
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
						
			this_nav_mc.onRelease = Delegate.create(this, onDetailNavClick, loc+","+i, this_nav_mc) ;			this_nav_mc.onRollOver = Delegate.create(this, detailOver, this_nav_mc) ;			this_nav_mc.onRollOut = Delegate.create(this, detailOut, this_nav_mc) ;			this_nav_mc.onPress = detailPress ;
			
		}	
		
	}
	
	private function removeDetailNav(){
		
		
		selected_detail_mc = null;
		for(var each in view.detail_nav_mc){
			var this_mc:MovieClip = view.detail_nav_mc[each];
			this_mc.removeMovieClip();
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
	
	public function animateArrow(){
		
		_slider_mc.arrow_mc._x = -100; 
		_slider_mc.arrow_mc._visible = true; 
		
		CY_Home_View( MovieClipHelper.getMovieClipHelper( 
								CY_ViewList.VIEW_HOME ) ).showIntro("lobby");
		centerSlider(1);			
		
		
		var count = 2; ; 
		var INT = setInterval( Delegate.create(this, function(){
			
			//ANIMANIAC.showIntro(loc_array[count]);
			CY_Home_View( MovieClipHelper.getMovieClipHelper( 
								CY_ViewList.VIEW_HOME ) ).showIntro(loc_array[count]);
			count++; 	
			centerSlider(count-1);
			
			if(count > loc_array.length){
				clearInterval(INT);	
				
				CY_Home_View( MovieClipHelper.getMovieClipHelper( 
								CY_ViewList.VIEW_HOME ) ).showThumb("lobby");
								centerSlider(1);	
								
				CY_Home_View( MovieClipHelper.getMovieClipHelper( 
								CY_ViewList.VIEW_HOME ) ).changeSection("home");
								
			}
		
		}), 1000);
		
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
		
		
		TV_FLVPBK = FLVPlayback(_tv_mc.vid_mc.attachMovie("FLVPlayback", "flvpb_mc",1000, {_x:240}));
		TV_FLVPBK.setSize(750, 400);
		
		var path = "./flv/video_1.flv";
		
		TV_FLVPBK.load(path);
		TV_FLVPBK.play();
		
		//_tv_mc.tv_nav_mc.swapDepths(1010);		//_tv_mc.thumb_2_mc.swapDepths(1020);
		//_tv_mc.close_mc.swapDepths(1030);
		
		_tv_mc.tv_nav_mc.thumb_1_mc.onRelease = Delegate.create(this, function(){
			var path = "./flv/video_1.flv";
			TV_FLVPBK.load(path);
			TV_FLVPBK.play();
			TV_FLVPBK.setSize(750, 400);
		}); 
		
		_tv_mc.tv_nav_mc.thumb_2_mc.onRelease = Delegate.create(this, function(){
			var path = "./flv/video_2.flv";
			TV_FLVPBK.load(path);
			TV_FLVPBK.play();
			TV_FLVPBK.setSize(750, 400);
		}); 
		
		_tv_mc.tv_nav_mc.close_mc.onRelease = Delegate.create(this, function(){
			this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, ["lobby"] ) );
		});
		
		this._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_ARRIVED, ["tv"]) );
	}
	
	private function removeTV() : Void {
		var _mc = _tv_mc.mask_mc; 
		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970, .5, true);
		this._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_DEPARTED, ["tv"]) );
		
		TV_FLVPBK.pause();
		
		TV_FLVPBK.removeMovieClip();
		
		
	}

	private function activateAmen() : Void {
		//var _mc = _ammenities_mc.mask_mc; 
		//var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 0, .5, true);
	
		//new PlayClip( _ammenities_mc.amen_anim_mc, 33);
		_amenities_mc._visible = true;
		 _amenities_mc.amen_anim_mc.gotoAndPlay("IN");
		 
		 	buildAmen();
		 	
		 	
		this._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_ARRIVED, ["amenities"]) );
	}

	
	
	private function buildAmen(){
		
		for (var i = 1; i< loc_array.length; i++) {
			var loc = loc_array[i];
			trace("buildAmen :"+loc);
			_amenities_mc.amen_anim_mc.attachMovie("mc_am_block", "block_"+loc+"_mc", 10*i, 
				{_alpha:0, _y:475, _x:5+((i-1)*162)});
			
			var block_mc:MovieClip = _amenities_mc.amen_anim_mc["block_"+loc+"_mc"];
			block_mc.title_txt.text = _data.locations.section[loc].title; 
			
			//detail_am_array = new Array();
			//var temp_array  : Array = new Array();
			//temp_array = _data.locations.section[loc].detail.splice(); 
			detail_am_array = _data.locations.section[loc].detail; 
			
			TweenLite.to(block_mc, .25, {_alpha:100, delay:(.25*(6-i))});
			
			for (var j = 0; j< detail_am_array.length; j++) {
				
				block_mc.attachMovie("mc_am_label", "label_"+j+"_mc", 10*j, {_x:40});
				var label_mc:MovieClip = block_mc["label_"+j+"_mc"];
				
				var _txt:TextField = 	label_mc.label_txt; 
				_txt.multiline = true; 
				_txt.autoSize = true; 
				_txt.text = _data.locations.section[loc].detail[j].title;
				
				var prev_txt = block_mc["label_"+(j-1)+"_mc"].label_txt;
				
				if(j == 0){
					_txt._y = -10 - _txt._height; 
				}else{
					_txt._y = (prev_txt._y-_txt._height-20);
				}
				
				var scope = this; 
				label_mc.loc = loc+","+j;
				
				label_mc.onRollOver = shiftLabelOver;
				label_mc.onRollOut = shiftLabelOut; 
								label_mc.onRelease = function(){
			
					//var base = CY_Location_View.getBaseLiveLocation().split(",").join("");
					//trace("base:"+base);
					var this_loc = this.loc;
					//scope._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, [this_loc] ) );
					
					scope.showAmenDetail(this_loc);
					scope.closeAmen();
					
				};
				
				
				
			}
				
		}
	}
	
	
	private function shiftLabelOver(){
		
		var _mc = this; 
		_mc.x = _mc._x; 
		
		TweenLite.to(_mc, .25, {_x:"5"});
			
		
	}
	
	private function shiftLabelOut(){
		
		var _mc = this; 
		
		TweenLite.to(_mc, .25, {_x:_mc.x});
			
		
	}
	
	private function showAmenDetail(loc){
		
		//var loc = current_loc = e.getTarget()[0];
		LIVE_AMEN_LOC = loc; 
		trace("show AMEN detail:"+loc);
		
		//** Dissect LOCATION and build Detail Page **//
		var d = _details_mc.detail_base_mc.getNextHighestDepth();
		var loc_s = loc.split(",").join("");
		var base_loc 	= loc.split(",")[0];
		var detail_num 	= loc.split(",")[1];
		
		var _mc = _details_mc.detail_base_mc.attachMovie("mc_detail_pieces", "detail_page_"+loc_s+"_mc", d, {_x:10});
		
		_mc.copy_mc._alpha = 0; 
		
		 det_x_array = new Array();
		
		//** Save X Position and Collapse Detail slices **//
		for(var i=7; i>=1; i--){
			var det_mc : MovieClip = 	_mc['detail_'+i+'_mc'];
			det_x_array[i] = det_mc._x;
			det_mc._x = 970;
		}
		
		//** Build Detail Image Arrays **//
		var targ_array:Array = new Array();
		var src_array:Array = new Array();
		
		targ_array.push(_mc['detail_2_mc']); src_array.push("images/det_images/"+base_loc+"_"+(Number(detail_num)+1)+"_d.jpg");
		targ_array.push(_mc['detail_5_mc']); src_array.push("images/det_images/"+base_loc+"_"+(Number(detail_num)+1)+"_c.jpg");
		targ_array.push(_mc['detail_6_mc']); src_array.push("images/det_images/"+base_loc+"_"+(Number(detail_num)+1)+"_b.jpg");
		targ_array.push(_mc['detail_7_mc']); src_array.push("images/det_images/"+base_loc+"_"+(Number(detail_num)+1)+"_a.jpg");
		
		//** Load 'em **//
		new MultiLoader(	src_array, targ_array, 
							Delegate.create(this, detailInTransition, loc), 
							Delegate.create(this, showDetailLoadProgress)
						);
		
		
		//** Build Image Rotation if Applicable  **//
		if(_data.locations.section[base_loc].detail[detail_num].rotate == "true"){
			for(var j=4; j>=1; j--){
				var rot_mc = _mc.rotate_mc.createEmptyMovieClip("rotate_"+j+"_mc", (100*j));
				new ImageLoader(rot_mc, "images/det_images/"+base_loc+"_"+(Number(detail_num)+1)+"_b_"+j+".jpg");
			}
			var caption = 	_data.locations.section[base_loc].detail[detail_num].caption;
			
			startRotate(_mc.rotate_mc, caption, 3);
		}else{
			_mc.rotate_mc._visible = false; 
		}
		
		
		//** Build Detail Title + Copy **//
		var header_txt:TextField = _mc.copy_mc.header_txt;
		var body_txt:TextField = _mc.copy_mc.body_txt;
		header_txt.text = _data.locations.section[base_loc].detail[detail_num].header;
		body_txt.text 	= _data.locations.section[base_loc].detail[detail_num].text;
		trace("body:"+_data.locations.section[base_loc].detail[detail_num].text+" header_txt:"+header_txt);
		
		header_txt.autoSize = true
		body_txt.autoSize 	= true
		
		body_txt._y = header_txt._y + header_txt._height + 5;
		
		
		//** Display Caption if Applicable **//
		var caption = _data.locations.section[base_loc].detail[detail_num].caption;
		if(caption.line1 != undefined){
			showCaption(caption, 0);
		}
		
		
		//** Set Close Button **//
		_details_mc.close_mc.label_mc.onRelease = Delegate.create(this, function(){
			
			var base = CY_Location_View.getBaseLiveLocation().split(",").join("");
			trace("base:"+base);
			//this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, ["amenities"] ) );
			this.activateAmen();
			this.removeAmenDetail(loc);
			
		});
		
		_details_mc.close_mc.label_mc.onRollOver = shiftLabelOver;
		_details_mc.close_mc.label_mc.onRollOut  = shiftLabelOut;
		
		//stopVideo();
		
		centerSlider(getIndexByLoc(base_loc));
		
	}
	
	
	private function getIndexByLoc(loc){
		
		for(var each in loc_array){
			
			if(loc_array[each] == loc){
				return each;	
				break;
			}
		}
		
		
	}
	
	
	private function removeAmenDetail(loc){
		
		//var loc = e.getTarget()[0];
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
			//scope._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_DEPARTED, [loc]) );
			
		
		hideCaption();
		hideCloseButton();
		
		
		
	}
	
	
	
	
	private function removeAmen() : Void {
		//var _mc = _ammenities_mc.mask_mc; 
		//var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970, .5, true);
		removeAmenDetail(LIVE_AMEN_LOC); 
		closeAmen();
		this._fireEvent(	new BasicEvent( CY_EventList.LOCATION_ON_DEPARTED, ["amenities"]) );
		
		
	}
	
	private function closeAmen() : Void {
		//var _mc = _ammenities_mc.mask_mc; 
		//var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970, .5, true);
		 _amenities_mc.amen_anim_mc.gotoAndPlay("OUT");
		
		for (var i = 1; i< loc_array.length; i++) {
			var loc = loc_array[i];
			trace("buildAmen :"+loc);
			var block_mc:MovieClip = _amenities_mc.amen_anim_mc["block_"+loc+"_mc"];
			
			TweenLite.to(block_mc, .0125, {_alpha:0, delay:(.0125*i)});
			
			
			
		}
		
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
		var _mc  = this;		TweenLite.to(_mc, .25, {mcColor:0x619543});
	}	
		
	private function mainOut(){
		//trace("mainOut");
		var _mc = this;
		TweenLite.to(_mc, .25, {mcColor:0x619544});
		
	}
	
	
	
	private function onDetailNavClick(loc, _mc){
				
				trace("onDetailNavClick:"+loc);
				selected_detail_mc = _mc;
				
				var base_mc:MovieClip = _mc._parent; 
				
				for(var each in base_mc){
					if(base_mc[each]._name != selected_detail_mc._name){
						TweenLite.to(base_mc[each], .25, {mcColor:0xFFFFFF});
					}
				}				
				for(var each in detail_bg_array){
					var this_mc:MovieClip = detail_bg_array[each];
					
					if(_mc.bg_mc._name != this_mc._name){
						this_mc.removeMovieClip();
						trace("remove:"+this_mc);
					}
					
					
				}
		
				_mc.onRollOut();
				 
				
				this._fireEvent(	new BasicEvent( CY_EventList.CHANGE_LOCATION, [loc] ) );
						
	}
	
	
	private function detailOver(_mc){
		trace("detailOver:selected_detail_mc"+selected_detail_mc._name);		trace("detailOver:_mc"+_mc._name);
		//var _mc  = this;
		TweenLite.to(_mc, .25, {mcColor:0x4D7635});
		
		if(_mc._name != selected_detail_mc._name){
			var d:Number = _mc.getDepth(); 
			
			var base_mc:MovieClip = _mc._parent; 
			var bg_mc:MovieClip = base_mc.attachMovie("mc_detail_pebble", (_mc._name+"_bg_mc"), d-1);
			
			detail_bg_array.push(bg_mc);
			
			bg_mc._x = _mc._x+75; 
			bg_mc._y = _mc._y+14; 
			
			bg_mc._rotation += (d/3); 
			
			_mc.bg_mc = bg_mc; 
		}
		
		trace("bg_mc:"+bg_mc+" y:"+bg_mc._y+" x:"+bg_mc._x+" d:"+d);
		
	}
	
	private function detailOut(_mc){
		// var _mc  = this;
		
		trace("detailOut ");
		
		if(selected_detail_mc._name != _mc._name){
			_mc.bg_mc.removeMovieClip();
			TweenLite.to(_mc, .25, {mcColor:0xFFFFFF});		}else{
			TweenLite.to(_mc, .25, {mcColor:0x4D7635});		
		}
	}
	
	private function detailPress(){
		//trace("detailPress");
		var _mc  = this;
		TweenLite.to(_mc, 0, {mcColor:0xFFFFFF});
		
		
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
	
	
	
	private function setFormFieldFocusAction(){
		
		
		view.createTextField("hold_txt", 123567, -1000, -1000, 1, 1)
		
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
	
	
	private function setLinks(){
		
		
		view.whats_new_btn.onRelease = function(){
			getURL("http://www.gocourtyard.com");	
		}
		
		view.whats_new_btn.onRollOver = function(){
			this.gotoAndStop(2);
		}
		
		view.whats_new_btn.onRollOut = function(){
				this.gotoAndStop(1);	
		}
		view.privacy_btn.onRelease = function(){
			getURL("http://www.marriott.com/privacy.mi");	
		}
		view.privacy_btn.onRollOver = function(){
			this.gotoAndStop(2);
		}
		
		view.privacy_btn.onRollOut = function(){
				this.gotoAndStop(1);	
		}
		view.terms_btn.onRelease = function(){
			getURL("http://www.marriott.com/copyrite.mi");
		}
		view.terms_btn.onRollOver = function(){
			this.gotoAndStop(2);
		}
		
		view.terms_btn.onRollOut = function(){
				this.gotoAndStop(1);	
		}
		
		view.rewards_mc.onRelease = function(){
			getURL("https://www.marriott.com/rewards/createAccount/createAccountPage1.mi?segmentId=elite.nonrewards");
		}
		view.further_mc.onRelease = function(){
			getURL("http://www.marriott.com/hotel-rates/travel.mi");
		}
		
	}
	
	
	private function setVideoControls(playing:Boolean){
		
		var preload_mc:MovieClip = _video_mc.preloader_mc; 
		
		if(playing){
			preload_mc.stop_mc.gotoAndStop(1);			preload_mc.play_mc.gotoAndStop(2);
			preload_mc.stop_mc.enabled = true; 			preload_mc.play_mc.enabled = false; 
		}else if(!playing){
			preload_mc.stop_mc.gotoAndStop(2);
			preload_mc.play_mc.gotoAndStop(1);
			preload_mc.stop_mc.enabled = false; 
			preload_mc.play_mc.enabled = true; 
		}else{
			preload_mc.stop_mc.gotoAndStop(1);
			preload_mc.play_mc.gotoAndStop(1);
			preload_mc.stop_mc.enabled = false; 
			preload_mc.play_mc.enabled = false; 
			
		}
		
		preload_mc.play_mc.onRelease = Delegate.create(this, function() {
			FLVPBK.play();
		}); 
		
		preload_mc.stop_mc.onRelease = Delegate.create(this, function(){
			FLVPBK.pause();
		}); 
		
		preload_mc.hit_mc.onRollOver = Delegate.create(this, function(){
			trace("hit rollover");
			TweenLite.to(_video_mc.preloader_mc, .25, {_y:350, ease:Quad.easeIn});
		}); 
		
		preload_mc.hit_mc.onRollOut = Delegate.create(this, function(){
			var hitPebble:Boolean = preload_mc.pebble_mc.hitTest(_xmouse, _ymouse);
				trace("hit rollOUT - hitPebble:"+hitPebble);
			if(!hitPebble){
				TweenLite.to(_video_mc.preloader_mc, .25, {_y:402, ease:Quad.easeIn});
			}
		}); 
		
		preload_mc.pebble_mc.onRollOver = Delegate.create(this, function(){
			trace("pebble rollover");			//preload_mc.hit_mc.enabled = false; 
		});
		
		preload_mc.pebble_mc.onRollOut = Delegate.create(this, function(){			var hitHIT:Boolean = preload_mc.hit_mc.hitTest(_xmouse, _ymouse);
			trace("pebble rollOUT - hitHIT:"+hitHIT);
			if(!hitHIT){
				TweenLite.to(_video_mc.preloader_mc, .25, {_y:402, ease:Quad.easeIn});
			}
		}); 
		
		
	}
	
	

}