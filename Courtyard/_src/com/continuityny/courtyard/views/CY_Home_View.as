﻿//	Debugimport com.bourre.log.Logger;import com.bourre.log.LogLevel;//	Delegateimport com.bourre.commands.Delegate;//	Event Broadcastingimport com.bourre.events.IEvent;import com.bourre.events.BasicEvent;import com.bourre.events.EventType;import com.continuityny.courtyard.CY_EventList;import com.continuityny.courtyard.CY_EventBroadcaster;import com.bourre.visual.MovieClipHelper;//	list of Viewsimport com.continuityny.courtyard.CY_ViewList;import com.continuityny.courtyard.CY_Site_Model;import com.continuityny.courtyard.views.CY_Location_View;/// easing import com.mosesSupposes.fuse.*import com.robertpenner.easing.*;import mx.transitions.Tween;
import com.continuityny.courtyard.views.CY_Homey;
import com.continuityny.courtyard.views.CY_Nav_View;/** * @author Greg  */class com.continuityny.courtyard.views.CY_Home_View extends MovieClipHelper {		private var _data : Object;	private var LOCKED : Boolean = true;	private var _panelSets:Array = new Array();		private var _panel0 : MovieClip;	private var _panel1 : MovieClip;	private var _panel2 : MovieClip;	private var _panel3 : MovieClip;	private var _panel4 : MovieClip;	private var _panel5 : MovieClip;		private var ANIMANIAC : MovieClip ;		public var onLoaded : Function ; //TODO change this		private var loc_array : Array = ["home", "lobby", "market", "business",  "guest_room", "fitness", "outdoor"]; 			public function CY_Home_View( mc:MovieClip , ONLOADED) {		super( CY_ViewList.VIEW_HOME, mc );					trace("CY_Home_View: "+mc);				onLoaded = ONLOADED; 					view._x = 5; 		view._y = 75; 						}			public function _build(){				trace("CY_Home_View:_build");								view.attachMovie("mc_stage_size", "mask_mc", 1100); 		//ANIMANIAC = view.createEmptyMovieClip("home_mc", 1000); 				ANIMANIAC = view.attachMovie("mc_home_bg", "home_mc", 1000); 				view['home_mc'].setMask(view['mask_mc']);				// ANIMANIAC = view.createEmptyMovieClip("home_mc", 1000); 		 		new CY_Homey(ANIMANIAC, Delegate.create(this, onLoaded), Delegate.create(this, onChangeSection)); // no autostart				this._fireEvent(	new BasicEvent( CY_EventList.SET_LOCATION, 			["home", 			Delegate.create(this,activateHome),  			Delegate.create(this,removeHome)] ) );				}		private function onThisLoaded(){				trace("on this loaded"); 			}		private function onChangeSection(loc:String){				trace("HomeView: onChangeSection:"+loc);		this._fireEvent(new BasicEvent( CY_EventList.CHANGE_LOCATION, [loc.toLowerCase()]) );	}			public function changeSection(loc){				ANIMANIAC.changeSection(loc, view.home_mc);				}		public function showThumb(loc){				ANIMANIAC.showThumb(loc);				}		public function showIntro(loc){				ANIMANIAC.showIntro(loc);				}		public function activateHome(){				trace("CY_Home_View: activateHome");				view._visible = true; 					// view.attachMovie("mc_home", "home_mc", 1000); 				// ANIMANIAC.startMovie();		//changeSection("home");		/*var count = 1; ; 		var INT = setInterval( Delegate.create(this, function(){						ANIMANIAC.showIntro(loc_array[count]);			count++; 					}), 1000);*/						var _mc = view.home_mc.mask_mc; 		var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 0, .5, true);				var scope = this; 			tw.onMotionFinished = function(){		}						this._fireEvent(new BasicEvent( CY_EventList.LOCATION_ON_ARRIVED, ["home"]) );							CY_Nav_View( MovieClipHelper.getMovieClipHelper( 								CY_ViewList.VIEW_NAV ) ).animateArrow();			}				
	public function removeHome(){		trace("CY_Home_View: removeHome");						var _mc = view.home_mc.mask_mc; 		//var tw = new Tween(_mc, "_x", Quad.easeOut, _mc._x, 970, .5, true);				var scope = this; 				//view._visible = false; 				this._fireEvent(new BasicEvent( CY_EventList.LOCATION_ON_DEPARTED, ["home"]) );						}				private function _fireEvent( e : IEvent ) : Void {        CY_EventBroadcaster.getInstance().broadcastEvent( e );    }    private function _lock():Void{    	// lock interactions    	LOCKED = true;    	    }    private function _unlock():Void{    	// unlock interactions    	LOCKED = false;    }		}