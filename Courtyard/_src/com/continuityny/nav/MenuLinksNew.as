

import com.continuityny.type.TextLineNew;


class com.continuityny.nav.MenuLinksNew {
	
	
	private static var LAYOUT:String;
	
	private static var X_OFFSET:Number;
	private static var Y_OFFSET:Number;
	
	private static var LINK:Object;
	private static var LAST_LINK:Object;
	
	private static var DATA:Array = new Array();
	private var LINK_array:Array;
	
	
	
	public function MenuLinksNew ( 	target_mc:MovieClip,
									layout:String,
									x:Number,
									y:Number,
									offset:Number,
									rel:Function,
									over:Function,
									out:Function,
									style:Object,
									datasource:Array,
									startIndex:Number, 
									endIndex:Number, 
									key_array:Array) {
		
		this.LINK_array = new Array();
		
		if(	layout == "h" ){ X_OFFSET = offset; Y_OFFSET = 0; }
		if(	layout == "v" ){ Y_OFFSET = offset; X_OFFSET = 0; }
		
		DATA = datasource;
		
		for(var i:Number = startIndex; i<=endIndex; i++){
			
			trace("LINK: "+DATA[i]+ " : "+LAST_LINK._mc._width);
			
				if(i==startIndex || LAST_LINK == ""){
					var x_pos = x;
					var y_pos = y;
					
				}else{
					if(layout == "h"){
						var x_pos = (LAST_LINK._mc._x+LAST_LINK._mc._width+X_OFFSET);
						var y_pos = y+Y_OFFSET;
					}
					if(layout == "v"){
						var x_pos = x+X_OFFSET;
						var y_pos = (LAST_LINK._mc._y+LAST_LINK._mc._height+Y_OFFSET);
					}
				}
				
				
			// LINK = new TextLine(target_mc, DATA.getMain(i, "label").toLowerCase(), .7, 0, x_pos, y_pos, style);
			
			// var word = DATA[i].label.toLowerCase();
			var word:String;
			
			key_array.reverse();
			
			if(key_array == undefined){
				word = String(DATA[i]) ;
			}else{
				
				for(var key in key_array){
					word += String(DATA[i][key_array[key]])+" ";
					
				}
			}
			
			
			
			LINK = new TextLineNew(target_mc, word, .5, 0, x_pos, y_pos, style, null, true);
			
			LINK._mc.ref = i;
			
			trace("REF: "+(typeof LINK._mc.ref)+" : "+LINK._mc.ref+" : "+LINK._mc);
	
			LINK.setButton(rel, over, out);
			
			LAST_LINK = LINK;
			
			this.LINK_array[i] = LINK;
			
		}
		
	}
	
	
	public function setSelected (key:Number){
		trace("SET SELECTED: "+key+" : "+LINK_array[key]._mc);
		
		for(var a in LINK_array)
			LINK_array[a]._mc._alpha = 100;
		
		LINK_array[key]._mc._alpha = 50;
		
	}
	
	
}
