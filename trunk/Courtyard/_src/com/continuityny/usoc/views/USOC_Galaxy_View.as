
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
import com.continuityny.mc.RoundWindow;
import com.continuityny.mc.ImageLoader;
import com.bourre.data.libs.ConfigLoader;
import com.continuityny.usoc.USOC_ModelList;import com.continuityny.form.SubmitForm;/**
 * @author Greg
 * 
 * 
 * GALAXY - the galaxy can be entered in one of 4 ways 
 * 		
 * 		1. Directly to a 'supporter' from a validation email - 
 * 			#/galaxy,supporter,uid,vcode
 * 				- uid is the supporter id
 * 				- vcode is the validation code if the supporter is not already validated
 * 		
 * 		2. Directly to a supporter from Search - 
 * 			#/galaxy,supporter,uid
 * 				- same as above minus the vcode
 * 		
 * 		3. From an Invitaion email - 
 * 			#/galaxy,connect,uid,icode
 * 				- uid is the invited persons id
 * 				- icode is to validate that it is from a valid invitation
 * 		
 * 		4. Directly to the start of an athletes galaxy by the jump nav - 
 * 			#/galaxy,athlete,aid
 * 				- aid is the athletes id
 * 		
 * 
 */
 
 
class com.continuityny.usoc.views.USOC_Galaxy_View extends MovieClipHelper {

	private var INT : Number;
	
	private var _SUPPORTER:Object;
	private var _config:Object;
	
	private var _r : MovieClip;

	var chain:Array = [];
	var tempChain:Array = []; // add  children to this at end of chain, for bounds
		

	private var athlete_mc : MovieClip;

	private var _swf_mc : MovieClip;
	
	
	private var GALAXY_LIVE : Boolean;
	private var _children : Object;
	private var GALAXY_LOADED : Boolean;	
	private var _live_loc : String ; 		private var _UDATA : Object;	private var _NODE : MovieClip ;	
	public static var SELECTED_AID ;	// public var view : MovieClip; inherrited from MovieClipHelper
	
	
	
	
	
