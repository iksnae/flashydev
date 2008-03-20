


class com.continuityny.type.TextLineNew {
	
	//private static var depthCount:Number;
	//private static var lineCount:Number;
	
	public var _mc:MovieClip;
	private var WORD:String;

	private var this_txt : TextField;
	
	public function TextLineNew (	targ_mc:MovieClip,
						  		word:String, 
								letter_space:Number, 
								lead:Number, 
								xx:Number, 
								yy:Number, 
						  		style:Object, 
								reset:Boolean, 
								adv:Boolean) {
		
		
		WORD = word;
		
		if(targ_mc.depthCount == undefined || reset){ targ_mc.depthCount = 1; }else{targ_mc.depthCount++; }; // set depth
		if(targ_mc.lineCount == undefined || reset){  targ_mc.lineCount = 1; }else{targ_mc.lineCount++; }; // set depth
	
		targ_mc.createEmptyMovieClip("word_"+targ_mc.depthCount+"_mc", targ_mc.depthCount);
		
		var this_word_mc:MovieClip = _mc = targ_mc["word_"+targ_mc.depthCount+"_mc"];
		
		// trace("LINECOUNT:"+targ_mc.lineCount+" lead:"+lead+" - word:"+word + " : "+this_word_mc);
		

		if(word != undefined){
		//for(var i:Number=0; i<=word.length; i++){
			// trace("depthCount"+ this.depthCount+" " +this_word_mc);
			// args: name, depth, x, y, height, width
			
			this_word_mc.createTextField("word_txt", 10, 0, 0, 0, 0); 
			
			this_word_mc._x = xx; 
			this_word_mc._y = yy; 
			
			//var last_letter_txt = this_word_mc["let_"+(i-1)+"_txt"];
			this_txt = this_word_mc["word_txt"];
			// trace("this_letter_txt :"+this_letter_txt);
			//this_txt._x = this_txt._x+this_txt.textWidth+letter_space;
			
			this_txt.selectable = false;
			this_txt.embedFonts = true;
			this_txt.autoSize = true; // stretch box to text size
			
			style.letterSpacing = letter_space;
			
			
			
			if(adv) this_txt.antiAliasType = "advanced";
			if(adv) this_txt.sharpness = -300;

			this_txt.text = word;
			this_word_mc.mystyle = style; 
			this_txt.setTextFormat(style);
		
		//} // end For
		}

		
	
	}
	
	
	public function setButton(rel:Function, over:Function, out:Function){
		_mc.onRelease = rel; 
		_mc.onRollOver = over; 
		_mc.onRollOut = out; 
	}
	
	public function getMC() : MovieClip{
		return _mc;
	}
	
	public function getTXT() : TextField{
		return this_txt;
	}
	
	public function setColor (n:Number) {
		for (var _txt in _mc ){
			_mc[_txt].textColor = n;
		}
	}
	
	
	
}