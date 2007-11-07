﻿import com.util.Proxy;import com.mosesSupposes.fuse.*;class HomePageModules extends MovieClip {	private var Highilight:MovieClip;	private var subscribe_email:MovieClip;	private var subscribe_phone:MovieClip;	private var Header_txt:TextField;	private var Body_txt:TextField;	private var Hider:MovieClip;	function HomePageModules() {		init();	}	private function init() {		Highilight._alpha = 0;		//subscribe_email.envelope_mc._alpha=0;		if (this._name != 'JokeOfTheDay') {			onRollOver = Proxy.create(this, RollOverHandler);			onRollOut = Proxy.create(this, RollOutHandler);			onRelease = Proxy.create(this, ClickHandler, this._name);		}		if (this._name == 'JokeOfTheDay') {			subscribe_email.hit.onRelease = Proxy.create(this, SubscribeEmail);			subscribe_phone.hit.onRelease = Proxy.create(this, SubscribePhone);			subscribe_email.hit.onRollOver = Proxy.create(this, EmailOver);			subscribe_email.hit.onRollOut = Proxy.create(this, EmailOut);			subscribe_phone.hit.onRollOver = Proxy.create(this, PhoneOver);			subscribe_phone.hit.onRollOut = Proxy.create(this, PhoneOut);			Header_txt.text = this._parent._parent._parent.JokesArray[0][0];			Body_txt.htmlText = this._parent._parent._parent.JokesArray[0][1];		}		if (this._name == 'LatestNews') {			Header_txt.text = this._parent._parent._parent.NewsArray[0].title;			Body_txt.text = this._parent._parent._parent.NewsArray[0].description;			trace('LatestNews: '+this._parent._parent._parent.NewsArray);		}	}	private function EmailOver() {		ZigoEngine.doTween(subscribe_email.envelope_mc,'_x,_y,_rotation',[150, -50, 30],1,'easeOutElastic');	}	private function EmailOut() {		ZigoEngine.doTween(subscribe_email.envelope_mc,'_x,_y,_rotation',[10, 50, 60],1,'easeOutElastic');	}	private function PhoneOver() {		ZigoEngine.doTween(subscribe_phone.phone_mc,'_x,_y,_rotation',[90, -30, 30],1,'easeOutElastic');	}	private function PhoneOut() {		ZigoEngine.doTween(subscribe_phone.phone_mc,'_x,_y,_rotation',[80, 90, 60],1,'easeOutElastic');	}	private function RollOverHandler() {		ZigoEngine.doTween(Highilight,'_alpha',80,1,'easeOutElastic');	}	private function RollOutHandler() {		ZigoEngine.doTween(Highilight,'_alpha',0,.7,'easeOutBack');	}	private function ClickHandler(btn) {		trace(btn);		if (btn == 'LatestNews') {			this._parent._parent._parent.loadContent(1);		}	}	private function reset() {	}	private function SubscribeEmail() {		trace('SubscribeEmail');		this._parent._parent._parent.showMessage(1,'swf/jod_email.swf');	}	private function SubscribePhone() {		trace('SubscribePhone');		this._parent._parent._parent.showMessage(2,'swf/jod_phone.swf');	}}