	public function USOC_Galaxy_View( mc ) {
		
		super( USOC_ViewList.VIEW_GALAXY, mc );
			
		trace("USOC_Galaxy_View: mc:   eee "+mc);
			
		_init();
			
		//view._x = -90;
	}
	
	
	
	
	public function _init(){
				view._visible = false; 	
		
		_swf_mc = view.swf_mc;
		
		// SET UP GALAXY LOCATIONS
		this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["galaxy,athlete", 
			Delegate.create(this,activateGalaxy),  
			Delegate.create(this,removeGalaxy),
			Delegate.create(this,activateAthlete) // onArrivalDone
			] ) );
		
			
		this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["galaxy,supporter", 
			Delegate.create(this,activateGalaxy),  
			Delegate.create(this,removeGalaxy),
			Delegate.create(this,activateGalaxySupporter) // onArrivalDone
			] ) );
			
		this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["galaxy,connect", 
			Delegate.create(this,activateGalaxy),  
			Delegate.create(this,removeGalaxy),
			Delegate.create(this,activateGalaxyConnect) // onArrivalDone
			] ) );
			
		
			
		this._fireEvent(	new BasicEvent( USOC_EventList.SET_LOCATION, 
			["galaxy", 
			Delegate.create(this,fauxGalaxy),  
			Delegate.create(this,removeFauxGalaxy)
			] ) );
	
		
	}
	

	public function fauxGalaxy(){
		_global._r.devtrace("G.VIEW >>>> fauxGalaxy("+")");
		this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_ARRIVED, ["galaxy"]) );
	}
	
	
	public function removeFauxGalaxy(){
		_global._r.devtrace("G.VIEW >>>> removeFauxGalaxy("+")");
		this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_DEPARTED, ["galaxy"]) );
		
	}
	
	
	
	
	public function activateGalaxy(data){ // GENERIC GALAXY ENTRY POINT
		_global._r.devtrace("G.VIEW >>>> activateGalaxy("+data+")");
		_global._r.clearGalaxy();
		//_global._r.galaxyEnabled(true);
		
		_config = USOC_Site_Model.getConfig();
		
		var validate_url:String = _config.query.validate_supporter;

		
		
		_UDATA = data; 
		
		_global._r.devtrace("activateGalaxy:uid"	+ data.uid
				+	" aid:"			+ data.aid
				+	" vcode:"		+ data.vcode
				+	" icode:"		+ data.icode
				+	" firstname:"	+ data.firstname
				+	" form_aid:"	+ data.form_aid);
		
		// priority goes to form_aid
		if(data.form_aid == undefined){
			
			SELECTED_AID = data.aid;
			
			if(data.aid == undefined){
				SELECTED_AID = 0;
			}
		}
		
		//SELECTED_AID = (data.form_aid == undefined) ? data.aid : data.form_aid ;  
		
		USOC_Nav_View( MovieClipHelper.getMovieClipHelper( USOC_ViewList.VIEW_NAV ) ).closeAthleteMenu();
	
		// UNIVERSE - MAKE INVISIBLE
		USOC_Universe_View( MovieClipHelper.getMovieClipHelper( USOC_ViewList.VIEW_UNIVERSE ) ).view._visible = false;
		
		// GALAXY - MAKE VISIBLE
		view._visible = true ; 	
		
		
		_global._r.onSupporter 		= Delegate.create(this, makeSupporter, 		_UDATA);
		_global._r.makeFakeChildren = Delegate.create(this, makeFakeChildren, 	_UDATA);
		_global._r.getConnected 	= Delegate.create(this, getConnected, 		_UDATA.aid);
		
		_global._r.getFriends		= Delegate.create(this, getFriends);
		_global._r.athleteRelease 	= Delegate.create(this, athleteRelease); 
		
		_global._r.returnToUniverse 	= Delegate.create(this, returnToUniverse); 
		
		_global._r.flagMessage		= Delegate.create(this, flagMessage);
		_live_loc = USOC_Location_View.getLiveLocation();
		
		_global._r.devtrace("activategalaxy: live_loc - "+_live_loc);
		
		
		
		switch (_live_loc) {
			
			case "galaxy,athlete" :	
				
				_UDATA = USOC_Site_Model.getAthleteDataById(_UDATA.aid); // MAKE A FULL data object rom just the aid
				
				_global._r.devtrace("ActivateGalaxy: LIVE: galaxy,athlete - aid:"+_UDATA.aid);
				_global._r.devtrace("activateGalaxy - galaxy,athlete:uid"	+ data.uid
				+	" aid:"			+ data.aid
				+	" vcode:"		+ data.vcode
				+	" icode:"		+ data.icode
				+	" firstname:"	+ data.firstname);
				
				_loadFriendsXML(_UDATA.aid, handleAthleteChildrenLoaded, "athlete");
				
				break;
				
			case "galaxy,connect" :
				
				_global._r.devtrace("ActivateGalaxy: LIVE: galaxy,connect - uid:"+data.uid+" aid:"+data.aid);
				 _loadSupporterXML(data.uid); // PARENT UID - //TODO - replace with PARENT when all data is available //need to ask brian
				
				break;
				
			case "galaxy,supporter" :	
				
				_global._r.devtrace("ActivateGalaxy: LIVE: galaxy,supporter:"+data.vcode);
				
				if(data.vcode == undefined){ // internal 
					_loadSupporterXML(data.uid); // change this to uid once the get_chain_by_uid.php can return results for a non validated uid
					trace("ActivateGalaxy: LIVE: galaxy,supporter:internal-"+data.vcode);
				
				}else{	// validate external link 
					
					trace("ActivateGalaxy: galaxy,supporter:external-"+data.vcode);
					var send_vars:LoadVars = new LoadVars();
					send_vars.uid  	= data.uid;
					send_vars.vcode = data.vcode;
					var callback:Function = Delegate.create(this, supporterValidateCallback);
					new SubmitForm(validate_url, send_vars, "GET", callback, false);
				}
	
				
				break;
			
		}
		
		
			
	}
	
	private function flagMessage(uid){
		
		_global._r.devtrace("USOC_Galaxy_View:flagMessage - uid: "+uid);
		var flag_url:String = _config.query.flag;
		var send_vars:LoadVars = new LoadVars();
		send_vars.uid  	= uid;
		new SubmitForm(flag_url, send_vars, "GET", flagCallback, false);
		
	}
	private function flagCallback(answer){
		_global._r.devtrace("flagCallback: "+answer);
	}
	
	private function supporterValidateCallback(answer:String, data_string:String){
		
		_global._r.devtrace("form3Callback: "+answer+" data_string:"+data_string);
		
		if(answer=="valid"){
		//	initFormStepFour();
				_loadSupporterXML(_UDATA.uid);
		}else if(answer=="invalid"){
			if(data_string == "No rows affected."){
					_loadSupporterXML(_UDATA.uid);
			}
			//_form_mc.error_txt.text = "There was a problem with your submission. Please resubmit your Validation code or try again later.";
		}else if(answer=="connection"){
			//_form_mc.error_txt.text = "There was a problem with the connection. Please try again later.";
		}
		
	}
	
	
	
	private function getFriends(id, node){
		_global._r.devtrace("G.VIEW >>>> getFriends("+id+", "+node+")");
		//trace(">>>> USOC_Galaxy getFriends - "+id);
		_NODE = node;
		_loadFriendsXML ( id, onFriends, "supporter" )
	
	}
	
	private function onFriends(){
		_global._r.devtrace("G.VIEW >>>> onFriends("+")");
		// TO - centralize data - update 
		var d = new Object();
		if( (_children.supporter.length == 1) || (_children.supporter.length == undefined) ){
			d.friends = new Array(_children.supporter);
		}else{
			d.friends 		= _children.supporter; 
		}
		
		
		_global._r.onFriends(d.friends, _NODE);
		
	}
	
	
	private function initSupporterData(){
		_global._r.devtrace("G.VIEW >>>> initSupporterData("+")");
		_global._r.devtrace("initSupporterData: chain.supporter.fullname: "
			+_SUPPORTER.fullname
			+_SUPPORTER.aid+" live_loc-" + _live_loc);
		
		
		var vcode:String 	= _UDATA.vcode;
		var icode:String 	= _UDATA.icode; 
		var uid:String 		= _UDATA.uid;
		var form_aid:String 		= _UDATA.aid;
		_UDATA 				= _SUPPORTER.supporter;
		_UDATA.vcode 		= vcode; // for supporter link in valdiation email /#galaxy,supporter,uid,vcode
		_UDATA.icode 		= icode; 
		_UDATA.uid 			= uid; 
		_UDATA.form_aid 	= form_aid; 
		//_UDATA.aid 			= aid; 
		
		
		// TODO - add user to end of chain in a better way
		
		if(_UDATA.chain.supporter == undefined){
			_UDATA.chain.supporter = new Array();	
		}
		
		if(_UDATA.chain.supporter.length == undefined){
			_UDATA.chain.supporter = new Array(_UDATA.chain.supporter);	
		}
		
		if(_live_loc == "galaxy,supporter"){
			_UDATA.chain.supporter.push(_SUPPORTER.supporter );
		}
		
		_global._r.devtrace("initSupporterData:uid - "	+ _UDATA.uid
			+	" aid:"			+ _UDATA.aid
			+	" vcode:"		+ _UDATA.vcode
			+	" icode:"		+ _UDATA.icode
			+	" chain length:"		+ _UDATA.chain.supporter.length
			+	" chain suporter[0]:"		+ _UDATA.chain.supporter[0].fullname
			+	" friends suporter:"		+ _UDATA.friends.supporter
			+	" fullname:"	+ _UDATA.fullname);
				
		
		/*
		 * 
		 * Sample XML geenrated by php 
		 * http://clients.continuityny.com/usoc/bg/php/get_chain_by_uid.php?uid=4
		 * 
		 * I will call drawChain(_UDATA); 
		 * 
		 * _UDATA is an object parsed from that XML.
		 * It has the following breakdown.
		 * 						
		 * _UDATA.uid 			= uique supporter id
		 * _UDATA.fullname 		= name of supporter
		 * _UDATA.location		= location of supporter
		 * _UDATA.img_src		= url of supporter image to load
		 * _UDATA.aid			= the id of the athlete this user is supporting
		 * _UDATA.athlete_name	= the full name of that same athlete
		 * _UDATA.degrees		= this supporters distance fromt he athlete
		 * _UDATA.message		= this supporters message of support
		 * 
		 * _UDATA.chain.supporter		= the Array of linked supporters [0] being the closest to athlete
		 * _UDATA.chain.supporter[0].uid	= (each supporter in the array has all the same values as the main supporter)  
		 * 
		 * _UDATA.friends.supporter		= the Array of friends of this supporter - min 2, max 5
		 * 
		 * 
		 */
		
		if (_live_loc == "galaxy,supporter"){
			
			_global._r.devtrace("initSupporterData:galaxy,supporter:"+_UDATA.aid);
			
			var a_data = USOC_Site_Model.getAthleteDataById(_UDATA.aid);
			
			_global._r.drawChain(_UDATA, a_data); 
			
			this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_ARRIVED, [_live_loc, _UDATA]) );
			
		}else{
			
			// from "galaxy,connect"
			_global._r.devtrace("initSupporterData:else:"+_UDATA.aid+"  SELECTED_AID: "+SELECTED_AID);
			
			if(SELECTED_AID == undefined){
				_global._r.devtrace("initSupporterData:SELECTED_AID is undefined");
				SELECTED_AID = 0;
			}
			
			if(_UDATA.icode != undefined && _UDATA.aid != undefined){
				SELECTED_AID = _UDATA.aid;
			}
			
			// DATA used to init athlete - (not chain info)
			var a_data = USOC_Site_Model.getAthleteDataById(SELECTED_AID);
			
			//
			if(_UDATA.icode == undefined || (_UDATA.chain.supporter.length==0) || (_UDATA.chain.supporter.length==undefined)){
				
				_global._r.initAthlete(a_data); // // TODO - change to draw chain later
				
				this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_ARRIVED, [_live_loc, _UDATA]) );
			
			}else{
				
				_global._r.drawChain(_UDATA, a_data); 
				
				this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_ARRIVED, [_live_loc, _UDATA]) );
				//_global._r.onDrawDone = Delegate.create(this, handleOnArrive); // LISTEN FOR DRAW DONE
			}
		
		}
		
		
			
		
		//
		
		
		//_global._r.inChainInit(_UDATA.chain.supporter.length, _UDATA);
		
		// TODO - remove this when galaxy is implemented
		
		
	}
		
	private function handleOnArrive(){
		
		// _live_loc = "galaxy,connect" || "galaxy,supporter"
		
		_global._r.devtrace("G.VIEW >>>> handleOnArrive() -- _live_loc:"+_live_loc+" _UDATA.chain.supporters:"+_UDATA.chain.supporters.length);
		
		this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_ARRIVED, [_live_loc, _UDATA]) );
	
	}
	
	
	private function handleAthleteChildrenLoaded(){
		_global._r.devtrace("G.VIEW >>>> handleAthleteChildrenLoaded()");
		/*
		 * 
		 * all athlete info can be viewed here
		 * http://clients.continuityny.com/usoc/bg/php/get_universe.php
		 * 
		 * I will call initAthlete(_UDATA); 
		 * 
		 * _UDATA is an object parsed from a subset of that XML.
		 * It has the following breakdown.
		 * 						
		 * _UDATA.aid 			= uique athlete id
		 * _UDATA.firstname 	= first name of athlete		 * _UDATA.lastname 		= lasst name of athlete
		 * _UDATA.location		= location of supporter
		 * _UDATA.img_src		= url of supporter image to load
		 * _UDATA.sid			= sport id
		 * _UDATA.team			= name of sport the play
		 * _UDATA.message		= this supporters message of support
		 * _UDATA.supporters	= numberr of supproters this athlete has
		 * _UDATA.network		= the size of this athletes network
		 * 
		 * 
		 */
		 
		if( (_children.supporter.length == 1) || (_children.supporter.length == undefined) ){
			_UDATA.friends = new Array(_children.supporter);
		}else{
			_UDATA.friends = _children.supporter; 
		}
		
		_global._r.devtrace("friends - fullname:" + _children.supporter.fullname + " children:"+_children.supporter.length);
		
		_global._r.initAthlete(_UDATA); 
		_global._r.resetGalaxy();
			
		this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_ARRIVED, ["galaxy,athlete", _UDATA]) );
				
	}
	
	
	
	
	
	private function _setChildren(){
			_global._r.devtrace("G.VIEW >>>> _setChildren()");
			_global._r.devtrace("            setChildren:fullname"+_children.supporter.fullname);
			_global._r.devtrace("            setChildren:length"+_children.supporter.message);
			_global._r.setChildren	(_children.supporter);
	}
	
	
	
	
	
	private function makeFakeChildren(){
		_global._r.devtrace("G.VIEW >>>> makeFakeChildren()");
		var s_data : Array = USOC_Site_Model.getData().supporter;
		
		var start_index = random(30);
		var end_index = start_index+5;
		
		return s_data.slice(start_index, end_index); 
	}
	
	private function makeFakeChain(){
		_global._r.devtrace("G.VIEW >>>> makeFakeChain()");
		var s_data : Array = USOC_Site_Model.getData().supporter.slice(); 
		var _array = new Array() ;
		
		for(var i = 0; i<39; i++){
			var r = random(s_data.length);
			var t = s_data[r];
			_array.push( s_data[r] );
			s_data.splice(r, 1 ); 
			//trace("temp_array[i]: r - "+r+" " +s_data.length+" - "+t.uid);
		}
		
		return _array; 
		// FAKE_CHAIN = s_data; 
	}


	
	private function makeSupporter(d){	
			_global._r.devtrace("G.VIEW >>>> makeSupporter("+d+")");
			var id = String(d);
			_global._r.devtrace("onSupporter:"+id);
	}
	
	private function activateAthlete(d){	
			_global._r.devtrace("G.VIEW >>>> activateAthlete("+d+")");
			var id = String(d);
			_global._r.devtrace("activateAthlete:"+id);
			
	}
	
	private function activateGalaxyConnect(){
		_global._r.devtrace("G.VIEW >>>> activateGalaxyConnect:uid b4 "+_UDATA.uid+" icode:"+_UDATA.icode+" parent:"+_UDATA.fullname); 
		
		_global._r.galaxyEnabled(false);
		//this._fireEvent(new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["connect", _UDATA]) );
		//callLiveLocation("connect", _UDATA);
		this._fireEvent(new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["galaxy,form", _UDATA]) );
	}
	
	private function returnToUniverse(){
		_global._r.devtrace("G.VIEW >>>> returnToUniverse()");
		this._fireEvent(new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["universe"]) );
	}
	
	private function callLiveLocation(second, data){
			_global._r.devtrace("G.VIEW >>>> callLiveLocation()");	
			var base:String = USOC_Location_View.getBaseLiveLocation().split(",").join("");
				
			this._fireEvent(new BasicEvent( USOC_EventList.CHANGE_LOCATION, [base+","+second, data]) );
		
	}
	
	public function activateGalaxySupporter(){
		_global._r.devtrace("G.VIEW >>>> activateGalaxySupporter ");
		
	}
	
	private function getConnected(d){
		_global._r.devtrace("G.VIEW >>>> getConnected("+String(d)+")");
		//SELECTED_AID = String(d);
		this._fireEvent(new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["galaxy,connect",{aid:0, form_aid:String(d)}]) );
	}
	
	private function athleteRelease(id){
		_global._r.devtrace("G.VIEW >>>> athleteRelease - id:"+id);
		this._fireEvent(new BasicEvent( USOC_EventList.CHANGE_LOCATION, ["galaxy,athlete", {aid:id}]) );
		
	}
	//public function removeGalaxySupporter(d){
		
		//this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_DEPARTED, ["galaxy,supporter"]) );
	//}
	
	
	
	
	public function removeGalaxy(){
		
		GALAXY_LIVE = false; 
		this._fireEvent(new BasicEvent( USOC_EventList.LOCATION_ON_DEPARTED, ["galaxy,athlete"]) );
	}
	
	
	

	private function lockAll(){
		
	}
	
	
	private function _fireEvent( e : IEvent ) : Void {

        USOC_EventBroadcaster.getInstance().broadcastEvent( e );

    }
    
    
    // DATA ACCESS
    private function _loadSupporterXML( uid:String ) : Void {
		trace( "Application :: _loadChainXML:" +_config.query.chain);
	//	creating the object holding the result for a map
		_SUPPORTER = new Object();
	//	creating the config loader
		var _cfLoader : ConfigLoader = new ConfigLoader( _SUPPORTER );
	//	define the callback once the xml is loaded
		_cfLoader.addEventListener( ConfigLoader.onLoadInitEVENT, this, initSupporterData );
		_cfLoader.load(_config.query.chain+"?uid="+uid);
		
	}
	
	
    
    
    
    
    private function _loadFriendsXML ( id:String, callback:Function, kind:String ) : Void {
		trace( "Application :: _loadFriendsXML:" +_config.query.children);
		_children = new Object();
		var _cfLoader : ConfigLoader = new ConfigLoader( _children );
		_cfLoader.addEventListener( ConfigLoader.onLoadInitEVENT, this, callback );
		if(kind == "athlete"){
			_cfLoader.load(_config.query.children+"?aid="+id);		}else{
			_cfLoader.load(_config.query.children+"?uid="+id);
		}
	}
	
	
}