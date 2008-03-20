


class com.continuityny.type.TextLine   {
	
	
	
	private var TARGET_MC:MovieClip;
	private var WORD_MC:MovieClip; 
	private var WORD:String;
	private var WRAPS:Boolean;
	
	public function TextLine   (	_mc:MovieClip,
						  		word:String, 
						  		depth:Number,
								letter_space:Number, 
								lead:Number, 
								//xx:Number, 
								//yy:Number, 
						  		style:Object, 
								//reset:Boolean, 
								adv:Boolean,
								wrap:Boolean) {
		
		
		WORD = word;
		//trace("**********************"+wrap);
	//	if(targ_mc.depthCount == undefined || reset){ targ_mc.depthCount = 1; }else{targ_mc.depthCount++; }; // set depth
	//	if(targ_mc.lineCount == undefined || reset){ targ_mc.lineCount = 1; }else{targ_mc.lineCount++; }; // set depth
	
		TARGET_MC = _mc; 
		WORD_MC = TARGET_MC.createEmptyMovieClip("word_"+depth+"_mc", depth);
			/*
			WRAPS  = (wrap != undefined ||wrap != null ) ? false : wrap ; 
			trace("**********************"+WRAPS);
			if (WRAPS){
				trace("********************** THIS IS A SPECIAL WRAPPING TEXTFIELD");
				WORD_MC.createTextField("word_txt", 100, 0,0, 100, 100); 
				var _txt = WORD_MC.word_txt;
				_txt.autoSize = false;
				_txt.multiline = true;
				
			}else{
				trace("********************** THIS IS A NON WRAPPING TEXTFIELD");
				WORD_MC.createTextField("word_txt", 100, 0,0, 0, 0); 
				var _txt = WORD_MC.word_txt;
				_txt.autoSize = true; // stretch box to text size
				_txt.multiline = false;
			}
			
			
			//this_word_mc._x = xx; 
			//this_word_mc._y = yy; 
			
			_txt.wordWrap = WRAPS;
			_txt.selectable = false;
			_txt.embedFonts = true;
	

			if(adv) _txt.antiAliasType = "advanced";
			if(adv) _txt.sharpness = -300;

			// _txt.border = true; 
			
			
			 _txt.text = word.toUpperCase();
			
			//var tf = new TextFormat("FrutigerBold", 10, 0x000000); 
			
			_txt.setTextFormat(style);
		
			trace("word:"+	_txt.text);
			*/
	
	}
	
	
	
	public function setButton(rel:Function, over:Function, out:Function){
		WORD_MC.onRelease = rel; 
		WORD_MC.onRollOver = over; 
		WORD_MC.onRollOut = out; 
	}
	
	public function getMC() : MovieClip{
		return WORD_MC;
	}
	
	public function setColor (n:Number) {
		for (var _txt in WORD_MC ){
			WORD_MC[_txt].textColor = n;
		}
	}
	
	
	
}