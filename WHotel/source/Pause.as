
MovieClip.prototype.Pause = function(miliseconds) { 
	this.stop();
	var go = function(obj) {
		obj.play();
		clearInterval(id);
	} 
	var id = setInterval(go,miliseconds,this);
}